CREATE TABLE [dbo].[stg_cases](
	[stg_case_id] [int] IDENTITY(1,1) NOT NULL,
	[case_id] [uniqueidentifier] NULL,
	[assign_id] [uniqueidentifier] NULL,
	[source_case_code] [nvarchar](50) NULL,
	[debtor_source_code] [nvarchar](50) NULL,
	[case_refno] [nvarchar](50) NULL,
	[case_owner_refno] [nvarchar](50) NULL,
	[case_entitycustomer_alias] [nvarchar](100) NULL,
	[assign_isactive] [nvarchar](10) NULL,
	[assign_status] [nvarchar](50) NULL,
	[indatetime] [nvarchar](50) NULL,
	[assign_notes] [nvarchar](max) NULL,
	[assign_entitycustomer_alias] [nvarchar](100) NULL,
	[dyn_assigndt] [nvarchar](50) NULL,
	[dyn_isactive] [nvarchar](10) NULL,
	[dyn_owner_entity_alias] [nvarchar](100) NULL,
	[dyn_customer_entity_alias] [nvarchar](100) NULL,
	[dyn_debtamount] [nvarchar](50) NULL,
	[dyn_balance_amount] [nvarchar](50) NULL,
	[dyn_lastpaymentamount] [nvarchar](50) NULL,
	[dyn_lastpaymentdt] [nvarchar](50) NULL,
	[dyn_totalpaidamount] [nvarchar](50) NULL,
	[dyn_initialbucket] [nvarchar](50) NULL,
	[dyn_currentbucket] [nvarchar](50) NULL,
	[load_dt] [datetime] NULL,
	[process_status] [nvarchar](20) NULL,
	[process_note] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[stg_case_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]


CREATE TABLE [dbo].[stg_debtors](
	[stg_debtor_id] [int] IDENTITY(1,1) NOT NULL,
	[entity_id] [uniqueidentifier] NULL,
	[relation_id] [uniqueidentifier] NULL,
	[com_id] [uniqueidentifier] NULL,
	[phone_id] [uniqueidentifier] NULL,
	[address_id] [uniqueidentifier] NULL,
	[email_id] [uniqueidentifier] NULL,
	[source_debtor_code] [nvarchar](50) NULL,
	[entity_alias] [nvarchar](100) NULL,
	[entity_taxnumber] [nvarchar](50) NULL,
	[entity_identitynumber] [nvarchar](50) NULL,
	[entity_nationality] [nvarchar](50) NULL,
	[entity_secondnationality] [nvarchar](50) NULL,
	[entity_dateofbirth] [nvarchar](50) NULL,
	[entity_birthplace] [nvarchar](100) NULL,
	[entity_firstname] [nvarchar](100) NULL,
	[entity_midname] [nvarchar](100) NULL,
	[entity_lastname] [nvarchar](100) NULL,
	[entity_fathername] [nvarchar](100) NULL,
	[entity_mothername] [nvarchar](100) NULL,
	[relation_type] [nvarchar](50) NULL,
	[relation_isactive] [nvarchar](10) NULL,
	[com_type] [nvarchar](50) NULL,
	[com_isvalid] [nvarchar](10) NULL,
	[com_isvalidfrom] [nvarchar](50) NULL,
	[com_isvalidto] [nvarchar](50) NULL,
	[com_implementedby] [nvarchar](100) NULL,
	[com_implementeddt] [nvarchar](50) NULL,
	[phone_type] [nvarchar](50) NULL,
	[phone_number] [nvarchar](30) NULL,
	[phone_areacode] [nvarchar](10) NULL,
	[email_descr] [nvarchar](200) NULL,
	[email_type] [nvarchar](50) NULL,
	[add_streetnum] [nvarchar](20) NULL,
	[add_streetname] [nvarchar](100) NULL,
	[add_cityname] [nvarchar](100) NULL,
	[add_country] [nvarchar](100) NULL,
	[add_type] [nvarchar](50) NULL,
	[load_dt] [datetime] NULL,
	[process_status] [nvarchar](20) NULL,
	[process_note] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[stg_debtor_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]




CREATE TABLE [dbo].[stg_payments](
	[stg_payment_id] [int] IDENTITY(1,1) NOT NULL,
	[tran_id] [uniqueidentifier] NULL,
	[source_payment_code] [nvarchar](50) NULL,
	[source_case_code] [nvarchar](50) NULL,
	[tran_type] [nvarchar](50) NULL,
	[tran_amount] [nvarchar](50) NULL,
	[tran_debtamount] [nvarchar](50) NULL,
	[tran_registerdt] [nvarchar](50) NULL,
	[load_dt] [datetime] NULL,
	[process_status] [nvarchar](20) NULL,
	[process_note] [nvarchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[stg_payment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]



CREATE TABLE [dbo].[etl_execution_log](
	[log_id] [int] IDENTITY(1,1) NOT NULL,
	[package_name] [nvarchar](200) NULL,
	[step_name] [nvarchar](200) NULL,
	[status] [nvarchar](20) NULL,
	[row_count] [int] NULL,
	[log_message] [nvarchar](1000) NULL,
	[log_dt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[log_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]


CREATE TABLE [dbo].[etl_rejected_rows](
	[reject_id] [int] IDENTITY(1,1) NOT NULL,
	[source_table] [nvarchar](50) NULL,
	[source_row_key] [nvarchar](100) NULL,
	[rejection_reason] [nvarchar](500) NULL,
	[rejected_dt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[reject_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
