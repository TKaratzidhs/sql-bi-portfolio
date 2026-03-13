
# DebtCollection-ETL-SSIS

ETL pipeline project built with SQL Server Integration Services (SSIS) for importing and validating debt collection data into a normalized SQL Server database.

## Project Overview

This project simulates a real-world ETL process where debtor, case, and payment data is received from flat files and loaded into SQL Server through a staging and validation layer before reaching the live tables.

The solution was built to demonstrate practical SQL Server and BI development skills, including:

- SSIS package development
- staging-based ETL design
- data validation before live inserts
- logging of rejected rows
- execution logging
- loading into a normalized relational schema
- referential integrity checks after load

## Technologies Used

- SQL Server
- SQL Server Integration Services (SSIS)
- T-SQL
- CSV flat files
- Visual Studio

## Data Flow

The ETL pipeline follows this structure:

1. Load source CSV files into staging tables
2. Generate required GUID identifiers in staging
3. Validate business and technical rules in staging
4. Log rejected rows
5. Insert only validated rows into live tables
6. Log package execution steps
7. Verify relationships between staging and target tables

## Source Files

The package imports data from:

- `debtors.csv`
- `cases.csv`
- `payments.csv`

## Staging Tables

The staging layer includes:

- `stg_debtors`
- `stg_cases`
- `stg_payments`

Additional ETL support tables:

- `etl_rejected_rows`
- `etl_execution_log`

## Target Tables

Validated data is loaded into the existing normalized business schema:

- `entities`
- `demographics`
- `relations`
- `cases`
- `assignments`
- `transactions`
- `dynamic_fields`
- `communication`
- `phones`
- `addresses`
- `email`

## ETL Logic

### Debtors
Debtor records are loaded into staging, assigned GUIDs, validated, and then inserted into:

- `entities`
- `demographics`
- `relations`
- `communication`
- `phones`
- `addresses`
- `email`

### Cases
Case records are validated against already loaded debtor data and inserted into:

- `cases`
- `assignments`
- `dynamic_fields`

### Payments
Payment records are validated against loaded case data and inserted into:

- `transactions`

## Validation Rules

Example validation checks included in the package:

- required business keys must exist
- date values must be convertible
- decimal amounts must be valid
- duplicate keys in staging are rejected
- existing live duplicates are rejected
- case rows must reference valid debtors
- payment rows must reference valid cases

Only rows marked as `VALID` are inserted into live tables.

## Logging

The project includes two ETL logging mechanisms:

### Rejected Rows Log
`etl_rejected_rows` stores rows that fail validation, including the source row key and rejection reason.

### Execution Log
`etl_execution_log` stores package execution events and ETL step status.

## Data Integrity Checks

After load, validation queries were used to confirm:

- staging IDs exist in target tables
- case records link to the correct debtor relation
- payment records link to the correct assignment
- no orphan records exist in related target tables

## Repository Structure

```text
DebtCollection-ETL-SSIS/
│
├── README.md
├── ssis/
├── sql/
└── sample-data/
