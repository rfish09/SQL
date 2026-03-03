-- Query 1: Recent Invoices
-- Returns invoiceId, InvoiceDate, Customer Name, Customer Company, and Employee Rep Name

SELECT
I.InvoiceId AS 'InvoiceId',
I.InvoiceDate AS 'InvoiceDate',
CONCAT(C.FirstName, ' ', C.LastName) AS 'CustomerName',
C.Company AS 'CustomerCompany',
CONCAT(E.FirstName, ' ', E.LastName) AS 'CustomerEmployeeRepName'
FROM
Invoice AS I
JOIN Customer AS C
ON I.CustomerId = C.CustomerId
JOIN Employee AS E
ON C.SupportRepId = E.EmployeeId
WHERE C.Company IS NOT NULL
ORDER BY
I.InvoiceId DESC
LIMIT 5
