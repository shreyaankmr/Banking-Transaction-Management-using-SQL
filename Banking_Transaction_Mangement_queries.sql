CREATE DATABASE BANK_MANG;
USE BANK_MANG;
-- Create Customer Table
CREATE TABLE Customer (
    Customer_id INT PRIMARY KEY,
    Name VARCHAR(255),
    DOB DATE,
    Age INT,
    phone_no VARCHAR(15),
    Address VARCHAR(255)
);

-- Create Accounts Table
CREATE TABLE Accounts (
    Account_id INT PRIMARY KEY,
    customer_id INT,
    type VARCHAR(50),
    balance DECIMAL(18, 2),
    FOREIGN KEY (customer_id) REFERENCES Customer(Customer_id)
);

-- Create Transaction Table
CREATE TABLE Transaction (
    Transaction_id INT PRIMARY KEY,
    source_accid INT,
    transaction_type VARCHAR(50),
    dest_accid INT,
    amount DECIMAL(18, 2),
    timestamp TIMESTAMP,
    remarks VARCHAR(255),
    transaction_status VARCHAR(50),
    fees DECIMAL(18, 2),
    FOREIGN KEY (source_accid) REFERENCES Accounts(Account_id),
    FOREIGN KEY (dest_accid) REFERENCES Accounts(Account_id)
);

-- Create Beneficiary Table
CREATE TABLE Beneficiary (
    Beneficiary_id INT PRIMARY KEY,
    Name VARCHAR(255),
    contact VARCHAR(15),
    Transaction_id INT,
    FOREIGN KEY (Transaction_id) REFERENCES Transaction(Transaction_id)
);

-- Create Branch Table
CREATE TABLE Branch (
    branch_id INT PRIMARY KEY,
    branch_location VARCHAR(255),
    phone_no VARCHAR(15),
    manager VARCHAR(255)
);

-- Create Card Table
CREATE TABLE Card (
    card_no INT PRIMARY KEY,
    customer_id INT,
    account_id INT,
    Type VARCHAR(50),
    expiry DATE,
    cvv INT,
    pin INT,
    FOREIGN KEY (customer_id) REFERENCES Customer(Customer_id),
    FOREIGN KEY (account_id) REFERENCES Accounts(Account_id)
);

-- Create Schemes Table
CREATE TABLE Schemes (
    Scheme_id INT PRIMARY KEY,
    Name VARCHAR(255),
    Duration INT,
    Interest DECIMAL(5, 2)
);

-- Create Loan Table
CREATE TABLE Loan (
    Loan_id INT PRIMARY KEY,
    loanee_id INT,
    issue_date DATE,
    rate DECIMAL(5, 2),
    principal DECIMAL(18, 2),
    FOREIGN KEY (loanee_id) REFERENCES Customer(Customer_id)
);

-- Create Nominee Table
CREATE TABLE Nominee (
    Nominee_id INT PRIMARY KEY,
    Name VARCHAR(255),
    relation VARCHAR(50),
    account_id INT,
    FOREIGN KEY (account_id) REFERENCES Accounts(Account_id)
);

-- Create Tax Table
CREATE TABLE Tax (
    tax_no INT PRIMARY KEY,
    account_id INT,
    eligibility VARCHAR(255),
    bracket VARCHAR(50),
    FOREIGN KEY (account_id) REFERENCES Accounts(Account_id)
);

-- Create a owns (i.e relation) table
CREATE TABLE owns (
    customer_id INT,
    account_id INT,
    PRIMARY KEY (customer_id, account_id),
    FOREIGN KEY (customer_id) REFERENCES Customer(Customer_id),
    FOREIGN KEY (account_id) REFERENCES Accounts(Account_id)
);

SHOW TABLES;

