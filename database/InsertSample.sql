/* =========================================
   ENTITY IDs
   ========================================= */

DECLARE @NBG UNIQUEIDENTIFIER = NEWID();
DECLARE @ALPHA UNIQUEIDENTIFIER = NEWID();
DECLARE @DEH UNIQUEIDENTIFIER = NEWID();
DECLARE @OTE UNIQUEIDENTIFIER = NEWID();

DECLARE @GIANNIS UNIQUEIDENTIFIER = NEWID();
DECLARE @MARIA UNIQUEIDENTIFIER = NEWID();
DECLARE @NIKOS UNIQUEIDENTIFIER = NEWID();
DECLARE @ELENI UNIQUEIDENTIFIER = NEWID();
DECLARE @PETROS UNIQUEIDENTIFIER = NEWID();
DECLARE @DIMITRA UNIQUEIDENTIFIER = NEWID();
DECLARE @KOSTAS UNIQUEIDENTIFIER = NEWID();
DECLARE @ANNA UNIQUEIDENTIFIER = NEWID();
DECLARE @GEORGE UNIQUEIDENTIFIER = NEWID();
DECLARE @SOFIA UNIQUEIDENTIFIER = NEWID();

DECLARE @AGENT_NIKOS UNIQUEIDENTIFIER = NEWID();
DECLARE @AGENT_MARIA UNIQUEIDENTIFIER = NEWID();


/* =========================================
   ENTITIES
   ========================================= */

INSERT INTO entities (entity_id, entity_alias, createdt) VALUES
(@NBG,'National Bank of Greece','2025-03-01'),
(@ALPHA,'Alpha Bank','2025-03-01'),
(@DEH,'DEH','2025-03-01'),
(@OTE,'OTE','2025-03-01'),

(@GIANNIS,'Giannis Papadopoulos','2025-03-01'),
(@MARIA,'Maria Georgiou','2025-03-01'),
(@NIKOS,'Nikos Dimitriou','2025-03-01'),
(@ELENI,'Eleni Kosta','2025-03-01'),
(@PETROS,'Petros Antoniou','2025-03-01'),
(@DIMITRA,'Dimitra Savva','2025-03-01'),
(@KOSTAS,'Kostas Ioannou','2025-03-01'),
(@ANNA,'Anna Michail','2025-03-01'),
(@GEORGE,'George Laskaris','2025-03-01'),
(@SOFIA,'Sofia Kaneli','2025-03-01'),

(@AGENT_NIKOS,'Agent Nikos','2025-03-01'),
(@AGENT_MARIA,'Agent Maria','2025-03-01');


/* =========================================
   DEMOGRAPHICS
   ========================================= */

INSERT INTO demographics (
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
updatedt
)
VALUES

-- BANKS / COMPANIES
(@NBG,'AFM200001','CID100001','Greek','None','1950-01-01','Athens','National','Main','Bank','Corporate','Entity',GETDATE()),
(@ALPHA,'AFM200002','CID100002','Greek','None','1950-01-01','Athens','Alpha','Main','Bank','Corporate','Entity',GETDATE()),
(@DEH,'AFM200003','CID100003','Greek','None','1950-01-01','Athens','Public','Power','Corporation','Corporate','Entity',GETDATE()),
(@OTE,'AFM200004','CID100004','Greek','None','1950-01-01','Athens','Hellenic','Telecom','Organization','Corporate','Entity',GETDATE()),


-- DEBTORS
(@GIANNIS,'AFM100001','ID900001','Greek','None','1985-03-12','Athens','Giannis','K','Papadopoulos','Dimitris','Eleni',GETDATE()),

(@MARIA,'AFM100002','ID900002','Greek','None','1988-07-22','Patras','Maria','A','Georgiou','Antonis','Sofia',GETDATE()),

(@NIKOS,'AFM100003','ID900003','Greek','None','1979-11-03','Thessaloniki','Nikos','P','Dimitriou','Panagiotis','Maria',GETDATE()),

(@ELENI,'AFM100004','ID900004','Greek','None','1991-06-18','Larissa','Eleni','D','Kosta','Giannis','Anna',GETDATE()),

