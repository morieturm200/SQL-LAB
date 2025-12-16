USE company;

SELECT
    employee_id "Manager ID",
    last_name "Manager Last Name",
    first_name 'Manager First Name',
    position 'Manager Title',
    employment_date AS 'Manager Hire Date'
FROM
    employee AS Managers
WHERE
    position IN ('CEO', 'Manager');
    
SELECT
e.employee_id "Employee ID",
e.last_name "Employee Last Name",
e.first_name 'Employee First Name',
e.position 'Employee Title',
e.employment_date AS 'Employee Hire Date',
e.manager_id "Employee Manager ID",
m.employee_id "Manager ID",
m.last_name "Manager Last Name",
m.first_name 'Manager First Name",
m.position Manager Title',
m.employment_date AS 'Manager Hire Date'
FROM
employee AS e,
employee AS m
WHERE
e.manager_id = m.employee_id;

SELECT
e.employee_id "Employee ID",
e.last_name "Employee Last Name",
e.first_name 'Employee First Name',
e.position 'Employee Title',
e.department_id "Employee Department ID",
d.department_id "Department ID",
d.department_name "Department name"
FROM
employee AS e,
department AS d
WHERE
e.department_id = d.department_id;


SELECT
e.employee_id "Employee ID",
e.last_name "Employee Last Name",
e.first_name 'Employee First Name',
e.position 'Employee Title',
i.employee_id "Invoice Employee ID",
i.invoice_id 'Invoice',
i. transaction_moment 'Transaction moment'
FROM
employee AS e
JOIN
invoice AS i
ON
e.employee_id = i.employee_id
ORDER BY
i. transaction_moment;

SELECT
e.employee_id "Employee ID",
e.last_name "Employee Last Name",
e.first_name 'Employee First Name',
e.position 'Employee Title',
i.employee_id "Invoice Employee ID",
i.invoice_id 'Invoice',
i. transaction_moment 'Transaction moment'
FROM
employee AS e
JOIN
invoice AS i
USING (employee_id)
ORDER BY
i. transaction_moment;

SELECT
e.employee_id "Employee ID",
e.last_name "Employee Last Name",
e.first_name 'Employee First Name',
e.position 'Employee Title',
i.employee_id "Invoice Employee ID",
i.invoice_id 'Invoice',
i. transaction_moment 'Transaction moment'
FROM
employee AS e
NATURAL JOIN
invoice AS i
ORDER BY
i. transaction_moment;

SELECT
e.employee_id "Employee ID",
e.last_name "Employee Last Name",
e.first_name 'Employee First Name',
e.position 'Employee Title',
i.employee_id "Invoice Employee ID",
i.invoice_id 'Invoice',
i.customer_id 'Invoice Customer ID',
i. transaction_moment 'Transaction moment',
c.customer_id 'Customer ID',
c.last_name 'Customer Last Name',
c.first_name 'Customer First Name'
FROM
employee AS e
NATURAL JOIN
invoice AS i
JOIN
customer AS c
USING (customer_id)
ORDER BY i. transaction_moment;

SELECT
e.employee_id "Employee ID",
e.last_name "Employee Last Name",
e.first_name 'Employee First Name',
e.position 'Employee Title',
i.invoice_id 'Invoice',
i.customer_id 'Invoice Customer ID',
i. transaction_moment 'Transaction moment',
c.customer_id 'Customer ID',
c.last_name 'Customer Last Name',
c.first_name 'Customer First Name'
FROM
employee AS e
NATURAL JOIN
invoice AS i
LEFT JOIN
customer AS c
USING (customer_id)
WHERE customer_id IS NULL
ORDER By
i. transaction_moment;

SELECT
    e.employee_id 'Employee ID',
    e.last_name 'Employee Last Name',
    e.first_name 'Employee First Name',
    e.position 'Employee position',
    e.manager_id 'Employee Manager Id',
    e.department_id 'Employee department_id',
    
    m.employee_id 'Manager ID',
    m.last_name 'Manager Last Name',
    m.first_name 'Manager First Name',
    m.position 'Manager position',
    m.department_id 'Manager Department Id',
    
    d.department_id 'Department ID',
    d.department_name 'Department Name',
    d.city 'Department City'
FROM
    department AS d
RIGHT JOIN
    employee AS e
    ON e.department_id = d.department_id
LEFT JOIN
    employee AS m 
    ON e.manager_id = m.employee_id;

SELECT
employee_id,
first_name,
last_name,
position,
'Consulting' as Responsibility
FROM
employee
WHERE
position LIKE '%Consultant%'
UNION
SELECT
employee_id,
first_name,
last_name,
position, 'Not Consulting'
FROM
employee
WHERE
position NOT LIKE '%Consultant%'
ORDER BY last_name;

-- дз 

	SELECT
  o.orders_id AS 'Orders ID',
  p.product_name AS 'Product name',
  p.category AS 'Product category',
  i.invoice_id AS 'Invoice ID',
  i.transaction_moment AS 'Transaction moment',
  c.last_name AS 'Customer last name',
  c.first_name AS 'Customer first name'
FROM
  orders o
JOIN
  product p ON o.product_id = p.product_id
JOIN
  invoice i ON o.invoice_id = i.invoice_id
LEFT JOIN 
  customer c ON i.customer_id = c.customer_id
ORDER BY
  o.orders_id;
  
USE company;
SELECT
    o.orders_id AS 'Orders ID',
    p.product_name AS 'Product name',
    p.category AS 'Product category',
    i.invoice_id AS 'Invoice ID',
    i.transaction_moment AS 'Transaction moment',
    c.last_name AS 'Customer last name',
    c.first_name AS 'Customer first name'
FROM
    department AS d
INNER JOIN
    employee AS e ON d.department_id = e.department_id
INNER JOIN
    invoice AS i ON e.employee_id = i.employee_id
INNER JOIN
    customer AS c ON i.customer_id = c.customer_id
INNER JOIN
    orders AS o ON i.invoice_id = o.invoice_id
INNER JOIN
    product AS p ON o.product_id = p.product_id
WHERE
    d.department_name = 'Mercury'
    AND i.transaction_moment BETWEEN '2023-07-01' AND '2023-10-01'
ORDER BY
    o.orders_id;

USE company;

SELECT
    c.customer_id AS "Customer ID",
    c.last_name AS "Last Name",
    c.first_name AS "First Name",
    i.invoice_id AS "Invoice ID",
    i.transaction_moment AS "Transaction Moment"
FROM
    customer AS c
LEFT JOIN
    invoice AS i ON c.customer_id = i.customer_id

UNION

SELECT
    c.customer_id AS "Customer ID",
    c.last_name AS "Last Name",
    c.first_name AS "First Name",
    i.invoice_id AS "Invoice ID",
    i.transaction_moment AS "Transaction Moment"
FROM
    customer AS c
RIGHT JOIN
    invoice AS i ON c.customer_id = i.customer_id

ORDER BY
    `Invoice ID`;



