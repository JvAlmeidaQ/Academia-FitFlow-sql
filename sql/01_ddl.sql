CREATE DATABASE Academia_FitFlow;

USE Academia_FitFlow;

CREATE TABLE Endereco(
    id_endereco INT,
    rua VARCHAR(30) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    bairro VARCHAR(30) NOT NULL,
    cidade VARCHAR(30) NOT NULL,
    estado CHAR(2) NOT NULL,
    cep VARCHAR(10) NOT NULL,
    complemento VARCHAR(30)
);

CREATE TABLE Unidades(
    id_unidade INT,
    cnpj VARCHAR(20),
    nome_unidade VARCHAR(100),
    email VARCHAR(50)
);

CREATE TABLE Clientes(
    id_cliente INT,
    cpf VARCHAR(20),
    nome VARCHAR(100),
    sexo ENUM('M','F'),
    data_nasc DATE,
    data_pag DATE
);

CREATE TABLE Planos(
    id_plano INT,
    nome_plano VARCHAR(50),
    duracao_plano VARCHAR(30),
    valor_mensal DECIMAL(10,2)
);

CREATE TABLE Assinaturas(
    id_assinatura INT,
    data_inicio DATE,
    data_fim DATE,
    status ENUM('ATIVA','CANCELADA','PAUSADA')
);

CREATE TABLE Faturas(
    id_fatura INT,
    valor_fatura DECIMAL(10,2),
    data_venc DATE,
    status ENUM('Pendente', 'Pago', 'Atrasado')
);

CREATE TABLE Historico(
    id_historico INT,
    desc_mudanca VARCHAR(255),
    valor_antigo DECIMAL(10,2),
    valor_novo DECIMAL(10,2),
    plano_antigo VARCHAR(100),
    plano_novo VARCHAR(100)
);