(@PETROS,'AFM100005','ID900005','Greek','None','1984-09-14','Athens','Petros','L','Antoniou','Leonidas','Georgia',GETDATE()),

(@DIMITRA,'AFM100006','ID900006','Greek','None','1990-02-27','Heraklion','Dimitra','S','Savva','Spyros','Eirini',GETDATE()),

(@KOSTAS,'AFM100007','ID900007','Greek','None','1982-05-09','Volos','Kostas','M','Ioannou','Michalis','Eleni',GETDATE()),

(@ANNA,'AFM100008','ID900008','Greek','None','1993-12-01','Athens','Anna','T','Michail','Theodoros','Maria',GETDATE()),

(@GEORGE,'AFM100009','ID900009','Greek','None','1978-04-30','Ioannina','George','N','Laskaris','Nikolaos','Sofia',GETDATE()),

(@SOFIA,'AFM100010','ID900010','Greek','None','1987-10-11','Kalamata','Sofia','E','Kaneli','Evangelos','Dimitra',GETDATE());

/* =========================================
   RELATIONS
   ========================================= */

DECLARE @REL_GIANNIS UNIQUEIDENTIFIER = NEWID();
DECLARE @REL_MARIA UNIQUEIDENTIFIER = NEWID();
DECLARE @REL_NIKOS UNIQUEIDENTIFIER = NEWID();
DECLARE @REL_ELENI UNIQUEIDENTIFIER = NEWID();
DECLARE @REL_PETROS UNIQUEIDENTIFIER = NEWID();
DECLARE @REL_DIMITRA UNIQUEIDENTIFIER = NEWID();
DECLARE @REL_KOSTAS UNIQUEIDENTIFIER = NEWID();
DECLARE @REL_ANNA UNIQUEIDENTIFIER = NEWID();
DECLARE @REL_GEORGE UNIQUEIDENTIFIER = NEWID();
DECLARE @REL_SOFIA UNIQUEIDENTIFIER = NEWID();

INSERT INTO relations (relation_id,
    entity_id,
    relation_type,
    relation_isactive,
    relation_implementedby,
    relation_implementationdt)values
(@REL_GIANNIS,@GIANNIS,'debtor',1,'system','2025-03-01'),
(@REL_MARIA,@MARIA,'debtor',1,'system','2025-03-01'),
(@REL_NIKOS,@NIKOS,'debtor',1,'system','2025-03-01'),
(@REL_ELENI,@ELENI,'debtor',1,'system','2025-03-01'),
(@REL_PETROS,@PETROS,'debtor',1,'system','2025-03-01'),
(@REL_DIMITRA,@DIMITRA,'debtor',1,'system','2025-03-01'),
(@REL_KOSTAS,@KOSTAS,'debtor',1,'system','2025-03-01'),
(@REL_ANNA,@ANNA,'debtor',1,'system','2025-03-01'),
(@REL_GEORGE,@GEORGE,'debtor',1,'system','2025-03-01'),
(@REL_SOFIA,@SOFIA,'debtor',1,'system','2025-03-01');


/* =========================================
   CASES
   ========================================= */

DECLARE @CASE1 UNIQUEIDENTIFIER = NEWID();
DECLARE @CASE2 UNIQUEIDENTIFIER = NEWID();
DECLARE @CASE3 UNIQUEIDENTIFIER = NEWID();
DECLARE @CASE4 UNIQUEIDENTIFIER = NEWID();
DECLARE @CASE5 UNIQUEIDENTIFIER = NEWID();
DECLARE @CASE6 UNIQUEIDENTIFIER = NEWID();
DECLARE @CASE7 UNIQUEIDENTIFIER = NEWID();
DECLARE @CASE8 UNIQUEIDENTIFIER = NEWID();
DECLARE @CASE9 UNIQUEIDENTIFIER = NEWID();
DECLARE @CASE10 UNIQUEIDENTIFIER = NEWID();

