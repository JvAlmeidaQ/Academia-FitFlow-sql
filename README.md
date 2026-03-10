# FitFlow Management System 🏋️‍♂️

O projeto **FitFlow** é um sistema de banco de dados projetado para simular o gerenciamento de uma rede de academias.

Foi desenvolvido utilizando **MySQL** focado em **modelagem relacional normalizada, e análise de dados**.

Entre os recursos implementados estão **assinaturas recorrentes, Linha do Tempo automática de alterações e consultas para vizualização do negócio**.

---

# 🎯 Objetivo do Projeto

Este projeto foi criado para consolidar conhecimentos em:

* Modelagem de dados relacional
* SQL
* Uso de **Triggers** e **Stored Procedures**
* Construção de **consultas analíticas(Queries)** e **Views**

A arquitetura foi projetada pra seguir as **Três Formas Normais (3NF)** e garantir consistência e integridade dos dados.

---

# 🚀 Funcionalidades Principais

### 🧾 Gestão de Assinaturas

* Criação e gerenciamento de planos de academia
* Associação de clientes a assinaturas
* Controle de status de assinatura

### 🔄 Recorrência Financeira

* Geração automática de faturas mensais utilizando **Triggers**
* Controle de pagamentos e inadimplência

### 📜 Historico de Alterações

Sistema de histórico que registra:

* Mudanças de plano
* Alterações de status de assinatura
* Linha do tempo de relacionamento do cliente com a academia

### 📊 Queries (SQL Analytics)

O banco inclui **consultas analíticas prontas** para vizualização de metricas como:

* faturamento por unidade
* popularidade de planos
* Detalhes Operacionais
* Timeline do Historico
---

# 🛠️ Tecnologias Utilizadas

* **MySQL 8+**
* SQL (DDL, DML)
* **Triggers**
* **Stored Procedures**
* **Event Scheduler**
* **Views**
* **Window Functions**
* Modelagem relacional (3NF)

---

# 🏗️ Arquitetura do Projeto

O projeto é foi organizado em scripts SQL independentes.

```
sql/
 ├── 01_schema.sql
 ├── 02_triggers.sql
 ├── 03_procedures.sql
 ├── 04_events_jobs.sql
 ├── 05_seed.sql
 └── 06_analytics.sql
```

Descrição dos arquivos:

| Arquivo              | Função                                   |
| -------------------- | ---------------------------------------- |
| `01_schema.sql`      | Estrutura do banco e criação das tabelas |
| `02_triggers.sql`    | Automação de Tarefas                     |
| `03_procedures.sql`  | Lógicas de negócio                       |
| `04_events_jobs.sql` | Tarefas agendadas                        |
| `05_seed.sql`        | Inserção de Dados para testes            |
| `06_analytics.sql`   | Consultas analíticas                     |

Um script principal (`Main.sql`) executa todos os arquivos e reconstrói o ambiente completo.

---

# 🧠 Modelagem de Dados

O modelo do Projeto foi feito para representar o funcionamento de uma rede de academias.

Principais entidades do sistema:

* **Clientes**
* **Unidades**
* **Planos**
* **Assinaturas**
* **Faturas**
* **Histórico de Alterações**

Algumas das Regras/Relacionamentos da modelagem:

* Cada **cliente pertence a uma unidade**
* Uma **assinatura conecta cliente e plano**
* **Faturas** são geradas a partir de assinaturas
* Todas as mudanças relevantes são registradas na tabela de **histórico**

O DER completo está disponível em:

```
docs/ERD_Academia_FitFlow.jpg
```

---

# 📊 Business Intelligence (SQL Analytics)

As queries do projeto são organizadas em três níveis de análise.

| Nível       | Objetivo                | Exemplos                                      |
| ----------- | ----------------------- | ----------------------------------------------|
| Operacional | Monitoramento diário    | clientes ativos por região, faturas a vencer  |
| Gerencial   | Performance da academia | Performance por unidade e planos              |
| Estratégico | Tomada de decisão       | churn rate e segmentação de clientes          |

---

# 📈 Exemplo de Query Analítica

Cálculo da Performance por unidade:

```sql
SELECT 
    U.nome_unidade AS 'Unidades',
    IFNULL(SUM(F.valor_fatura), 0) AS 'Valores Pagos'
FROM Unidades U
LEFT JOIN Clientes C 
    ON C.id_unidade = U.id_unidade
LEFT JOIN Assinaturas A 
    ON A.id_cliente = C.id_cliente
LEFT JOIN Faturas F 
    ON F.id_assinatura = A.id_assinatura
    AND F.status = 'Pago'
GROUP BY U.nome_unidade
ORDER BY `Valores Pagos` DESC;
```

Exemplo de segmentação de clientes usando **Window Functions**:

```sql
SELECT * FROM (
    SELECT 
        C.id_cliente,
        C.nome,
        SUM(F.valor_fatura) AS 'Valor Gasto',
        NTILE(4) OVER (ORDER BY SUM(F.valor_fatura) DESC) AS grupo_vip
    FROM Clientes C
    INNER JOIN Assinaturas A 
        ON A.id_cliente = C.id_cliente
    INNER JOIN Faturas F 
        ON F.id_assinatura = A.id_assinatura 
    WHERE C.status = 'Ativo'
      AND A.status IN ('ATIVA','PAUSADA')
      AND F.status = 'Pago'
    GROUP BY C.id_cliente, C.nome
) AS Ranking_VIP
WHERE GRUPO_VIP = 1;
```

---

# 🚀 Como Executar o Projeto

Certifique-se de possuir um servidor **MySQL** em execução.

Execute o script principal:

```sql
SOURCE Main.sql;
```

Esse comando irá:

1. Criar todas as tabelas
2. Configurar triggers e procedures
3. Inserir dados de teste
4. Criar as views e executar as Queries de analytics

---

Projeto desenvolvido para fins educacionais.

João Vitor Almeida Queiroz

