UPDATE Sales.InvoiceLines
SET Sales.InvoiceLines.UnitPrice = Sales.InvoiceLines.UnitPrice + 20
WHERE
Sales.InvoiceLines.InvoiceLineID = (SELECT MIN(il.InvoiceLineID)
									FROM Sales.InvoiceLines il
									WHERE il.InvoiceID =  (SELECT 
															MIN(InvoiceId)  
															FROM Sales.Invoices
															WHERE CustomerID = 1060
															)
)