INSERT INTO cases(
case_id,
case_refno,
case_owner_refno,
case_owner_relation_id,
case_entitycustomer_id,
createdt) VALUES
(@CASE1,'CASE-1001','NBG-1',@REL_GIANNIS,@NBG,'2025-03-03'),
(@CASE2,'CASE-1002','NBG-2',@REL_MARIA,@NBG,'2025-03-04'),
(@CASE3,'CASE-1003','ALPHA-1',@REL_NIKOS,@ALPHA,'2025-03-05'),
(@CASE4,'CASE-1004','ALPHA-2',@REL_ELENI,@ALPHA,'2025-03-05'),
(@CASE5,'CASE-1005','DEH-1',@REL_PETROS,@DEH,'2025-03-06'),
(@CASE6,'CASE-1006','DEH-2',@REL_DIMITRA,@DEH,'2025-03-06'),
(@CASE7,'CASE-1007','OTE-1',@REL_KOSTAS,@OTE,'2025-03-07'),
(@CASE8,'CASE-1008','OTE-2',@REL_ANNA,@OTE,'2025-03-07'),
(@CASE9,'CASE-1009','NBG-3',@REL_GEORGE,@NBG,'2025-03-08'),
(@CASE10,'CASE-1010','ALPHA-3',@REL_SOFIA,@ALPHA,'2025-03-08');

/* =========================================
   ASSIGNMENTS
   ========================================= */

DECLARE @ASSIGN1 UNIQUEIDENTIFIER = NEWID();
DECLARE @ASSIGN2 UNIQUEIDENTIFIER = NEWID();
DECLARE @ASSIGN3 UNIQUEIDENTIFIER = NEWID();
DECLARE @ASSIGN4 UNIQUEIDENTIFIER = NEWID();
DECLARE @ASSIGN5 UNIQUEIDENTIFIER = NEWID();
DECLARE @ASSIGN6 UNIQUEIDENTIFIER = NEWID();
DECLARE @ASSIGN7 UNIQUEIDENTIFIER = NEWID();
DECLARE @ASSIGN8 UNIQUEIDENTIFIER = NEWID();
DECLARE @ASSIGN9 UNIQUEIDENTIFIER = NEWID();
DECLARE @ASSIGN10 UNIQUEIDENTIFIER = NEWID();
DECLARE @ASSIGN11 UNIQUEIDENTIFIER = NEWID();

INSERT INTO assignments (
assign_id,
assign_isactive,
assign_status,
indatetime,
case_id,
assign_notes,
assign_entitycustomer_id)
VALUES
(@ASSIGN1,0,'REVOKED','2025-03-03',@CASE1,'initial assignment',@NBG),
(@ASSIGN2,1,'ACTIVE','2025-03-05',@CASE1,'new invoice assignment',@NBG),

(@ASSIGN3,1,'ACTIVE','2025-03-04',@CASE2,'overdue card debt',@NBG),
(@ASSIGN4,1,'ACTIVE','2025-03-05',@CASE3,'loan overdue',@ALPHA),
(@ASSIGN5,1,'ACTIVE','2025-03-05',@CASE4,'loan overdue',@ALPHA),

(@ASSIGN6,1,'ACTIVE','2025-03-06',@CASE5,'electricity bill',@DEH),
(@ASSIGN7,1,'ACTIVE','2025-03-06',@CASE6,'electricity bill',@DEH),

(@ASSIGN8,1,'ACTIVE','2025-03-07',@CASE7,'telecom bill',@OTE),
(@ASSIGN9,1,'ACTIVE','2025-03-07',@CASE8,'telecom bill',@OTE),

(@ASSIGN10,1,'ACTIVE','2025-03-08',@CASE9,'loan overdue',@NBG),
(@ASSIGN11,1,'ACTIVE','2025-03-08',@CASE10,'loan overdue',@ALPHA);

/* =========================================
   ACTIONS
   ========================================= */

INSERT INTO actions(act_id,assign_id,
act_type,
act_notes,
act_implementeddt,
act_implementedby,
act_status) VALUES

