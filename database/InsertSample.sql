INSERT INTO entities (entity_alias, createdt) VALUES
('National Bank of Greece','2025-03-01'),
('Alpha Bank','2025-03-01'),
('DEH','2025-03-01'),
('OTE','2025-03-01'),

('Giannis Papadopoulos','2025-03-01'),
('Maria Georgiou','2025-03-01'),
('Nikos Dimitriou','2025-03-01'),
('Eleni Kosta','2025-03-01'),
('Petros Antoniou','2025-03-01'),
('Dimitra Savva','2025-03-01'),
('Kostas Ioannou','2025-03-01'),
('Anna Michail','2025-03-01'),
('George Laskaris','2025-03-01'),
('Sofia Kaneli','2025-03-01'),

('Agent Nikos','2025-03-01'),
('Agent Maria','2025-03-01');

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
-- Banks / Companies
(1,'AFM200001','CID100001','Greek','None','1950-01-01','Athens','National','Main','Bank','Corporate','Entity',GETDATE()),
(2,'AFM200002','CID100002','Greek','None','1950-01-01','Athens','Alpha','Main','Bank','Corporate','Entity',GETDATE()),
(3,'AFM200003','CID100003','Greek','None','1950-01-01','Athens','Public','Power','Corporation','Corporate','Entity',GETDATE()),
(4,'AFM200004','CID100004','Greek','None','1950-01-01','Athens','Hellenic','Telecom','Organization','Corporate','Entity',GETDATE()),

-- Debtors
(5,'AFM100001','ID900001','Greek','None','1985-03-12','Athens','Giannis','K','Papadopoulos','Dimitris','Eleni',GETDATE()),
(6,'AFM100002','ID900002','Greek','None','1988-07-22','Patras','Maria','A','Georgiou','Antonis','Sofia',GETDATE()),
(7,'AFM100003','ID900003','Greek','None','1979-11-03','Thessaloniki','Nikos','P','Dimitriou','Panagiotis','Maria',GETDATE()),
(8,'AFM100004','ID900004','Greek','None','1991-06-18','Larissa','Eleni','D','Kosta','Giannis','Anna',GETDATE()),
(9,'AFM100005','ID900005','Greek','None','1984-09-14','Athens','Petros','L','Antoniou','Leonidas','Georgia',GETDATE()),
(10,'AFM100006','ID900006','Greek','None','1990-02-27','Heraklion','Dimitra','S','Savva','Spyros','Eirini',GETDATE()),
(11,'AFM100007','ID900007','Greek','None','1982-05-09','Volos','Kostas','M','Ioannou','Michalis','Eleni',GETDATE()),
(12,'AFM100008','ID900008','Greek','None','1993-12-01','Athens','Anna','T','Michail','Theodoros','Maria',GETDATE()),
(13,'AFM100009','ID900009','Greek','None','1978-04-30','Ioannina','George','N','Laskaris','Nikolaos','Sofia',GETDATE()),
(14,'AFM100010','ID900010','Greek','None','1987-10-11','Kalamata','Sofia','E','Kaneli','Evangelos','Dimitra',GETDATE())




INSERT INTO relations (
entity_id,
relation_type,
relation_isactive,
relation_implementedby,
relation_implementationdt
) VALUES
(5,'debtor',1,'system','2025-03-01'),
(6,'debtor',1,'system','2025-03-01'),
(7,'debtor',1,'system','2025-03-01'),
(8,'debtor',1,'system','2025-03-01'),
(9,'debtor',1,'system','2025-03-01'),
(10,'debtor',1,'system','2025-03-01'),
(11,'debtor',1,'system','2025-03-01'),
(12,'debtor',1,'system','2025-03-01'),
(13,'debtor',1,'system','2025-03-01'),
(14,'debtor',1,'system','2025-03-01');


INSERT INTO cases (
case_refno,
case_owner_refno,
case_owner_relation_id,
case_entitycustomer_id,
creatdt
) VALUES
('CASE-1001','NBG-1',1,1,'2025-03-03'),
('CASE-1002','NBG-2',2,1,'2025-03-04'),
('CASE-1003','ALPHA-1',3,2,'2025-03-05'),
('CASE-1004','ALPHA-2',4,2,'2025-03-05'),
('CASE-1005','DEH-1',5,3,'2025-03-06'),
('CASE-1006','DEH-2',6,3,'2025-03-06'),
('CASE-1007','OTE-1',7,4,'2025-03-07'),
('CASE-1008','OTE-2',8,4,'2025-03-07'),
('CASE-1009','NBG-3',9,1,'2025-03-08'),
('CASE-1010','ALPHA-3',10,2,'2025-03-08');


INSERT INTO assignments (
assign_isactive,
assign_status,
indatetime,
case_id,
assign_notes,
assign_entitycustomer_id
) VALUES
(0,'REVOKED','2025-03-03',1,'initial assignment',1),
(1,'ACTIVE','2025-03-05',1,'new invoice assignment',1),

(1,'ACTIVE','2025-03-04',2,'overdue card debt',1),
(1,'ACTIVE','2025-03-05',3,'loan overdue',2),
(1,'ACTIVE','2025-03-05',4,'loan overdue',2),

(1,'ACTIVE','2025-03-06',5,'electricity bill',3),
(1,'ACTIVE','2025-03-06',6,'electricity bill',3),

(1,'ACTIVE','2025-03-07',7,'telecom bill',4),
(1,'ACTIVE','2025-03-07',8,'telecom bill',4),

(1,'ACTIVE','2025-03-08',9,'loan overdue',1),
(1,'ACTIVE','2025-03-08',10,'loan overdue',2);



