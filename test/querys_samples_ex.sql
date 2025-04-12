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

--Listar os produtos mais vendidos com suas categorias
SELECT
    PP.Name AS ProductName
    ,PPS.Name AS ProductSubcategory
    ,COUNT(SOD.SalesOrderID) AS OrderQty
FROM Sales.SalesOrderDetail SOD
INNER JOIN Production.Product PP ON SOD.ProductID = PP.ProductID
INNER JOIN  Production.ProductSubcategory PPS ON PP.ProductSubcategoryID = PPS.ProductSubcategoryID
GROUP BY PP.Name, PPS.Name
ORDER BY OrderQty DESC;

--Encontrar os clientes e o total que gastaram em pedidos
--Desafio: Liste apenas os clientes que gastaram mais de $5000.
SELECT 
    SC.CustomerID
    ,SC.TerritoryID
    ,COUNT(SOH.SalesOrderID) AS TotalQty
    ,SUM(SOH.TotalDue) AS Total
FROM Sales.Customer SC
INNER JOIN Sales.SalesOrderHeader SOH ON SC.TerritoryID = SOH.TerritoryID
WHERE SOH.TotalDue > 5000
GROUP BY SC.CustomerID, SC.TerritoryID
ORDER BY Total;

--Listar produtos com preço acima da média
WITH TotalMedia AS(
    SELECT
        Name
        ,ListPrice
    FROM Production.Product
    WHERE ListPrice > 1000
)
SELECT *
FROM TotalMedia
WHERE ListPrice > (SELECT AVG(ListPrice) FROM Production.Product)
ORDER BY ListPrice DESC;

--Encontrar os 5 produtos mais vendidos por categoria
WITH VendasPorProduto AS (
    SELECT 
        P.ProductID,
        P.Name AS Produto,
        PS.Name AS Categoria,
        COUNT(SD.SalesOrderID) AS TotalVendas,
        RANK() OVER (PARTITION BY PS.Name ORDER BY COUNT(SD.SalesOrderID) DESC) AS Ranking
    FROM Sales.SalesOrderDetail SD
    JOIN Production.Product P ON SD.ProductID = P.ProductID
    JOIN Production.ProductSubcategory PS ON P.ProductSubcategoryID = PS.ProductSubcategoryID
    GROUP BY P.ProductID, P.Name, PS.Name
)
SELECT * 
FROM VendasPorProduto
WHERE Ranking <= 5
ORDER BY Categoria, Ranking;


SELECT 
    SalesOrderID
    ,CAST(UnitPrice AS INT) as UnitPrice
FROM Sales.SalesOrderDetail;