/*Validate Debtor Data*/
begin
/* Reset notes for rows still under processing */
UPDATE stg_debtors
SET process_note = NULL
WHERE process_status IN ('PENDING', 'VALID', 'REJECTED');


/* Missing source debtor code */
UPDATE stg_debtors
SET
    process_status = 'REJECTED',
    process_note = 'Missing source_debtor_code'
WHERE (source_debtor_code IS NULL OR LTRIM(RTRIM(source_debtor_code)) = '')
  AND ISNULL(process_status, 'PENDING') = 'PENDING';


/* Missing entity alias */
UPDATE stg_debtors
SET
    process_status = 'REJECTED',
    process_note = 'Missing entity_alias'
WHERE (entity_alias IS NULL OR LTRIM(RTRIM(entity_alias)) = '')
  AND ISNULL(process_status, 'PENDING') = 'PENDING';


/* Missing tax number */
UPDATE stg_debtors
SET
    process_status = 'REJECTED',
    process_note = 'Missing entity_taxnumber'
WHERE (entity_taxnumber IS NULL OR LTRIM(RTRIM(entity_taxnumber)) = '')
  AND ISNULL(process_status, 'PENDING') = 'PENDING';


/* Invalid birth date format */
UPDATE stg_debtors
SET
    process_status = 'REJECTED',
    process_note = 'Invalid entity_dateofbirth'
WHERE entity_dateofbirth IS NOT NULL
  AND LTRIM(RTRIM(entity_dateofbirth)) <> ''
  AND TRY_CONVERT(DATE, entity_dateofbirth) IS NULL
  AND ISNULL(process_status, 'PENDING') = 'PENDING';


/* Invalid communication valid-from date */
UPDATE stg_debtors
SET
    process_status = 'REJECTED',
    process_note = 'Invalid com_isvalidfrom'
WHERE com_isvalidfrom IS NOT NULL
  AND LTRIM(RTRIM(com_isvalidfrom)) <> ''
  AND TRY_CONVERT(DATETIME, com_isvalidfrom) IS NULL
  AND ISNULL(process_status, 'PENDING') = 'PENDING';


/* Invalid communication valid-to date */
UPDATE stg_debtors
SET
    process_status = 'REJECTED',
    process_note = 'Invalid com_isvalidto'
WHERE com_isvalidto IS NOT NULL
  AND LTRIM(RTRIM(com_isvalidto)) <> ''
  AND TRY_CONVERT(DATETIME, com_isvalidto) IS NULL
  AND ISNULL(process_status, 'PENDING') = 'PENDING';


/* Invalid communication implemented date */
UPDATE stg_debtors
SET
    process_status = 'REJECTED',
    process_note = 'Invalid com_implementeddt'
WHERE com_implementeddt IS NOT NULL
  AND LTRIM(RTRIM(com_implementeddt)) <> ''
  AND TRY_CONVERT(DATETIME, com_implementeddt) IS NULL
  AND ISNULL(process_status, 'PENDING') = 'PENDING';


/* Invalid load date */
UPDATE stg_debtors
SET
    process_status = 'REJECTED',
    process_note = 'Invalid load_dt'
WHERE load_dt IS NULL
  AND ISNULL(process_status, 'PENDING') = 'PENDING';


/* Invalid relation_isactive */
UPDATE stg_debtors
SET
    process_status = 'REJECTED',
    process_note = 'Invalid relation_isactive'
WHERE relation_isactive IS NOT NULL
  AND LTRIM(RTRIM(relation_isactive)) <> ''
  AND UPPER(LTRIM(RTRIM(relation_isactive))) NOT IN ('1','0','TRUE','FALSE','YES','NO')
  AND ISNULL(process_status, 'PENDING') = 'PENDING';


/* Invalid com_isvalid */
UPDATE stg_debtors
SET
    process_status = 'REJECTED',
    process_note = 'Invalid com_isvalid'
