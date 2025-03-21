--Extrair apenas o nome de usuário do LoginID
SELECT 
    LoginID, 
    RIGHT(LoginID, LEN(LoginID) - CHARINDEX('\', LoginID)) AS Usuario
FROM HumanResources.Employee;


--Formatar números de telefone
SELECT
    PhoneNumber
    ,TRIM(REPLACE(PhoneNumber, ' ','-' )) AS PhoneNumber
FROM Person.PersonPhone;

SELECT
    PP.Name AS ProductName
    ,PPS.Name AS ProductSubcategory
    ,COUNT(SOD.SalesOrderID) AS OrderQty
FROM Sales.SalesOrderDetail SOD
INNER JOIN Production.Product PP ON SOD.ProductID = PP.ProductID
INNER JOIN  Production.ProductSubcategory PPS ON PP.ProductSubcategoryID = PPS.ProductSubcategoryID
GROUP BY PP.Name, PPS.Name
ORDER BY OrderQty DESC;