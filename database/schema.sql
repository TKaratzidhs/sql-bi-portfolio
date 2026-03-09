CREATE TABLE entities (
    entity_id INT IDENTITY(1,1) PRIMARY KEY,
    entity_alias NVARCHAR(100),
    createdt DATETIME DEFAULT GETDATE(),
    updatedt DATETIME
);


CREATE TABLE demographics (
    entity_id INT PRIMARY KEY,
    entity_taxnumber NVARCHAR(50),
    entity_identitynumber NVARCHAR(50),
    entity_nationality NVARCHAR(50),
    entity_secondnationality NVARCHAR(50),
    entity_dateofbirth DATE,
    entity_birthplace NVARCHAR(100),
    entity_firstname NVARCHAR(100),
    entity_midname NVARCHAR(100),
    entity_lastname NVARCHAR(100),
    entity_fathername NVARCHAR(100),
    entity_mothername NVARCHAR(100),
    createdt DATETIME DEFAULT GETDATE(),
    updatedt DATETIME,

    CONSTRAINT FK_demographics_entities
    FOREIGN KEY (entity_id) REFERENCES entities(entity_id)
);


CREATE TABLE relations (
    relation_id INT IDENTITY(1,1) PRIMARY KEY,
    entity_id INT,
    relation_type NVARCHAR(50),
    relation_isactive BIT,
    relation_implementedby NVARCHAR(100),
    relation_implementationdt DATETIME,
    createdt DATETIME DEFAULT GETDATE(),
    updatedt DATETIME,

    CONSTRAINT FK_relations_entities
    FOREIGN KEY (entity_id) REFERENCES entities(entity_id)
);


CREATE TABLE cases (
    case_id INT IDENTITY(1,1) PRIMARY KEY,
    case_refno NVARCHAR(50),
    case_owner_refno NVARCHAR(50),
    case_owner_relation_id INT,
    creatdt DATETIME DEFAULT GETDATE(),
    updatedt DATETIME,
    case_entitycustomer_id INT,

    CONSTRAINT FK_cases_owner_relation
    FOREIGN KEY (case_owner_relation_id) REFERENCES relations(relation_id),

    CONSTRAINT FK_cases_entity
    FOREIGN KEY (case_entitycustomer_id) REFERENCES entities(entity_id)
);


CREATE TABLE assignments (
    assign_id INT IDENTITY(1,1) PRIMARY KEY,
    assign_isactive BIT,
    assign_status NVARCHAR(50),
    indatetime DATETIME,
    case_id INT,
    assign_notes NVARCHAR(MAX),
    createdt DATETIME DEFAULT GETDATE(),
    updatedt DATETIME,
    assign_entitycustomer_id INT,

    CONSTRAINT FK_assignments_cases
    FOREIGN KEY (case_id) REFERENCES cases(case_id),

    CONSTRAINT FK_assignments_entities
    FOREIGN KEY (assign_entitycustomer_id) REFERENCES entities(entity_id)
);


CREATE TABLE transactions (
    tran_id INT IDENTITY(1,1) PRIMARY KEY,
    assign_id INT,
    tran_type NVARCHAR(50),
    tran_amount DECIMAL(18,2),
    tran_debtamount DECIMAL(18,2),
    tran_registerdt DATETIME,
    createdt DATETIME DEFAULT GETDATE(),
    updatedt DATETIME,

    CONSTRAINT FK_transactions_assignments
    FOREIGN KEY (assign_id) REFERENCES assignments(assign_id)
);


CREATE TABLE actions (
    act_id INT IDENTITY(1,1) PRIMARY KEY,
    assign_id INT,
    act_type NVARCHAR(50),
    act_notes NVARCHAR(MAX),
    act_implementeddt DATETIME,
    act_implementedby NVARCHAR(100),
    act_status NVARCHAR(50),
    createdt DATETIME DEFAULT GETDATE(),
    updatedt DATETIME,

    CONSTRAINT FK_actions_assignments
    FOREIGN KEY (assign_id) REFERENCES assignments(assign_id)
);


CREATE TABLE dynamic_fields (
    assign_id INT PRIMARY KEY,
    case_refno NVARCHAR(50),
    dyn_assigndt DATETIME,
    dyn_isactive BIT,
    dyn_owner_entity_alias NVARCHAR(100),
    dyn_customer_entity_alias NVARCHAR(100),
    dyn_debtamount DECIMAL(18,2),
    dyn_balance_amount DECIMAL(18,2),
    dyn_lastpaymentamount DECIMAL(18,2),
    dyn_lastpaymentdt DATETIME,
    dyn_totalpaidamount DECIMAL(18,2),
    dyn_initialbucket NVARCHAR(50),
    dyn_currentbucket NVARCHAR(50),
    createdt DATETIME DEFAULT GETDATE(),
    updatedt DATETIME,

    CONSTRAINT FK_dynamic_assignments
    FOREIGN KEY (assign_id) REFERENCES assignments(assign_id)
);


CREATE TABLE communication (
    com_id INT IDENTITY(1,1) PRIMARY KEY,
    entity_id INT,
    com_type NVARCHAR(50),
    com_isvalid BIT,
    com_isvalidfrom DATETIME,
    com_isvalidto DATETIME,
    com_implementedby NVARCHAR(100),
    com_implementeddt DATETIME,
    createdt DATETIME DEFAULT GETDATE(),
    updatedt DATETIME,

    CONSTRAINT FK_communication_entities
    FOREIGN KEY (entity_id) REFERENCES entities(entity_id)
);


CREATE TABLE phones (
    phone_id INT IDENTITY(1,1) PRIMARY KEY,
    com_id INT,
    phone_type NVARCHAR(50),
    phone_number NVARCHAR(30),
    phone_areacode NVARCHAR(10),
    createdt DATETIME DEFAULT GETDATE(),
    updatedt DATETIME,

    CONSTRAINT FK_phones_communication
    FOREIGN KEY (com_id) REFERENCES communication(com_id)
);


CREATE TABLE addresses (
    address_id INT IDENTITY(1,1) PRIMARY KEY,
    com_id INT,
    add_streetnum NVARCHAR(20),
    add_streetname NVARCHAR(100),
    add_cityname NVARCHAR(100),
    add_country NVARCHAR(100),
    add_type NVARCHAR(50),
    createdt DATETIME DEFAULT GETDATE(),
    updatedt DATETIME,

    CONSTRAINT FK_addresses_communication
    FOREIGN KEY (com_id) REFERENCES communication(com_id)
);


CREATE TABLE email (
    email_id INT IDENTITY(1,1) PRIMARY KEY,
    com_id INT,
    email_descr NVARCHAR(200),
    email_type NVARCHAR(50),
    createdt DATETIME DEFAULT GETDATE(),
    updatedt DATETIME,

    CONSTRAINT FK_email_communication
    FOREIGN KEY (com_id) REFERENCES communication(com_id)
);



