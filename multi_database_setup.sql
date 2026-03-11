# studentsdb database

create database studentsdb;

use studentsdb;

create table students(
    studentsid int auto_increment primary key,
    firstname varchar(50),
    lastname varchar(30),
    birthdate date,
    gender varchar(10)
);

create table course(
    courseid int auto_increment primary key,
    coursename varchar(50),
    credits int
);

create table enrollment(
    enrollmentid int auto_increment primary key,
    courseid int,
    studentsid int,
    enrollmentdate date,
    foreign key(studentsid) references students(studentsid),
    foreign key(courseid) references course(courseid)
);

# insert students data
insert into students (firstname, lastname, birthdate, gender)
values
('kavi', 'malar', '1999-11-06', 'male'),
('amitha', 'dg', '1999-12-08', 'female'),
('ravi', 'kumar', '2000-01-15', 'male'),
('priya', 'sharma', '2001-05-23', 'female'),
('ajay', 'singh', '1998-07-30', 'male'),
('sneha', 'patel', '2000-09-12', 'female'),
('vikram', 'das', '1999-03-17', 'male'),
('anita', 'rao', '2001-06-21', 'female'),
('manoj', 'gupta', '2000-10-05', 'male'),
('divya', 'mehta', '1998-12-11', 'female');

# insert courses
insert into course (coursename, credits)
values
('mathematics', 4),
('physics', 3),
('chemistry', 3),
('biology', 4),
('computer science', 5),
('english literature', 3),
('history', 3),
('economics', 4),
('psychology', 3),
('philosophy', 2);

# insert enrollment data
insert into enrollment (courseid, studentsid, enrollmentdate)
values
(1, 1, '2023-01-15'),
(2, 2, '2023-02-20'),
(3, 3, '2023-03-10'),
(4, 4, '2023-04-05'),
(5, 5, '2023-05-18'),
(6, 6, '2023-06-12'),
(7, 7, '2023-07-22'),
(8, 8, '2023-08-30'),
(9, 9, '2023-09-14'),
(10, 10, '2023-10-01');

# select all students
select * from students;

# sales_management database

create database sales_management;
use sales_management;

create table productlines(
    productline varchar(70) primary key,
    textdescription varchar(6000),
    htmldescription mediumtext,
    image blob
);

create table products(
    productcode varchar(60) primary key,
    productname varchar(70) not null,
    productscale varchar(70),
    productvendor varchar(70),
    productdescription text,
    quantityinstock int,
    buyprice decimal(10,2),
    msrp decimal(10,2),
    productline varchar(70),
    foreign key(productline) references productlines(productline)
);

create table offices(
    officecode int primary key,
    city varchar(80),
    phone varchar(50),
    addressline1 varchar(80),
    addressline2 varchar(80),
    state varchar(80),
    country varchar(80),
    postalcode varchar(20),
    territory varchar(80)
);

create table employees(
    employeenumber int primary key,
    lastname varchar(70),
    firstname varchar(70),
    extension varchar(20),
    email varchar(70),
    officecode int,
    reportsto int,
    jobtitle varchar(70)
);

create table customers(
    customernumber int primary key,
    customername varchar(60),
    contactlastname varchar(60),
    contactfirstname varchar(60),
    phone varchar(30),
    addressline1 varchar(60),
    addressline2 varchar(60),
    city varchar(60),
    state varchar(60),
    postalcode varchar(20),
    country varchar(60),
    salesrepemployeenumber int,
    creditlimit decimal(10,2)
);

create table orders(
    ordernumber int primary key,
    orderdate date,
    requireddate date,
    shippeddate date,
    status varchar(70),
    comments varchar(3000),
    customernumber int
);

create table orderdetails(
    ordernumber int,
    productcode varchar(60),
    quantityordered int,
    orderlinenumber int,
    priceeach decimal(10,2),
    primary key(ordernumber, productcode, orderlinenumber)
);

create table payments(
    customernumber int,
    checknumber varchar(50),
    paymentdate date,
    amount decimal(10,2),
    primary key(customernumber, checknumber)
);

create table sales_data(
    transaction_id int,
    employee_id int,
    month varchar(70),
    sales_amount decimal(10,2)
);

# alter productlines table
alter table productlines drop image;

# alter employees table
alter table employees drop email;
alter table employees add email varchar(70);

# example queries
select productcode, productname, productline, buyprice, msrp from products;
select productcode, productname, productline, buyprice, msrp from products where buyprice >= 80;
select * from products where msrp < 200 and productvendor = 'classic cars co';
select * from products where msrp < 200 and productline = 'classic cars' order by buyprice desc;
select productcode, productname, productline, buyprice, msrp from products order by buyprice desc limit 5;

update customers set creditlimit = 15000 where customernumber = 2005;
update customers set addressline1 = 'goa', phone = 52343345 where customernumber = 2005;
select * from customers;

# classicmodels101 database

create database if not exists classicmodels101;
use classicmodels101;

create table if not exists employees(
    employeeid int primary key,
    first_name varchar(50),
    last_name varchar(50),
    dept varchar(50),
    salary decimal(10,2)
);

insert into employees values
(101, 'arun', 'kumar', 'sales', 55000.00),
(102, 'meena', 'sharma', 'hr', 48000.00),
(103, 'ravi', 'verma', 'it', 72000.50),
(104, 'pooja', 'singh', 'finance', 55000.00),
(105, 'karan', 'patel', 'it', 72000.50),
(106, 'sneha', 'iyer', 'sales', 61000.75),
(107, 'vikram', 'reddy', 'hr', 48000.00),
(108, 'neha', 'joshi', 'finance', 83000.25),
(109, 'amit', 'das', 'it', 61000.75),
(110, 'divya', 'nair', 'sales', 55000.00);

# stored procedure to get employee details by department
delimiter $$
create procedure getemployeedetailsbydepartment(in dept_name varchar(50))
begin
    select employeeid, first_name, last_name, dept, salary
    from employees
    where dept = dept_name;
end $$
delimiter ;

call getemployeedetailsbydepartment('sales');

# stored procedure to get employees by salary range
delimiter $$
create procedure getemployeesbysalaryrange(in min_sal decimal(10,2), in max_sal decimal(10,2))
begin
    select employeeid, first_name, last_name, dept, salary
    from employees
    where salary between min_sal and max_sal;
end $$
delimiter ;

call getemployeesbysalaryrange(55000.00, 83000.25);