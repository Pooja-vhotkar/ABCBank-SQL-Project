-- =============================================
-- ABCBank MySQL Database Project 
-- =============================================

-- =============================================
-- Section 1: Data Definition Language (DDL)
-- Commands for defining database structure.
-- =============================================

-- Create database
-- The CREATE DATABASE command is a DDL statement.
CREATE DATABASE ABCBank;

-- Use the database
-- The USE command selects the database for subsequent operations.
USE ABCBank;

-- Create Customer table
-- CREATE TABLE is a DDL command.
-- It defines the columns and applies constraints.
CREATE TABLE Customer (
    Customer_ID INT PRIMARY KEY, -- PRIMARY KEY constraint ensures unique ID for each row.
    Customer_Name VARCHAR(100) NOT NULL, -- NOT NULL constraint disallows null values.
    Address VARCHAR(255),
    Phone VARCHAR(15) UNIQUE, -- UNIQUE constraint ensures all phone numbers are different.
    Email VARCHAR(100)
);

-- Create Account table
-- Defines account details.
CREATE TABLE Account (
    Account_ID INT PRIMARY KEY, -- PRIMARY KEY constraint.
    Customer_ID INT, -- Links to Customer table via Foreign Key.
    Account_Type VARCHAR(50) NOT NULL, -- NOT NULL constraint.
    Balance DECIMAL(10,2) CHECK (Balance >= 0), -- CHECK constraint ensures balance is non-negative.
    Opened_date DATETIME DEFAULT current_timestamp, -- DEFAULT constraint sets a default value if none is provided.
    Reporting_Date DATE,
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID) -- FOREIGN KEY links Account.Customer_ID to Customer.Customer_ID.
);

-- Create Transactions table
-- Records financial transactions.
CREATE TABLE Transactions (
    Transaction_ID INT PRIMARY KEY, -- PRIMARY KEY constraint.
    Account_ID INT, -- Links to Account table via Foreign Key.
    Transaction_Type VARCHAR(20) NOT NULL, -- NOT NULL constraint.
    Amount DECIMAL(10,2),
    Transaction_Date DATE,
    FOREIGN KEY (Account_ID) REFERENCES Account(Account_ID) -- FOREIGN KEY links Transactions.Account_ID to Account.Account_ID.
);

-- Create Loans table
-- Stores loan information.
CREATE TABLE Loans (
    Loan_ID INT PRIMARY KEY, -- PRIMARY KEY constraint.
    Customer_ID INT, -- Links to Customer table via Foreign Key.
    Loan_Type VARCHAR(50) NOT NULL, -- NOT NULL constraint.
    Loan_Amount DECIMAL(10,2) CHECK (Loan_Amount > 0), -- CHECK constraint ensures loan amount is positive.
    Loan_Status VARCHAR(20),
    Issue_Date DATE,
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID) -- FOREIGN KEY links Loans.Customer_ID to Customer.Customer_ID.
);

-- Create LoanPayments table
-- Records payments made towards loans.
CREATE TABLE Loan_Payments (
    Payment_ID INT PRIMARY KEY, -- PRIMARY KEY constraint.
    Loan_ID INT, -- Links to Loans table via Foreign Key.
    Payment_Date DATE,
    Amount_Paid DECIMAL(10,2) DEFAULT 0, -- DEFAULT constraint sets default amount to 0.
    FOREIGN KEY (Loan_ID) REFERENCES Loans(Loan_ID) -- FOREIGN KEY links Loan_Payments.Loan_ID to Loans.Loan_ID.
);

-- ALTER TABLE examples
-- ALTER TABLE is a DDL command used to modify existing tables.
ALTER TABLE Customer ADD Gender VARCHAR(10); -- Adds a new column.
select * from customer;

-- DROP COLUMN example
-- ALTER TABLE DROP COLUMN removes a column.
ALTER TABLE Customer DROP COLUMN Gender; -- Drops the previously added column.
select * from customer;

-- TRUNCATE TABLE example
-- TRUNCATE TABLE is a DDL command that removes all rows from a table quickly.
-- It's faster than DELETE for removing all rows and resets identity columns.
-- INSERT INTO Loan_Payments VALUES (301, 201, '2025-01-10', 10000), (302, 201, '2025-02-10', 10000); -- Data inserted.
TRUNCATE TABLE Loan_Payments; -- This line would remove the inserted data.
SELECT * FROM Loan_Payments;

-- RENAME TABLE example
-- RENAME TABLE is a DDL command.
RENAME TABLE Loan_Payments TO LoanPayment; -- Renames the table.
SHOW Tables;
RENAME TABLE LoanPayment TO Loan_Payments; -- Renames it back.


