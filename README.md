# ABC Bank SQL Database Project

A mini banking system built with **MySQL 8.0**, covering relational schema design, SQL queries, and constraints for customers, accounts, transactions, and loans.

# Files Included
- `ABCBank_MySQL_Project_v4.pptx`: Presentation file with ER diagram, SQL schema, queries, and analysis.
- ABCBank_Project.sql - SQL prroject file

# Project Objective
To design and implement a banking database for managing:
- Customer Information
- Account Details
- Financial Transactions
- Loans and Loan Payments

# Tools & Concepts Used
- MySQL Workbench
- DDL, DML, DQL
- Joins (INNER, LEFT, RIGHT, SELF, CROSS)
- Aggregate Functions (COUNT, SUM)
- Constraints (PRIMARY KEY, FOREIGN KEY, NOT NULL, CHECK, DEFAULT)

# Database Schema
- **Customer ↔ Account** (1:M)
- **Account ↔ Transactions** (1:M)
- **Customer ↔ Loans** (1:M)
- **Loans ↔ LoanPayments** (1:M)

# Sample SQL Snippets

```sql
-- Table: Customer
CREATE TABLE Customer (
  Customer_ID INT PRIMARY KEY,
  First_Name VARCHAR(50),
  Last_Name VARCHAR(50),
  Email VARCHAR(100),
  Phone_Number VARCHAR(15)
);

-- Inner Join: Customer + Account Balances
SELECT c.Customer_ID, c.First_Name, a.Account_ID, a.Balance
FROM Customer c
INNER JOIN Account a ON c.Customer_ID = a.Customer_ID;
