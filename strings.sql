--extraindo apenas a parte do login após a barra invertida (\), usando a função RIGHT combinada com CHARINDEX
--usando apenas a função SUBSTRING para extrair a parte após a barra invertida (\)
SELECT
    RIGHT(LoginID, LEN(LoginID) - CHARINDEX('\', LoginID)) AS usuario
    ,SUBSTRING(LoginID, 1, CHARINDEX('-', LoginID) - 1) AS empresa
    ,HireDate
FROM [AdventureWorks2017].[HumanResources].[Employee]
WHERE HireDate BETWEEN '2009-01-01' AND '2009-01-31'
ORDER BY HireDate ASC

--usando a função REPLACE para substituir os espaços por hífens e a função LTRIM e RTRIM para remover os espaços no início e no final da string
SELECT DISTINCT
    REPLACE(LTRIM(RTRIM(RIGHT(PhoneNumber, LEN(PhoneNumber) - CHARINDEX(') ', PhoneNumber)))), ' ', '-') AS PhoneNumber_format
FROM [AdventureWorks2017].[Person].PersonPhone
ORDER BY PhoneNumber ASC

--usando todas as funções juntas e criando um join a partir do BusinessEntityID
SELECT 
    RIGHT(LoginID, LEN(LoginID) - CHARINDEX('\', LoginID)) AS usuario
    ,SUBSTRING(LoginID, 1, CHARINDEX('-', LoginID) - 1) AS empresa
    ,HireDate
    ,REPLACE(LTRIM(RTRIM(RIGHT(phonenumber, LEN(PhoneNumber) - CHARINDEX(') ', PhoneNumber)))), ' ', '-') AS PhoneNumber_format
FROM 
    [AdventureWorks2017].[HumanResources].[Employee] HE
LEFT JOIN [AdventureWorks2017].[Person].[PersonPhone] PP
    ON HE.BusinessEntityID = PP.BusinessEntityID;

-- Alguns outros desafios:
--Selecione os nomes dos produtos (Name) da tabela Production.Product, removendo espaços extras no início e no final.
SELECT
    LTRIM(RTRIM(Name))
FROM [AdventureWorks2017].[Production].[Product]

--Exiba o nome (FirstName) e o número de caracteres do primeiro nome dos funcionários na tabela Person.Person.
SELECT
    FirstName
    ,LEN(FirstName) AS FirstName_length
    ,LEFT(FirstName, 3) AS FirstName_3
FROM [adventureworks2017].[Person].Person

--Na tabela Person.EmailAddress, extraia o domínio (parte após @) dos e-mails.
SELECT TOP 10
    EmailAddress, 
    SUBSTRING(EmailAddress, CHARINDEX('@', EmailAddress) + 1, LEN(EmailAddress)) AS Dominio
FROM AdventureWorks2017.Person.EmailAddress;

--Alguns números de telefone na tabela Person.PersonPhone possuem parênteses e espaços.
--Remova os parênteses "(" e ")" dos números.

SELECT 
    PhoneNumber, 
    REPLACE(REPLACE(PhoneNumber, '(', ''), ')', '') AS TelefoneFormatado
FROM AdventureWorks2017.Person.PersonPhone;

--Substitua os espaços internos dos números de telefone da tabela Person.PersonPhone por hífens (-).
SELECT PhoneNumber, 
       REPLACE(PhoneNumber, ' ', '-') AS TelefoneFormatado
FROM AdventureWorks2017.Person.PersonPhone;

--O código do produto (ProductNumber) na tabela Production.Product segue o formato AA-1234. Extraia apenas a parte antes do hífen (AA).
SELECT ProductNumber, 
       LEFT(ProductNumber, CHARINDEX('-', ProductNumber) - 1) AS Codigo
FROM AdventureWorks2017.Production.Product;


