SELECT
Sub6.CustomerCategoryName,
MaxLoss,
CustomerName,
CustomerID
FROM(SELECT
	Sub5.CustomerCategoryName,
	MAX(Sub5.CustomerLoss) AS MaxLoss
	FROM(SELECT
		Sub4.CustomerName,
		Sub4.CustomerID,
		Sub4.CustomerLoss,
		cc.CustomerCategoryName
		FROM(SELECT
			Sub3.CustomerID,
			CustomerName,
			CustomerCategoryID,
			SUM(Loss) AS CustomerLoss
			FROM(SELECT
				Sub2.OrderID,
				Loss,
				CustomerID
				FROM
					(SELECT
					OrderID,
					SUM(Quantity * UnitPrice) AS Loss
					FROM(SELECT
						OrderID,
						Quantity,
						UnitPrice
						FROM Sales.OrderLines
						WHERE OrderID NOT IN(SELECT OrderID
											FROM Sales.Invoices)
						) AS Sub
					GROUP BY OrderID) AS Sub2
				JOIN Sales.Orders o
				ON o.OrderID = Sub2.OrderID) AS Sub3
			JOIN Sales.Customers c
			ON Sub3.CustomerID = c.CustomerID
			GROUP BY Sub3.CustomerID,CustomerName,CustomerCategoryID) AS Sub4
			JOIN Sales.CustomerCategories cc
			ON cc.CustomerCategoryID = Sub4.CustomerCategoryID) AS Sub5
			GROUP BY CustomerCategoryName) AS Sub6
			JOIN (SELECT
		Sub4.CustomerName,
		Sub4.CustomerID,
		Sub4.CustomerLoss,
		cc.CustomerCategoryName
		FROM(SELECT
			Sub3.CustomerID,
			CustomerName,
			CustomerCategoryID,
			SUM(Loss) AS CustomerLoss
			FROM(SELECT
				Sub2.OrderID,
				Loss,
				CustomerID
				FROM
					(SELECT
					OrderID,
					SUM(Quantity * UnitPrice) AS Loss
					FROM(SELECT
						OrderID,
						Quantity,
						UnitPrice
						FROM Sales.OrderLines
						WHERE OrderID NOT IN(SELECT OrderID
											FROM Sales.Invoices)
						) AS Sub
					GROUP BY OrderID) AS Sub2
				JOIN Sales.Orders o
				ON o.OrderID = Sub2.OrderID) AS Sub3
			JOIN Sales.Customers c
			ON Sub3.CustomerID = c.CustomerID
			GROUP BY Sub3.CustomerID,CustomerName,CustomerCategoryID) AS Sub4
			JOIN Sales.CustomerCategories cc
			ON cc.CustomerCategoryID = Sub4.CustomerCategoryID) AS Sub7
			ON Sub7.CustomerLoss = MaxLoss

			ORDER BY MaxLoss DESC