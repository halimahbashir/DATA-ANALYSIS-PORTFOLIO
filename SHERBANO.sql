CREATE DATABASE ADEBOLA;
USE ADEBOLA;
CREATE TABLE sherbano_info(
id int primary key,
    firstname varchar(255) not null,
    lastname varchar(255) not null,
    gender varchar(10) not null,
    email_address varchar(255) not null,
    phone_no varchar(15) not null,
    home_address varchar(255) not null,
    joined_date date
);
## INSERT QUERY: insert records into the database
INSERT INTO sherbano_info
(id,firstname,lastname,gender,email_address,phone_no,home_address,joined_date)
VALUES 
("2","khasyaytullah","abdulwaliyy","female","khash@gmail.com","08160294353","452 kosofe Lagos state","2026-08-26"),
("3","okikiola","ajayi","male","okikiolaajayi431@gmail.com","07067301717","87 kosofe Lagos state","2026-08-26"),
("4","hassan","taiwo","male","hassan@gmail.com","08067301717","98 kosofe Lagos state","2026-08-26"),
("5","hassanah","kenny","female","hassanah@gmail.com","09067301717","18 kosofe Lagos state","2026-08-26")
## SELECT QUERY: retrieve all data from the database

##SELECT QUERY: retrieve all data from the dataset where email_address = user_email_address
SELECT firstname FROM sherbano_info;
SELECT * FROM sherbano_info WHERE email_address="hassan@gmail.com";
SELECT email_address FROM sherbano_info;
SELECT id,lastname,firstname FROM sherbano_info;
SELECT * FROM sherbano_info limit 4;
