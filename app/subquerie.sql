--todos os produtos cadastrados que tem o preço de venda maior que a média 438.66
--caso a tabela sofra alterações durante o tempo, a query não precisará ser alterada
--pois a subquery irá retornar a média atualizada
SELECT *
FROM [AdventureWorks2017].[Production].[Product]
WHERE ListPrice > (SELECT AVG(ListPrice) AS AvgListPrice FROM [AdventureWorks2017].[Production].[Product]);

--todos os funcionários que tem o cargo de Design Engineer
SELECT
    FirstName
FROM [AdventureWorks2017].[Person].[Person]
WHERE BusinessEntityID IN (SELECT BusinessEntityID FROM [AdventureWorks2017].[HumanResources].[Employee] WHERE JobTitle = 'Design Engineer');

--alternativa com INNER JOIN
--podemos usar o actual plan para ver a diferença de performance quando usamos subqueries
SELECT
    PP.FirstName
FROM [AdventureWorks2017].[Person].[Person] PP
INNER JOIN [AdventureWorks2017].[HumanResources].[Employee] HE
    ON PP.BusinessEntityID = HE.BusinessEntityID
WHERE HE.JobTitle = 'Design Engineer';

--select de todos os endereços que estão no estado de Alberta e agrupando por cidade
SELECT *
FROM [AdventureWorks2017].[Person].[Address]
WHERE StateProvinceID = (SELECT StateProvinceID FROM [AdventureWorks2017].[Person].[StateProvince] WHERE Name = 'Alberta')
ORDER BY city ASC;

--Listar produtos que nunca foram vendidos
SELECT
    ProductID
    ,Name as product_name
FROM [AdventureWorks2017].[Production].[Product]
WHERE ProductID NOT IN (SELECT ProductID FROM [AdventureWorks2017].[Sales].[SalesOrderDetail]);

--Listar todos os clientes que fizeram pedidos com valor maior que 10.000
SELECT
    CustomerID
    ,PersonID
    ,territoryID
FROM [Sales].[Customer]
WHERE CustomerID IN (SELECT CustomerID FROM [Sales].[SalesOrderHeader] WHERE SubTotal > 10.000);

--listando os funcionários que trabalham no departamento de 'Sales'.
--ajustando o login do usuário para exibir apenas o nome do usuário
SELECT
    HE.BusinessEntityID
    --,HE.LoginID
    ,SUBSTRING(LoginID, CHARINDEX('\', LoginID) + 1, LEN(LoginID)) AS login
    ,HEDH.DepartmentID
    ,HD.Name
FROM HumanResources.Employee HE
INNER JOIN HumanResources.EmployeeDepartmentHistory HEDH
    ON HE.BusinessEntityID = HEDH.BusinessEntityID
INNER JOIN HumanResources.Department HD
    ON HEDH.DepartmentID = HD.DepartmentID
WHERE HEDH.DepartmentID = (SELECT DepartmentID FROM HumanResources.Department WHERE Name = 'Sales');

--Exibir os fornecedores que não possuem produtos cadastrados no banco de dados.
SELECT
    Name
    ,AccountNumber
    ,BusinessEntityID
FROM Purchasing.Vendor
WHERE BusinessEntityID NOT IN (SELECT BusinessEntityID FROM Purchasing.ProductVendor);