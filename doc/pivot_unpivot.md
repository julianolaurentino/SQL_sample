# 🔄 PIVOT e UNPIVOT no SQL

Os operadores **PIVOT** e **UNPIVOT** são usados para transformar dados em SQL:
- **PIVOT**: Converte **linhas em colunas**, criando um formato mais legível para relatórios.
- **UNPIVOT**: Faz o inverso, convertendo **colunas em linhas**, útil para normalização de dados.

---

## 📌 **O que é PIVOT?**
O **PIVOT** permite transformar valores distintos de uma coluna em colunas individuais.

🔹 **Exemplo:** Vamos supor que temos a seguinte tabela de vendas:

| Ano  | Produto  | Vendas |
|------|---------|--------|
| 2022 | Camisa  | 100    |
| 2022 | Calça   | 150    |
| 2023 | Camisa  | 200    |
| 2023 | Calça   | 180    |

Podemos usar **PIVOT** para exibir os produtos como colunas:

```sql
SELECT * FROM (
    SELECT Ano, Produto, Vendas
    FROM Vendas
) AS Fonte
PIVOT (
    SUM(Vendas) FOR Produto IN ([Camisa], [Calça])
) AS PivotTable;
```

🔹 **Resultado:**

| Ano  | Camisa | Calça |
|------|--------|-------|
| 2022 | 100    | 150   |
| 2023 | 200    | 180   |

✅ **Vantagens do PIVOT:**
- Facilita a análise de dados no formato de tabela dinâmica.
- Reduz a necessidade de múltiplas consultas agregadas.

---

## 📌 **O que é UNPIVOT?**
O **UNPIVOT** faz o contrário do **PIVOT**, transformando colunas em linhas.

🔹 **Exemplo:** Vamos converter a tabela pivotada de volta ao formato original:

```sql
SELECT * FROM (
    SELECT Ano, Camisa, Calça
    FROM VendasPivotadas
) AS Fonte
UNPIVOT (
    Vendas FOR Produto IN (Camisa, Calça)
) AS UnpivotTable;
```

🔹 **Resultado:**

| Ano  | Produto | Vendas |
|------|---------|--------|
| 2022 | Camisa  | 100    |
| 2022 | Calça   | 150    |
| 2023 | Camisa  | 200    |
| 2023 | Calça   | 180    |

✅ **Vantagens do UNPIVOT:**
- Útil para normalizar dados armazenados em formato de colunas.
- Facilita a manipulação e análise em bancos de dados relacionais.

---

## 📌 **Resumo**
| Operação | Descrição |
|----------|-----------|
| **PIVOT**   | Transforma linhas em colunas. |
| **UNPIVOT** | Transforma colunas em linhas. |


