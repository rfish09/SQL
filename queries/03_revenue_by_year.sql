SELECT
YEAR(I.InvoiceDate) AS 'Year',
SUM(I.Total) AS TotalRevenue,

SUM(I.Total) - LAG(SUM(I.Total)) OVER (ORDER BY YEAR(I.InvoiceDate)) AS RevenueDiff

FROM
Invoice AS I
GROUP BY 
YEAR(I.InvoiceDate)
ORDER BY
YEAR(I.InvoiceDate) DESC
