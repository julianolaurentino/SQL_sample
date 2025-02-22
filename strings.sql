SELECT
    RIGHT(LoginID, LEN(LoginID) - CHARINDEX('\', LoginID)) AS usuario
    ,SUBSTRING(LoginID, 1, CHARINDEX('-', LoginID) - 1) AS empresa
    ,HireDate
FROM [AdventureWorks2017].[HumanResources].[Employee]
WHERE HireDate BETWEEN '2009-01-01' AND '2009-01-31'
ORDER BY HireDate ASC

SELECT DISTINCT
    REPLACE(LTRIM(RTRIM(RIGHT(PhoneNumber, LEN(PhoneNumber) - CHARINDEX(') ', PhoneNumber)))), ' ', '-') AS PhoneNumber_format
FROM [AdventureWorks2017].[Person].PersonPhone
ORDER BY PhoneNumber ASC

SELECT 
    RIGHT(LoginID, LEN(LoginID) - CHARINDEX('\', LoginID)) AS usuario
    ,SUBSTRING(LoginID, 1, CHARINDEX('-', LoginID) - 1) AS empresa
    ,HireDate
    ,REPLACE(LTRIM(RTRIM(RIGHT(phonenumber, LEN(PhoneNumber) - CHARINDEX(') ', PhoneNumber)))), ' ', '-') AS PhoneNumber_format
FROM 
    [AdventureWorks2017].[HumanResources].[Employee] HE
LEFT JOIN [AdventureWorks2017].[Person].[PersonPhone] PP
    ON HE.BusinessEntityID = PP.BusinessEntityID;