WHERE com_isvalid IS NOT NULL
  AND LTRIM(RTRIM(com_isvalid)) <> ''
  AND UPPER(LTRIM(RTRIM(com_isvalid))) NOT IN ('1','0','TRUE','FALSE','YES','NO')
  AND ISNULL(process_status, 'PENDING') = 'PENDING';


/* Duplicate source_debtor_code inside staging */
WITH dup_source AS
(
    SELECT source_debtor_code
    FROM stg_debtors
    WHERE ISNULL(process_status, 'PENDING') = 'PENDING'
    GROUP BY source_debtor_code
    HAVING COUNT(*) > 1
)
UPDATE sd
SET
    process_status = 'REJECTED',
    process_note = 'Duplicate source_debtor_code in staging'
FROM stg_debtors sd
INNER JOIN dup_source d
    ON sd.source_debtor_code = d.source_debtor_code
WHERE ISNULL(sd.process_status, 'PENDING') = 'PENDING';


/* Duplicate tax number already existing in live table */
UPDATE sd
SET
    process_status = 'REJECTED',
    process_note = 'entity_taxnumber already exists in demographics'
FROM stg_debtors sd
INNER JOIN demographics d
    ON sd.entity_taxnumber = d.entity_taxnumber
WHERE ISNULL(sd.process_status, 'PENDING') = 'PENDING';


/* Duplicate tax number inside staging */
WITH dup_tax AS
(
    SELECT entity_taxnumber
    FROM stg_debtors
    WHERE ISNULL(process_status, 'PENDING') = 'PENDING'
      AND entity_taxnumber IS NOT NULL
      AND LTRIM(RTRIM(entity_taxnumber)) <> ''
    GROUP BY entity_taxnumber
    HAVING COUNT(*) > 1
)
UPDATE sd
SET
    process_status = 'REJECTED',
    process_note = 'Duplicate entity_taxnumber in staging'
FROM stg_debtors sd
INNER JOIN dup_tax d
    ON sd.entity_taxnumber = d.entity_taxnumber
WHERE ISNULL(sd.process_status, 'PENDING') = 'PENDING';


/* Mark remaining rows as valid */
UPDATE stg_debtors
SET
    process_status = 'VALID',
    process_note = 'Validation passed'
WHERE ISNULL(process_status, 'PENDING') = 'PENDING';

end



/*Validate Cases Data*/ 
Begin 

/* Reset notes only for rows still in process */
UPDATE stg_cases
SET process_note = NULL
WHERE process_status IN ('PENDING', 'VALID', 'REJECTED');


/* Missing source_case_code */
UPDATE stg_cases
SET
    process_status = 'REJECTED',
    process_note = 'Missing source_case_code'
WHERE (source_case_code IS NULL OR LTRIM(RTRIM(source_case_code)) = '')
  AND ISNULL(process_status, 'PENDING') = 'PENDING';


/* Missing debtor_source_code */
UPDATE stg_cases
SET
    process_status = 'REJECTED',
    process_note = 'Missing debtor_source_code'
WHERE (debtor_source_code IS NULL OR LTRIM(RTRIM(debtor_source_code)) = '')
  AND ISNULL(process_status, 'PENDING') = 'PENDING';


/* Missing case_refno */
UPDATE stg_cases
SET
    process_status = 'REJECTED',
    process_note = 'Missing case_refno'
WHERE (case_refno IS NULL OR LTRIM(RTRIM(case_refno)) = '')
  AND ISNULL(process_status, 'PENDING') = 'PENDING';


/* Missing case_owner_refno */
UPDATE stg_cases
SET
    process_status = 'REJECTED',
    process_note = 'Missing case_owner_refno'
WHERE (case_owner_refno IS NULL OR LTRIM(RTRIM(case_owner_refno)) = '')
  AND ISNULL(process_status, 'PENDING') = 'PENDING';


/* Missing case customer alias */
UPDATE stg_cases
SET
    process_status = 'REJECTED',
    process_note = 'Missing case_entitycustomer_alias'
