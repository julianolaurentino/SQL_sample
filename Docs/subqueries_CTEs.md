# 🛠️ Subqueries e CTEs no SQL Server  

As **Subqueries** e **Common Table Expressions (CTEs)** são formas avançadas de estruturar consultas SQL, tornando-as mais organizadas e eficientes. Vamos explorar suas diferenças e como usá-las!  

---

## 🔍 **O que são Subqueries?**  

Uma **Subquery** (ou **Subconsulta**) é uma consulta dentro de outra consulta. Ela pode ser usada para **filtrar**, **calcular valores** ou até **substituir tabelas temporárias**.  

### **📌 Principais Tipos de Subqueries:**  
| Tipo          | Descrição | Exemplo Prático |
|--------------|-----------|----------------|
| **Escalar**   | Retorna um único valor | `(SELECT AVG(Salary) FROM Employees)` |
| **Multilinhas** | Retorna várias linhas (usada com `IN`, `EXISTS`, etc.) | `(SELECT CustomerID FROM Orders WHERE TotalDue > 1000)` |
| **Correlacionada** | Depende da consulta principal para ser executada | `(SELECT AVG(Salary) FROM Employees E WHERE E.DepartmentID = D.DepartmentID)` |

---

## 🔹 **1. Exemplo de Subquery Simples**  

👉 **Objetivo:** Buscar funcionários cujo salário é maior que a média.  

```sql
SELECT FirstName, LastName, Salary
FROM HumanResources.Employee
WHERE Salary > (SELECT AVG(Salary) FROM HumanResources.Employee);
```
▶ Explicação:

A subquery calcula o salário médio, e a consulta principal retorna apenas os funcionários que ganham acima desse valor.

## 🔹 **2. Exemplo de Subquery Multilinhas**
👉 Objetivo: Encontrar clientes que já realizaram pedidos.
```sql
SELECT FirstName, LastName
FROM Person.Person
WHERE BusinessEntityID IN (SELECT CustomerID FROM Sales.Customer);
```
▶ Explicação:

A subquery retorna todos os CustomerID da tabela Sales.Customer, e a consulta principal filtra apenas os clientes que aparecem nessa lista.

## 🔍 **O que são CTEs (Common Table Expressions)?**  
Uma CTE (Common Table Expression) é uma estrutura temporária que permite nomear e reutilizar consultas complexas dentro de uma WITH.

✅ Vantagens das CTEs:
✔ Deixam o código mais legível
✔ Podem ser recursivas (útil para hierarquias)
✔ Podem ser referenciadas múltiplas vezes na mesma consulta

## 🔹 **3. Exemplo de CTE Simples**
👉 Objetivo: Criar uma CTE para calcular o salário médio por departamento.
```sql
WITH SalarioPorDepartamento AS (
    SELECT DepartmentID, AVG(Salary) AS SalarioMedio
    FROM HumanResources.Employee
    GROUP BY DepartmentID
)
SELECT D.Name AS Departamento, S.SalarioMedio
FROM SalarioPorDepartamento S
INNER JOIN HumanResources.Department D
ON S.DepartmentID = D.DepartmentID;
```
▶ Explicação:

A CTE SalarioPorDepartamento calcula o salário médio.
A consulta principal junta essa CTE com Department para exibir os nomes.

## 🔹 **4. Exemplo de CTE Recursiva**
👉 Objetivo: Buscar a hierarquia de um funcionário dentro da empresa.
```sql
WITH Hierarquia AS (
    SELECT EmployeeID, ManagerID, JobTitle
    FROM HumanResources.Employee
    WHERE EmployeeID = 5  -- Começa pelo funcionário específico

    UNION ALL

    SELECT E.EmployeeID, E.ManagerID, E.JobTitle
    FROM HumanResources.Employee E
    INNER JOIN Hierarquia H
    ON E.ManagerID = H.EmployeeID
)
SELECT * FROM Hierarquia;
```
▶ Explicação:

O primeiro SELECT retorna o funcionário base.
O UNION ALL junta todos os subordinados recursivamente.

## 📊 Comparação: Subquery vs. CTE  

| **Característica**       | **Subquery** 🔽 | **CTE** 🟢 |
|--------------------------|----------------|------------|
| **Legibilidade**         | 🔴 Menos clara | 🟢 Mais organizada |
| **Reutilização**         | 🔴 Só pode ser usada 1 vez | 🟢 Pode ser referenciada várias vezes |
| **Performance**          | 🔴 Pode ser menos eficiente | 🟢 Mais otimizada em queries complexas |
| **Suporte a Recursão**   | 🔴 Não suporta | 🟢 Suporta |

---

***🎯 Conclusão***

✔ Subqueries são úteis para filtros rápidos e cálculos simples.

✔ CTEs tornam consultas complexas mais organizadas e reutilizáveis.

✔ Para hierarquias, prefira CTEs Recursivas!