INSERT INTO actions (
assign_id,
act_type,
act_notes,
act_implementeddt,
act_implementedby,
act_status
) VALUES

(1,'ASSIGNMENT','case assigned','2025-03-03 09:00','system','completed'),
(1,'CALL','debtor contacted','2025-03-03 11:00','Agent Nikos','completed'),
(1,'PAYMENT','partial payment','2025-03-04 10:00','Agent Nikos','completed'),
(1,'REVOKE','invoice settled','2025-03-04 12:00','system','completed'),

(2,'ASSIGNMENT','new invoice','2025-03-05 09:00','system','completed'),
(2,'CALL','contact attempt','2025-03-06 10:00','Agent Maria','completed'),

(3,'ASSIGNMENT','assignment created','2025-03-04 09:00','system','completed'),
(3,'CALL','customer contacted','2025-03-04 13:00','Agent Nikos','completed'),

(4,'ASSIGNMENT','assignment created','2025-03-05 09:30','system','completed'),
(5,'ASSIGNMENT','assignment created','2025-03-05 10:00','system','completed'),

(6,'ASSIGNMENT','assignment created','2025-03-06 09:30','system','completed'),
(7,'ASSIGNMENT','assignment created','2025-03-06 10:00','system','completed'),

(8,'ASSIGNMENT','assignment created','2025-03-07 09:30','system','completed'),
(9,'ASSIGNMENT','assignment created','2025-03-07 10:00','system','completed'),

(10,'ASSIGNMENT','assignment created','2025-03-08 09:30','system','completed'),
(11,'ASSIGNMENT','assignment created','2025-03-08 10:00','system','completed');



INSERT INTO transactions (
assign_id,
tran_type,
tran_amount,
tran_debtamount,
tran_registerdt
) VALUES
(1,'payment',150,500,'2025-03-04'),
(3,'payment',200,800,'2025-03-05'),
(6,'payment',50,200,'2025-03-07');


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
dyn_currentbucket
) VALUES

(1,'CASE-1001','2025-03-03',0,'Giannis Papadopoulos','NBG',500,350,150,'2025-03-04',150,'3','2'),
(2,'CASE-1001','2025-03-05',1,'Giannis Papadopoulos','NBG',300,300,0,NULL,150,'3','3'),

(3,'CASE-1002','2025-03-04',1,'Maria Georgiou','NBG',800,600,200,'2025-03-05',200,'4','3'),
(4,'CASE-1003','2025-03-05',1,'Nikos Dimitriou','Alpha Bank',1200,1200,0,NULL,0,'5','5'),
(5,'CASE-1004','2025-03-05',1,'Eleni Kosta','Alpha Bank',900,900,0,NULL,0,'4','4'),

(6,'CASE-1005','2025-03-06',1,'Petros Antoniou','DEH',200,150,50,'2025-03-07',50,'2','2'),
(7,'CASE-1006','2025-03-06',1,'Dimitra Savva','DEH',350,350,0,NULL,0,'3','3'),

(8,'CASE-1007','2025-03-07',1,'Kostas Ioannou','OTE',120,120,0,NULL,0,'1','1'),
(9,'CASE-1008','2025-03-07',1,'Anna Michail','OTE',240,240,0,NULL,0,'2','2'),

(10,'CASE-1009','2025-03-08',1,'George Laskaris','NBG',5000,5000,0,NULL,0,'6','6'),
(11,'CASE-1010','2025-03-08',1,'Sofia Kaneli','Alpha Bank',3200,3200,0,NULL,0,'6','6');


INSERT INTO communication (
entity_id,
com_type,
com_isvalid,
com_isvalidfrom,
com_implementedby,
com_implementeddt
)
VALUES
(5,'phone',1,'2025-03-01','Agent Nikos','2025-03-01'),
(5,'email',1,'2025-03-01','Agent Nikos','2025-03-01'),
(5,'address',1,'2025-03-01','Agent Nikos','2025-03-01'),

(6,'phone',1,'2025-03-01','Agent Maria','2025-03-01'),
(6,'email',1,'2025-03-01','Agent Maria','2025-03-01'),
(6,'address',1,'2025-03-01','Agent Maria','2025-03-01'),

(7,'phone',1,'2025-03-01','Agent Nikos','2025-03-01'),
(7,'email',1,'2025-03-01','Agent Nikos','2025-03-01'),
(7,'address',1,'2025-03-01','Agent Nikos','2025-03-01'),

(8,'phone',1,'2025-03-01','Agent Maria','2025-03-01'),
(8,'email',1,'2025-03-01','Agent Maria','2025-03-01'),
(8,'address',1,'2025-03-01','Agent Maria','2025-03-01');


INSERT INTO phones (
com_id,
phone_type,
phone_number,
phone_areacode
)
VALUES
(1,'mobile','6971111111','30'),
(4,'mobile','6972222222','30'),
(7,'mobile','6973333333','30'),
(10,'mobile','6974444444','30');


INSERT INTO email (
com_id,
email_descr,
email_type
)
VALUES
(2,'giannis.papadopoulos@email.com','personal'),
(5,'maria.georgiou@email.com','personal'),
(8,'nikos.dimitriou@email.com','personal'),
(11,'eleni.kosta@email.com','personal');

INSERT INTO addresses (
com_id,
add_streetnum,
add_streetname,
add_cityname,
add_country,
add_type
)
VALUES
(3,'12','Athinas','Athens','Greece','home'),
(6,'5','Tsimiski','Thessaloniki','Greece','home'),
(9,'21','Patision','Athens','Greece','home'),
(12,'7','Egnatia','Thessaloniki','Greece','home');



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
