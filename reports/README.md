# Debt Collection Portfolio Report | SSRS

A multi-page SSRS paginated report built on top of a SQL Server debt collection dataset.

This report was created as a portfolio project to demonstrate report design, stored procedure usage, multi-page layout, internal navigation, and operational/financial reporting in SQL Server Reporting Services (SSRS).

---

## Report Overview

The report is designed as a **4-page reporting pack** for a debt collection scenario.

It combines operational, financial, and contact information into a single paginated SSRS report with internal bookmark navigation between sections.

The report was built in **Microsoft Report Builder** and is intended to show practical reporting skills using **SSRS** and **SQL Server**.

---

## Report Pages

### 1. Collection Case Overview
A high-level summary of collection cases and assignments.

Includes fields such as:
- case reference
- creditor
- debtor
- assignment status
- debt amount
- balance amount
- total paid
- last payment date
- bucket
- phone
- email
- latest action

### 2. Assignment History
A detailed operational history page showing assignment activity and related actions.

Includes fields such as:
- case reference
- debtor
- creditor
- assignment date
- assignment status
- active flag
- action type
- action date
- action by
- action status
- action notes

### 3. Payments and Balances
A financial view of each case and assignment.

Includes fields such as:
- case reference
- creditor
- debtor
- debt amount
- total paid
- balance amount
- last payment amount
- last payment date
- payment count
- current bucket

### 4. Debtor Contact Sheet
A contact-focused page for debtor communication details.

Includes fields such as:
- case reference
- creditor
- debtor
- tax number
- identity number
- phone number
- email address
- address
- city
- country
- assignment status

---

## Report Features

- Multi-page SSRS paginated report
- One section per page
- Internal bookmark navigation between pages
- Document map navigation
- Page breaks between report sections
- Stored procedure-based datasets
- Operational and financial reporting views
- Portfolio-friendly report structure

---

## Technical Implementation

The report uses **SQL Server stored procedures** as datasets instead of embedding large SQL queries directly inside SSRS.

Stored procedures used:

- `dbo.usp_rpt_CaseOverview`
- `dbo.usp_rpt_AssignmentHistory`
- `dbo.usp_rpt_PaymentsBalances`
- `dbo.usp_rpt_DebtorContactSheet`

This approach keeps the data logic inside SQL Server and keeps the SSRS layer focused on report presentation.

---

## Tools Used

- SQL Server
- SQL Server Reporting Services (SSRS)
- Microsoft Report Builder
- SQL Server Management Studio (SSMS)

---


## File Included

- `DebtCollectionPortfolioReport.rdl`

---

## Purpose

The purpose of this report is to demonstrate:

- SSRS report development
- use of stored procedures in reporting
- paginated report design
- multi-page report organization
- internal report navigation
- presentation of business data in a professional reporting format

---

## Author

Portfolio project created to showcase SQL Server and SSRS reporting skills.
