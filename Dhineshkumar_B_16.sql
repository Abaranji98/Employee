CREATE DATABASE Employee;

USE Employee;

CREATE TABLE employees (
employee_id int PRIMARY KEY,
employee_type varchar(50),
first_name varchar(50),
last_name varchar(50),
registered_on DATE,
email_id TEXT,
contact varchar(20),
contract_expiry DATE
);

INSERT INTO employees (employee_id, employee_type, first_name, last_name, registered_on, email_id, contact, contract_expiry)
VALUES
    (1, 'Full-time', 'Vijay', 'Shukla', '2023-10-09', 'vijay.shukla@icloud.com', '555-6666', '2024-01-31'),
    (2, 'Contractor', 'Mitali', 'Gandhi', '2023-10-10', 'mitali.gandhi@yahoo.com', '555-7777', '2023-12-15'),
    (3, 'Part-time',  'Arun', 'Deshmukh', '2023-10-11', 'arun.deshmukh@yahoo.com', '555-8888', '2024-03-31'),
    (4, 'Full-time', 'Suman', 'Bose', '2023-10-12', 'suman.bose@gmail.com', '555-9999', '2024-02-28'),
    (5, 'Contractor', 'Sanjay', 'Rathore', '2023-10-13', 'sanjay.rathore@yahoo.com', '555-0000', '2023-11-30'),
    (6, 'Full-time', 'Snehal', 'Mehta', '2023-10-14', 'snehal.mehta@gmail.com', '555-1112', '2024-04-30'),
    (7, 'Part-time', 'Aradhya', 'Pandey', '2023-10-15', 'aradhya.pandey@hotmail.com', '555-2223', '2024-03-15'),
    (8, 'Part-time',  'Harish', 'Iyer', '2023-10-16', 'harish.iyer@icloud.com', '555-3334', '2023-11-30'),
    (9, 'Contractor', 'Meenakshi', 'Chopra', '2023-10-17', 'meenakshi.chopra@yahoo.com', '555-4445', '2024-03-31'),
    (10, 'Full-time', 'Rajat', 'Nair', '2023-10-18', 'rajat.nair@gmail.com', '555-5556', '2024-02-15');
    
--  1.Count Employees by Type:
    
SELECT employee_type, COUNT(*) as count
FROM employees
GROUP BY employee_type;

-- 2.Average Contract Duration:

SELECT AVG(DATEDIFF(contract_expiry, registered_on)) as avg_contract_duration
FROM employees
WHERE employee_type = 'Contractor';

-- 3. Employees Expiring Soon:

SELECT employee_id, first_name, last_name, contract_expiry
FROM employees
WHERE DATEDIFF(contract_expiry, CURDATE()) <= 30;

-- 4.Full-time Employees with Longest Tenure:

SELECT employee_id, first_name, last_name, registered_on
FROM employees
WHERE employee_type = 'Full-time'
ORDER BY registered_on ASC
LIMIT 1;

-- 5. Part-time Employees with the Shortest Tenure:

SELECT employee_id, first_name, last_name, registered_on
FROM employees
WHERE employee_type = 'Part-time'
ORDER BY registered_on DESC
LIMIT 1;

-- 6. Employee with the Earliest Contract Expiry Date:

SELECT employee_id, first_name, last_name, contract_expiry
FROM employees
ORDER BY contract_expiry DESC
LIMIT 1;

CREATE TABLE employee_assignments (
    assignment_id INT PRIMARY KEY,
    employee_id INT,
    assignment_name VARCHAR(100),
    start_date DATE,
    end_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);


INSERT INTO employee_assignments (assignment_id, employee_id, assignment_name, start_date, end_date, status)
VALUES
    (1, 1, 'Project Alpha', '2023-10-15', '2024-01-15', 'In Progress'),
    (2, 2, 'Consulting Project', '2023-11-01', '2023-12-31', 'Completed'),
    (3, 4, 'Product Development', '2023-10-20', '2024-02-29', 'In Progress'),
    (4, 7, 'Marketing Campaign', '2023-11-10', '2024-03-10', 'In Progress'),
    (5, 10, 'Research Study', '2023-10-25', '2024-01-25', 'In Progress');
    
-- 7. List Employees and Their Current Assignments:

SELECT e.employee_id, e.first_name, e.last_name, ea.assignment_name, ea.start_date, ea.end_date
FROM employees e
INNER JOIN employee_assignments ea ON e.employee_id = ea.employee_id
WHERE ea.status = 'In Progress';

-- 8. Count Employees by Assignment Status:

