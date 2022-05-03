SELECT
Sub.CustomerID,
c.CustomerName,
COUNT(DISTINCT Sub.OrderID) AS TotalNBOrders,
COUNT(DISTINCT Sub.OrderID) AS TotalNBInvoices,
SUM(Sub.Quantity * Sub.UnitPrice) AS OrdersTotalValue,
SUM (Sub.QuantityI * Sub.UnitPriceI) AS InvoicesTotalValue,
SUM((Sub.QuantityI * Sub.UnitPriceI)-(Sub.Quantity * Sub.UnitPrice)) AS AbsoluteValueDifference
FROM (SELECT
		o.CustomerID,
		o.OrderId,
		NULL AS InvoiceID,
		ol.UnitPrice,
		ol.Quantity,
		0 AS UnitPriceI,
		0 AS QuantityI,
		ol.OrderLineID,
		NULL AS InvoiceLineID 
		FROM Sales.Orders As o
		JOIN Sales.OrderLines AS ol
		ON o.OrderId = ol.OrderID AND EXISTS
		(	SELECT i.OrderId
			FROM Sales.Invoices AS i
			WHERE i.OrderID = o.OrderID
		)
		UNION
		SELECT i.CustomerID,
		NULL AS OrderId,
		i.InvoiceID,
		0 AS UnitPriceO,
		0 AS QuantityO,
		il.UnitPrice,
		il.Quantity,
		NULL AS OrderLineID,
		InvoiceLineID
		FROM Sales.Invoices AS i
		JOIN Sales.InvoiceLines AS il
		ON i.InvoiceID = il.InvoiceID
	) AS Sub
	JOIN Sales.Customers As c
	ON Sub.CustomerID = c.CustomerID
GROUP BY Sub.CustomerID, c.CustomerName
ORDER BY AbsoluteValueDifference DESC, TotalNBOrders, CustomerName