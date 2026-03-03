SELECT
I.BillingCity AS 'City',
SUM(I.TOTAL) AS 'Revenue_2025'
FROM
Invoice AS I
WHERE
I.InvoiceDate LIKE '%2025%'
GROUP BY
I.BillingCity
ORDER BY
SUM(I.Total) DESC
LIMIT 5