-- Insert into customer table
INSERT INTO Customer (Customer_id, Name, DOB, Age, phone_no, Address)
VALUES
(1, 'Rahul Kumar', '1990-05-15', 32, '9876543210', '123 MG Road'),
(2, 'Priya Sharma', '1985-08-22', 37, '8765432109', '456 Jayanagar'),
(3, 'Amit Patel', '1988-12-10', 33, '7654321098', '789 Malleshwaram'),
(4, 'Sneha Das', '1995-03-25', 28, '6543210987', '321 Koramangala'),
(5, 'Vikram Singh', '1980-07-18', 42, '5432109876', '567 Whitefield'),
(6, 'Ananya Reddy', '1992-09-05', 29, '4321098765', '876 Electronic City'),
(7, 'Karthik Menon', '1983-11-30', 38, '3210987654', '234 Indiranagar'),
(8, 'Ritu Kapoor', '1998-06-15', 25, '2109876543', '789 Koramangala'),
(9, 'Rajat Gupta', '1987-04-22', 34, '1098765432', '456 Marathahalli'),
(10, 'Anushka Jain', '1994-02-08', 27, '9876543210', '123 BTM Layout');

-- Insert data into Accounts Table
INSERT INTO Accounts (Account_id, customer_id, type, balance)
VALUES
(1, 1, 'Savings', 5000.00),
(2, 1, 'Checking', 2000.00),
(3, 2, 'Savings', 8000.00),
(4, 2, 'Fixed Deposit', 15000.00),
(5, 3, 'Checking', 3000.00),
(6, 3, 'Savings', 12000.00),
(7, 4, 'Savings', 6000.00),
(8, 5, 'Current', 10000.00),
(9, 6, 'Savings', 9000.00),
(10, 7, 'Fixed Deposit', 20000.00);

-- Insert data into Transaction Table
INSERT INTO Transaction (Transaction_id, source_accid, transaction_type, dest_accid, amount, timestamp, remarks, transaction_status, fees)
VALUES
(1, 1, 'Transfer', 2, 1000.00, '2023-01-15 10:30:00', 'Transfer to Priya', 'Success', 2.50),
(2, 3, 'Deposit', 3, 5000.00, '2023-02-20 15:45:00', 'Deposit from Amit', 'Success', 0.50),
(3, 4, 'Withdrawal', 4, 2000.00, '2023-03-10 08:15:00', 'Withdrawal by Sneha', 'Success', 1.00),
(4, 5, 'Transfer', 6, 3000.00, '2023-04-05 12:00:00', 'Transfer to Ananya', 'Success', 2.00),
(5, 7, 'Deposit', 7, 10000.00, '2023-05-22 09:30:00', 'Deposit from Karthik', 'Success', 1.50),
(6, 8, 'Withdrawal', 8, 1500.00, '2023-06-18 14:20:00', 'Withdrawal by Ritu', 'Success', 0.75),
(7, 9, 'Transfer', 10, 7000.00, '2023-07-10 17:00:00', 'Transfer to Anushka', 'Success', 3.00),
(8, 10, 'Withdrawal', 9, 2500.00, '2023-08-05 11:45:00', 'Withdrawal by Rajat', 'Success', 1.25),
(9, 2, 'Deposit', 2, 4000.00, '2023-09-12 13:10:00', 'Deposit from Priya', 'Success', 0.75),
(10, 6, 'Transfer', 5, 6000.00, '2023-10-08 16:30:00', 'Transfer to Vikram', 'Success', 2.50);

-- Insert data into Beneficiary Table
INSERT INTO Beneficiary (Beneficiary_id, Name, contact, Transaction_id)
VALUES
(1, 'Mother', '9876543210', 1),
(2, 'Father', '8765432109', 2),
(3, 'Sibling', '7654321098', 4),
(4, 'Friend', '6543210987', 6),
(5, 'Relative', '5432109876', 8),
(6, 'Colleague', '4321098765', 10),
(7, 'Spouse', '3210987654', 3),
(8, 'Child', '2109876543', 5),
(9, 'Neighbor', '1098765432', 7),
(10, 'Business Partner', '9876543210', 9);

-- Insert data into Branch Table
INSERT INTO Branch (branch_id, branch_location, phone_no, manager)
VALUES
(1, 'Main Branch', '8888888888', 'Mr. Sharma'),
(2, 'City Center', '7777777777', 'Ms. Kapoor'),
(3, 'Tech Park', '6666666666', 'Mr. Reddy'),
(4, 'Suburb Plaza', '5555555555', 'Ms. Das'),
(5, 'Financial District', '4444444444', 'Mr. Gupta'),
(6, 'Industrial Area', '3333333333', 'Ms. Jain'),
(7, 'Business Hub', '2222222222', 'Mr. Menon'),
(8, 'Corporate Zone', '1111111111', 'Ms. Smith'),
(9, 'Shopping Complex', '9999999999', 'Mr. Patel'),
(10, 'Residential Zone', '1234567890', 'Ms. Johnson');