SELECT ea.status, COUNT(*) as count
FROM employee_assignments ea
GROUP BY ea.status;

-- 9.Find Employees with No Current Assignments:

SELECT e.employee_id, e.first_name, e.last_name
FROM employees e
LEFT JOIN employee_assignments ea ON e.employee_id = ea.employee_id
WHERE ea.assignment_id IS NULL;

-- 10.Average Duration of Current Assignments:

SELECT AVG(DATEDIFF(ea.end_date, ea.start_date)) as avg_assignment_duration
FROM employee_assignments ea
WHERE ea.status = 'In Progress';

-- 11.Find Employees with the Most Assignments:

SELECT e.employee_id, e.first_name, e.last_name, COUNT(ea.assignment_id) as assignment_count
FROM employees e
INNER JOIN employee_assignments ea ON e.employee_id = ea.employee_id
WHERE ea.status = 'In Progress'
GROUP BY e.employee_id, e.first_name, e.last_name
ORDER BY assignment_count DESC
LIMIT 1;

-- 12.List Employees with No Current Assignments:

SELECT e.employee_id, e.first_name, e.last_name
FROM employees e
LEFT JOIN employee_assignments ea ON e.employee_id = ea.employee_id
WHERE ea.assignment_id IS NULL;

-- 13.Find the Assignment with the Earliest Start Date:

SELECT * FROM employee_assignments WHERE start_date = (SELECT MIN(start_date) FROM employee_assignments);

-- 14.Find the Employee with the Highest Employee ID(latest)

SELECT * FROM employees WHERE employee_id = (SELECT MAX(employee_id) FROM employees);

-- 15. Count the Total Number of Assignments:

SELECT COUNT(*) as total_assignments FROM employee_assignments;

-- 16. Count the Total Number of Employees:

SELECT COUNT(*) as total_employees FROM employees;

-- 17.Add the new column 'priority' to the 'employee_assignments' table

ALTER TABLE employee_assignments
ADD COLUMN priority VARCHAR(20) DEFAULT 'Normal';

-- 18.Update the existing rows to set the default value

UPDATE employee_assignments
SET priority = 'Normal';

CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100),
    start_date DATE,
    end_date DATE
);

INSERT INTO projects (project_id, project_name, start_date, end_date)
VALUES
    (1, 'Project A', '2023-10-01', '2023-12-31'),
    (2, 'Project B', '2023-11-15', '2024-02-29'),
    (3, 'Project C', '2023-10-10', '2024-01-20');
    
    
    -- List All Projects and Their Assignments:
    
    SELECT
    p.project_id,
    p.project_name,
    p.start_date AS project_start_date,
    p.end_date AS project_end_date,
    ea.assignment_id,
    ea.assignment_name,
    ea.start_date AS assignment_start_date,
    ea.end_date AS assignment_end_date,
    ea.status AS assignment_status
FROM projects p
LEFT JOIN employee_assignments ea ON p.project_id = ea.assignment_id;

-- 19. Count the Number of Assignments for Each Project:

SELECT
    p.project_id,
    p.project_name,
    COUNT(ea.assignment_id) AS assignment_count
FROM projects p
LEFT JOIN employee_assignments ea ON p.project_id = ea.assignment_id
GROUP BY p.project_id, p.project_name;

-- 20. Find Projects with No Assignments:

SELECT
    p.project_id,
    p.project_name
FROM projects p
LEFT JOIN employee_assignments ea ON p.project_id = ea.assignment_id
WHERE ea.assignment_id IS NULL;

   -- 21. List Employees and Their Assignments for a Specific Project (replace <project_id> with the desired project ID)
   
SELECT
   e.employee_id,
   e.first_name,
   e.last_name,
   ea.assignment_name,
   ea.start_date AS assignment_start_date,
   ea.end_date AS assignment_end_date,
   ea.status AS assignment_status
FROM employees e
INNER JOIN employee_assignments ea ON e.employee_id = ea.employee_id
INNER JOIN projects p ON ea.assignment_id = p.project_id
WHERE p.project_id = 1; 

-- 22. Calculate the Average Assignment Duration for Each Project:

SELECT
    p.project_id,
    p.project_name,
    AVG(DATEDIFF(ea.end_date, ea.start_date)) AS avg_assignment_duration
FROM projects p
INNER JOIN employee_assignments ea ON p.project_id = ea.assignment_id
GROUP BY p.project_id, p.project_name;


-- 23.drop table employees
drop table employees;

-- 24.drop table project
drop table projects;
-- 25.drop database employee
drop database Employee;









    
    


