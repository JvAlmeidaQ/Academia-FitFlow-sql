-- -----------------------------------------------------------------------------
-- 1. ENDEREÇOS
-- -----------------------------------------------------------------------------
INSERT INTO Endereco (rua, numero, bairro, cidade, estado, cep) VALUES
('Rua dos Tupis', '450', 'Centro', 'Belo Horizonte', 'MG', '30190060'),    
('Av. Paulista', '1000', 'Bela Vista', 'São Paulo', 'SP', '01310100'),      
('Rua XV de Novembro', '200', 'Centro', 'Ouro Preto', 'MG', '36200000'),     
('Rua Halfeld', '500', 'Centro', 'Juiz de Fora', 'MG', '36010002'),         
('Av. Atlântica', '1702', 'Copacabana', 'Rio de Janeiro', 'RJ', '22021001'), 
('Rua XV de Novembro', '300', 'Centro', 'Curitiba', 'PR', '80020310'),      
('Av. Tancredo Neves', '120', 'Caminho das Árvores', 'Salvador', 'BA', '41820020'),  
('Rua dos Andradas', '800', 'Centro Histórico', 'Porto Alegre', 'RS', '90020000'),  
('SCN Quadra 2', '10', 'Asa Norte', 'Brasília', 'DF', '70712900'),         
('Av. Boa Viagem', '2000', 'Boa Viagem', 'Recife', 'PE', '51011000'),        
('Av. Beira Mar', '4000', 'Meireles', 'Fortaleza', 'CE', '60165121'),       
('Av. T-10', '50', 'Setor Bueno', 'Goiânia', 'GO', '74223060'),             
('Rua Timbiras', '1500', 'Funcionários', 'Belo Horizonte', 'MG', '30140061'),  
('Rua Padre Toledo', '50', 'Centro', 'Ouro Preto', 'MG', '36200022'),        
('Rua Augusta', '900', 'Consolação', 'São Paulo', 'SP', '01305000'),         
('Rua Marechal Deodoro', '300', 'Centro', 'Juiz de Fora', 'MG', '36013000');  

-- -----------------------------------------------------------------------------
-- 2. UNIDADES (Rede FitFlow)
-- -----------------------------------------------------------------------------
INSERT INTO Unidades (cnpj, nome_unidade, email, id_endereco) VALUES
('12345678000190', 'FitFlow BH', 'bh@fitflow.com', 1), 
('98765432000110', 'FitFlow Paulista', 'sp@fitflow.com', 2),
('11111111000101', 'Unidade Ouro Preto', 'op@fitflow.com', 3), 
('22222222000102', 'Unidade Juiz de Fora', 'jf@fitflow.com', 4),
('33333333000103', 'Unidade Copacabana', 'rio@fitflow.com', 5), 
('44444444000104', 'Unidade Curitiba', 'pr@fitflow.com', 6),
('55555555000105', 'Unidade Salvador', 'ssa@fitflow.com', 7), 
('66666666000106', 'Unidade Porto Alegre', 'poa@fitflow.com', 8),
('77777777000107', 'Unidade Brasília', 'df@fitflow.com', 9), 
('88888888000108', 'Unidade Recife', 'pe@fitflow.com', 10),
('99999999000109', 'Unidade Fortaleza', 'ce@fitflow.com', 11), 
('10101010000110', 'Unidade Goiânia', 'go@fitflow.com', 12);

-- -----------------------------------------------------------------------------
-- 3. PLANOS E DISPONIBILIDADE
-- -----------------------------------------------------------------------------
INSERT INTO Planos (nome_plano, duracao_plano_meses, valor_mensal) VALUES
('Mensal', 1, 140.00), 
('Trimestral', 3, 120.00), 
('Anual', 12, 100.00);

-- Vinculando todos os planos a todas as unidades
INSERT INTO Unidade_Planos (id_unidade, id_plano)
SELECT u.id_unidade, p.id_plano FROM Unidades u, Planos p;

-- -----------------------------------------------------------------------------
-- 4. CLIENTES (Cenários Diversos)
-- -----------------------------------------------------------------------------