-- Insert data into Card Table
INSERT INTO Card (card_no, customer_id, account_id, Type, expiry, cvv, pin)
VALUES
(123456789, 1, 1, 'Debit', '2024-12-31', 123, 5678),
(234567890, 1, 2, 'Credit', '2025-10-31', 456, 7890),
(345678901, 2, 3, 'Debit', '2023-08-31', 789, 1234),
(456789012, 2, 4, 'Credit', '2026-04-30', 987, 2345),
(567890123, 3, 5, 'Debit', '2024-06-30', 321, 3456),
(678901234, 3, 6, 'Credit', '2023-12-31', 654, 4567),
(789012345, 4, 7, 'Debit', '2025-02-28', 876, 5678),
(890123456, 4, 8, 'Credit', '2026-09-30', 234, 6789),
(901234567, 5, 9, 'Debit', '2023-11-30', 543, 7890),
(1234567890, 5, 10, 'Credit', '2024-05-31', 789, 8901);

-- Insert data into Schemes Table
INSERT INTO Schemes (Scheme_id, Name, Duration, Interest)
VALUES
(1, 'Fixed Deposit', 12, 3.5),
(2, 'Recurring Deposit', 24, 4.0),
(3, 'Savings Plan', 36, 2.5),
(4, 'Education Loan', 60, 5.8),
(5, 'Home Loan', 120, 6.2),
(6, 'Personal Loan', 36, 7.0),
(7, 'Senior Citizen Scheme', 24, 4.5),
(8, 'Gold Loan', 12, 8.0),
(9, 'Car Loan', 48, 6.5),
(10, 'Business Loan', 84, 9.2);

-- Insert data into Loan Table
INSERT INTO Loan (Loan_id, loanee_id, issue_date, rate, principal)
VALUES
(1, 2, '2023-02-01', 5.0, 10000.00),
(2, 4, '2023-04-15', 6.5, 20000.00),
(3, 6, '2023-07-01', 7.8, 15000.00),
(4, 8, '2023-09-20', 6.0, 25000.00),
(5, 10, '2023-11-10', 8.2, 18000.00),
(6, 1, '2024-01-05', 7.0, 12000.00),
(7, 3, '2024-03-22', 5.5, 30000.00),
(8, 5, '2024-06-18', 6.8, 22000.00),
(9, 7, '2024-08-10', 8.5, 18000.00),
(10, 9, '2024-10-05', 7.2, 20000.00);

-- Insert data into Nominee Table
INSERT INTO Nominee (Nominee_id, Name, relation, account_id)
VALUES
(1, 'Aarav Kumar', 'Son', 1),
(2, 'Meera Patel', 'Daughter', 2),
(3, 'Arjun Das', 'Brother', 3),
(4, 'Neha Singh', 'Sister', 4),
(5, 'Aryan Reddy', 'Son', 6),
(6, 'Dia Menon', 'Daughter', 7),
(7, 'Vir Kapoor', 'Son', 8),
(8, 'Riya Gupta', 'Daughter', 9),
(9, 'Isha Jain', 'Sister', 10),
(10, 'Vihaan Menon', 'Son', 5);

-- Insert data into Tax Table
INSERT INTO Tax (tax_no, account_id, eligibility, bracket)
VALUES
(98765, 2, 'Eligible', '30%'),
(87654, 4, 'Eligible', '25%'),
(76543, 6, 'Eligible', '20%'),
(65432, 8, 'Eligible', '18%'),
(54321, 10, 'Eligible', '22%'),
(43210, 1, 'Not Eligible', 'NA'),
(32109, 3, 'Not Eligible', 'NA'),
(21098, 5, 'Not Eligible', 'NA'),
(10987, 7, 'Eligible', '15%'),
(98764, 9, 'Eligible', '50%');