-- =============================================
-- Section 2: Data Manipulation Language (DML)
-- Commands for altering data within tables.
-- =============================================

-- INSERT statements
-- INSERT INTO is a DML command used to add new rows.
-- VALUES is a keyword used with INSERT.
INSERT INTO Customer VALUES
(1, 'John Doe', 'New York', '1234567890', 'john@example.com'),
(2, 'Jane Smith', 'Los Angeles', '2345678901', 'jane@example.com'),
(3, 'Tom Hanks', 'Chicago', '3456789012', 'tom@example.com'),
(4, 'Sara Lee', 'Houston', '4567890123', 'sara@example.com'),
(5, 'David Kim', 'Phoenix', '5678901234', 'david@example.com'),
(6, 'Lily James', 'Boston', '6789012345', 'lily@example.com'),
(7, 'Robert Ray', 'Austin', '7890123456', 'ray@example.com'),
(8, 'Emma Watson', 'Dallas', '8901234567', 'emma@example.com'),
(9, 'Chris Paul', 'Miami', '9012345678', 'chris@example.com'),
(10, 'Monica Bell', 'Seattle', '0123456789', 'monica@example.com');

INSERT INTO Account VALUES
(101, 1, 'Saving', 1000, '2024-01-01', '2025-05-01'),
(102, 2, 'Current', 2000, '2024-02-01', '2025-05-01'),
(103, 3, 'Saving', 3000, '2024-03-01', '2025-05-01'),
(104, 4, 'Saving', 4000, '2024-04-01', '2025-05-01'),
(105, 5, 'Current', 5000, '2024-05-01', '2025-05-01'),
(106, 6, 'Saving', 6000, '2024-06-01', '2025-05-01'),
(107, 7, 'Saving', 7000, '2024-07-01', '2025-05-01'),
(108, 8, 'Current', 8000, '2024-08-01', '2025-05-01'),
(109, 9, 'Saving', 9000, '2024-09-01', '2025-05-01'),
(110, 10, 'Current', 10000, '2024-10-01', '2025-05-01'); 

INSERT INTO Transactions VALUES
(1001, 101, 'Deposit', 500, '2025-01-10'),
(1002, 101, 'Withdraw', 200, '2025-01-15'),
(1003, 102, 'Deposit', 700, '2025-02-10'),
(1004, 103, 'Withdraw', 300, '2025-02-20'),
(1005, 104, 'Deposit', 900, '2025-03-01'),
(1006, 105, 'Deposit', 1000, '2025-03-10'),
(1007, 106, 'Withdraw', 400, '2025-03-15'),
(1008, 107, 'Deposit', 1100, '2025-04-01'),
(1009, 108, 'Withdraw', 600, '2025-04-10'),
(1010, 109, 'Deposit', 1200, '2025-04-20');

INSERT INTO Loans VALUES
(201, 1, 'Home', 500000, 'Approved', '2024-01-01'),
(202, 2, 'Car', 25000, 'Approved', '2024-02-01'),
(203, 3, 'Personal', 15000, 'Pending', '2024-03-01'),
(204, 4, 'Education', 20000, 'Approved', '2024-04-01'),
(205, 5, 'Business', 30000, 'Approved', '2024-05-01'),
(206, 6, 'Home', 400000, 'Approved', '2024-06-01'),
(207, 7, 'Car', 22000, 'Approved', '2024-07-01'),
(208, 8, 'Personal', 12000, 'Rejected', '2024-08-01'),
(209, 9, 'Education', 18000, 'Approved', '2024-09-01'),
(210, 10, 'Business', 35000, 'Pending', '2024-10-01'); 

INSERT INTO Loan_Payments VALUES
(301, 201, '2025-01-10', 10000),
(302, 201, '2025-02-10', 10000),
(303, 202, '2025-01-20', 5000),
(304, 203, '2025-03-01', 3000),
(305, 204, '2025-03-15', 4000),
(306, 205, '2025-04-01', 6000),
(307, 206, '2025-04-10', 8000),
(308, 207, '2025-04-20', 7000),
(309, 208, '2025-05-01', 2000),
(310, 209, '2025-05-03', 4000); 

