/*Debtor Insert*/
Begin 

INSERT INTO entities
(
    entity_id,
    entity_alias,
    createdt,
    updatedt
)
SELECT
    sd.entity_id,
    sd.entity_alias,
    sd.load_dt,
    NULL
FROM stg_debtors sd
WHERE sd.process_status = 'VALID'
  AND sd.entity_id IS NOT NULL;

INSERT INTO demographics
(
    entity_id,
    entity_taxnumber,
    entity_identitynumber,
    entity_nationality,
    entity_secondnationality,
    entity_dateofbirth,
    entity_birthplace,
    entity_firstname,
    entity_midname,
    entity_lastname,
    entity_fathername,
    entity_mothername,
    createdt,
    updatedt
)
SELECT
    sd.entity_id,
    sd.entity_taxnumber,
    sd.entity_identitynumber,
    sd.entity_nationality,
    sd.entity_secondnationality,
    TRY_CONVERT(DATE, sd.entity_dateofbirth),
    sd.entity_birthplace,
    sd.entity_firstname,
    sd.entity_midname,
    sd.entity_lastname,
    sd.entity_fathername,
    sd.entity_mothername,
    sd.load_dt,
    NULL
FROM stg_debtors sd
WHERE sd.process_status = 'VALID'
  AND sd.entity_id IS NOT NULL;

INSERT INTO relations
(
    relation_id,
    entity_id,
    relation_type,
    relation_isactive,
    relation_implementedby,
    relation_implementationdt,
    createdt,
    updatedt
)
SELECT
    sd.relation_id,
    sd.entity_id,
    sd.relation_type,
    CASE
        WHEN sd.relation_isactive IN ('1', 'true', 'TRUE', 'yes', 'YES') THEN 1
        ELSE 0
    END,
    'ssis',
    TRY_CONVERT(DATETIME, sd.load_dt),
    sd.load_dt,
    NULL
FROM stg_debtors sd
WHERE sd.process_status = 'VALID'
  AND sd.relation_id IS NOT NULL
  AND sd.entity_id IS NOT NULL;

INSERT INTO communication
(
    com_id,
    entity_id,
    com_type,
    com_isvalid,
    com_isvalidfrom,
    com_isvalidto,
    com_implementedby,
    com_implementeddt,
    createdt,
    updatedt
)
SELECT
    sd.com_id,
    sd.entity_id,
    sd.com_type,
    CASE
        WHEN sd.com_isvalid IN ('1', 'true', 'TRUE', 'yes', 'YES') THEN 1
        ELSE 0
    END,
    TRY_CONVERT(DATETIME, sd.com_isvalidfrom),
    TRY_CONVERT(DATETIME, sd.com_isvalidto),
    sd.com_implementedby,
    TRY_CONVERT(DATETIME, sd.com_implementeddt),
    sd.load_dt,
    NULL
FROM stg_debtors sd
WHERE sd.process_status = 'VALID'
  AND sd.com_id IS NOT NULL
  AND sd.entity_id IS NOT NULL;

INSERT INTO phones
(
    phone_id,
    com_id,
    phone_type,
    phone_number,
    phone_areacode,
    createdt,
    updatedt
)
SELECT
    sd.phone_id,
    sd.com_id,
    sd.phone_type,
    sd.phone_number,
    sd.phone_areacode,
    sd.load_dt,
    NULL
FROM stg_debtors sd
WHERE sd.process_status = 'VALID'
  AND sd.phone_id IS NOT NULL
  AND sd.com_id IS NOT NULL
  AND sd.phone_number IS NOT NULL;

INSERT INTO addresses
(
    address_id,
    com_id,
    add_streetnum,
    add_streetname,
    add_cityname,
    add_country,
    add_type,
    createdt,
    updatedt
)
SELECT
    sd.address_id,
    sd.com_id,
    sd.add_streetnum,
    sd.add_streetname,
    sd.add_cityname,
    sd.add_country,
    sd.add_type,
    sd.load_dt,
    NULL
FROM stg_debtors sd
WHERE sd.process_status = 'VALID'
  AND sd.address_id IS NOT NULL
  AND sd.com_id IS NOT NULL;

INSERT INTO email
(
    email_id,
    com_id,
    email_descr,
    email_type,
    createdt,
    updatedt
)
SELECT
    sd.email_id,
    sd.com_id,
    sd.email_descr,
    sd.email_type,
    sd.load_dt,
    NULL
FROM stg_debtors sd
WHERE sd.process_status = 'VALID'
  AND sd.email_id IS NOT NULL
  AND sd.com_id IS NOT NULL
  AND sd.email_descr IS NOT NULL;

UPDATE stg_debtors
SET
    process_status = 'LOADED',
    process_note = 'Inserted into target tables'
WHERE process_status = 'VALID'
  AND entity_id IS NOT NULL;

