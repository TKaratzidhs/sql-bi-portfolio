CREATE OR ALTER PROCEDURE dbo.usp_rpt_CaseOverview
(
    @CreditorAlias      NVARCHAR(100) = NULL,
    @AssignmentStatus   NVARCHAR(50)  = NULL,
    @CurrentBucket      NVARCHAR(50)  = NULL,
    @CaseRefNo          NVARCHAR(50)  = NULL,
    @DebtorName         NVARCHAR(200) = NULL,
    @OnlyActive         BIT           = 1
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        c.case_refno                                              AS CaseRefNo,
        c.case_owner_refno                                        AS OwnerRefNo,

        creditor.entity_alias                                     AS CreditorName,

    --    debtor.entity_id                                          AS DebtorEntityId,
        debtor.entity_alias                                       AS DebtorFullName,
        d.entity_firstname                                        AS DebtorFirstName,
        d.entity_lastname                                         AS DebtorLastName,
        d.entity_taxnumber                                        AS TaxNumber,
        d.entity_identitynumber                                   AS IdentityNumber,

 --       a.assign_id                                               AS AssignmentId,
        a.assign_status                                           AS AssignmentStatus,
        a.assign_isactive                                         AS AssignmentIsActive,
        a.indatetime                                              AS AssignmentDate,
        a.assign_notes                                            AS AssignmentNotes,

        df.dyn_debtamount                                         AS DebtAmount,
        df.dyn_balance_amount                                     AS BalanceAmount,
        df.dyn_totalpaidamount                                    AS TotalPaidAmount,
        df.dyn_lastpaymentamount                                  AS LastPaymentAmount,
        df.dyn_lastpaymentdt                                      AS LastPaymentDate,
        df.dyn_initialbucket                                      AS InitialBucket,
        df.dyn_currentbucket                                      AS CurrentBucket,

        ph.phone_number                                           AS MobilePhone,
        em.email_descr                                            AS EmailAddress,
        adr.add_streetname                                        AS StreetName,
        adr.add_streetnum                                         AS StreetNumber,
        adr.add_cityname                                          AS City,
        adr.add_country                                           AS Country,

        last_act.act_type                                         AS LatestActionType,
        last_act.act_status                                       AS LatestActionStatus,
        last_act.act_implementeddt                                AS LatestActionDate,
        last_act.act_implementedby                                AS LatestActionBy

    FROM cases c
    INNER JOIN assignments a
        ON a.case_id = c.case_id

    INNER JOIN entities creditor
        ON creditor.entity_id = c.case_entitycustomer_id

    INNER JOIN relations r
        ON r.relation_id = c.case_owner_relation_id

    INNER JOIN entities debtor
        ON debtor.entity_id = r.entity_id

    LEFT JOIN demographics d
        ON d.entity_id = debtor.entity_id

    LEFT JOIN dynamic_fields df
        ON df.assign_id = a.assign_id

    OUTER APPLY
    (
        SELECT TOP (1)
            p.phone_number
        FROM communication com
        INNER JOIN phones p
            ON p.com_id = com.com_id
        WHERE com.entity_id = debtor.entity_id
          AND com.com_type = 'phone'
          AND com.com_isvalid = 1
        ORDER BY com.com_isvalidfrom DESC, com.createdt DESC
    ) ph

    OUTER APPLY
    (
        SELECT TOP (1)
            e.email_descr
        FROM communication com
        INNER JOIN email e
            ON e.com_id = com.com_id
        WHERE com.entity_id = debtor.entity_id
          AND com.com_type = 'email'
          AND com.com_isvalid = 1
        ORDER BY com.com_isvalidfrom DESC, com.createdt DESC
    ) em

    OUTER APPLY
    (
        SELECT TOP (1)
            ad.add_streetname,
            ad.add_streetnum,
            ad.add_cityname,
            ad.add_country
        FROM communication com
        INNER JOIN addresses ad
            ON ad.com_id = com.com_id
        WHERE com.entity_id = debtor.entity_id
          AND com.com_type = 'address'
          AND com.com_isvalid = 1
        ORDER BY com.com_isvalidfrom DESC, com.createdt DESC
    ) adr

    OUTER APPLY
    (
        SELECT TOP (1)
            ac.act_type,
            ac.act_status,
            ac.act_implementeddt,
            ac.act_implementedby
        FROM actions ac
        WHERE ac.assign_id = a.assign_id
        ORDER BY ac.act_implementeddt DESC, ac.createdt DESC
    ) last_act

    WHERE
        (@OnlyActive IS NULL OR a.assign_isactive = @OnlyActive)
        AND (@CreditorAlias IS NULL OR creditor.entity_alias = @CreditorAlias)
        AND (@AssignmentStatus IS NULL OR a.assign_status = @AssignmentStatus)
        AND (@CurrentBucket IS NULL OR df.dyn_currentbucket = @CurrentBucket)
        AND (@CaseRefNo IS NULL OR c.case_refno = @CaseRefNo)
        AND (
            @DebtorName IS NULL
            OR debtor.entity_alias LIKE '%' + @DebtorName + '%'
            OR CONCAT(ISNULL(d.entity_firstname,''), ' ', ISNULL(d.entity_lastname,'')) LIKE '%' + @DebtorName + '%'
        )
    ORDER BY
        creditor.entity_alias,
        c.case_refno,
        a.indatetime DESC;
END;
GO

CREATE OR ALTER PROCEDURE dbo.usp_rpt_AssignmentHistory
(
    @CaseRefNo        NVARCHAR(50)  = NULL,
    @CreditorAlias    NVARCHAR(100) = NULL,
    @DebtorName       NVARCHAR(200) = NULL,
    @AssignmentStatus NVARCHAR(50)  = NULL,
    @OnlyActive       BIT           = NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        c.case_refno                                        AS CaseRefNo,
        c.case_owner_refno                                  AS OwnerRefNo,

        creditor.entity_alias                               AS CreditorName,
        debtor.entity_alias                                 AS DebtorFullName,

        d.entity_firstname                                  AS DebtorFirstName,
        d.entity_lastname                                   AS DebtorLastName,
        d.entity_taxnumber                                  AS TaxNumber,

        a.assign_id                                         AS AssignmentId,
        a.indatetime                                        AS AssignmentDate,
        a.assign_status                                     AS AssignmentStatus,
        a.assign_isactive                                   AS AssignmentIsActive,
        a.assign_notes                                      AS AssignmentNotes,

        ac.act_id                                           AS ActionId,
        ac.act_type                                         AS ActionType,
        ac.act_notes                                        AS ActionNotes,
        ac.act_implementeddt                                AS ActionDate,
        ac.act_implementedby                                AS ActionBy,
        ac.act_status                                       AS ActionStatus,

        df.dyn_debtamount                                   AS DebtAmount,
        df.dyn_balance_amount                               AS BalanceAmount,
        df.dyn_totalpaidamount                              AS TotalPaidAmount,
        df.dyn_lastpaymentamount                            AS LastPaymentAmount,
        df.dyn_lastpaymentdt                                AS LastPaymentDate,
        df.dyn_initialbucket                                AS InitialBucket,
        df.dyn_currentbucket                                AS CurrentBucket

    FROM assignments a
    INNER JOIN cases c
        ON c.case_id = a.case_id
    INNER JOIN entities creditor
        ON creditor.entity_id = c.case_entitycustomer_id
    INNER JOIN relations r
        ON r.relation_id = c.case_owner_relation_id
    INNER JOIN entities debtor
        ON debtor.entity_id = r.entity_id
    LEFT JOIN demographics d
        ON d.entity_id = debtor.entity_id
    LEFT JOIN actions ac
        ON ac.assign_id = a.assign_id
    LEFT JOIN dynamic_fields df
        ON df.assign_id = a.assign_id

    WHERE
        (@CaseRefNo IS NULL OR c.case_refno = @CaseRefNo)
        AND (@CreditorAlias IS NULL OR creditor.entity_alias = @CreditorAlias)
        AND (@AssignmentStatus IS NULL OR a.assign_status = @AssignmentStatus)
        AND (@OnlyActive IS NULL OR a.assign_isactive = @OnlyActive)
        AND (
            @DebtorName IS NULL
            OR debtor.entity_alias LIKE '%' + @DebtorName + '%'
            OR CONCAT(ISNULL(d.entity_firstname,''), ' ', ISNULL(d.entity_lastname,'')) LIKE '%' + @DebtorName + '%'
        )

    ORDER BY
        c.case_refno,
        a.indatetime,
        ac.act_implementeddt,
        ac.createdt;
END;
GO

CREATE OR ALTER PROCEDURE dbo.usp_rpt_PaymentsBalances
(
    @CaseRefNo        NVARCHAR(50)  = NULL,
    @CreditorAlias    NVARCHAR(100) = NULL,
    @DebtorName       NVARCHAR(200) = NULL,
    @CurrentBucket    NVARCHAR(50)  = NULL,
    @OnlyActive       BIT           = 1
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        c.case_refno                                        AS CaseRefNo,
        c.case_owner_refno                                  AS OwnerRefNo,

        creditor.entity_alias                               AS CreditorName,
        debtor.entity_alias                                 AS DebtorFullName,

        d.entity_firstname                                  AS DebtorFirstName,
        d.entity_lastname                                   AS DebtorLastName,
        d.entity_taxnumber                                  AS TaxNumber,

        a.assign_id                                         AS AssignmentId,
        a.assign_status                                     AS AssignmentStatus,
        a.assign_isactive                                   AS AssignmentIsActive,
        a.indatetime                                        AS AssignmentDate,

        df.dyn_debtamount                                   AS DebtAmount,
        df.dyn_totalpaidamount                              AS TotalPaidAmount,
        df.dyn_balance_amount                               AS BalanceAmount,
        df.dyn_lastpaymentamount                            AS LastPaymentAmount,
        df.dyn_lastpaymentdt                                AS LastPaymentDate,
        df.dyn_initialbucket                                AS InitialBucket,
        df.dyn_currentbucket                                AS CurrentBucket,

        pay.PaymentCount,
        pay.TransactionPaidAmount,
        pay.FirstPaymentDate,
        pay.LastTransactionDate

    FROM assignments a
    INNER JOIN cases c
        ON c.case_id = a.case_id
    INNER JOIN entities creditor
        ON creditor.entity_id = c.case_entitycustomer_id
    INNER JOIN relations r
        ON r.relation_id = c.case_owner_relation_id
    INNER JOIN entities debtor
        ON debtor.entity_id = r.entity_id
    LEFT JOIN demographics d
        ON d.entity_id = debtor.entity_id
    LEFT JOIN dynamic_fields df
        ON df.assign_id = a.assign_id
    OUTER APPLY
    (
        SELECT
            COUNT(*) AS PaymentCount,
            SUM(CASE WHEN t.tran_type = 'payment' THEN t.tran_amount ELSE 0 END) AS TransactionPaidAmount,
            MIN(CASE WHEN t.tran_type = 'payment' THEN t.tran_registerdt END) AS FirstPaymentDate,
            MAX(CASE WHEN t.tran_type = 'payment' THEN t.tran_registerdt END) AS LastTransactionDate
        FROM transactions t
        WHERE t.assign_id = a.assign_id
    ) pay

    WHERE
        (@CaseRefNo IS NULL OR c.case_refno = @CaseRefNo)
        AND (@CreditorAlias IS NULL OR creditor.entity_alias = @CreditorAlias)
        AND (@CurrentBucket IS NULL OR df.dyn_currentbucket = @CurrentBucket)
        AND (@OnlyActive IS NULL OR a.assign_isactive = @OnlyActive)
        AND (
            @DebtorName IS NULL
            OR debtor.entity_alias LIKE '%' + @DebtorName + '%'
            OR CONCAT(ISNULL(d.entity_firstname,''), ' ', ISNULL(d.entity_lastname,'')) LIKE '%' + @DebtorName + '%'
        )

    ORDER BY
        creditor.entity_alias,
        c.case_refno,
        a.indatetime DESC;
END;
GO

CREATE OR ALTER PROCEDURE dbo.usp_rpt_DebtorContactSheet
(
    @CaseRefNo        NVARCHAR(50)  = NULL,
    @CreditorAlias    NVARCHAR(100) = NULL,
    @DebtorName       NVARCHAR(200) = NULL,
    @OnlyActive       BIT           = 1
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        c.case_refno                                        AS CaseRefNo,
        c.case_owner_refno                                  AS OwnerRefNo,

        creditor.entity_alias                               AS CreditorName,

        debtor.entity_id                                    AS DebtorEntityId,
        debtor.entity_alias                                 AS DebtorFullName,

        d.entity_firstname                                  AS DebtorFirstName,
        d.entity_lastname                                   AS DebtorLastName,
        d.entity_taxnumber                                  AS TaxNumber,
        d.entity_identitynumber                             AS IdentityNumber,
        d.entity_dateofbirth                                AS DateOfBirth,
        d.entity_birthplace                                 AS BirthPlace,
        d.entity_fathername                                 AS FatherName,
        d.entity_mothername                                 AS MotherName,

        a.assign_id                                         AS AssignmentId,
        a.assign_status                                     AS AssignmentStatus,
        a.assign_isactive                                   AS AssignmentIsActive,
        a.indatetime                                        AS AssignmentDate,

        ph.phone_type                                       AS PhoneType,
        ph.phone_areacode                                   AS PhoneAreaCode,
        ph.phone_number                                     AS PhoneNumber,

        em.email_type                                       AS EmailType,
        em.email_descr                                      AS EmailAddress,

        adr.add_type                                        AS AddressType,
        adr.add_streetname                                  AS StreetName,
        adr.add_streetnum                                   AS StreetNumber,
        adr.add_cityname                                    AS City,
        adr.add_country                                     AS Country

    FROM assignments a
    INNER JOIN cases c
        ON c.case_id = a.case_id
    INNER JOIN entities creditor
        ON creditor.entity_id = c.case_entitycustomer_id
    INNER JOIN relations r
        ON r.relation_id = c.case_owner_relation_id
    INNER JOIN entities debtor
        ON debtor.entity_id = r.entity_id
    LEFT JOIN demographics d
        ON d.entity_id = debtor.entity_id

    OUTER APPLY
    (
        SELECT TOP (1)
            p.phone_type,
            p.phone_areacode,
            p.phone_number
        FROM communication com
        INNER JOIN phones p
            ON p.com_id = com.com_id
        WHERE com.entity_id = debtor.entity_id
          AND com.com_type = 'phone'
          AND com.com_isvalid = 1
        ORDER BY com.com_isvalidfrom DESC, com.createdt DESC
    ) ph

    OUTER APPLY
    (
        SELECT TOP (1)
            e.email_type,
            e.email_descr
        FROM communication com
        INNER JOIN email e
            ON e.com_id = com.com_id
        WHERE com.entity_id = debtor.entity_id
          AND com.com_type = 'email'
          AND com.com_isvalid = 1
        ORDER BY com.com_isvalidfrom DESC, com.createdt DESC
    ) em

    OUTER APPLY
    (
        SELECT TOP (1)
            ad.add_type,
            ad.add_streetname,
            ad.add_streetnum,
            ad.add_cityname,
            ad.add_country
        FROM communication com
        INNER JOIN addresses ad
            ON ad.com_id = com.com_id
        WHERE com.entity_id = debtor.entity_id
          AND com.com_type = 'address'
          AND com.com_isvalid = 1
        ORDER BY com.com_isvalidfrom DESC, com.createdt DESC
    ) adr

    WHERE
        (@CaseRefNo IS NULL OR c.case_refno = @CaseRefNo)
        AND (@CreditorAlias IS NULL OR creditor.entity_alias = @CreditorAlias)
        AND (@OnlyActive IS NULL OR a.assign_isactive = @OnlyActive)
        AND (
            @DebtorName IS NULL
            OR debtor.entity_alias LIKE '%' + @DebtorName + '%'
            OR CONCAT(ISNULL(d.entity_firstname,''), ' ', ISNULL(d.entity_lastname,'')) LIKE '%' + @DebtorName + '%'
        )

    ORDER BY
        creditor.entity_alias,
        debtor.entity_alias,
        c.case_refno,
        a.indatetime DESC;
END;
GO