(NEWID(),@ASSIGN1,'ASSIGNMENT','case assigned','2025-03-03 09:00','system','completed'),
(NEWID(),@ASSIGN1,'CALL','debtor contacted','2025-03-03 11:00','Agent Nikos','completed'),
(NEWID(),@ASSIGN1,'PAYMENT','partial payment','2025-03-04 10:00','Agent Nikos','completed'),
(NEWID(),@ASSIGN1,'REVOKE','invoice settled','2025-03-04 12:00','system','completed'),

(NEWID(),@ASSIGN2,'ASSIGNMENT','new invoice','2025-03-05 09:00','system','completed'),
(NEWID(),@ASSIGN2,'CALL','contact attempt','2025-03-06 10:00','Agent Maria','completed'),

(NEWID(),@ASSIGN3,'ASSIGNMENT','assignment created','2025-03-04 09:00','system','completed'),
(NEWID(),@ASSIGN3,'CALL','customer contacted','2025-03-04 13:00','Agent Nikos','completed'),

(NEWID(),@ASSIGN4,'ASSIGNMENT','assignment created','2025-03-05 09:30','system','completed'),
(NEWID(),@ASSIGN5,'ASSIGNMENT','assignment created','2025-03-05 10:00','system','completed'),

(NEWID(),@ASSIGN6,'ASSIGNMENT','assignment created','2025-03-06 09:30','system','completed'),
(NEWID(),@ASSIGN7,'ASSIGNMENT','assignment created','2025-03-06 10:00','system','completed'),

(NEWID(),@ASSIGN8,'ASSIGNMENT','assignment created','2025-03-07 09:30','system','completed'),
(NEWID(),@ASSIGN9,'ASSIGNMENT','assignment created','2025-03-07 10:00','system','completed'),

(NEWID(),@ASSIGN10,'ASSIGNMENT','assignment created','2025-03-08 09:30','system','completed'),
(NEWID(),@ASSIGN11,'ASSIGNMENT','assignment created','2025-03-08 10:00','system','completed');

/* =========================================
   TRANSACTIONS
   ========================================= */

INSERT INTO transactions(
tran_id,
assign_id,
tran_type,
tran_amount,
tran_debtamount,
tran_registerdt
) VALUES
(NEWID(),@ASSIGN1,'payment',150,500,'2025-03-04'),
(NEWID(),@ASSIGN3,'payment',200,800,'2025-03-05'),
(NEWID(),@ASSIGN6,'payment',50,200,'2025-03-07');

/* =========================================
   DYNAMIC_FIELDS
   ========================================= */

INSERT INTO dynamic_fields (
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
dyn_currentbucket)VALUES

(@ASSIGN1,'CASE-1001','2025-03-03',0,'Giannis Papadopoulos','NBG',500,350,150,'2025-03-04',150,'3','2'),
(@ASSIGN2,'CASE-1001','2025-03-05',1,'Giannis Papadopoulos','NBG',300,300,0,NULL,150,'3','3'),

(@ASSIGN3,'CASE-1002','2025-03-04',1,'Maria Georgiou','NBG',800,600,200,'2025-03-05',200,'4','3'),
(@ASSIGN4,'CASE-1003','2025-03-05',1,'Nikos Dimitriou','Alpha Bank',1200,1200,0,NULL,0,'5','5'),
(@ASSIGN5,'CASE-1004','2025-03-05',1,'Eleni Kosta','Alpha Bank',900,900,0,NULL,0,'4','4'),

(@ASSIGN6,'CASE-1005','2025-03-06',1,'Petros Antoniou','DEH',200,150,50,'2025-03-07',50,'2','2'),
(@ASSIGN7,'CASE-1006','2025-03-06',1,'Dimitra Savva','DEH',350,350,0,NULL,0,'3','3'),

(@ASSIGN8,'CASE-1007','2025-03-07',1,'Kostas Ioannou','OTE',120,120,0,NULL,0,'1','1'),
(@ASSIGN9,'CASE-1008','2025-03-07',1,'Anna Michail','OTE',240,240,0,NULL,0,'2','2'),

(@ASSIGN10,'CASE-1009','2025-03-08',1,'George Laskaris','NBG',5000,5000,0,NULL,0,'6','6'),
(@ASSIGN11,'CASE-1010','2025-03-08',1,'Sofia Kaneli','Alpha Bank',3200,3200,0,NULL,0,'6','6');

