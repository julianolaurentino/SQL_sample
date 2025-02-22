SELECT *
FROM Person.Person
WHERE FirstName = 'PETER' AND LastName = 'KREBS'

SELECT *
FROM Person.EmailAddress
WHERE BusinessEntityID = 26

SELECT * 
FROM Production.Product
WHERE Color != 'RED'
--WHERE ListPrice > 1500 AND ListPrice < 5000
--WHERE Color = 'BLUE' OR Color = 'BLACK'

SELECT * 
FROM Production.Product
WHERE Weight > 500 AND Weight <= 700

SELECT *
FROM HumanResources.Employee
WHERE MaritalStatus = 'M' AND SalariedFlag = '1'

SELECT COUNT(ProductID) Count_Product
FROM Production.Product

SELECT COUNT([Size]) Count_Size
FROM Production.Product

SELECT COUNT(DISTINCT[Size]) Count_Distinct_Size
FROM Production.Product

SELECT TOP 10 *
FROM Production.Product
WHERE Weight > 500 AND Weight <= 700
ORDER BY Weight ASC

SELECT * 
FROM Person.Person
ORDER BY FirstName ASC, LastName DESC

SELECT TOP 10 ProductID
FROM Production.Product
ORDER BY ListPrice DESC

SELECT FirstName, COUNT(FIRSTNAME) AS "QTD"
FROM Person.Person
WHERE Title = 'Mr.'
GROUP BY FirstName
HAVING COUNT(FIRSTNAME) > 10

SELECT PRODUCTID, SUM(LINETOTAL) AS 'SUM'
FROM SALES.SalesOrderDetail
GROUP BY ProductID
HAVING SUM(LINETOTAL) BETWEEN 16200 AND 500000

SELECT STATEPROVINCEID, COUNT(STATEPROVINCEID) AS 'QTD_PROVINCE'
FROM PERSON.Address WITH(NOLOCK)
GROUP BY StateProvinceID
HAVING COUNT(StateProvinceID) > 1000
ORDER BY StateProvinceID DESC

SELECT ProductID, AVG(LINETOTAL) AS 'AVG_LINETOTAL'
FROM SALES.SalesOrderDetail
GROUP BY ProductID
HAVING AVG(LINETOTAL) <= 1000000

SELECT PP.BusinessEntityID, PP.FirstName, PP.LastName, PE.EmailAddress
FROM PERSON.Person PP
 JOIN PERSON.EmailAddress PE ON PE.BusinessEntityID = PP.BusinessEntityID

SELECT TOP 10 *
FROM Production.ProductSubcategory

SELECT pp.ListPrice, PP.Name, PPS.Name AS 'SUBCATEGORY'
FROM Production.Product PP
INNER JOIN Production.ProductSubcategory PPS ON PP.ProductSubcategoryID = PPS.ProductSubcategoryID


SELECT *
FROM Production.Product
WHERE ListPrice > (SELECT AVG(ListPrice) FROM Production.Product)

SELECT *
FROM Person.Person
WHERE BusinessEntityID IN (
SELECT BusinessEntityID FROM HumanResources.Employee
WHERE JobTitle = 'Design Engineer')

SELECT TOP 10 * 
FROM Person.PERSON
WHERE FirstName like 'on%'


--JOIN / LEFT JOIN
SELECT DISTINCT PP.FirstName, HE.JobTitle, HE.HireDate
FROM Person.Person PP
INNER JOIN HumanResources.Employee HE ON HE.BusinessEntityID = PP.BusinessEntityID

SELECT PP.BusinessEntityID, PP.FirstName, PP.LastName, PE.EmailAddress
FROM PERSON.Person PP
LEFT JOIN PERSON.EmailAddress PE ON PE.BusinessEntityID = PP.BusinessEntityID

--AGREGA��O
SELECT PRODUCTID, SUM(LINETOTAL) AS 'SUM'
FROM SALES.SalesOrderDetail
GROUP BY ProductID
HAVING SUM(LINETOTAL) BETWEEN 16200 AND 500000

SELECT STATEPROVINCEID, COUNT(STATEPROVINCEID) AS 'QTD_PROVINCE'
FROM PERSON.Address WITH(NOLOCK)
GROUP BY StateProvinceID
HAVING COUNT(StateProvinceID) > 1000
ORDER BY StateProvinceID DESC

SELECT ProductID, AVG(LINETOTAL) AS 'AVG_LINETOTAL'
FROM SALES.SalesOrderDetail
GROUP BY ProductID
HAVING AVG(LINETOTAL) <= 1000000


SELECT SalesOrderID, DATEPART(MONTH, OrderDate) 'Month'
FROM Sales.SalesOrderHeader

SELECT OrderDate, DATEPART(DAY,OrderDate) 'DAY'
FROM Sales.SalesOrderHeader

SELECT AVG(TOTALDUE) AS 'TOTAL_AVG',
		DATEPART(MONTH, OrderDate) AS 'MONTH'
FROM SALES.SalesOrderHeader
GROUP BY DATEPART(MONTH, ORDERDATE)
ORDER BY DATEPART(MONTH, ORDERDATE)



--CONVERT
SELECT CONVERT(varchar(50), FirstName, 7) AS '2'
FROM Person.Person

--SUBSTRING
SELECT TOP 10 substring(cast(OrderDate as varchar(50)), 1,12) as 'DATE'
FROM SALES.SalesOrderHeader

--CONCAT
SELECT DISTINCT CONCAT(FirstName, ' ', LastName)
FROM Person.Person
WHERE EmailPromotion IN (
SELECT BusinessEntityID FROM HumanResources.Employee WHERE JobTitle LIKE '%Engineer%')

