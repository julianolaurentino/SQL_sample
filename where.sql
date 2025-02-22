
SELECT *
FROM [AdventureWorks2017].PERSON.PERSON
WHERE Lastname = 'miller' and FirstName = 'anna'

SELECT *
FROM 
    [AdventureWorks2017].Production.Product
/*WHERE 
    Color = 'red' OR Color = 'blue'*/
WHERE 
    Color IN ('red', 'black')

SELECT 
    Name as ProductName
    ,Color
    ,ListPrice
FROM 
    [AdventureWorks2017].Production.Product
/*WHERE 
    Color = 'red' OR Color = 'blue'*/
WHERE 
    Color IN ('red', 'black')
    AND ListPrice > 1500 AND ListPrice < 5000

SELECT *
FROM 
    [AdventureWorks2017].Production.Product
WHERE 
    Color <> 'red'

SELECT 
    Name
    ,Weight
FROM 
    [AdventureWorks2017].Production.Product
WHERE 
    Weight > 500 AND Weight < 700

SELECT *
FROM 
    [AdventureWorks2017].HumanResources.Employee
WHERE 
    MaritalStatus = 'M' AND SalariedFlag = 1


SELECT 
    PP.FIRSTNAME
    ,PP.LASTNAME
    ,PE.EMAILADDRESS
FROM 
    [AdventureWorks2017].PERSON.PERSON PP
LEFT JOIN [AdventureWorks2017].[Person].EmailAddress PE
    ON PP.BusinessEntityID = PE.BusinessEntityID
    WHERE PP.FirstName = 'Peter' AND PP.LastName = 'Krebs'