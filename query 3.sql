USE [WideWorldImporters]
GO
/****** Object:  StoredProcedure [dbo].[ReportCustomerTurnover]    Script Date: 12/03/2022 20:50:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ReportCustomerTurnover]

	@StartingChoice  INT=1, 
	@StartingYear INT = 2013

AS

BEGIN
SET NOCOUNT ON;

	DECLARE @Choice INT;
	SET @Choice = @StartingChoice;

	DECLARE @Year INT;
	SET @Year = @StartingYear;

	IF @CHOICE = 1 AND @Year IS NOT NULL
	BEGIN
	SELECT
CustomerName,
COALESCE(SUM(CASE  
	WHEN MONTH(InvoiceDate)= 1 AND YEAR(InvoiceDate) = @YEAR
	THEN (TotalInvoice) ELSE 0 END), 0) As 'Jan',
SUM(CASE  
	WHEN MONTH(InvoiceDate)= 2 AND YEAR(InvoiceDate) = @YEAR
	THEN (TotalInvoice) ELSE 0 END) As 'Feb',
SUM(CASE 
	WHEN MONTH(InvoiceDate)= 3 AND YEAR(InvoiceDate) = @YEAR 
	THEN (TotalInvoice) ELSE 0 END) As 'Mar',
SUM(CASE  
	WHEN MONTH(InvoiceDate)= 4 AND YEAR(InvoiceDate) = @YEAR 
	THEN (TotalInvoice) ELSE 0 END) As 'Apr',
SUM(CASE  
	WHEN MONTH(InvoiceDate)= 5 AND YEAR(InvoiceDate) = @YEAR 
	THEN (TotalInvoice) ELSE 0 END) As 'May',
SUM(CASE  
	WHEN MONTH(InvoiceDate)= 6 AND YEAR(InvoiceDate) = @YEAR 
	THEN (TotalInvoice) ELSE 0 END) As 'Jun',
SUM(CASE  
	WHEN MONTH(InvoiceDate)= 7 AND YEAR(InvoiceDate) = @YEAR 
	THEN (TotalInvoice) ELSE 0 END) As 'Jul',
SUM(CASE  
	WHEN MONTH(InvoiceDate)= 8 AND YEAR(InvoiceDate) = @YEAR 
	THEN (TotalInvoice) ELSE 0 END) As 'Aug',
SUM(CASE  
	WHEN MONTH(InvoiceDate)= 9 AND YEAR(InvoiceDate) = @YEAR 
	THEN (TotalInvoice) ELSE 0 END) As 'Sep',
SUM(CASE  
	WHEN MONTH(InvoiceDate)= 10 AND YEAR(InvoiceDate) = @YEAR 
	THEN (TotalInvoice) ELSE 0 END) As 'Oct',
SUM(CASE  
	WHEN MONTH(InvoiceDate)= 11 AND YEAR(InvoiceDate) = @YEAR 
	THEN (TotalInvoice) ELSE 0 END) As 'Nov',
SUM(CASE  
	WHEN MONTH(InvoiceDate)= 12 AND YEAR(InvoiceDate) = @YEAR 
	THEN (TotalInvoice) ELSE 0 END) As 'Dec'
FROM(SELECT
	i.CustomerID,
	c.CustomerName,
	i.InvoiceID,
	TotalInvoice,
	InvoiceDate
	FROM (SELECT
		InvoiceId,
		SUM(Quantity * Unitprice) AS TotalInvoice
		FROM Sales.InvoiceLines il
		GROUP BY InvoiceID) AS Sub1
	JOIN Sales.Invoices i
	ON i.InvoiceID = Sub1.InvoiceID
	RIGHT JOIN Sales.Customers c
	ON i.CustomerID = c.CustomerID) AS Sub2
	GROUP BY CustomerName
	ORDER BY CustomerName
	END

	IF @CHOICE = 2 AND @Year IS NOT NULL
	BEGIN
	SELECT
CustomerName,
SUM(CASE  
	WHEN DATEPART(quarter,InvoiceDate)= 1 AND YEAR(InvoiceDate) = @YEAR  
	THEN (TotalInvoice) ELSE 0 END) As 'Q1',
SUM(CASE  
	WHEN DATEPART(quarter,InvoiceDate)= 2 AND YEAR(InvoiceDate) = @YEAR  
	THEN (TotalInvoice) ELSE 0 END) As 'Q2',
SUM(CASE  
	WHEN DATEPART(quarter,InvoiceDate)= 3 AND YEAR(InvoiceDate) = @YEAR  
	THEN (TotalInvoice) ELSE 0 END) As 'Q3',
SUM(CASE  
	WHEN DATEPART(quarter,InvoiceDate)= 4 AND YEAR(InvoiceDate) = @YEAR  
	THEN (TotalInvoice) ELSE 0 END) As 'Q4'
FROM(SELECT
	i.CustomerID,
	c.CustomerName,
	i.InvoiceID,
	TotalInvoice,
	InvoiceDate
	FROM (SELECT
		InvoiceId,
		SUM(Quantity * Unitprice) AS TotalInvoice
		FROM Sales.InvoiceLines il
		GROUP BY InvoiceID) AS Sub1
	JOIN Sales.Invoices i
	ON i.InvoiceID = Sub1.InvoiceID
	RIGHT JOIN Sales.Customers c
	ON i.CustomerID = c.CustomerID) AS Sub2
	GROUP BY CustomerName
	ORDER BY CustomerName
	END


	IF @CHOICE = 3
	BEGIN
	SELECT
CustomerName,
SUM(CASE  
	WHEN YEAR(InvoiceDate)= 2013 
	THEN (TotalInvoice) ELSE 0 END) As '2013',
SUM(CASE  
	WHEN YEAR(InvoiceDate)= 2014 
	THEN (TotalInvoice) ELSE 0 END) As '2014',
SUM(CASE  
	WHEN YEAR(InvoiceDate)= 2015 
	THEN (TotalInvoice) ELSE 0 END) As '2015',
SUM(CASE  
	WHEN YEAR(InvoiceDate)= 2016 
	THEN (TotalInvoice) ELSE 0 END) As '2016'
FROM(SELECT
	i.CustomerID,
	c.CustomerName,
	i.InvoiceID,
	TotalInvoice,
	InvoiceDate
	FROM (SELECT
		InvoiceId,
		SUM(Quantity * Unitprice) AS TotalInvoice
		FROM Sales.InvoiceLines il
		GROUP BY InvoiceID) AS Sub1
	JOIN Sales.Invoices i
	ON i.InvoiceID = Sub1.InvoiceID
	RIGHT JOIN Sales.Customers c
	ON i.CustomerID = c.CustomerID) AS Sub2
	GROUP BY CustomerName
	ORDER BY CustomerName
	END
END;