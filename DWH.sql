-- DWH --
CREATE DATABASE DWH;
GO

-- Tabel DimCustomer
CREATE TABLE DimCustomer (
    CustomerID INT,  
    CustomerName VARCHAR(50),
    Address VARCHAR(MAX),
    CityName VARCHAR(50),
    StateName VARCHAR(50),
    Age VARCHAR(3),  
    Gender VARCHAR(10),  
    Email VARCHAR(50) 
);
GO

-- Tabel DimAccount
CREATE TABLE DimAccount (
    AccountID INT ,
    CustomerID INT,  
    AccountType VARCHAR(10),
    Balance INT,
    DateOpened DATETIME2(0),
    Status VARCHAR(10),
);
GO

-- Tabel DimBranch
CREATE TABLE DimBranch (
    BranchID INT,    
    BranchName VARCHAR(50),
    BranchLocation VARCHAR(50)
GO

-- Tabel FactTransaction
CREATE TABLE FactTransaction (
    TransactionID INT, 
    AccountID INT,
    TransactionDate DATETIME2(0),
    Amount INT,
    TransactionType VARCHAR(50),
    BranchID INT
);
GO