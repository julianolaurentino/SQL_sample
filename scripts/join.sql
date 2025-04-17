--utilizando inner join para juntar duas tabelas (firstname, lastname e emailaddress) onde a condição é verdadeira
--inner join é utilizado para juntar duas tabelas, onde a condição é verdadeira

SELECT 
    PP.FirstName
    ,PP.LastName
    ,PEA.EmailAddress
FROM [adventureWorks2017].[Person].[Person] PP
INNER JOIN [adventureWorks2017].[Person].[EmailAddress] PEA
    ON PP.BusinessEntityID = PEA.BusinessEntityID;

--preco do produto, nome do produto e nome da subcategoria
SELECT 
    P.Name
    ,P.ListPrice
    ,SC.Name AS SubcategoryName
FROM [adventureWorks2017].[Production].[Product] P
INNER JOIN [adventureWorks2017].[Production].[ProductSubcategory] SC
    ON P.ProductSubcategoryID = SC.ProductSubcategoryID;

--cross join é utilizado para juntar duas tabelas, onde a condição é verdadeira
SELECT TOP 10 *
FROM [adventureWorks2017].[Person].[BusinessEntityAddress] PB
CROSS JOIN [adventureWorks2017].[Person].[Address] PA;

--relacionando PP.BusinessEntityID, PNT.Name, PNT.PhoneNumberTypeID, PP.PhoneNumber
SELECT TOP 10
    PP.BusinessEntityID
    ,PNT.Name
    ,PNT.PhoneNumberTypeID
    ,PP.PhoneNumber
FROM [adventureWorks2017].[Person].[PhoneNumberType] PNT
INNER JOIN [adventureWorks2017].[Person].[PersonPhone] PP
    ON PNT.PhoneNumberTypeID = PP.PhoneNumberTypeID;

--relacionando A.AddressID, A.City, A.StateProvinceID, SP.Name AS StateProvinceName
SELECT TOP 10 
    A.AddressID
    ,A.City
    ,A.StateProvinceID
    ,SP.Name AS StateProvinceName
FROM [adventureWorks2017].[Person].[Address] A
INNER JOIN [adventureWorks2017].[Person].[StateProvince]SP
    ON SP.StateProvinceID = A.StateProvinceID;

--Comparando resultados de joins diferentes
SELECT * 
FROM [adventureWorks2017].[Person].[Person] PP
LEFT JOIN [adventureWorks2017].[Sales].[PersonCreditCard] PC --19972 LINHAS
--INNER JOIN  [adventureWorks2017].[Sales].[PersonCreditCard] PC --19118 LINHAS
    ON PP.BusinessEntityID = PC.BusinessEntityID
WHERE PC.BusinessEntityID IS NULL; --lista de pessoas que não possuem cartão de crédito / 854 linhas

--Retorna todas as pessoas e todos os funcionários. 
--Quando não há correspondência, os valores de colunas da outra tabela aparecem como NULL.
SELECT 
    P.FirstName
    ,P.LastName
    ,E.JobTitle
    ,E.HireDate
FROM [AdventureWorks2017].[Person].[Person] P
FULL JOIN [AdventureWorks2017].[HumanResources].[Employee] E
    ON P.BusinessEntityID = E.BusinessEntityID;

--Exemplo de self join. Relacionando os produtos que possuem o mesmo unitpricediscount que possuem o mesmo ProductID
SELECT
    A.ProductID
    ,A.UnitPrice
    ,B.ProductID
    ,B.UnitPrice
FROM [AdventureWorks2017].[Sales].[SalesOrderDetail] A,
    [AdventureWorks2017].[Sales].[SalesOrderDetail] B
WHERE A.ProductID = B.ProductID


SELECT
    PP.FirstName
    ,PP.LastName
    ,PA.AddressLine1
    ,PA.City
    ,ROW_NUMBER() OVER (ORDER BY PA.City DESC) AS RankCity
FROM person.person PP
INNER JOIN Person.BusinessEntityAddress BEA ON PP.BusinessEntityID = BEA.BusinessEntityID
INNER JOIN Person.Address PA ON BEA.AddressID = PA.AddressID