--DATEPART
SELECT SUM(LINETOTAL) AS TOTAL, 
		DATEPART(MONTH, ModifiedDate) AS 'MONTH' 
FROM Sales.SalesOrderDetail
GROUP BY DATEPART(MONTH, ModifiedDate)
ORDER BY DATEPART(MONTH, ModifiedDate)

--DECLARE / SET
DECLARE @VALOR INT,
		@TEXTO VARCHAR(40),
		@DATA_NASC DATE,
		@NADA MONEY
SET @VALOR = 50
SET @TEXTO = 'BOSON'
SET @DATA_NASC = GETDATE()
SELECT @VALOR AS VALOR,
		@TEXTO AS TEXTO,
		@DATA_NASC AS 'DATA DE NASCIMENTO',
		@NADA AS SALARIO

SELECT RESULT.ProductID, SUM(RESULT.LISTPRICE) AS TOTAL, RESULT.STARTDATE
--PPH.STARTDATE
FROM (SELECT ProductID, ListPrice, StartDate FROM Production.ProductListPriceHistory) AS RESULT
--Production.Product PP
--INNER JOIN Production.ProductListPriceHistory PPH ON PP.ProductID = PPH.ProductID
GROUP BY RESULT.ProductID
ORDER BY TOTAL

SELECT *
FROM Person.Person
WHERE BusinessEntityID IN (
SELECT BusinessEntityID FROM HumanResources.Employee
WHERE JobTitle = 'Design Engineer')

SELECT NAME, sum(ListPrice) as total
FROM Production.Product
WHERE ListPrice <> 0.00
GROUP BY Name
ORDER BY total

SELECT SSOD.ProductID AS 'PRODUCT_ID',
		SSOH.SalesOrderID AS 'SALES_ID',
		PP.Name AS 'PRODUCT_NAME', 
		PP.ListPrice AS 'PRICE',
		PPS.Name AS 'SUBCATEGORY', 
		PPC.NAME AS 'CATEGORY',
		SSOD.UnitPriceDiscount AS 'DISCOUNT',
		SSOD.OrderQty AS 'QTD',
		CAST(SSOH.OrderDate AS DATE) AS 'ORDER_DATE',
		SSOH.TerritoryID AS 'TERRITORY_ID',
		PSP.CountryRegionCode 'COUNTRY_CODE',
		PSP.StateProvinceCode 'PROVINCE',
		--PA.City AS 'CITY',
		CASE
			WHEN SSOD.OrderQty <= 2 THEN 'LOW PRIORITY'
			WHEN SSOD.ORDERQTY <= 4 THEN 'MEDIUM PRIORITY'
			ELSE 'HIGH PRIORITY'
		END AS 'PRIORITY'
FROM Production.Product PP
INNER JOIN Production.ProductSubcategory PPS ON PP.ProductSubcategoryID = PPS.ProductSubcategoryID
INNER JOIN Production.ProductCategory PPC ON PPS.ProductCategoryID = PPC.ProductCategoryID
INNER JOIN SALES.SalesOrderDetail SSOD ON PP.ProductID = SSOD.ProductID
INNER JOIN SALES.SalesOrderHeader SSOH ON SSOD.SalesOrderID = SSOH.SalesOrderID
INNER JOIN PERSON.StateProvince PSP ON SSOH.TerritoryID = PSP.TerritoryID
--INNER JOIN PERSON.Address PA ON PSP.StateProvinceID = PA.StateProvinceID
WHERE PSP.CountryRegionCode IN ('US')


SELECT SSOD.ProductID AS 'PRODUCT_ID',
		SSOH.SalesOrderNumber AS 'SALES_ORDER',
		SSOH.CustomerID 'CUSTOMER_ID',
		PP.Name AS 'PRODUCT_NAME', 
		PP.ListPrice AS 'PRICE',
		PPS.Name AS 'SUBCATEGORY', 
		PPC.NAME AS 'CATEGORY',
		SSOD.UnitPriceDiscount AS 'DISCOUNT',
		SSOD.OrderQty AS 'QTD',
		CAST(SSOH.OrderDate AS DATE) AS 'ORDER_DATE',
		CAST(SSOH.ShipDate AS DATE) AS 'SHIP_DATE',
		CAST(SSOH.DueDate AS DATE) AS 'DELIVERY_DATE',
		SSOH.TerritoryID AS 'TERRITORY_ID',
		PSP.StateProvinceCode 'PROVINCE',
		CASE
			WHEN SSOD.OrderQty <= 2 THEN 'LOW PRIORITY'
			WHEN SSOD.ORDERQTY <= 4 THEN 'MEDIUM PRIORITY'
			ELSE 'HIGH PRIORITY'
		END AS 'PRIORITY',
		CASE 
			WHEN SSOH.OnlineOrderFlag = 1 THEN 'ONLINE'
			ELSE 'TELEPHONE'
		END AS 'ORDER_TYPE'
FROM Production.Product PP
INNER JOIN Production.ProductSubcategory PPS ON PP.ProductSubcategoryID = PPS.ProductSubcategoryID
INNER JOIN Production.ProductCategory PPC ON PPS.ProductCategoryID = PPC.ProductCategoryID
INNER JOIN SALES.SalesOrderDetail SSOD ON PP.ProductID = SSOD.ProductID
INNER JOIN SALES.SalesOrderHeader SSOH ON SSOD.SalesOrderID = SSOH.SalesOrderID
INNER JOIN PERSON.StateProvince PSP ON SSOH.TerritoryID = PSP.TerritoryID
WHERE PSP.CountryRegionCode IN ('US')


SELECT *
FROM 
SALES.SalesOrderHeader

SELECT *
FROM SALES.SalesOrderDetail
