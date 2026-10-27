CREATE DATABASE sterling_bank;
USE sterling_bank;
CREATE TABLE customer_info_table(
customer_id int primary key,
firstname varchar(50) not null,
lastname varchar(50) not null,
gender varchar(6) not null,
email_address varchar(100) not null,
phone_number varchar(20) not null,
home_address varchar(255) not null,
city varchar(50) not null,
state varchar(50) not null,
date_registered date
);

CREATE TABLE employee_info_table(
employee_id int primary key,
first_name varchar(50),
last_name varchar(50),
phone_number varchar(20),
email_address varchar(100),
position varchar(50),
department varchar(50),
date_employed date
);
CREATE TABLE account_type_table(
account_type_id int primary key,
account_type_name varchar(50) not null,
description varchar(255) not null,
minimum_balance decimal(15,2) not null,
interest_rate decimal(5,2)
);
CREATE TABLE account_info_table(
account_id int primary key,
customer_id int not null,
account_type_id int not null,
account_number varchar(20) unique not null,
balance decimal(15,2) not null,
date_opened date,
status varchar(20) not null,
foreign key (customer_id) references customer_info_table(customer_id),
foreign key (account_type_id) references account_type_table(account_type_id)
);
CREATE TABLE account_opening_table(
opening_id int primary key,
customer_id int not null,
account_id int not null,
employee_id int not null,
opening_date date,
initial_deposit decimal(15,2),
status varchar(20) not null,
foreign key (customer_id) references customer_info_table(customer_id),
foreign key (account_id) references account_info_table(account_id),
foreign key (employee_id) references employee_info_table(employee_id)
);
CREATE TABLE transaction_info_table(
transaction_id int primary key,
account_id int not null,
transaction_type varchar(30) not null,
amount decimal(15,2) not null,
transaction_date datetime,
description varchar(255),
employee_id int,
foreign key (account_id) references account_info_table(account_id),
foreign key (employee_id)references employee_info_table(employee_id)
);
CREATE TABLE loan_info_table(
loan_id int primary key,
customer_id int not null,
employee_id int not null,
loan_type varchar(50) not null,
loan_amount decimal(15,2) not null,
interest_rate decimal(5,2) not null,
start_date date,
end_date date,
status varchar(20) not null,
foreign key (customer_id) references customer_info_table(customer_id),
foreign key (employee_id) references employee_info_table(employee_id)
);
CREATE TABLE mortgage_info_table(
mortgage_id int primary key,
customer_id int not null,
employee_id int not null,
property_address varchar(255) not null,
property_value decimal(15,2) not null,
mortgage_amount decimal(15,2) not null,
interest_rate decimal(5,2) not null,
start_date date,
end_date date,
status varchar(20) not null,
foreign key (customer_id) references customer_info_table(customer_id),
foreign key (employee_id) references employee_info_table(employee_id)
);
CREATE TABLE atm_request_table(
request_id int primary key,
customer_id int not null,
account_id int not null,
request_type varchar(50) not null,
request_date date,
employee_id int,
status varchar(20) not null,
remarks varchar(255),
foreign key (customer_id) references customer_info_table(customer_id),
foreign key (account_id) references account_info_table(account_id),
foreign key(employee_id) references employee_info_table(employee_id)
);
INSERT INTO customer_info_table
(customer_id,firstname,lastname,gender,email_address,phone_number,home_address,city,state,date_registered)
VALUES
("1","halimah","bashir","female","halimahbashir7@gmail.com","09160294353","12 Allen Avenue","Ikeja","Lagos","2026-08-27"),
("2","khashyahtullah","olaide","female","olaide@gmail.com","08145236725","16 Allen Avenue","Ikeja","Lagos","2026-08-27");
SELECT * FROM customer_info_table;
INSERT INTO employee_info_table
(employee_id,first_name,last_name,phone_number,email_address,position,department,date_employed)
VALUES
("1","hassan","taiwo","08122433331","hassan2@gmail.com","manager","human resources","2024-01-23"),
("2","hassanah","kenny","09127433331","hassanah9@gmail.com","loan officer","loans","2022-03-13");
SELECT * FROM employee_info_table;
INSERT INTO account_type_table
(account_type_id,account_type_name,description,minimum_balance,interest_rate)
VALUES
("1","savings","personal savings account","5000.00","4.50"),
("2","current","current account for regular transactions","1000.00","8.00");
SELECT * FROM account_type_table;
INSERT INTO account_info_table
(account_id,customer_id,account_type_id,account_number,balance,date_opened,status)
VALUES
("1","1","1","10000001","150000.00","2026-01-10","active"),
("2","2","2","10000002","250000.00","2026-08-20","active");
SELECT * FROM account_info_table;
INSERT INTO account_opening_table
(opening_id,customer_id,account_id,employee_id,opening_date,initial_deposit,status)
VALUES
("1","1","1","2","2026-01-10","150000.00","approved"),
("2","2","2","2","2024-05-11","153000.00","approved");
SELECT * FROM account_opening_table;
INSERT INTO transaction_info_table
( transaction_id,account_id,transaction_type,amount,transaction_date,description,employee_id)
VALUES
("1","1","deposit","50000.00","2026-02-15","cash deposit at branch","1"),
("2","2","withdrawal","20000.00","2026-03-10","atm withdrawal","2");
SELECT *FROM transaction_info_table;
INSERT INTO loan_info_table
(loan_id,customer_id,employee_id,loan_type,loan_amount,interest_rate,start_date,end_date,status)
VALUES
("1","1","2","personal","300000.00","12.50","2026-04-01","2027-04-01","active"),
("2","2","1","business","750000.00","15.00","2026-05-15","2028-05-15","pending");
SELECT * FROM loan_info_table;
INSERT INTO mortgage_info_table
(mortgage_id,customer_id,employee_id,property_address,property_value,mortgage_amount,interest_rate,start_date,end_date,status)
VALUES
("1","1","1","5 freedom way,Lekki,Lagos","25000000.00","18000000.00","10.00","2026-01-05","2046-01-05","active"),
("2","2","2","10 Aadmirality Road,Lekki,Lagos","35000000.00","29000000.00","11.25","2026-06-01","2046-06-01","active");
SELECT * FROM loan_info_table;
INSERT INTO atm_request_table
(request_id,customer_id,account_id,request_type,request_date,employee_id,status,remarks)
VALUES
("1","1","1","new card","2026-02-01","1","completed","card issued at branch"),
("2","2","2","pin reset","2026-03-05","2","pending","awaiting verification");
SELECT * FROM atm_request_table;




