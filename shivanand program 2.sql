desc participated
insert into accident values (11, '2003-01-01', 'Mysore Road');
drop database insurance;
create database insurence;
use insurence;
create table insurence (driver_id varchar(10), name varchar(20), address varchar(30), primary key(driver_id));
desc insurence;
create table car(reg_num varchar(10),model varchar(10),year int, primary
key(reg_num));
create table accident(report_num int, accident_date date, location
varchar(20),primary key(report_num));
CREATE TABLE owns (
    driver_id VARCHAR(10),
    reg_num VARCHAR(10),
    PRIMARY KEY (driver_id, reg_num),
    FOREIGN KEY (driver_id) REFERENCES person(driver_id),
    FOREIGN KEY (reg_num) REFERENCES car(reg_no)  -- Fixed to match 'reg_no' from the car table
);
DROP TABLE IF EXISTS person;
CREATE TABLE person (
    driver_id VARCHAR(10) PRIMARY KEY, -- Changed from driving_id to driver_id to match your junction table
    name VARCHAR(20), 
    address VARCHAR(30));
DROP TABLE IF EXISTS car;
CREATE TABLE car (
    reg_no VARCHAR(10) PRIMARY KEY, 
    model VARCHAR(20), 
    year INT
);
DROP TABLE IF EXISTS owns;
CREATE TABLE owns (
    driver_id VARCHAR(10),
    reg_num VARCHAR(10),
    PRIMARY KEY (driver_id, reg_num),
    FOREIGN KEY (driver_id) REFERENCES person(driver_id),
    FOREIGN KEY (reg_num) REFERENCES car(reg_no)
);
SELECT * FROM person;
SELECT * FROM car;
SELECT * FROM owns;

INSERT INTO person (driver_id, name, address) VALUES 
('D101', 'Rahul Sharma', 'Jayanagar, Bangalore'),
('D102', 'Anita Rao', 'Mysore Road, Bangalore');

INSERT INTO car (reg_no, model, year) VALUES 
('KA-01-1234', 'Swift', 2020),
('KA-02-5678', 'i20', 2022);

INSERT INTO owns (driver_id, reg_num) VALUES 
('D101', 'KA-01-1234'),
('D102', 'KA-02-5678');

UPDATE person 
SET address = 'Indiranagar, Bangalore' 
WHERE driver_id = 'D101';

UPDATE car 
SET model = 'Swift Dzire', year = 2021 
WHERE reg_no = 'KA-01-1234';

UPDATE owns 
SET driver_id = 'D102' 
WHERE reg_num = 'KA-01-1234';

SELECT COUNT(DISTINCT driver_id) AS total_owners
FROM owns
JOIN participated ON owns.reg_num = participated.reg_no;

USE INSURANCE;

-- 1. Create the accident table
CREATE TABLE accident (
    report_num INT PRIMARY KEY,
    date DATE,
    location VARCHAR(50)
);

-- 2. Create the participated table (bridges cars, accidents, and records damage)
CREATE TABLE participated (
    driver_id VARCHAR(10),
    reg_no VARCHAR(10),
    report_num INT,
    damage_amount INT,
    PRIMARY KEY (driver_id, reg_no, report_num),
    FOREIGN KEY (driver_id) REFERENCES person(driver_id),
    FOREIGN KEY (reg_no) REFERENCES car(reg_no),
    FOREIGN KEY (report_num) REFERENCES accident(report_num)
);

SELECT COUNT(DISTINCT driver_id) AS total_owners
FROM participated;

USE INSURANCE;

INSERT INTO accident (report_num, name, location) 
VALUES ('11', '2026-01-01', 'Mysore Road');

-- 2. Link a driver and their car to that accident record
-- (Using the 'D101' driver and 'KA-01-1234' car we inserted earlier)
INSERT INTO participated (driver_id, reg_no, report_num, damage_amount) VALUES 
('D101', 'KA-01-1234', 11, 25000);
DROP TABLE IF EXISTS participated;
DROP TABLE IF EXISTS accident;
CREATE TABLE accident (
    report_num INT PRIMARY KEY,
    accident_date DATE,        -- Using 'accident_date' to avoid SQL keyword conflicts
    location VARCHAR(50)
);
CREATE TABLE participated (
    driver_id VARCHAR(10),
    reg_no VARCHAR(10),
    report_num INT,
    damage_amount INT,
    PRIMARY KEY (driver_id, reg_no, report_num),
    FOREIGN KEY (driver_id) REFERENCES person(driver_id),
    FOREIGN KEY (reg_no) REFERENCES car(reg_no),
    FOREIGN KEY (report_num) REFERENCES accident(report_num)
);
INSERT INTO accident (report_num, accident_date, location) 
VALUES (11, '2026-01-01', 'Mysore Road');

SELECT COUNT(DISTINCT p.report_num) AS accident_count FROM car c JOIN participated p ON c.reg_no = p.reg_no WHERE c.model = 'Swift';
SELECT COUNT(*) AS total_accidents FROM accident WHERE YEAR(accident_date) = 2026;
INSERT INTO accident (report_num, accident_date, location) VALUES (12, '2026-10-08', 'MG Road');

SELECT * FROM person;
SELECT * FROM owns;
SELECT * FROM accident;
SELECT * FROM participated;
SELECT accident_date, location FROM accident;
SELECT driver_id, damage_amount FROM participated WHERE damage_amount >= 25000;