-- UPDATE examples
-- UPDATE is a DML command used to modify existing rows.
-- SET is a keyword used with UPDATE.
UPDATE Customer SET Address = 'San Diego' WHERE Customer_ID = 1; -- Updates address for Customer_ID 1.
SELECT * FROM customer;
UPDATE Account SET Balance = Balance + 100 WHERE Account_ID = 101; -- Updates balance using arithmetic operator (+).
SELECT * FROM Account;
UPDATE Loans SET Loan_Status = 'Closed' WHERE Loan_ID = 205; -- Updates loan status.
SELECT * FROM Loans;

-- DELETE examples
-- DELETE FROM is a DML command used to remove rows.
DELETE FROM Transactions WHERE Amount < 300; -- Deletes transactions with amount less than 300 using comparison operator (<).
DELETE FROM Loan_Payments WHERE Amount_Paid = 2000; -- Deletes loan payments with amount equal to 2000 using comparison operator (=).
SET SQL_SAFE_UPDATE = 0;
-- =============================================
-- Section 3: Data Query Language (DQL) - Original Examples
-- Commands for retrieving data.
-- =============================================

-- Simple select examples
-- SELECT retrieves data. FROM specifies the table.
SELECT * FROM Customer; -- Selects all columns and rows from Customer table.
SELECT Customer_Name, Phone FROM Customer; -- Selects specific columns.

-- WHERE clause
-- WHERE filters results based on a condition.
SELECT Account_Type, Balance FROM Account WHERE Balance > 5000; -- Filters accounts with Balance > 5000 using comparison operator (>).
SELECT * FROM Loans WHERE Loan_Status = 'Approved'; -- Filters loans with status 'Approved' using comparison operator (=).

-- Arithmetic operations within SELECT
SELECT Balance + 500 AS Updated_Balance FROM Account; -- Adds 500 to Balance, AS renames the output column.
SELECT Loan_Amount - 1000 AS Reduced_Loan FROM Loans; -- Subtracts 1000 from Loan_Amount.

-- Logical operations within WHERE
SELECT * FROM Account WHERE Balance > 5000 AND Account_Type = 'Saving'; -- Uses AND to combine conditions.
SELECT * FROM Loans WHERE Loan_Type = 'Home' OR Loan_Amount > 30000; -- Uses OR to combine conditions.
SELECT * FROM Loans WHERE Customer_ID IN (1, 3, 5); -- Uses IN to match any value in a list.
SELECT * FROM Loans WHERE Loan_Type NOT IN ('Personal', 'Car'); -- Uses NOT IN to exclude values in a list.
SELECT * FROM Transactions WHERE Amount BETWEEN 500 AND 1000; -- Uses BETWEEN to check if a value is within a range.

-- LIKE operations for pattern matching 
SELECT * FROM Customer WHERE Customer_Name LIKE 'J%'; -- Finds names starting with 'J'.
SELECT * FROM Customer WHERE Email LIKE '%@example.com'; -- Finds emails ending with '@example.com'.
SELECT * FROM Customer WHERE Address LIKE '%o%'; -- Finds addresses containing 'o'.
SELECT * FROM Customer WHERE Phone LIKE '__345678%'; -- Finds phone numbers with '345678' starting from the 3rd digit, using underscore (_) as a wildcard for a single character.

-- ORDER BY clause
-- ORDER BY sorts the results. Default is ASC (ascending).
SELECT * FROM Account ORDER BY Balance DESC; -- Orders accounts by balance descending.
SELECT * FROM Customer ORDER BY Customer_Name ASC; -- Orders customers by name ascending.
SELECT * FROM Loans ORDER BY Loan_Amount DESC; -- Orders loans by amount descending.

-- DISTINCT keyword
-- DISTINCT removes duplicate values from the result set.
SELECT DISTINCT Account_Type FROM Account; -- Gets unique account types.
SELECT DISTINCT Loan_Type FROM Loans; -- Gets unique loan types.
SELECT DISTINCT Transaction_Type FROM Transactions; -- Gets unique transaction types.

-- NULL / NOT NULL checks
-- Checks for NULL values (absence of data). IS NOT NULL is a condition.
SELECT * FROM Customer WHERE Email IS NOT NULL; -- Finds customers with an email address.
SELECT * FROM Loans WHERE Loan_Status IS NULL; -- Finds loans where status is not set.

-- LIMIT clause
-- LIMIT restricts the number of rows returned.
SELECT * FROM Customer LIMIT 5; -- Returns only the first 5 customers.
SELECT * FROM Loans ORDER BY Issue_Date DESC LIMIT 3; -- Orders by issue date descending and returns the top 3 most recent loans.

