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
('12345678000190', 'FitFlow BH', 'bh@fitflow.com', 1), ('98765432000110', 'FitFlow Paulista', 'sp@fitflow.com', 2),
('11111111000101', 'Unidade Centro', 'centro@fitflow.com', 3), ('22222222000102', 'Unidade Norte', 'norte@fitflow.com', 4),
('33333333000103', 'Unidade Sul', 'sul@fitflow.com', 5), ('44444444000104', 'Unidade Leste', 'leste@fitflow.com', 6),
('55555555000105', 'Unidade Oeste', 'oeste@fitflow.com', 7), ('66666666000106', 'Unidade Premium', 'prem@fitflow.com', 8),
('77777777000107', 'Unidade Express', 'exp@fitflow.com', 9), ('88888888000108', 'Unidade Fitness', 'fit@fitflow.com', 10),
('99999999000109', 'Unidade Total', 'total@fitflow.com', 11), ('10101010000110', 'Unidade Pro', 'pro@fitflow.com', 12);

-- 3. Planos (Catálogo Global)
INSERT INTO Planos (nome_plano, duracao_plano, valor_mensal) VALUES
('Mensal', 30, 100.00), ('Trimestral', 90, 270.00), ('Anual', 365, 900.00);

-- 4. Associativa (Disponibilidade dos planos em cada unidade)
-- Ligando todos os 3 planos a todas as 12 unidades (N:N)
INSERT INTO Unidade_Planos (id_unidade, id_plano)
SELECT u.id_unidade, p.id_plano FROM Unidades u, Planos p;

-- 5. Clientes e Endereços Específicos
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

-- 6. Telefones (Reais e Convencionais)
INSERT INTO Telefone (ddd, numero, tipo_telefone, id_cliente, id_unidade) VALUES
('031', '999887766', 'Celular', 1, NULL),
('031', '32221000', 'Comercial', NULL, 1),
('011', '988776655', 'Celular', 3, NULL),
('032', '32154000', 'Comercial', NULL, 3);

-- 7. Assinaturas (Via Procedure para testar o gatilho)
-- Cliente 1 e 2 na Unidade 1 (Plano 1 - Mensal)
CALL SP_gerar_assinatura(1, 1);
CALL SP_gerar_assinatura(1, 2);

-- Cliente 3 na Unidade 2 (Plano 1 - Mensal)
CALL SP_gerar_assinatura(1, 3);

-- Cliente 4 na Unidade 3 (Plano 1 - Mensal)
CALL SP_gerar_assinatura(1, 4);