-- Endereços Adicionais para novos clientes
INSERT INTO Endereco (rua, numero, bairro, cidade, estado, cep) VALUES
('Rua da Bahia','1200','Centro','Belo Horizonte','MG','30160010'),  
('Rua Oscar Freire','850','Jardins','São Paulo','SP','01426001'),   
('Av. Rio Branco','156','Centro','Rio de Janeiro','RJ','20040002'),
('Rua Santa Rita','75','Centro','Ouro Preto','MG','35400000'),      
('Av. Getúlio Vargas','400','Savassi','Belo Horizonte','MG','30112020'), 
('Rua Vergueiro','1500','Paraíso','São Paulo','SP','04101000'),    
('Rua do Catete','311','Catete','Rio de Janeiro','RJ','22220000'),  
('Rua São Mateus','150','São Mateus','Juiz de Fora','MG','36025001'),
('Rua Halfeld', '101', 'Centro', 'Juiz de Fora', 'MG', '36010002'),
('Av. Atlântica', '1700', 'Copacabana', 'Rio de Janeiro', 'RJ', '22021001'),
('Rua XV de Novembro', '250', 'Centro', 'Curitiba', 'PR', '80020310'),
('Av. Tancredo Neves', '150', 'Caminho das Árvores', 'Salvador', 'BA', '41820020'),
('Rua dos Andradas', '900', 'Centro Histórico', 'Porto Alegre', 'RS', '90020000'),
('SCN Quadra 5', '20', 'Asa Norte', 'Brasília', 'DF', '70712900'),
('Av. Boa Viagem', '2500', 'Boa Viagem', 'Recife', 'PE', '51011000'),
('Av. Beira Mar', '4500', 'Meireles', 'Fortaleza', 'CE', '60165121'), 
('Av. T-15', '100', 'Setor Bueno', 'Goiânia', 'GO', '74223060'); 

INSERT INTO Clientes (cpf, nome, sexo, data_nasc, dia_pag, id_endereco, id_unidade) VALUES
('11122233344', 'João Silva', 'M', '1990-05-15', 10, 13, 1),
('22233344455', 'João Fiel', 'M', '1990-01-01', 5, 14, 3),
('33344455566', 'Maria Devedora', 'F', '1995-02-02', 10, 15, 2),
('44455566677', 'Pedro Mudança', 'M', '1988-03-03', 15, 16, 4),
('55511122233', 'Carlos Eduardo Souza', 'M', '1989-04-10', 5, 17, 1),
('55511122235', 'Ricardo Martins', 'M', '1985-02-20', 15, 18, 2),
('55511122237', 'Marcos Vinicius Lima', 'M', '1991-01-30', 20, 19, 5),
('55511122238', 'Patricia Gomes Rocha', 'F', '1993-03-12', 5, 20, 3),
('55511122240', 'Camila Teixeira', 'F', '1996-09-22', 15, 21, 1),
('55511122242', 'Amanda Ribeiro', 'F', '1995-08-17', 10, 22, 2),
('55511122245', 'Thiago Moreira', 'M', '1986-07-07', 5, 23, 5),
('55511122248', 'Daniela Pacheco', 'F', '1992-06-09', 10, 24, 4),
('12345678901', 'Ricardo Azevedo', 'M', '1985-04-12', 10, 25, 4),
('12345678902', 'Mariana Costa', 'F', '1992-08-23', 10, 26, 5),
('12345678903', 'Gabriel Santos', 'M', '1988-11-05', 15, 27, 6),
('12345678904', 'Fernanda Lima', 'F', '1995-02-14', 5, 28, 7),
('12345678905', 'Lucas Oliveira', 'M', '1990-06-30', 20, 29, 8),
('12345678906', 'Beatriz Souza', 'F', '1993-09-19', 10, 30, 9),
('12345678907', 'Thiago Mendes', 'M', '1987-12-01', 15, 31, 10),
('12345678908', 'Larissa Rocha', 'F', '1996-03-25', 5, 32, 11),
('12345678909', 'Eduardo Pereira', 'M', '1991-07-10', 10, 33, 12);

-- -----------------------------------------------------------------------------
-- 5. ASSINATURAS (Via Procedure - Testa Triggers de Fatura)
-- -----------------------------------------------------------------------------

-- Assinaturas Ativas
CALL SP_gerar_assinatura(1, 1);
CALL SP_gerar_assinatura(3, 2);
CALL SP_gerar_assinatura(1, 3);
CALL SP_gerar_assinatura(1, 4);
CALL SP_gerar_assinatura(2, 5);
CALL SP_gerar_assinatura(1, 6); 
CALL SP_gerar_assinatura(3, 7); 

CALL SP_gerar_assinatura(3, 13);
CALL SP_gerar_assinatura(3, 14);
CALL SP_gerar_assinatura(1, 15);
CALL SP_gerar_assinatura(1, 16);
CALL SP_gerar_assinatura(2, 17);
CALL SP_gerar_assinatura(1, 18);
CALL SP_gerar_assinatura(2, 19);
CALL SP_gerar_assinatura(2, 20);
CALL SP_gerar_assinatura(3, 21);

CALL SP_gerar_assinatura(1, 8); 
CALL SP_gerar_assinatura(2, 9); 
CALL SP_gerar_assinatura(1, 10);

-- -----------------------------------------------------------------------------
-- 6. WORKFLOW DE ESTADOS (Trocas, Pausas e Cancelamentos)
-- -----------------------------------------------------------------------------

-- Troca de Plano (Testa Procedure e Trigger de Histórico)
CALL SP_alterar_plano(2,3);
CALL SP_alterar_plano(3, 4);
CALL SP_alterar_plano(3,5);
CALL SP_alterar_plano(1,7);
CALL SP_alterar_plano(2, 10); 

