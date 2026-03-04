USE Academia_FitFlow;

DELIMITER $

CREATE PROCEDURE SP_gerar_assinatura(
    IN p_id_plano INT,
    IN p_id_cliente INT
)
BEGIN
    DECLARE var_unidade_plano, var_unidade_cliente INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

        SELECT id_unidade
        INTO var_unidade_plano
        FROM Planos
        WHERE id_plano = p_id_plano;

        SELECT id_unidade
        INTO var_unidade_cliente
        FROM Clientes
        WHERE id_cliente = p_id_cliente;

        IF var_unidade_plano = var_unidade_cliente THEN
            INSERT INTO Assinaturas (data_inicio,status,id_plano,p_id_cliente)
            VALUES (CURDATE(),'Ativa',p_id_plano,p_id_cliente);
        END IF;

    COMMIT;
END
$

CREATE PROCEDURE SP_alterar_plano(
    IN new_id_plano INT,
    IN p_id_assinatura INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;
        UPDATE Assinaturas
         SET id_plano = new_id_plano, status = 'ATIVA'
        WHERE id_assinatura = p_id_assinatura;
    COMMIT;
END
$

CREATE PROCEDURE SP_alterar_status_assinatura(
    IN p_id_assinatura INT,
    IN p_new_status CHAR(10)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;
        IF p_new_status = 'CANCELADA' THEN
            UPDATE Assinaturas
            SET status = p_new_status, data_fim = CURDATE()
            WHERE id_assinatura = p_id_assinatura;
        ELSE
            UPDATE Assinaturas
            SET status = p_new_status
            WHERE id_assinatura = p_id_assinatura;
        END IF;
    COMMIT;
END
$

CREATE PROCEDURE SP_registrar_pagamento(
    IN p_id_fatura INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;
       UPDATE Faturas
       SET status = 'Pago'
       WHERE id_fatura = p_id_fatura;
    COMMIT;
END
$

CREATE PROCEDURE SP_verificar_pag_pendente()
BEGIN
    DECLARE var_linhas_atualizadas INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        INSERT INTO Log_Eventos(evento,detalhes)
        VALUES ('ERRO', 'Falha ao prcessar atrasos');
    END;

    START TRANSACTION;
            UPDATE Faturas
            SET status = 'Atrasado'
            WHERE data_venc < CURDATE()
            AND status = 'Pendente'; 

            SET var_linhas_atualizadas = ROW_COUNT();

            INSERT INTO Log_Eventos(evento,detalhes)
            VALUES('PROCESSAMENTO_DIARIO', 
                    CONCAT(v_linhas_afetadas, ' fatura(s) Atrasadas.'));
    COMMIT;
END
$