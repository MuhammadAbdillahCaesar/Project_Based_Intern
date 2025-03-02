-- Store Procedure DailyTransaction  --
CREATE PROCEDURE DailyTransaction 
    @start_date DATETIME,  
    @end_date DATETIME     
AS
BEGIN
    SELECT 
        CAST(TransactionDate AS DATE) AS Date,             
        COUNT(TransactionID) AS TotalTransactions,          
        SUM(Amount) AS TotalAmount                          
    FROM FactTransaction
    WHERE TransactionDate BETWEEN @start_date AND @end_date
    GROUP BY CAST(TransactionDate AS DATE)
    ORDER BY Date;                                               
END;
GO

-- Store Procedure BalancePerCustomer --

CREATE PROCEDURE BalancePerCustomer 
    @name VARCHAR(50)
AS
BEGIN
    SELECT 
        c.CustomerName,
        a.AccountType,
        a.Balance,
        a.Balance + ISNULL(SUM(CASE WHEN t.TransactionType = 'Deposit' THEN t.Amount ELSE -t.Amount END), 0) AS CurrentBalance
    FROM 
        DimCustomer c
    JOIN 
        DimAccount a ON c.CustomerID = a.CustomerID
    LEFT JOIN 
        FactTransaction t ON a.AccountID = t.AccountID
    WHERE 
        LOWER(c.CustomerName) LIKE LOWER('%' + @name + '%')  -- Search case-insensitively for any part of the name
        AND a.Status = 'active'
    GROUP BY 
        c.CustomerName, a.AccountType, a.Balance
    ORDER BY 
        c.CustomerName, a.AccountType;
END;
GO

-- run sp
EXEC DailyTransaction @start_date = '2024-01-18', @end_date = '2024-03-20';

--run sp
EXEC BalancePerCustomer @name = 'Shelly';

-- FactTransaction --
SELECT * FROM FactTransaction;
DELETE FROM FactTransaction;

-- DimAccount --
SELECT * FROM DimAccount;
DELETE FROM DimAccount;

-- DimBranch --
SELECT * FROM DimBranch;
DELETE FROM DimBranch;

-- DimCustomer --
SELECT * FROM DimCustomer;
DELETE FROM DimCustomer;