-- Insert data into owns table
INSERT INTO owns (customer_id, account_id)
VALUES
    (1, 1),
    (1, 2),
    (2, 3),
    (2, 4),
    (3, 5),
    (3, 6),
    (4, 7),
    (5, 8),
    (6, 9),
    (7, 10);

-- Statements to check the insert statements

SELECT * FROM Customer;
SELECT * FROM Accounts;
SELECT * FROM Transaction;
SELECT * FROM Beneficiary;
SELECT * FROM Branch;
SELECT * FROM Card;
SELECT * FROM Schemes;
SELECT * FROM  Loan;
SELECT * FROM Nominee;
SELECT * FROM  Tax;
SELECT * FROM owns;

-- Create a trigger to update account balances after a new transaction
DELIMITER //
CREATE TRIGGER update_account_balances AFTER INSERT ON Transaction
FOR EACH ROW
BEGIN
    -- Update the balance of the source account
    UPDATE Accounts
    SET balance = balance - NEW.amount
    WHERE Account_id = NEW.source_accid;

    -- Update the balance of the destination account
    UPDATE Accounts
    SET balance = balance + NEW.amount
    WHERE Account_id = NEW.dest_accid;
END;
//
DELIMITER ;

SELECT * FROM Accounts; -- Before transaction
SELECT * FROM Transaction;

INSERT INTO Transaction (Transaction_id, source_accid, transaction_type, dest_accid, amount, timestamp, remarks, transaction_status, fees)
VALUES
(11, 1, 'Transfer', 2, 590.00, '2023-01-15 11:30:00', 'Transfer to Priya', 'Success', 2.50);
SELECT * FROM Accounts;

-- Create a stored procedure to retrieve transaction history for a specific account
DELIMITER //
CREATE PROCEDURE GetTransactionHistory(accountID INT)
BEGIN
    SELECT
        Transaction_id,
        transaction_type,
        amount,
        timestamp,
        remarks
    FROM
        Transaction
    WHERE
        source_accid = accountID OR dest_accid = accountID;
END;
//
DELIMITER ;

CALL GetTransactionHistory(1);

-- Create a function to calculate total fees paid by a customer
DELIMITER //
CREATE FUNCTION CalculateTotalFeePaid(customerID INT) RETURNS DECIMAL(18, 2) READS SQL DATA
BEGIN
    DECLARE totalFees DECIMAL(18, 2);

    SELECT SUM(fees) INTO totalFees
    FROM Transaction
    WHERE source_accid IN (SELECT Account_id FROM Accounts WHERE customer_id = customerID);

    RETURN COALESCE(totalFees, 0);
END;
//
DELIMITER ;

SELECT CalculateTotalFeePaid(3) AS TotalFees;


-- Simple queries Requirement
SELECT
    b.Beneficiary_id,
    b.Name AS BeneficiaryName,
    b.contact
FROM
    Beneficiary b
WHERE
    b.Transaction_id = 8;
    
SELECT
    l.Loan_id,
    l.issue_date,
    l.rate,
    l.principal
FROM
    Loan l
WHERE
    l.loanee_id = 2;
    
-- Query 7: Retrieve Information about All Branches
SELECT
    branch_id,
    branch_location,
    phone_no,
    manager
FROM
    Branch;
    
    
-- Requirement Nested query
-- Highest balance customers
SELECT
    Customer_id,
    Name,
    (SELECT MAX(balance) FROM Accounts WHERE customer_id = c.Customer_id) AS HighestBalance
FROM
    Customer c;

-- Tax eligible customers
SELECT
    c.Customer_id,
    c.Name,
    (SELECT bracket FROM Tax WHERE account_id = a.Account_id) AS TaxBracket
FROM
    Customer c
JOIN
    Accounts a ON c.Customer_id = a.customer_id
WHERE
    EXISTS (SELECT 1 FROM Tax WHERE account_id = a.Account_id)
LIMIT 0, 1000;


-- Requirement of Correlated queries
--  Retrieve Customers with Average Account Balance Greater Than Overall Average
SELECT
    Customer_id,
    Name,
    (SELECT AVG(balance) FROM Accounts WHERE customer_id = c.Customer_id) AS AvgAccountBalance
FROM
    Customer c
