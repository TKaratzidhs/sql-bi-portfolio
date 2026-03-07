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

INSERT INTO demographics (entity_id,entity_taxnumber,entity_firstname,entity_lastname,entity_nationality,createdt) VALUES
(5,'111111111','Giannis','Papadopoulos','GR','2025-03-01'),
(6,'222222222','Maria','Georgiou','GR','2025-03-01'),
(7,'333333333','Nikos','Dimitriou','GR','2025-03-01'),
(8,'444444444','Eleni','Kosta','GR','2025-03-01'),
(9,'555555555','Petros','Antoniou','GR','2025-03-01'),
(10,'666666666','Dimitra','Savva','GR','2025-03-01'),
(11,'777777777','Kostas','Ioannou','GR','2025-03-01'),
(12,'888888888','Anna','Michail','GR','2025-03-01'),
(13,'999999999','George','Laskaris','GR','2025-03-01'),
(14,'101010101','Sofia','Kaneli','GR','2025-03-01');

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
) VALUES
(5,'phone',1,'2025-03-01','Agent Nikos','2025-03-01'),
(6,'phone',1,'2025-03-01','Agent Maria','2025-03-01'),
(7,'email',1,'2025-03-02','Agent Nikos','2025-03-02');
