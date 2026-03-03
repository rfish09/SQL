# SQL
Chinook SQL Analysis

# Project Overview
This project is to illustrate usage of SQL using the Chinook Database. This will include filtering, aggregation, joins, and subqueries.

# Database Description
The Chinook database is a public sample database that models a digital music store. Tables within the database include:
  
- Albums
- Artists
- Customers
- Employees
- Genres
- Invoices
- Playlists
- Mediatypes

# Questions Explored
1. What are the most recent Invoices from Representative Jane Peacock?
2. Which cities have gotten the most revenue in 2025?
3. What is the Total Revenue by Year and How much did it change from the previous year?   



# Query 1: Recent Invoices
What are the most recent invoices from representative Jane Peacock?

### SQL
See queries/01_recent_invoices.sql

## Output
| InvoiceId | InvoiceDate | CustomerName | CustomerCompany | EmployeeRepName |
| --------- | ----------- | ------------ | ---------------- | --------------- |
| 395       | 2025-10-05  | Roberto Almeida | Riotur        | Jane Peacock    |
| 382       | 2025-08-07  | Luís Gonçalves | Embraer     | Jane Peacock    |
| 373       | 2025-07-03  | Roberto Almeida | Riotur     | Jane Peacock    |
| 350       | 2025-03-31  | Roberto Almeida | Riotur     | Jane Peacock    |
| 328       | 2024-12-15  | Jennifer Peterson | Rogers Canada    | Jane Peacock    |

- InvoiceDate contains 00:00:00 after the date, however I removed this for readability.
- Total Rows: 28

## Explanation
This query:
- JOIN Invoices to Customers Table, and Customers to Employees.
- CONCAT combines first and last name. Similar to using the || operator.
- WHERE gets the results where company has a value, and where the Representative last name contains Peacock.
- ORDER BY sorts the most recent invoice first.
- LIMIT cuts the results to the first 5 for readability.

This query show us what Invoices Jane Peacock has done since her hiring. First I planned to look at all Invoices, however I noticed that Jane Peacock was showing up more than others, so I wanted to see how many Invoices she had done (28). This could be used for a performance review. This also lets you know how many Invoices are done in a year, and a function to show that would need a simple COUNT(*) and GROUP BY statement.


# Query 2: City Revenue
Which cities have gotten the most revenue in 2025?

### SQL
See queries/02_city_revenue.sql

## Ouput
| City | Revenue_2025 |
| ---- | ------------- |
| Prague | 36.75 |
| Porto | 24.75 | 
| Buenos Aires | 24.75 |
| New York | 22.77 |
| Paris | 22.77 |

- Total Rows: 43

## Explanation
- SUM() used to get the total revenue per each instance of Invoice for that city
- WHERE used to sort the invoice dates to get only those in 2025
- GROUP BY sorts by the cities
- ORDER BY gets the highest summed revenue by city
- LIMIT for only top 5 results.

This query gives us the top 5 cities for the most revenue generated in 2025. This shows us that we seem to have the most business in Prague. Given this we could throw around the idea of opening more locations or upping business. We could also flip the ORDER BY to ASC to see what cities are not doing so well, and go over what might be causing that problem. Is it the representative? Is it the time of year? Was it doing well before and has fallen off? An example of other things we can look at.


# Query 3: Revenue Over Time

### SQL
See queries/03_revenue_by_year

## Output
| Year | TotalRevenue | RevenueDiff |
| ---- | ------------ | ----------- |
| 2025 | 450.58 | -26.95 |
| 2024 | 477.53 | 7.95 | 
| 2023 | 469.58 | -11.87 |
| 2022 | 481.45 | 31.99 |
| 2021 | 449.46 | NULL |

- Total Rows: 5

## Explanation
- YEAR() gets the year from the timestamp. This is similar to strftime() in SQLite.
- SUM() gets the total revenue for each year as signified by the GROUP BY.
- LAG() uses a previous row from the same query without having to use a self-join. In this case it made it easy to find the year over year differences by keeping it clean and only using one line. You need the OVER function for it to work. This specifies the order of the rows that it will be joining on. This allows LAG to go over those previous rows in the same way the previous aggregate function did so that it is using the same data to compute the result.
- GROUP BY() gets all the totals for each year and allows SUM to combine them.
- ORDER BY the year descending from 2025...2021.
- No Need to Limit since the database only goes back five years. If it went back say 20, we might want to limit.

This query shows us that revenue has been both increasing and decreasing year by year. It improved after the first year, but continued to flucuate. Looking at the full dataset I can assume that this is due to many 0.00's in the dataset, supposedely from not selling anything that year in a country/city, or on the off hand some extreme numbers like 90$ in one city. These kinds of outliers tend to wrench the differences up and down.