HAVING
    AvgAccountBalance > (SELECT AVG(balance) FROM Accounts);
    
-- List Transactions with Amount Exceeding Customer's Average Balance
SELECT
    Transaction_id,
    transaction_type,
    amount,
    (SELECT AVG(balance) FROM Accounts WHERE Account_id = t.source_accid) AS AvgBalance
FROM
    Transaction t
WHERE
    amount > (SELECT AVG(balance) FROM Accounts WHERE Account_id = t.source_accid);
    
-- Requirement Aggregate along with group by and having
--  Retrieve Customers with the Highest Average Account Balance
SELECT
    c.Customer_id,
    c.Name,
    AVG(a.balance) AS AvgAccountBalance
FROM
    Customer c
JOIN
    Accounts a ON c.Customer_id = a.customer_id
GROUP BY
    c.Customer_id, c.Name
HAVING
    AvgAccountBalance >= ALL (SELECT AVG(balance) FROM Accounts GROUP BY customer_id);
    
-- Retrieve Customers with Multiple Accounts and Their Total Balance
SELECT
    c.Customer_id,
    c.Name,
    COUNT(DISTINCT a.Account_id) AS NumberOfAccounts,
    SUM(a.balance) AS TotalBalance
FROM
    Customer c
JOIN
    Accounts a ON c.Customer_id = a.customer_id
GROUP BY
    c.Customer_id, c.Name
HAVING
    NumberOfAccounts > 1 AND TotalBalance > 10000; 
    
-- Additional Requirement All JOINS
-- INNER JOIN  Retrieve Customers with Their Accounts
SELECT
    Customer.Customer_id,
    Customer.Name,
    Accounts.Account_id,
    Accounts.type,
    Accounts.balance
FROM
    Customer
INNER JOIN
    Accounts ON Customer.Customer_id = Accounts.customer_id;
    
-- LEFT OUTER JOIN  Retrieve All Customers and Their Accounts (including customers without accounts)
SELECT
    Customer.Customer_id,
    Customer.Name,
    Accounts.Account_id,
    Accounts.type,
    Accounts.balance
FROM
    Customer
LEFT JOIN
    Accounts ON Customer.Customer_id = Accounts.customer_id;
    
-- Right Outer Join
-- Another Right Outer join to know customer owning accounts in owns table
SELECT *
FROM Customer
RIGHT JOIN owns ON Customer.Customer_id = owns.customer_id;

    
-- Full Outer Join: Retrieve All Customers and Accounts (including unmatched rows from both tables)
-- Retrieve all customers and their accounts
SELECT
    Customer.Customer_id,
    Customer.Name,
    Accounts.Account_id,
    Accounts.type,
    Accounts.balance
FROM
    Customer
LEFT JOIN
    Accounts ON Customer.Customer_id = Accounts.customer_id

UNION

-- Retrieve all accounts and their customers (excluding those already retrieved)
SELECT
    Customer.Customer_id,
    Customer.Name,
    Accounts.Account_id,
    Accounts.type,
    Accounts.balance
FROM
    Customer
RIGHT JOIN
    Accounts ON Customer.Customer_id = Accounts.customer_id
WHERE
    Customer.Customer_id IS NULL;
    
-- Equi Join: Retrieve Transactions with Source and Destination Account Details
SELECT
    Transaction.Transaction_id,
    Transaction.transaction_type,
    Transaction.amount,
    Transaction.timestamp,
    Transaction.remarks,
    AccountsSource.Account_id AS SourceAccount,
    AccountsDest.Account_id AS DestinationAccount
FROM
    Transaction
JOIN
    Accounts AccountsSource ON Transaction.source_accid = AccountsSource.Account_id
JOIN
    Accounts AccountsDest ON Transaction.dest_accid = AccountsDest.Account_id;


-- Delete statement
-- Delete a specific transaction from the Transaction table
DELETE FROM Transaction
WHERE Transaction_id = 1;

-- to check output of delete statement
SELECT * FROM Transaction;

-- Update statement
-- Update the balance of a specific account in the Accounts table
UPDATE Accounts
SET balance = 6000.00
WHERE Account_id = 3;

-- to check the output of update statement
SELECT * FROM Accounts;










    

    











