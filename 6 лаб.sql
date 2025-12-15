DROP DATABASE IF EXISTS `company`;
CREATE DATABASE `company`;
USE `company`;

-- departments
CREATE TABLE IF NOT EXISTS department (
  department_id INT NOT NULL AUTO_INCREMENT,
  department_name VARCHAR(30) NOT NULL UNIQUE,
  city VARCHAR(30) NOT NULL DEFAULT 'Lviv',
  street VARCHAR(50),                   -- зроблено NULL, бо в даних є NULL
  building_no INT,                      -- display width опущено
  PRIMARY KEY (department_id)
);

-- employee
CREATE TABLE IF NOT EXISTS employee (
  employee_id INT NOT NULL AUTO_INCREMENT,
  user_name VARCHAR(50) NOT NULL UNIQUE,
  first_name VARCHAR(30) NOT NULL,
  last_name VARCHAR(30) NOT NULL,
  position VARCHAR(50),
  employment_date DATE,
  department_id INT,          -- зробив NULL дозволеним (в даних є NULL)
  manager_id INT,
  rate DECIMAL(10,2) NOT NULL,
  bonus DECIMAL(10,2),
  PRIMARY KEY (employee_id)
);

-- customer
CREATE TABLE IF NOT EXISTS customer (
  customer_id INT NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(30) NOT NULL,
  last_name VARCHAR(30) NOT NULL,
  gender CHAR(1),
  birth_date DATE,
  phone_number VARCHAR(20) UNIQUE,  -- VARCHAR щоб приймати формат з дефісами
  email VARCHAR(100) UNIQUE,
  discount INT,
  PRIMARY KEY (customer_id)
);

-- product
CREATE TABLE IF NOT EXISTS product (
  product_id INT NOT NULL AUTO_INCREMENT,
  product_name VARCHAR(100) NOT NULL,
  product_description VARCHAR(255),
  category VARCHAR(50),
  manufacture VARCHAR(50),
  product_type VARCHAR(50),
  amount INT,
  price DECIMAL(10,2),
  PRIMARY KEY (product_id)
);


CREATE TABLE IF NOT EXISTS invoice (
  invoice_id BIGINT NOT NULL,         
  employee_id INT,                      
  customer_id INT,                    
  payment_method TINYINT,
  transaction_moment DATETIME,
  `status` varchar(10) NOT NULL,
  PRIMARY KEY (invoice_id)
);


CREATE TABLE IF NOT EXISTS orders (
  orders_id INT NOT NULL AUTO_INCREMENT,
  invoice_id BIGINT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL,
  order_datetime DATETIME NOT NULL,   
  PRIMARY KEY (orders_id)
);


ALTER TABLE employee
  ADD CONSTRAINT fk_employee_department FOREIGN KEY (department_id) REFERENCES department(department_id),
  ADD CONSTRAINT fk_employee_manager FOREIGN KEY (manager_id) REFERENCES employee(employee_id);

ALTER TABLE invoice
  ADD CONSTRAINT fk_invoice_employee FOREIGN KEY (employee_id) REFERENCES employee(employee_id),
  ADD CONSTRAINT fk_invoice_customer FOREIGN KEY (customer_id) REFERENCES customer(customer_id);

ALTER TABLE orders
  ADD CONSTRAINT fk_orders_invoice FOREIGN KEY (invoice_id) REFERENCES invoice(invoice_id),
  ADD CONSTRAINT fk_orders_product FOREIGN KEY (product_id) REFERENCES product(product_id);

SELECT * FROM department;
SELECT * FROM employee; 
SELECT * FROM customer ;
SELECT * FROM product ;
SELECT * FROM invoice;
SELECT * FROM orders ;
  
USE company ;
SELECT *
FROM customer 
ORDER BY last_name  ;

USE company;
SELECT
LPAD(employee_id,5, '0') as 'Employee ID',
CONCAT_WS(" "last_name, first_name) as 'Full name',
--CONCAT_WS("",last_name, first_name, position) as 'Full name with Position',
CONCAT(LOWER(first_name), ".", LOWER (last_name), "@company.com") as 'email'
FROM
employee;

SELECT
first_name 'First name',
last_name 'Last name',
DATE_FORMAT(employment_date, "%d %M%Y") AS 'Date of hiring',
-- MySQL DATEDIFF() returns the number of days between two dates or datetimes.
FORMAT (DATEDIFF (CURDATE(), employment_date)/365.22,1) 'Length of service',
-- MySQL the TIMESTAMPDIFF() returns a value after subtracting a datetime expression from another.
TIMESTAMPDIFF (YEAR, employment_date, CURDATE()) AS 'Years of service'
FROM
employee;

