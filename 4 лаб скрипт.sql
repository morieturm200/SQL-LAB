
USE company;
SELECT *
FROM  employee;

SELECT
employee_id,
first_name,
last_name,
position
FROM
employee;

SELECT
employee_id,
first_name,
last_name,
position
FROM
employee
LIMIT 7;

SELECT DISTINCT
position
FROM
employee;

SELECT DISTINCT
position
FROM
employee
ORDER BY
position ASC;

SELECT DISTINCT
position
FROM
employee
ORDER BY
position DESC;

SELECT
employee_id,
last_name,
first_name,
position,
employment_date
FROM
employee
WHERE
position = 'Seller'
ORDER BY
employment_date ASC;

SELECT
employee_id,
last_name,
first_name,
position,
employment_date
FROM
employee
WHERE
(
position = 'Seller'
OR
position = 'Consultant'
)
AND
employment_date> '2013-01-01'
ORDER BY
employment_date DESC;

-- Solution 1
SELECT
    last_name,
    first_name,
    position,
    employment_date
FROM
    employee
WHERE
    (
        position LIKE 'Seller'
        OR
        position IN ('Senior Consultant', 'Consultant')
    )
    AND
    employment_date > '2013-01-01'
ORDER BY
    employment_date DESC;
    
    -- Solution 2
SELECT
employee_id,
last_name,
first_name,
position,
employment_date
FROM
employee
WHERE
(
position LIKE 'S___'
OR
(
position LIKE '%Consultant'
AND
position NOT LIKE 'A%'
))
AND
employment_date > '2013-01-01'
ORDER BY
employment_date DESC;

SELECT
employee_id,
last_name,
first_name,
position,
manager_id,
department_id
FROM
employee
WHERE
manager_id IS NULL
OR
department_id IS NOT NULL
ORDER BY
manager_id ASC;

-- Solution 1
SELECT
last_name,
first_name,
position,
employment_date,
bonus
FROM
employee
WHERE
bonus IS NOT NULL
AND
(
employment_date > '2015-12-31'
and
employment_date < '2020-12-31'
)
ORDER BY
last_name ASC;

-- Solution 2
SELECT
last_name,
first_name,
position,
employment_date,
bonus
FROM
employee
WHERE
bonus IS NOT NULL
AND
employment_date
BETWEEN '2015-12-31'
AND '2016-12-31'
ORDER BY
last_name ASC;

SELECT
employee_id,
last_name,
first_name,
position,
CASE
WHEN position = 'Senior Consultant' THEN 'Can Seles, Consulting and Lead'
WHEN position IN ('Senior Consultant', 'Consultant') THEN 'Can Seles and Consulting'
WHEN position like 'Assistant Consultant' THEN 'Can only Consulting'
WHEN position LIKE 'Seller' THEN 'Can only Sale'
ELSE 'Service Roles'
END AS 'Relation to Customer'
FROM
employee
ORDER By last_name;

SELECT
employee_id,
last_name "Last Name",
first_name 'First Name',
position Title,
employment_date AS 'Hire Date'
FROM
employee;



-- дз

USE company;
SELECT *
FROM customer;


USE company;
SELECT DISTINCT manufacture
FROM product
ORDER BY manufacture;

USE company;

SELECT product_name, manufacture, category, product_type, price
FROM product
WHERE manufacture = 'DELL'
ORDER BY product_name;

USE company;
SELECT first_name, last_name, genger, birth_date, phone_number
FROM customer
WHERE genger = 'F'
AND birth_date BETWEEN '1990-01-01' AND '2000-12-31'
ORDER BY last_name;


SELECT * 
FROM product
WHERE category = 'NOTEBOOK'
    AND product_description LIKE '%512GB%'
    AND amount > 0;
SELECT *
FROM product
WHERE
    amount > 0
    AND category IN ('NOTEBOOK', 'Desktops')
    AND (product_description LIKE '%512GB%' OR product_description LIKE '%1 TB%');
    
    SELECT * 
FROM product
WHERE category = 'NOTEBOOK'
    AND product_description LIKE '%512GB%'
    AND amount > 0;
    
SELECT *
FROM product
WHERE
    amount > 0
    AND category IN ('NOTEBOOK', 'Desktops')
    AND (product_description LIKE '%512GB%' OR product_description LIKE '%1 TB%');

 USE company;
 SELECT *
 FROM invoice
 WHERE customer_id IS NULL;

