--exemplos de scripts de como usar o PIVOT e UNPIVOT no SQL Server
SELECT *
FROM (
    SELECT 
        FORMAT(ModifiedDate, 'dd/MM/yyyy') AS OrderDate,
        Name,
        ListPrice
    FROM Production.Product
) AS SourceTable
PIVOT (
    SUM(ListPrice) 
    FOR Name IN ([Mountain-200 Black, 42], [Mountain-200 Black, 38], [Mountain-200 Red, 38])
) AS PivotTable;

--total de vendas (TotalDue) por ano usando PIVOT. 
--A tabela de origem é Sales.SalesOrderHeader, e a coluna a ser agregada é TotalDue.
SELECT * 
FROM (
    SELECT
        YEAR(OrderDate) AS OrderYear
        ,TotalDue
    FROM Sales.SalesOrderHeader
) AS SourceTable
PIVOT (
    SUM(TotalDue)
    FOR OrderYear IN ([2004], [2005], [2006], [2007], [2008], [2009], [2010], [2011], [2012], [2013])
 ) AS PIVOTTable;


--quantidade total de produtos vendidos (OrderQty) 
--para cada subcategoria de produto,(Production.ProductSubcategory) no ano de 2013
SELECT *
FROM (
    SELECT
        YEAR(OD.ModifiedDate) AS OrderYear
        ,P.Name
        ,PS.Name AS SubcategoryName
        ,OD.OrderQty
    FROM Sales.SalesOrderDetail OD 
    INNER JOIN Production.Product P ON OD.ProductID = P.ProductID 
    INNER JOIN Production.ProductSubcategory PS ON P.ProductSubcategoryID = PS.ProductSubcategoryID
) AS SourceTable
PIVOT (
    SUM(OrderQty) 
    FOR OrderYear IN ([2013])
) AS PivotTable;

--PIVOT para mostrar o preço de lista (ListPrice) 
--dos produtos das categorias "Bikes", "Components" e "Clothing".
SELECT *
FROM (
    SELECT
        P.Name AS ProductName,
        PC.Name AS CategoryName,
        P.ListPrice
    FROM Production.Product P
    INNER JOIN Production.ProductCategory PC ON P.ProductSubcategoryID = PC.ProductCategoryID
    INNER JOIN Production.ProductSubcategory PS ON P.ProductSubcategoryID = PS.ProductSubcategoryID
) AS SourceTable
PIVOT (
    SUM(ListPrice) 
    FOR CategoryName IN ([Bikes], [Components], [Clothing])
) AS PivotTable;

--Status dos pedidos de venda em colunas e a contagem de pedidos para cada ano.
SELECT *
FROM (
    SELECT
        YEAR(OrderDate) AS OrderYear
        ,[Status]
        ,TotalDue
    FROM SALES.SalesOrderHeader
) AS SourceTable
PIVOT (
    SUM(TotalDue) 
    FOR OrderYear IN ([2010], [2011], [2012], [2013])
) AS PivotTable;

--relatório pivotado que 
--mostre a quantidade de funcionários (HumanResources.Employee) por título de cargo.
SELECT * 
FROM (
    SELECT
        JobTitle
        ,NationalIDNumber
    FROM HumanResources.Employee
) AS SourceTable
PIVOT (
    COUNT(NationalIDNumber) 
    FOR JobTitle IN (
        [Production Technician]
        ,[Production Supervisor]
        ,[Production Manager]
        ,[Production Planner]
        ,[Production Assistant]
        ,[Production Team Leader]
        ,[Production Worker]
        ,[Production Engineer]
    )
) AS PivotTable;