WHERE (case_entitycustomer_alias IS NULL OR LTRIM(RTRIM(case_entitycustomer_alias)) = '')
  AND ISNULL(process_status, 'PENDING') = 'PENDING';


/* Missing assign customer alias */
UPDATE stg_cases
SET
    process_status = 'REJECTED',
    process_note = 'Missing assign_entitycustomer_alias'
WHERE (assign_entitycustomer_alias IS NULL OR LTRIM(RTRIM(assign_entitycustomer_alias)) = '')
  AND ISNULL(process_status, 'PENDING') = 'PENDING';


/* Invalid indatetime */
UPDATE stg_cases
SET
    process_status = 'REJECTED',
    process_note = 'Invalid indatetime'
WHERE indatetime IS NOT NULL
  AND LTRIM(RTRIM(indatetime)) <> ''
  AND TRY_CONVERT(DATETIME, indatetime) IS NULL
  AND ISNULL(process_status, 'PENDING') = 'PENDING';


/* Invalid dyn_assigndt */
UPDATE stg_cases
SET
    process_status = 'REJECTED',
    process_note = 'Invalid dyn_assigndt'
WHERE dyn_assigndt IS NOT NULL
  AND LTRIM(RTRIM(dyn_assigndt)) <> ''
  AND TRY_CONVERT(DATETIME, dyn_assigndt) IS NULL
  AND ISNULL(process_status, 'PENDING') = 'PENDING';


/* Invalid dyn_lastpaymentdt */
UPDATE stg_cases
SET
    process_status = 'REJECTED',
    process_note = 'Invalid dyn_lastpaymentdt'
WHERE dyn_lastpaymentdt IS NOT NULL
  AND LTRIM(RTRIM(dyn_lastpaymentdt)) <> ''
  AND TRY_CONVERT(DATETIME, dyn_lastpaymentdt) IS NULL
  AND ISNULL(process_status, 'PENDING') = 'PENDING';


/* Invalid assign_isactive */
UPDATE stg_cases
SET
    process_status = 'REJECTED',
    process_note = 'Invalid assign_isactive'
WHERE assign_isactive IS NOT NULL
  AND LTRIM(RTRIM(assign_isactive)) <> ''
  AND UPPER(LTRIM(RTRIM(assign_isactive))) NOT IN ('1','0','TRUE','FALSE','YES','NO')
  AND ISNULL(process_status, 'PENDING') = 'PENDING';


/* Invalid dyn_isactive */
UPDATE stg_cases
SET
    process_status = 'REJECTED',
    process_note = 'Invalid dyn_isactive'
WHERE dyn_isactive IS NOT NULL
  AND LTRIM(RTRIM(dyn_isactive)) <> ''
  AND UPPER(LTRIM(RTRIM(dyn_isactive))) NOT IN ('1','0','TRUE','FALSE','YES','NO')
  AND ISNULL(process_status, 'PENDING') = 'PENDING';


/* Invalid dyn_debtamount */
UPDATE stg_cases
SET
    process_status = 'REJECTED',
    process_note = 'Invalid dyn_debtamount'
WHERE dyn_debtamount IS NOT NULL
  AND LTRIM(RTRIM(dyn_debtamount)) <> ''
  AND TRY_CONVERT(DECIMAL(18,2), dyn_debtamount) IS NULL
  AND ISNULL(process_status, 'PENDING') = 'PENDING';


/* Invalid dyn_balance_amount */
UPDATE stg_cases
SET
    process_status = 'REJECTED',
    process_note = 'Invalid dyn_balance_amount'
WHERE dyn_balance_amount IS NOT NULL
  AND LTRIM(RTRIM(dyn_balance_amount)) <> ''
  AND TRY_CONVERT(DECIMAL(18,2), dyn_balance_amount) IS NULL
  AND ISNULL(process_status, 'PENDING') = 'PENDING';


