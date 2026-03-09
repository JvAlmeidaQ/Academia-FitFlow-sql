USE Academia_FitFlow;

-- -----------------------------------------------------------------------------
-- Queries de Historico
-- -----------------------------------------------------------------------------

-- 1. Timeline Historico
SELECT 
    C.id_cliente,
    C.nome,
    A.data_inicio AS 'inicio_Plano',
    A.data_fim AS 'Fim_do_Plano',
    H.data_mudança,
    H.desc_mudanca,
    P_A.nome_plano AS 'Plano_Antigo',
    P_N.nome_plano AS 'Plano_Novo'
FROM Historico H
INNER JOIN Clientes C
    ON H.id_cliente = C.id_cliente
INNER JOIN Assinaturas A
    ON A.id_assinatura = H.id_assinatura
INNER JOIN Planos P_A
    ON P_A.id_plano = H.id_plano_antigo
INNER JOIN Planos P_N
    ON P_N.id_plano = H.id_plano_novo
ORDER BY C.id_cliente;

-- 2. Trocas de Plano
SELECT
        P_A.nome_plano AS 'Plano_Antigo',
        P_N.nome_plano AS 'Plano_Novo',
        COUNT(*) AS 'Total__Mudanças_Plano'
FROM Historico H
INNER JOIN Assinaturas A
    ON A.id_assinatura = H.id_assinatura
INNER JOIN Planos P_A
    ON P_A.id_plano = H.id_plano_antigo
INNER JOIN Planos P_N
    ON P_N.id_plano = H.id_plano_novo
INNER JOIN Clientes C
    ON C.id_cliente = H.id_cliente
WHERE H.id_plano_antigo != H.id_plano_novo
GROUP BY H.id_plano_antigo, H.id_plano_novo;

-- 3. Eficácia de venda
SELECT
    P_A.nome_plano AS 'Plano_Antigo',
    P_N.nome_plano AS 'Plano_Novo',
    H.desc_mudanca,
    (P_A.valor_mensal - P_N.valor_mensal) AS 'Diferença_Financeira'
FROM Historico H
INNER JOIN Planos P_A
    ON P_A.id_plano = H.id_plano_antigo
INNER JOIN Planos P_N
    ON P_N.id_plano = H.id_plano_novo;

-- -----------------------------------------------------------------------------
-- Queries Analiticas
-- -----------------------------------------------------------------------------

/*Nível 1: Operacional (Básico)*/

-- 1. Relatório de Clientes por Região
SELECT C.nome, E.cidade, E.bairro
FROM Clientes C
INNER JOIN Endereco E
    ON C.id_endereco = E.id_endereco
WHERE C.status = 'Ativo'
ORDER BY E.cidade;

-- 2. Visão de Receita de Curto Prazo
SELECT F.status, F.valor_fatura, F.data_venc
FROM Faturas F
WHERE F.status = 'Pendente'
    AND F.data_venc BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY)
ORDER BY F.data_venc, F.valor_fatura Desc;

-- 3. Clientes que estão com faturas para vencer nos proximos dias
SELECT 
    C.nome,
    U.nome_unidade,
    F.valor_fatura, F.data_venc
FROM Faturas F
INNER JOIN Assinaturas A
    ON F.id_assinatura = A.id_assinatura
INNER JOIN Clientes C 
    ON C.id_cliente = A.id_cliente
INNER JOIN Unidades U
    ON U.id_unidade = C.id_unidade
INNER JOIN Planos P
    ON P.id_plano = A.id_plano
WHERE 
    F.data_venc BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY)
    AND 
    F.status = 'Pendente'
ORDER BY data_venc, C.nome;

/* Nível 2: Gerencial (Intermediário) */

-- 1. Faturamento por Unidade
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

-- 2. Popularidade de Planos

SELECT 
    P.nome_plano, P.valor_mensal,
    COUNT(A.id_assinatura) AS 'QTD.Assinaturas por Plano'
FROM Planos P
INNER JOIN Assinaturas A
    ON A.id_plano = P.id_plano
WHERE A.status IN ('ATIVA','PAUSADA')
GROUP BY(P.id_plano)
ORDER BY `QTD.Assinaturas por Plano` DESC;

-- 3. Inadimplência Relativa
SELECT 
    U.nome_unidade AS 'Unidades',
    ROUND((SUM(CASE WHEN F.status = 'Atrasado' THEN 1 ELSE 0 END) * 100.0 / COUNT(F.id_fatura)), 2)
            AS 'Taxa de Inadimplencia'
FROM Faturas F
INNER JOIN Assinaturas A
    ON A.id_assinatura = F.id_assinatura
INNER JOIN Clientes C
    ON C.id_cliente = A.id_cliente
INNER JOIN Unidades U 
    ON U.id_unidade = C.id_unidade
GROUP BY(U.nome_unidade)
ORDER BY `Taxa de Inadimplencia` DESC;

/* Nível 3: Avançado (Visão Estratégica) */

-- 1. Análise de Fidelidade (Churn Rate)

SELECT 
    P.nome_plano,
    ROUND(AVG(DATEDIFF(A.data_fim,A.data_inicio)), 0) AS 'Tempo de Permanencia em Dias'
FROM Assinaturas A 
INNER JOIN Planos P
    ON A.id_plano = P.id_plano
WHERE A.status = 'CANCELADA'
GROUP BY (P.nome_plano)
ORDER BY P.nome_plano;

-- 2. Segmentação de Clientes "VIPs"
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


-- 3. Dashboard (View)

DROP VIEW IF EXISTS VW_Dashboard;
CREATE VIEW VW_Dashboard AS
SELECT 
    U.nome_unidade,
    SUM(CASE WHEN F.status = 'Pago' THEN F.valor_fatura ELSE 0 END) AS 'faturamento_total',

    COUNT(DISTINCT CASE WHEN C.status = 'Ativo' AND A.status IN ('ATIVA','PAUSADA') THEN A.id_assinatura END) AS 'Clientes_Ativos',

    COUNT(DISTINCT CASE WHEN A.data_inicio >= DATE_SUB(CURDATE(), INTERVAL 30 DAY) THEN A.id_assinatura END) AS 'novas_assinaturas',

    COUNT(DISTINCT CASE WHEN A.status = 'CANCELADA' AND A.data_fim >= DATE_SUB(CURDATE(), INTERVAL 30 DAY) THEN A.id_assinatura END) AS 'assinaturas_canceladas'
FROM Unidades U
INNER JOIN Clientes C ON C.id_unidade = U.id_unidade
INNER JOIN Assinaturas A ON A.id_cliente = C.id_cliente
INNER JOIN Faturas F ON F.id_assinatura = A.id_assinatura
GROUP BY U.nome_unidade
ORDER BY `faturamento_total` DESC;