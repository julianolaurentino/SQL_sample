--comparando groupby e window function
--descobrindo o total de vendas por cliente por meio do group by
SELECT
    SalesOrderID
    ,ProductID
    ,FORMAT(ModifiedDate, 'dd/MM/yyyy') AS OrderDate
    ,SUM(OrderQty) AS TotalOrderQty
FROM SALES.SalesOrderDetail
GROUP BY SalesOrderID, ProductID, ModifiedDate

-- Descobrindo o total de vendas em todos os pedidos
SELECT
    FORMAT(ModifiedDate, 'dd/MM/yyyy') AS OrderDate
    ,SalesOrderID
    ,ProductID
    ,SUM(OrderQty) OVER (PARTITION BY ProductID) AS TotalOrderQty
FROM Sales.SalesOrderDetail
ORDER BY ProductID ASC 

-- Descobrindo o total de vendas por quantidade de produtos em todos os pedidos
SELECT
    FORMAT(ModifiedDate, 'dd/MM/yyyy') AS OrderDate
    ,SalesOrderID
    ,ProductID
    ,OrderQty
    ,SUM(OrderQty) OVER() AS  TotalOrderQty
    ,SUM(OrderQty) OVER (PARTITION BY ProductID) AS TotalOrderbyProductID
FROM Sales.SalesOrderDetail
ORDER BY ProductID ASC

-- Descobrindo o total de vendas por quantidade de produtos e territorio em todos os pedidos
SELECT
    FORMAT(OD.ModifiedDate, 'dd/MM/yyyy') AS OrderDate
    ,OH.TerritoryID
    ,OD.SalesOrderID
    ,OD.ProductID
    ,OD.OrderQty
    ,SUM(OD.OrderQty) OVER() AS  TotalOrderQty
    ,SUM(OD.OrderQty) OVER (PARTITION BY ProductID, TerritoryID) AS TotalOrderbyProductID_TerritoryID
FROM Sales.SalesOrderDetail OD
    INNER JOIN SALES.SalesOrderHeader OH ON OD.SalesOrderID = OH.SalesOrderID
ORDER BY ProductID ASC