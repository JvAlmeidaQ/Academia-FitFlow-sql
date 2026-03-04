-- 1. Endereços

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
('Av. T-10', '50', 'Setor Bueno', 'Goiânia', 'GO', '74223060');           

-- 2. Unidades

INSERT INTO Unidades (cnpj, nome_unidade, email, id_endereco) VALUES
('12345678000190', 'FitFlow BH', 'contato@fitflowbh.com', 1),
('98765432000110', 'FitFlow Paulista', 'contato@fitflowsp.com', 2),
('11111111000101', 'Unidade Centro', 'contato@fitflowcentro.com', 3),
('22222222000102', 'Unidade Norte', 'contato@fitflownorte.com', 4),
('33333333000103', 'Unidade Sul', 'contato@fitflowsul.com', 5),
('44444444000104', 'Unidade Leste', 'contato@fitflowleste.com', 6),
('55555555000105', 'Unidade Oeste', 'contato@fitflowoeste.com', 7),
('66666666000106', 'Unidade Premium', 'contato@fitflowprem.com', 8),
('77777777000107', 'Unidade Express', 'contato@fitflowexp.com', 9),
('88888888000108', 'Unidade Fitness', 'contato@fitflowfit.com', 10),
('99999999000109', 'Unidade Total', 'contato@fitflowtotal.com', 11),
('10101010000110', 'Unidade Pro', 'contato@fitflowpro.com', 12);

-- 3. Planos

INSERT INTO Planos (nome_plano, duracao_plano, valor_mensal, id_unidade) VALUES
('Mensal', 30, 100.00, 1), ('Trimestral', 90, 270.00, 1), ('Anual', 365, 900.00, 1),
('Mensal', 30, 120.00, 2), ('Trimestral', 90, 320.00, 2), ('Anual', 365, 1100.00, 2),
('Mensal', 30, 100.00, 3), ('Trimestral', 90, 270.00, 3), ('Anual', 365, 900.00, 3),
('Mensal', 30, 100.00, 4), ('Trimestral', 90, 270.00, 4), ('Anual', 365, 900.00, 4),
('Mensal', 30, 100.00, 5), ('Trimestral', 90, 270.00, 5), ('Anual', 365, 900.00, 5),
('Mensal', 30, 100.00, 6), ('Trimestral', 90, 270.00, 6), ('Anual', 365, 900.00, 6),
('Mensal', 30, 100.00, 7), ('Trimestral', 90, 270.00, 7), ('Anual', 365, 900.00, 7),
('Mensal', 30, 100.00, 8), ('Trimestral', 90, 270.00, 8), ('Anual', 365, 900.00, 8),
('Mensal', 30, 100.00, 9), ('Trimestral', 90, 270.00, 9), ('Anual', 365, 900.00, 9),
('Mensal', 30, 100.00, 10), ('Trimestral', 90, 270.00, 10), ('Anual', 365, 900.00, 10),
('Mensal', 30, 100.00, 11), ('Trimestral', 90, 270.00, 11), ('Anual', 365, 900.00, 11),
('Mensal', 30, 100.00, 12), ('Trimestral', 90, 270.00, 12), ('Anual', 365, 900.00, 12);

-- 4. Clientes e Seus Endereços

INSERT INTO Endereco (rua, numero, bairro, cidade, estado, cep) VALUES
('Rua Timbiras', '1500', 'Funcionários', 'Belo Horizonte', 'MG', '30140061'),
('Rua Padre Toledo', '50', 'Centro', 'Ouro Preto', 'MG', '36200022'),          
('Rua Augusta', '900', 'Consolação', 'São Paulo', 'SP', '01305000'),      
('Rua Marechal Deodoro', '300', 'Centro', 'Juiz de Fora', 'MG', '36013000');

INSERT INTO Clientes (cpf, nome, sexo, data_nasc, dia_pag, id_endereco, id_unidade) VALUES
('11122233344', 'João Silva', 'M', '1990-05-15', 10, 13, 1),
('22233344455', 'João Fiel', 'M', '1990-01-01', 5, 14, 1),
('33344455566', 'Maria Devedora', 'F', '1995-02-02', 10, 15, 2),
('44455566677', 'Pedro Mudança', 'M', '1988-03-03', 15, 16, 3);

-- 5. Assinaturas

INSERT INTO Assinaturas (data_inicio, status, id_plano, id_cliente) VALUES
(CURDATE(), 'ATIVA', 1, 1);


INSERT INTO Assinaturas (data_inicio, data_fim, status, id_plano, id_cliente) VALUES
(DATE_SUB(CURDATE(), INTERVAL 60 DAY), DATE_ADD(DATE_SUB(CURDATE(), INTERVAL 60 DAY), INTERVAL 30 DAY),'ATIVA', 1, 2);


INSERT INTO Assinaturas (data_inicio, data_fim, status, id_plano, id_cliente) VALUES
(DATE_SUB(CURDATE(), INTERVAL 40 DAY), DATE_ADD(DATE_SUB(CURDATE(), INTERVAL 40 DAY), INTERVAL 30 DAY), 'ATIVA', 4, 3);


INSERT INTO Assinaturas (data_inicio, data_fim, status, id_plano, id_cliente) VALUES
(DATE_SUB(CURDATE(), INTERVAL 10 DAY), DATE_ADD(DATE_SUB(CURDATE(), INTERVAL 10 DAY), INTERVAL 30 DAY), 'ATIVA', 7, 4);


INSERT INTO Planos