End 

/*Cases Insert*/

Begin 
INSERT INTO cases
(
    case_id,
    case_refno,
    case_owner_refno,
    case_owner_relation_id,
    createdt,
    updatedt,
    case_entitycustomer_id
)
SELECT
    sc.case_id,
    sc.case_refno,
    sc.case_owner_refno,
    sd.relation_id,
    TRY_CONVERT(DATETIME, sc.load_dt),
    NULL,
    e_case.entity_id
FROM stg_cases sc
INNER JOIN stg_debtors sd
    ON sc.debtor_source_code = sd.source_debtor_code
   AND sd.process_status = 'LOADED'
INNER JOIN entities e_case
    ON sc.case_entitycustomer_alias = e_case.entity_alias
WHERE sc.process_status = 'VALID'
  AND sc.case_id IS NOT NULL;


INSERT INTO assignments
(
    assign_id,
    assign_isactive,
    assign_status,
    indatetime,
    case_id,
    assign_notes,
    createdt,
    updatedt,
    assign_entitycustomer_id
)
SELECT
    sc.assign_id,
    CASE
        WHEN UPPER(LTRIM(RTRIM(sc.assign_isactive))) IN ('1','TRUE','YES') THEN 1
        ELSE 0
    END,
    sc.assign_status,
    TRY_CONVERT(DATETIME, sc.indatetime),
    sc.case_id,
    sc.assign_notes,
    TRY_CONVERT(DATETIME, sc.load_dt),
    NULL,
    e_assign.entity_id
FROM stg_cases sc
INNER JOIN entities e_assign
    ON sc.assign_entitycustomer_alias = e_assign.entity_alias
WHERE sc.process_status = 'VALID'
  AND sc.assign_id IS NOT NULL
  AND sc.case_id IS NOT NULL;


INSERT INTO dynamic_fields
(
    assign_id,
    case_refno,
    dyn_assigndt,
    dyn_isactive,
    dyn_owner_entity_alias,
    dyn_customer_entity_alias,
    dyn_debtamount,
    dyn_balance_amount,
    dyn_lastpaymentamount,
    dyn_lastpaymentdt,
    dyn_totalpaidamount,
    dyn_initialbucket,
    dyn_currentbucket,
    createdt,
    updatedt
)
SELECT
    sc.assign_id,
    sc.case_refno,
    TRY_CONVERT(DATETIME, sc.dyn_assigndt),
    CASE
        WHEN UPPER(LTRIM(RTRIM(sc.dyn_isactive))) IN ('1','TRUE','YES') THEN 1
        ELSE 0
    END,
    sc.dyn_owner_entity_alias,
    sc.dyn_customer_entity_alias,
    TRY_CONVERT(DECIMAL(18,2), sc.dyn_debtamount),
    TRY_CONVERT(DECIMAL(18,2), sc.dyn_balance_amount),
    TRY_CONVERT(DECIMAL(18,2), sc.dyn_lastpaymentamount),
    TRY_CONVERT(DATETIME, sc.dyn_lastpaymentdt),
    TRY_CONVERT(DECIMAL(18,2), sc.dyn_totalpaidamount),
    sc.dyn_initialbucket,
    sc.dyn_currentbucket,
    TRY_CONVERT(DATETIME, sc.load_dt),
    NULL
FROM stg_cases sc
WHERE sc.process_status = 'VALID'
  AND sc.assign_id IS NOT NULL;


UPDATE stg_cases
SET
    process_status = 'LOADED',
    process_note = 'Inserted into target tables'
WHERE process_status = 'VALID'
  AND case_id IS NOT NULL
  AND assign_id IS NOT NULL;


End

/*Payments Insert*/

Begin 

INSERT INTO transactions
(
    tran_id,
    assign_id,
    tran_type,
    tran_amount,
    tran_debtamount,
    tran_registerdt,
    createdt,
    updatedt
)
SELECT
    sp.tran_id,
    sc.assign_id,
    sp.tran_type,
    TRY_CONVERT(DECIMAL(18,2), sp.tran_amount),
    TRY_CONVERT(DECIMAL(18,2), sp.tran_debtamount),
    TRY_CONVERT(DATETIME, sp.tran_registerdt),
    TRY_CONVERT(DATETIME, sp.load_dt),
    NULL
FROM stg_payments sp
INNER JOIN stg_cases sc
    ON sp.source_case_code = sc.source_case_code
   AND sc.process_status = 'LOADED'
WHERE sp.process_status = 'VALID'
  AND sp.tran_id IS NOT NULL
  AND sc.assign_id IS NOT NULL;


UPDATE stg_payments
SET
    process_status = 'LOADED',
    process_note = 'Inserted into target tables'
WHERE process_status = 'VALID'
  AND tran_id IS NOT NULL;

End