SELECT
'Count of All employees'
AS 'Bonus eligible',
COUNT(*) 'Count of employees'
FROM employee
UNION
SELECT 
'Count of employees who received bonus'
AS  'Bonus eligible',
COUNT(*) 'Count of employees'
FROM 
employee
WHERE
bonus IS NOT NULL;


SELECT
MIN(rate) 'Lowest salary',
MAX(rate) 'Highest salary', 
FORMAT (AVG(bonus),2) 
AS 'Average Bonus by Employee', 
FORMAT (SUM(bonus) / COUNT(*),2) 
AS 'Average Bonus by Company'
FROM employee;

SELECT
COUNT(*) AS
'Count of Offices',
COUNT(DISTINCT city) AS
'Count of representative
offices of cities'
FROM department;

SELECT
position As 'Position', COUNT(*) AS 'Count Employee by Position'
FROM employee GROUP BY position;

SELECT
department_id AS 'Department id', COUNT(*) AS 'Count of employees by Department'
FROM employee
GROUP BY department_id;

SELECT
department_id AS
'Department id', position As 'Position', COUNT(*) AS 'Count of employees by Position
for each Departmenn'
FROM employee
GROUP BY department_id, position
ORDER BY COUNT(*) DESC;

SELECT
department_id,
position,
COUNT(*) AS 'Count Employee'
FROM
employee
GROUP BY
department_id, position
HAVING
COUNT(*) > 1;

SELECT
d.department_name,
position,
COUNT(*) 'Count Employee by Position'
FROM
employee e
JOIN
department d
ON
e.department_id= d.department_id
WHERE
city = 'LVIV'
GROUP BY
position, d.department_id
HAVING
COUNT(*) = 1
ORDER BY d.department_name;

SELECT
d.department_name,
last_name,
first_name,
position,
COUNT(invoice_id) 'Employee by Sales'
FROM
department d
JOIN
employee e
ON
d.department_id = e.department_id
JOIN
invoice i
ON
e.employee_id = i.employee_id
GROUP BY
i.employee_id
HAVING
COUNT(invoice_id) > 10
ORDER BY COUNT(invoice_id) DESC;

-- Домашня робота 

USE company;

SELECT
    LPAD(product_id, 4, '0') AS "Product ID",
    CONCAT(
        manufacture, ' :: ',
        REPLACE(SUBSTRING_INDEX(product_name, '::', 1), '/', ' ')
    ) AS "Product Name",
    UPPER(CONCAT(product_type, ' - ', category)) AS "Category"
FROM
    product
ORDER BY
    manufacture;

USE company;

SELECT
    LPAD(MONTH(MIN(i.transaction_moment)), 2, '0') AS "Month",
    FORMAT(SUM(o.quantity * p.price), 2) AS "Total revenue",
    CONCAT(
        'Quarter ', QUARTER(MIN(i.transaction_moment)),
        '-',
        YEAR(MIN(i.transaction_moment))
    ) AS "Sales Period"
FROM
    invoice AS i
INNER JOIN
    orders AS o ON i.invoice_id = o.invoice_id
INNER JOIN
    product AS p ON o.product_id = p.product_id
GROUP BY
    YEAR(i.transaction_moment),
    MONTH(i.transaction_moment)
ORDER BY
    MIN(i.transaction_moment);

USE company;

SELECT
    p.product_id AS "Product ID",
    p.product_name AS "Product name",
    p.price AS "Product Price",
    SUM(o.quantity) AS "Product Quantity",
    FORMAT(SUM(o.quantity * p.price), 2) AS "Total Amount"
FROM
    orders AS o
INNER JOIN
    product AS p ON o.product_id = p.product_id
GROUP BY
    p.product_id, p.product_name, p.price
HAVING
    SUM(o.quantity * p.price) > 50000
ORDER BY
    "Total Amount" DESC;
    
    USE company;

SELECT
    c.customer_id AS "Customer ID",
    c.last_name AS "Customer last name",
    c.first_name AS "Customer first name",
    FORMAT(SUM(o.quantity * p.price), 2) AS "Total Amount"
FROM
    customer AS c
INNER JOIN
    invoice AS i ON c.customer_id = i.customer_id
INNER JOIN
    orders AS o ON i.invoice_id = o.invoice_id
INNER JOIN
    product AS p ON o.product_id = p.product_id
GROUP BY
    c.customer_id, c.last_name, c.first_name
ORDER BY
    SUM(o.quantity * p.price) DESC
LIMIT 10;