/* Invalid dyn_lastpaymentamount */
UPDATE stg_cases
SET
    process_status = 'REJECTED',
    process_note = 'Invalid dyn_lastpaymentamount'
WHERE dyn_lastpaymentamount IS NOT NULL
  AND LTRIM(RTRIM(dyn_lastpaymentamount)) <> ''
  AND TRY_CONVERT(DECIMAL(18,2), dyn_lastpaymentamount) IS NULL
  AND ISNULL(process_status, 'PENDING') = 'PENDING';


/* Invalid dyn_totalpaidamount */
UPDATE stg_cases
SET
    process_status = 'REJECTED',
    process_note = 'Invalid dyn_totalpaidamount'
WHERE dyn_totalpaidamount IS NOT NULL
  AND LTRIM(RTRIM(dyn_totalpaidamount)) <> ''
  AND TRY_CONVERT(DECIMAL(18,2), dyn_totalpaidamount) IS NULL
  AND ISNULL(process_status, 'PENDING') = 'PENDING';


/* Duplicate source_case_code in staging */
WITH dup_source AS
(
    SELECT source_case_code
    FROM stg_cases
    WHERE ISNULL(process_status, 'PENDING') = 'PENDING'
    GROUP BY source_case_code
    HAVING COUNT(*) > 1
)
UPDATE sc
SET
    process_status = 'REJECTED',
    process_note = 'Duplicate source_case_code in staging'
FROM stg_cases sc
INNER JOIN dup_source d
    ON sc.source_case_code = d.source_case_code
WHERE ISNULL(sc.process_status, 'PENDING') = 'PENDING';


/* Duplicate case_refno in staging */
WITH dup_ref AS
(
    SELECT case_refno
    FROM stg_cases
    WHERE ISNULL(process_status, 'PENDING') = 'PENDING'
    GROUP BY case_refno
    HAVING COUNT(*) > 1
)
UPDATE sc
SET
    process_status = 'REJECTED',
    process_note = 'Duplicate case_refno in staging'
FROM stg_cases sc
INNER JOIN dup_ref d
    ON sc.case_refno = d.case_refno
WHERE ISNULL(sc.process_status, 'PENDING') = 'PENDING';


/* case_refno already exists in live table */
UPDATE sc
SET
    process_status = 'REJECTED',
    process_note = 'case_refno already exists in cases'
FROM stg_cases sc
INNER JOIN cases c
    ON sc.case_refno = c.case_refno
WHERE ISNULL(sc.process_status, 'PENDING') = 'PENDING';


/* debtor_source_code not found in loaded debtors staging */
UPDATE sc
SET
    process_status = 'REJECTED',
    process_note = 'debtor_source_code not found in stg_debtors'
FROM stg_cases sc
LEFT JOIN stg_debtors sd
    ON sc.debtor_source_code = sd.source_debtor_code
   AND sd.process_status = 'LOADED'
WHERE sd.source_debtor_code IS NULL
  AND ISNULL(sc.process_status, 'PENDING') = 'PENDING';


/* case customer alias not found in entities */
UPDATE sc
SET
    process_status = 'REJECTED',
    process_note = 'case_entitycustomer_alias not found in entities'
FROM stg_cases sc
LEFT JOIN entities e
    ON sc.case_entitycustomer_alias = e.entity_alias
WHERE e.entity_id IS NULL
  AND ISNULL(sc.process_status, 'PENDING') = 'PENDING';


/* assign customer alias not found in entities */
UPDATE sc
SET
    process_status = 'REJECTED',
    process_note = 'assign_entitycustomer_alias not found in entities'
FROM stg_cases sc
LEFT JOIN entities e
    ON sc.assign_entitycustomer_alias = e.entity_alias
WHERE e.entity_id IS NULL
  AND ISNULL(sc.process_status, 'PENDING') = 'PENDING';


/* Mark remaining rows as valid */
UPDATE stg_cases
SET
    process_status = 'VALID',
    process_note = 'Validation passed'
