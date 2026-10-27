CREATE DATABASE KINGS_COLLEGE;
USE zenithbank;
USE kings_college;

select * from customer_info;

select * from student_info;

CREATE TABLE student_info(
	id int primary key,
    firstname varchar(255) not null,
    lastname varchar(255) not null,
    gender varchar(10) not null,
    email_address varchar(255) not null,
    phone_no varchar(15) not null,
    home_address varchar(255) not null,
    joined_date date
);
##insert query : insert records into the database table
INSERT INTO student_info
(id,firstname,lastname,gender,email_address,phone_no,home_address,joined_date)
VALUES
("2","Halimah","Bashir","female","halimah@gmail.com","0909890989","111, lagos road ikorodu lagos state","2026-08-26"),
("3","Anglea","olumachi","female","angela@gmail.com","08098903588","123, lagos road ikorodu lagos state","2026-08-26"),
("4","ADEBANJO","HAMZAT","male","exploitechs@gmail.com","08098903588","123, lagos road ikorodu lagos state","2026-08-26");

##Select Query : retrieve all data from the database table
SELECT * FROM student_info WHERE id=3;

##Select Query : retrieve all data from the database table WHERE email_address = user_email_address
SELECT * FROM student_info WHERE email_address="halimah@gmail.com";
SELECT firstname FROM student_info;
SELECT id, phone_no, email_address FROM student_info;
SELECT * FROM student_info limit 3;
sherbano_infosherbano_info
