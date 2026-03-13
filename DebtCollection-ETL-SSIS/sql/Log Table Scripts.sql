/*Log Start - End*/
Begin 

INSERT INTO etl_execution_log
(
    package_name,
    step_name,
    status,
    row_count,
    log_message,
    log_dt
)
VALUES
(
    'SSIS_Demo',
    'Package Start',
    'STARTED',
    NULL,
    'SSIS package execution started',
    GETDATE()
);

INSERT INTO etl_execution_log
(
    package_name,
    step_name,
    status,
    row_count,
    log_message,
    log_dt
)
VALUES
(
    'SSIS_Demo',
    'Package End',
    'SUCCESS',
    NULL,
    'SSIS package execution completed',
    GETDATE()
);

End 

/*Log Rejected Rows*/

Begin 

INSERT INTO etl_rejected_rows
(
    source_table,
    source_row_key,
    rejection_reason,
    rejected_dt
)
SELECT
    'stg_debtors',
    source_debtor_code,
    process_note,
    GETDATE()
FROM stg_debtors
WHERE process_status = 'REJECTED';

INSERT INTO etl_rejected_rows
(
    source_table,
    source_row_key,
    rejection_reason,
    rejected_dt
)
SELECT
    'stg_cases',
    source_case_code,
    process_note,
    GETDATE()
FROM stg_cases
WHERE process_status = 'REJECTED';

INSERT INTO etl_rejected_rows
(
    source_table,
    source_row_key,
    rejection_reason,
    rejected_dt
)
SELECT
    'stg_payments',
    source_payment_code,
    process_note,
    GETDATE()
FROM stg_payments
WHERE process_status = 'REJECTED';

End 