WHERE ISNULL(process_status, 'PENDING') = 'PENDING';

end


/*Validate Payments Data*/

Begin 

/* Reset notes for rows still under processing */
UPDATE stg_payments
SET process_note = NULL
WHERE process_status IN ('PENDING', 'VALID', 'REJECTED');


/* Missing source_payment_code */
UPDATE stg_payments
SET
    process_status = 'REJECTED',
    process_note = 'Missing source_payment_code'
WHERE (source_payment_code IS NULL OR LTRIM(RTRIM(source_payment_code)) = '')
  AND ISNULL(process_status, 'PENDING') = 'PENDING';


/* Missing source_case_code */
UPDATE stg_payments
SET
    process_status = 'REJECTED',
    process_note = 'Missing source_case_code'
WHERE (source_case_code IS NULL OR LTRIM(RTRIM(source_case_code)) = '')
  AND ISNULL(process_status, 'PENDING') = 'PENDING';


/* Missing tran_type */
UPDATE stg_payments
SET
    process_status = 'REJECTED',
    process_note = 'Missing tran_type'
WHERE (tran_type IS NULL OR LTRIM(RTRIM(tran_type)) = '')
  AND ISNULL(process_status, 'PENDING') = 'PENDING';


/* Invalid tran_amount */
UPDATE stg_payments
SET
    process_status = 'REJECTED',
    process_note = 'Invalid tran_amount'
WHERE tran_amount IS NOT NULL
  AND LTRIM(RTRIM(tran_amount)) <> ''
  AND TRY_CONVERT(DECIMAL(18,2), tran_amount) IS NULL
  AND ISNULL(process_status, 'PENDING') = 'PENDING';


/* Invalid tran_debtamount */
UPDATE stg_payments
SET
    process_status = 'REJECTED',
    process_note = 'Invalid tran_debtamount'
WHERE tran_debtamount IS NOT NULL
  AND LTRIM(RTRIM(tran_debtamount)) <> ''
  AND TRY_CONVERT(DECIMAL(18,2), tran_debtamount) IS NULL
  AND ISNULL(process_status, 'PENDING') = 'PENDING';


/* Invalid tran_registerdt */
UPDATE stg_payments
SET
    process_status = 'REJECTED',
    process_note = 'Invalid tran_registerdt'
WHERE tran_registerdt IS NOT NULL
  AND LTRIM(RTRIM(tran_registerdt)) <> ''
  AND TRY_CONVERT(DATETIME, tran_registerdt) IS NULL
  AND ISNULL(process_status, 'PENDING') = 'PENDING';


/* Duplicate source_payment_code in staging */
WITH dup_source AS
(
    SELECT source_payment_code
    FROM stg_payments
    WHERE ISNULL(process_status, 'PENDING') = 'PENDING'
    GROUP BY source_payment_code
    HAVING COUNT(*) > 1
)
UPDATE sp
SET
    process_status = 'REJECTED',
    process_note = 'Duplicate source_payment_code in staging'
FROM stg_payments sp
INNER JOIN dup_source d
    ON sp.source_payment_code = d.source_payment_code
WHERE ISNULL(sp.process_status, 'PENDING') = 'PENDING';


/* source_case_code not found in loaded cases staging */
UPDATE sp
SET
    process_status = 'REJECTED',
    process_note = 'source_case_code not found in stg_cases'
FROM stg_payments sp
LEFT JOIN stg_cases sc
    ON sp.source_case_code = sc.source_case_code
   AND sc.process_status = 'LOADED'
WHERE sc.source_case_code IS NULL
  AND ISNULL(sp.process_status, 'PENDING') = 'PENDING';


/* Mark remaining rows as valid */
UPDATE stg_payments
SET
    process_status = 'VALID',
    process_note = 'Validation passed'
WHERE ISNULL(process_status, 'PENDING') = 'PENDING';

end 