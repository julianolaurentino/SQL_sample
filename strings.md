# 📌 Principais Funções de Manipulação de Strings no SQL Server

Manipular strings é essencial em SQL. Aqui estão as funções mais usadas para trabalhar com textos no **SQL Server**, explicadas com exemplos práticos. 🚀

## 🛠️ Funções Básicas

| Função         | Descrição | Exemplo | Resultado |
|---------------|-------------|---------|-----------|
| **`LEN`**     | Retorna o número de caracteres na string (sem contar espaços à direita). | `LEN('SQL Server')` | `10` |
| **`CHARINDEX`** | Retorna a posição de uma substring dentro de outra string. | `CHARINDEX('S', 'SQL Server')` | `1` |
| **`PATINDEX`** | Similar ao `CHARINDEX`, mas permite padrões `LIKE`. | `PATINDEX('%S%', 'SQL Server')` | `1` |

## ✂️ Funções de Extração

| Função         | Descrição | Exemplo | Resultado |
|---------------|-------------|---------|-----------|
| **`SUBSTRING`** | Extrai uma parte da string a partir de uma posição específica. | `SUBSTRING('SQL Server', 5, 6)` | `"Server"` |
| **`LEFT`**     | Retorna os primeiros N caracteres da string. | `LEFT('SQL Server', 3)` | `"SQL"` |
| **`RIGHT`**    | Retorna os últimos N caracteres da string. | `RIGHT('SQL Server', 6)` | `"Server"` |

## 🧹 Funções de Remoção de Espaços

| Função         | Descrição | Exemplo | Resultado |
|---------------|-------------|---------|-----------|
| **`LTRIM`**   | Remove espaços **à esquerda** da string. | `LTRIM('  SQL')` | `"SQL"` |
| **`RTRIM`**   | Remove espaços **à direita** da string. | `RTRIM('SQL  ')` | `"SQL"` |
| **`TRIM`** (SQL Server 2017+) | Remove espaços **dos dois lados** da string. | `TRIM('  SQL  ')` | `"SQL"` |

## 🔄 Funções de Substituição e Modificação

| Função         | Descrição | Exemplo | Resultado |
|---------------|-------------|---------|-----------|
| **`REPLACE`** | Substitui todas as ocorrências de uma substring dentro de outra. | `REPLACE('SQL Server', 'SQL', 'MySQL')` | `"MySQL Server"` |
| **`STUFF`**   | Insere ou substitui parte de uma string. | `STUFF('SQL Server', 5, 0, ' Database')` | `"SQL Database Server"` |

## 🔗 Funções de Junção e Formatação

| Função         | Descrição | Exemplo | Resultado |
|---------------|-------------|---------|-----------|
| **`CONCAT`** (SQL Server 2012+) | Junta várias strings automaticamente. | `CONCAT('SQL', ' ', 'Server')` | `"SQL Server"` |
| **`FORMAT`** | Formata um valor (ex: datas e números). | `FORMAT(GETDATE(), 'yyyy-MM-dd')` | `"2025-02-22"` |

## 🔤 Funções de Alteração de Caixa

| Função         | Descrição | Exemplo | Resultado |
|---------------|-------------|---------|-----------|
| **`UPPER`**   | Converte a string para maiúsculas. | `UPPER('sql')` | `"SQL"` |
| **`LOWER`**   | Converte a string para minúsculas. | `LOWER('SQL')` | `"sql"` |

---

