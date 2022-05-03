# SQL queries

Here are some exercises using the WorldWideWebImporters Database and SQLPlayground (source : https://github.com/Microsoft/sql-server-samples/releases/download/wide-world-importers-v1.0/WideWorldImporters-Full.bak)



## Question #1
Write a SQL query which reports the consistency between orders and their attached invoices.
The resultset should report for each (CustomerID, CustomerName)
 a. the total number of orders: TotalNBOrders
 b. the number of invoices converted from an order: TotalNBInvoices
 c. the total value of orders: OrdersTotalValue
 d. the total value of invoices: InvoicesTotalValue
 f. the absolute value of the difference between c - d: AbsoluteValueDifference
 
 The resultset must be sorted by highest values of AbsoluteValueDifference, then by smallest to highest values of TotalNBOrders and CustomerName is that order.
 
 Please note that all values in a & b must be identical by definition of the query, as we are observing orders converted into invoices.
We are looking for potential differences between c & d.
BUT, you must find them consistent as the data is clean in WideWorldImporters.

## Question #2
For the CustomerId = 1060 (CustomerName = 'Anand Mudaliyar')
Identify the first InvoiceLine of his first Invoice, where "first" means the lowest respective IDs, and write an update query increasing the UnitPrice of this InvoiceLine by 20.

## Question #3
Write a T-SQL stored procedure called ReportCustomerTurnover.
This procedure takes two parameters: Choice and Year, both integers.

When Choice = 1 and Year = <aYear>, ReportCustomerTurnover selects all the customer names and their total monthly turnover (invoiced value) for the year <aYear>.

When Choice = 2 and Year = <aYear>, ReportCustomerTurnover  selects all the customer names and their total quarterly (3 months) turnover (invoiced value) for the year <aYear>.

When Choice = 3, the value of Year is ignored and ReportCustomerTurnover  selects all the customer names and their total yearly turnover (invoiced value).

When no value is provided for the parameter Choice, the default value of Choice must be 1.
When no value is provided for the parameter Year, the default value is 2013. This doesn't impact Choice = 3.

For Choice = 3, the years can be hard-coded within the range of [2013-2016].

NULL values in the resultsets are not acceptable and must be substituted to 0.

All output resultsets are ordered by customer names alphabetically.

## Question #4
Write a SQL query which reports the highest loss of money from orders not being converted into invoices, by customer category.

The name and id of the customer who generated this highest loss must also be identified. The resultset is ordered by highest loss.