/* =========================================
   COMMUNICATION
   ========================================= */

DECLARE @COM1 UNIQUEIDENTIFIER = NEWID();
DECLARE @COM2 UNIQUEIDENTIFIER = NEWID();
DECLARE @COM3 UNIQUEIDENTIFIER = NEWID();
DECLARE @COM4 UNIQUEIDENTIFIER = NEWID();
DECLARE @COM5 UNIQUEIDENTIFIER = NEWID();
DECLARE @COM6 UNIQUEIDENTIFIER = NEWID();
DECLARE @COM7 UNIQUEIDENTIFIER = NEWID();
DECLARE @COM8 UNIQUEIDENTIFIER = NEWID();
DECLARE @COM9 UNIQUEIDENTIFIER = NEWID();
DECLARE @COM10 UNIQUEIDENTIFIER = NEWID();
DECLARE @COM11 UNIQUEIDENTIFIER = NEWID();
DECLARE @COM12 UNIQUEIDENTIFIER = NEWID();

INSERT INTO communication (
com_id,
entity_id,
com_type,
com_isvalid,
com_isvalidfrom,
com_implementedby,
com_implementeddt) VALUES
(@COM1,@GIANNIS,'phone',1,'2025-03-01','Agent Nikos','2025-03-01'),
(@COM2,@GIANNIS,'email',1,'2025-03-01','Agent Nikos','2025-03-01'),
(@COM3,@GIANNIS,'address',1,'2025-03-01','Agent Nikos','2025-03-01'),

(@COM4,@MARIA,'phone',1,'2025-03-01','Agent Maria','2025-03-01'),
(@COM5,@MARIA,'email',1,'2025-03-01','Agent Maria','2025-03-01'),
(@COM6,@MARIA,'address',1,'2025-03-01','Agent Maria','2025-03-01'),

(@COM7,@NIKOS,'phone',1,'2025-03-01','Agent Nikos','2025-03-01'),
(@COM8,@NIKOS,'email',1,'2025-03-01','Agent Nikos','2025-03-01'),
(@COM9,@NIKOS,'address',1,'2025-03-01','Agent Nikos','2025-03-01'),

(@COM10,@ELENI,'phone',1,'2025-03-01','Agent Maria','2025-03-01'),
(@COM11,@ELENI,'email',1,'2025-03-01','Agent Maria','2025-03-01'),
(@COM12,@ELENI,'address',1,'2025-03-01','Agent Maria','2025-03-01');

INSERT INTO phones (
phone_id,
com_id,
phone_type,
phone_number,
phone_areacode) VALUES
(NEWID(),@COM1,'mobile','6971111111','30'),
(NEWID(),@COM4,'mobile','6972222222','30'),
(NEWID(),@COM7,'mobile','6973333333','30'),
(NEWID(),@COM10,'mobile','6974444444','30');

INSERT INTO  email (
email_id,
com_id,
email_descr,
email_type) VALUES
(NEWID(),@COM2,'giannis.papadopoulos@email.com','personal'),
(NEWID(),@COM5,'maria.georgiou@email.com','personal'),
(NEWID(),@COM8,'nikos.dimitriou@email.com','personal'),
(NEWID(),@COM11,'eleni.kosta@email.com','personal');


INSERT INTO addresses (
address_id,
com_id,
add_streetnum,
add_streetname,
add_cityname,
add_country,
add_type) VALUES
(NEWID(),@COM3,'12','Athinas','Athens','Greece','home'),
(NEWID(),@COM6,'5','Tsimiski','Thessaloniki','Greece','home'),
(NEWID(),@COM9,'21','Patision','Athens','Greece','home'),
(NEWID(),@COM12,'7','Egnatia','Thessaloniki','Greece','home');








select * from actions
select * from addresses 
select * from assignments 
select * from cases 
select * from communication
select * from demographics 
select * from dynamic_fields 
select * from email 
select * from entities 
select * from phones 
select * from relations 
select * from transactions 