-- Aggregate Functions
-- Functions that perform calculations on a set of rows and return a single value.
SELECT COUNT(*) FROM Customer; -- Counts the total number of customers.
SELECT SUM(Amount_Paid) FROM Loan_Payments; -- Calculates the total amount paid across all payments.
SELECT AVG(Balance) FROM Account; -- Calculates the average balance across all accounts.
SELECT MIN(Loan_Amount), MAX(Loan_Amount) FROM Loans; -- Calculates the min and max loan amount from loans

-- GROUP BY clause
-- GROUP BY groups rows that have the same values in specified columns into summary rows. Used with aggregate functions.
SELECT Account_Type, COUNT(*) FROM Account GROUP BY Account_Type; -- Counts how many accounts of each type exist.
SELECT Loan_Type, AVG(Loan_Amount) FROM Loans GROUP BY Loan_Type; -- Calculates the average loan amount for each loan type.
SELECT Loan_ID, SUM(Amount_Paid) FROM Loan_Payments GROUP BY Loan_ID; -- Calculates the total payment amount for each loan.

-- HAVING clause
-- HAVING filters groups created by GROUP BY, similar to how WHERE filters rows.
SELECT Loan_Type, COUNT(*) FROM Loans GROUP BY Loan_Type HAVING COUNT(*) > 2; -- Finds loan types that have more than 2 loans.
SELECT Loan_ID, SUM(Amount_Paid) AS TotalPaid FROM Loan_Payments GROUP BY Loan_ID HAVING TotalPaid > 10000; -- Finds loans where the total payment amount is over 10000.
SELECT Account_Type, AVG(Balance) AS AvgBal FROM Account GROUP BY Account_Type HAVING AvgBal > 4000; -- Finds account types with an average balance over 4000.

-- JOINS
-- Used to combine rows from two or more tables based on a related column between them.

-- 1.INNER JOIN
-- Returns rows when there is a match in both tables.
-- INNER JOIN (or just JOIN) returns only the rows where the join condition is met in both tables.
SELECT c.Customer_Name, a.Account_ID, a.Balance      -- Alias 'c' for Customer, 'a' for Account using table aliases.
FROM Customer c
JOIN Account a ON c.Customer_ID = a.Customer_ID;     -- Join condition links tables via Customer_ID.

SELECT a.Account_ID, t.Transaction_ID, t.Amount -- Alias 't' for Transactions.
FROM Account a
JOIN Transactions t ON a.Account_ID = t.Account_ID; -- Join condition links tables via Account_ID.

SELECT c.Customer_Name, l.Loan_Type, l.Loan_Amount -- Alias 'l' for Loans.
FROM Customer c
JOIN Loans l ON c.Customer_ID = l.Customer_ID; -- Join condition links tables via Customer_ID.

SELECT l.Loan_ID, l.Loan_Type, p.Amount_Paid -- Alias 'p' for Loan_Payments.
FROM Loans l
JOIN Loan_Payments p ON l.Loan_ID = p.Loan_ID; -- Join condition links tables via Loan_ID.

-- 1. Inner Join - List all customers along with their account balances
SELECT c.Customer_ID, c.Customer_Name, a.Account_ID, a.Balance
FROM Customer c
INNER JOIN Account a ON c.Customer_ID = a.Customer_ID;


-- 2. **LEFT JOIN (LEFT OUTER JOIN)**
-- Returns all rows from the left table, and matched rows from the right table.
-- List all customers and their accounts, even if they don’t have any account
SELECT c.Customer_ID, c.Customer_Name, a.Account_ID, a.Balance
FROM Customer c
LEFT JOIN Account a ON c.Customer_ID = a.Customer_ID;

-- 3. **RIGHT JOIN (RIGHT OUTER JOIN)**
-- Returns all rows from the right table, and matched rows from the left table.
-- List all accounts and their corresponding customers, even if some accounts have no associated customer (rare, but shown for structure)
SELECT c.Customer_ID, c.Customer_Name, a.Account_ID, a.Balance
FROM Customer c
RIGHT JOIN Account a ON c.Customer_ID = a.Customer_ID;


-- 4. **SELF JOIN**
-- Join a table to itself.
-- Example: Show pairs of customers in the same city
SELECT A.Customer_Name AS Customer1, B.Customer_Name AS Customer2, A.Address
FROM Customer A
JOIN Customer B ON A.Address = B.Address AND A.Customer_ID <> B.Customer_ID;


-- 5. **CROSS JOIN**
-- Returns the Cartesian product (all combinations).
-- Every customer with every account (use carefully!)
SELECT c.Customer_Name, a.Account_ID
FROM Customer c
CROSS JOIN Account a;

DROP Database ABCbank;