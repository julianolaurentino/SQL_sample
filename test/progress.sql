--Criando algumas consultas para testes

SELECT *
FROM [AdventureWorks2017].[Person].EmailAddress
WHERE
    BusinessEntityID = 26;

SELECT *
FROM [AdventureWorks2017].[Person].Person
WHERE 
    FirstName = 'Peter' AND LastName = 'Krebs';

SELECT 
    PP.FIRSTNAME
    ,PP.LASTNAME
    ,PE.EMAILADDRESS
FROM 
    [AdventureWorks2017].PERSON.PERSON PP
LEFT JOIN [AdventureWorks2017].[Person].EmailAddress PE
    ON PP.BusinessEntityID = PE.BusinessEntityID
    WHERE PP.FirstName = 'Peter' AND PP.LastName = 'Krebs';


SELECT COUNT(*) AS QTD_PRODUTOS
FROM [AdventureWorks2017].[Production].Product

SELECT COUNT([Size]) AS Size
FROM [AdventureWorks2017].[Production].[Product];

SELECT 
    FirstName
    ,LastName
FROM [AdventureWorks2017].[Person].[Person]
ORDER BY FirstName ASC;

SELECT 
    FirstName
    ,LastName
FROM [AdventureWorks2017].[Person].[Person]
ORDER BY FirstName ASC, LastName DESC;


SELECT 
    Name
    ,ListPrice
FROM [AdventureWorks2017].[Production].[Product]
WHERE ListPrice NOT BETWEEN 1000 AND 1500
ORDER BY ListPrice DESC;


SELECT 
    Name
    ,ListPrice
FROM [AdventureWorks2017].[Production].[Product]
WHERE ListPrice BETWEEN 1000 AND 1500
ORDER BY ListPrice ASC;

--toda função de agregação precisa ser agrupada
--exibindo a média do TotalDue agrupado por mês
SELECT 
    AVG(TotalDue) AS AVG_TotalDue
    ,DATEPART(MONTH, OrderDate) AS Month
FROM Sales.SalesOrderHeader
GROUP BY DATEPART(MONTH, OrderDate)
ORDER BY Month ASC;
