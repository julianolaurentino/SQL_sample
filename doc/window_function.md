

# 📌 Window Functions no SQL

As **Window Functions** (Funções de Janela) são um recurso poderoso do SQL que permite calcular valores agregados em um conjunto de linhas **sem agrupar os resultados**, diferentemente das funções de agregação tradicionais como `SUM()`, `AVG()`, `COUNT()`, etc.

---

## 🔹 **O que são Window Functions?**

Window Functions executam um cálculo sobre um conjunto de linhas **relacionadas à linha atual**, definidas por uma "janela" especificada através da cláusula **`OVER()`**.

Elas são úteis para:
- Calcular rankings e percentuais.
- Obter totais acumulados.
- Comparar valores entre linhas.
- Executar agregações sem perder detalhes da linha.

> 📌 **Diferente das funções de agregação (`GROUP BY`), as Window Functions NÃO reduzem o número de linhas retornadas!**

---

## 🔹 **Principais Window Functions**

### 📊 **1. Funções de Ranking**
Essas funções classificam os dados dentro de uma "janela" definida.

```markdown
| Função         | Descrição |
|---------------|-----------|
| `RANK()`      | Atribui uma classificação, permitindo empates (pula números quando há empates). |
| `DENSE_RANK()`| Similar ao `RANK()`, mas **não pula números** quando há empates. |
| `ROW_NUMBER()`| Atribui um número único para cada linha, sem empates. |
| `NTILE(n)`    | Divide as linhas em `n` partes iguais e atribui um número de grupo. |
```

🔹 **Exemplo:** Classificando os produtos mais vendidos por categoria.
```sql
SELECT
    ProductID,
    Name,
    Category,
    RANK() OVER (PARTITION BY Category ORDER BY TotalSales DESC) AS Ranking
FROM Sales;
```

---

### ➕ **2. Funções de Agregação com Window**

```markdown
| Função      | Descrição |
|------------|-----------|
| `SUM()`    | Calcula a soma acumulada dentro da "janela". |
| `AVG()`    | Calcula a média dentro da "janela". |
| `COUNT()`  | Conta o número de linhas na "janela". |
| `MIN()` / `MAX()` | Retorna o menor/maior valor na "janela". |
```

🔹 **Exemplo:** Obtendo a soma acumulada das vendas por mês.
```sql
SELECT
    SalesDate,
    CustomerID,
    TotalSales,
    SUM(TotalSales) OVER (PARTITION BY CustomerID ORDER BY SalesDate) AS Sales_Acumuladas
FROM Sales;
```

---

### ⏮️ **3. Funções de Janela para Comparação**

```markdown
| Função        | Descrição |
|--------------|-----------|
| `LAG()`      | Retorna o valor da linha **anterior**. |
| `LEAD()`     | Retorna o valor da linha **seguinte**. |
| `FIRST_VALUE()` | Retorna o primeiro valor da "janela". |
| `LAST_VALUE()`  | Retorna o último valor da "janela". |
```

🔹 **Exemplo:** Comparando a venda atual com a venda do mês anterior.
```sql
SELECT
    SalesDate,
    CustomerID,
    TotalSales,
    LAG(TotalSales, 1) OVER (PARTITION BY CustomerID ORDER BY SalesDate) AS Venda_Anterior
FROM Sales;
```

---

## 🔹 **Entendendo a Cláusula `OVER()`**

A cláusula **`OVER()`** define como a "janela" das funções será estruturada. Ela pode conter:

1. **`PARTITION BY`** – Divide os dados em grupos (como `GROUP BY`, mas sem reduzir as linhas).
2. **`ORDER BY`** – Define a ordem dos cálculos dentro da "janela".
3. **`ROWS BETWEEN ...`** – Especifica o intervalo de linhas consideradas.

🔹 **Exemplo:** Média móvel dos últimos 3 meses:
```sql
SELECT
    SalesDate,
    CustomerID,
    TotalSales,
    AVG(TotalSales) OVER (PARTITION BY CustomerID ORDER BY SalesDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS Media_3_Meses
FROM Sales;
```

---

## 📌 **Resumo**
✅ As **Window Functions** permitem cálculos sobre um conjunto de linhas sem perder os detalhes da consulta.  
✅ São úteis para rankings, agregações avançadas e análise de tendências.  
✅ `OVER()` define a "janela" da função, permitindo particionar (`PARTITION BY`), ordenar (`ORDER BY`) e especificar intervalos (`ROWS BETWEEN`).  
✅ Funções como `RANK()`, `SUM()`, `LAG()` e `AVG()` tornam relatórios mais avançados e eficientes.  



![Window Function Three](https://cdn0.devart.com/views/content/products/dbforge/mysql/studio/images/types-of-window-functions.png)