-- Pausar Assinaturas
CALL SP_alterar_status_assinatura(12,'PAUSADA');
CALL SP_alterar_status_assinatura(8, 'PAUSADA'); 

-- Cancelar Assinaturas
CALL SP_alterar_status_assinatura(6, 'CANCELADA');

UPDATE Assinaturas 
SET status = 'CANCELADA', 
    data_fim = DATE_SUB(CURDATE(), INTERVAL 2 MONTH)
WHERE id_assinatura = 2;

UPDATE Assinaturas 
SET status = 'CANCELADA', 
    data_inicio = DATE_SUB(CURDATE(), INTERVAL 6 MONTH),
    data_fim = DATE_SUB(CURDATE(), INTERVAL 5 MONTH)
WHERE id_plano = 1 AND id_assinatura IN = 1;

UPDATE Assinaturas 
SET status = 'CANCELADA', 
    data_inicio = DATE_SUB(CURDATE(), INTERVAL 3 MONTH),
    data_fim = DATE_SUB(CURDATE(), INTERVAL 2 MONTH)
WHERE id_plano = 2 AND id_assinatura = 10;

UPDATE Assinaturas 
SET status = 'CANCELADA', 
    data_inicio = DATE_SUB(CURDATE(), INTERVAL 12 MONTH),
    data_fim = DATE_SUB(CURDATE(), INTERVAL 2 MONTH)
WHERE id_plano = 3 AND id_assinatura = 13;

-- -----------------------------------------------------------------------------
-- 7. FINANCEIRO (Pagamentos e Inadimplência)
-- -----------------------------------------------------------------------------

-- Registrar Pagamentos
CALL SP_registrar_pagamento(1); 
CALL SP_registrar_pagamento(2); 
CALL SP_registrar_pagamento(5); 

UPDATE Faturas F
INNER JOIN Assinaturas A
    ON F.id_assinatura = A.id_assinatura
SET F.status = 'Pago'
WHERE A.id_plano = 1 
AND F.id_fatura BETWEEN 1 AND 10;

UPDATE Faturas F
INNER JOIN Assinaturas A
    ON F.id_assinatura = A.id_assinatura
SET F.status = 'Pago'
WHERE A.id_plano = 2 
AND F.id_fatura BETWEEN 60 AND 80;

UPDATE Faturas F
INNER JOIN Assinaturas A
    ON F.id_assinatura = A.id_assinatura
SET F.status = 'Pago'
WHERE A.id_plano = 3
AND F.id_fatura BETWEEN 30 AND 45;


-- Simular Inadimplência
UPDATE Faturas 
SET status = 'Atrasado'
WHERE id_fatura IN (2, 8, 12);

UPDATE Faturas 
SET data_venc = DATE_SUB(CURDATE(), INTERVAL 5 DAY) 
WHERE id_fatura IN (3, 4); 

-- Processar faturas atrasadas
CALL SP_verificar_pag_pendente();

-- -----------------------------------------------------------------------------
-- 8. ENVELHECIMENTO DE DADOS
-- -----------------------------------------------------------------------------

-- Assinaturas antiga
INSERT INTO Assinaturas (data_inicio, data_fim, status, id_plano, id_cliente)
VALUES (DATE_SUB(CURDATE(), INTERVAL 14 MONTH), DATE_SUB(CURDATE(), INTERVAL 2 MONTH), 'CANCELADA', 3, 11);

-- Inserir Faturas pagas no passado para esse cliente antigo
INSERT INTO Faturas (valor_fatura, data_venc, status, id_assinatura)
VALUES 
(100.00, DATE_SUB(CURDATE(), INTERVAL 10 MONTH), 'Pago', LAST_INSERT_ID()),
(100.00, DATE_SUB(CURDATE(), INTERVAL 11 MONTH), 'Pago', LAST_INSERT_ID());


INSERT INTO Assinaturas (data_inicio, data_fim, status, id_plano, id_cliente)
VALUES (DATE_SUB(CURDATE(), INTERVAL 12 MONTH), DATE_SUB(CURDATE(), INTERVAL 4 MONTH), 'CANCELADA', 3, 12);

INSERT INTO Faturas (valor_fatura, data_venc, status, id_assinatura)
VALUES 
(100.00, DATE_SUB(CURDATE(), INTERVAL 6 MONTH), 'Pago', LAST_INSERT_ID()),
(100.00, DATE_SUB(CURDATE(), INTERVAL 7 MONTH), 'Pago', LAST_INSERT_ID());

-- -----------------------------------------------------------------------------
-- 9. TELEFONES CONTATO
-- -----------------------------------------------------------------------------
INSERT INTO Telefone (ddd, numero, tipo_telefone, id_cliente, id_unidade) VALUES
('031', '999887766', 'Celular', 1, NULL),
('031', '32221000', 'Comercial', NULL, 1),
('011', '988776655', 'Celular', 3, NULL),
('032', '32154000', 'Comercial', NULL, 3),
('021', '977665544', 'Celular', 7, NULL);