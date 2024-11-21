----------------------DROP TABLE----------------------------


DROP TABLE T_EW_CONSUMO_DIARIO_APARELHO CASCADE CONSTRAINTS;
DROP TABLE T_EW_CONSUMO_DIARIO_TOTAL CASCADE CONSTRAINTS;
DROP TABLE T_EW_APARELHO_ELETRONICO CASCADE CONSTRAINTS;
DROP TABLE T_EW_PREVISAO_CONSUMO CASCADE CONSTRAINTS;
DROP TABLE T_EW_VALOR_KWH CASCADE CONSTRAINTS;
DROP TABLE T_EW_META_CONSUMO_MENSAL CASCADE CONSTRAINTS;
DROP TABLE T_EW_USUARIO CASCADE CONSTRAINTS;

DROP SEQUENCE SEQ_USUARIO;
DROP SEQUENCE SEQ_APARELHO_ELETRONICO;
DROP SEQUENCE SEQ_CONSUMO_DIARIO_TOTAL;
DROP SEQUENCE SEQ_CONSUMO_DIARIO_APARELHO;
DROP SEQUENCE SEQ_PREVISAO_CONSUMO;
DROP SEQUENCE SEQ_VALOR_KWH;
DROP SEQUENCE SEQ_META_CONSUMO_MENSAL;


-------------------------------------------------------------
----------------------CREATE TABLE---------------------------


---
CREATE TABLE T_EW_USUARIO (
    id_usuario INTEGER NOT NULL,
    nm_nome VARCHAR2(100) NOT NULL,
    ds_email VARCHAR2(150) NOT NULL,
    cd_senha VARCHAR2(255) NOT NULL,
    cd_cep VARCHAR2(10) NOT NULL,
    CONSTRAINT T_EW_USUARIO_PK PRIMARY KEY (id_usuario)
);

CREATE SEQUENCE SEQ_USUARIO
  START WITH 1
  INCREMENT BY 1
  MINVALUE 0
  MAXVALUE 1000
  NOCYCLE;
---
---
CREATE TABLE T_EW_APARELHO_ELETRONICO (
    id_aparelho_eletronico INTEGER NOT NULL,
    nm_nome VARCHAR2(100) NOT NULL,
    vl_consumo_watts NUMBER(10,2) NOT NULL,
    ds_categoria VARCHAR2(50) NOT NULL,
    ds_modelo VARCHAR2(50) NOT NULL,
    id_usuario INTEGER NOT NULL,
    CONSTRAINT T_EW_APARELHO_ELETRONICO_PK PRIMARY KEY (id_aparelho_eletronico),
    CONSTRAINT T_EW_APARELHO_ELETRONICO_T_EW_USUARIO_FK FOREIGN KEY (id_usuario) REFERENCES T_EW_USUARIO(id_usuario)
);

CREATE SEQUENCE SEQ_APARELHO_ELETRONICO
  START WITH 1
  INCREMENT BY 1
  MINVALUE 0
  MAXVALUE 1000
  NOCYCLE;
---
---
CREATE TABLE T_EW_CONSUMO_DIARIO_TOTAL (
    id_consumo_total INTEGER NOT NULL,
    vl_total_da_diaria NUMBER(7,2) NOT NULL,
    dt_da_diaria DATE NOT NULL,
    CONSTRAINT T_EW_CONSUMO_DIARIO_TOTAL_PK PRIMARY KEY (id_consumo_total)
);

CREATE SEQUENCE SEQ_CONSUMO_DIARIO_TOTAL
  START WITH 1
  INCREMENT BY 1
  MINVALUE 0
  MAXVALUE 1000
  NOCYCLE;
---
---
CREATE TABLE T_EW_CONSUMO_DIARIO_APARELHO (
    id_consumo_diario INTEGER NOT NULL,
    qt_horas_uso NUMBER(10,2) NOT NULL,
    dt_consumo DATE NOT NULL,
    vl_aparelho_consumo_watt NUMBER(10,2) NOT NULL,
    id_aparelho_eletronico INTEGER NOT NULL,
    id_consumo_total INTEGER NOT NULL,
    CONSTRAINT T_EW_CONSUMO_DIARIO_APARELHO_PK PRIMARY KEY (id_consumo_diario),
    CONSTRAINT T_EW_CONSUMO_DIARIO_APARELHO_T_EW_APARELHO_ELETRONICO_FK FOREIGN KEY (id_aparelho_eletronico) REFERENCES T_EW_APARELHO_ELETRONICO(id_aparelho_eletronico),
    CONSTRAINT T_EW_CONSUMO_DIARIO_APARELHO_T_EW_CONSUMO_DIARIO_TOTAL_FK FOREIGN KEY (id_consumo_total) REFERENCES T_EW_CONSUMO_DIARIO_TOTAL(id_consumo_total)
);

CREATE SEQUENCE SEQ_CONSUMO_DIARIO_APARELHO
  START WITH 1
  INCREMENT BY 1
  MINVALUE 0
  MAXVALUE 1000
  NOCYCLE;
---
---
CREATE TABLE T_EW_PREVISAO_CONSUMO (
    id_previsao INTEGER NOT NULL,
    qt_media_horas_dia NUMBER(10,2) NOT NULL,
    vl_consumo_previsto_mensal NUMBER(10,2) NOT NULL,
    dt_previsao DATE NOT NULL,
    id_usuario INTEGER NOT NULL,
    CONSTRAINT T_EW_PREVISAO_CONSUMO_PK PRIMARY KEY (id_previsao),
    CONSTRAINT T_EW_PREVISAO_CONSUMO_T_EW_USUARIO_FK FOREIGN KEY (id_usuario) REFERENCES T_EW_USUARIO(id_usuario)
);

CREATE SEQUENCE SEQ_PREVISAO_CONSUMO
  START WITH 1
  INCREMENT BY 1
  MINVALUE 0
  MAXVALUE 1000
  NOCYCLE;
---
---
CREATE TABLE T_EW_VALOR_KWH (
    id_kwh INTEGER NOT NULL,
    vl_valor_kwh NUMBER(4,3) NOT NULL,
    id_usuario INTEGER NOT NULL,
    CONSTRAINT T_EW_VALOR_KWH_PK PRIMARY KEY (id_kwh),
    CONSTRAINT T_EW_VALOR_KWH_T_EW_USUARIO_FK FOREIGN KEY (id_usuario) REFERENCES T_EW_USUARIO(id_usuario)
);

CREATE SEQUENCE SEQ_VALOR_KWH
  START WITH 1
  INCREMENT BY 1
  MINVALUE 0
  MAXVALUE 1000
  NOCYCLE;
---
---
CREATE TABLE T_EW_META_CONSUMO_MENSAL (
    id_meta INTEGER NOT NULL,
    ds_meta_watts NUMBER(10,2) NOT NULL,
    ds_meta_financeira NUMBER(10,2) NOT NULL,
    id_usuario INTEGER NOT NULL,
    CONSTRAINT T_EW_META_CONSUMO_MENSAL_PK PRIMARY KEY (id_meta),
    CONSTRAINT T_EW_META_CONSUMO_MENSAL_T_EW_USUARIO_FK FOREIGN KEY (id_usuario) REFERENCES T_EW_USUARIO(id_usuario)
);

CREATE SEQUENCE SEQ_META_CONSUMO_MENSAL
  START WITH 1
  INCREMENT BY 1
  MINVALUE 0
  MAXVALUE 1000
  NOCYCLE;
---


-------------------------------------------------------------
------------------PROCEDURES - INSERT------------------------

---
CREATE OR REPLACE PROCEDURE PROC_INSERT_EW_USUARIO(
    p_Nome VARCHAR2,
    p_Email VARCHAR2,
    p_Senha VARCHAR2,
    p_CEP VARCHAR2
) AS
BEGIN
    INSERT INTO T_EW_USUARIO (id_usuario, nm_nome, ds_email, cd_senha, cd_cep)
    VALUES (SEQ_USUARIO.NEXTVAL, p_Nome, p_Email, p_Senha, p_CEP);
END;

BEGIN
    PROC_INSERT_EW_USUARIO('João Silva', 'joao.silva@gmail.com', 'senha123', '12345-678');
    PROC_INSERT_EW_USUARIO('Maria Oliveira', 'maria.oliveira@gmail.com', 'senha456', '23456-789');
    PROC_INSERT_EW_USUARIO('Carlos Pereira', 'carlos.pereira@gmail.com', 'senha789', '34567-890');
    PROC_INSERT_EW_USUARIO('Ana Costa', 'ana.costa@gmail.com', 'senha321', '45678-901');
    PROC_INSERT_EW_USUARIO('Lucas Martins', 'lucas.martins@gmail.com', 'senha654', '56789-012');
    PROC_INSERT_EW_USUARIO('Fernanda Lima', 'fernanda.lima@gmail.com', 'senha987', '67890-123');
    PROC_INSERT_EW_USUARIO('Pedro Souza', 'pedro.souza@gmail.com', 'senha111', '78901-234');
    PROC_INSERT_EW_USUARIO('Juliana Ferreira', 'juliana.ferreira@gmail.com', 'senha222', '89012-345');
    PROC_INSERT_EW_USUARIO('Rafael Almeida', 'rafael.almeida@gmail.com', 'senha333', '90123-456');
    PROC_INSERT_EW_USUARIO('Camila Rocha', 'camila.rocha@gmail.com', 'senha444', '01234-567');
END;
---
---
CREATE OR REPLACE PROCEDURE PROC_INSERT_EW_APARELHO_ELETRONICO(
    p_Nome VARCHAR2,
    p_ConsumoWatts NUMBER,
    p_Categoria VARCHAR2,
    p_Modelo VARCHAR2,
    p_IdUsuario INTEGER
) AS
BEGIN
    INSERT INTO T_EW_APARELHO_ELETRONICO (id_aparelho_eletronico, nm_nome, vl_consumo_watts, ds_categoria, ds_modelo, id_usuario)
    VALUES (SEQ_APARELHO_ELETRONICO.NEXTVAL, p_Nome, p_ConsumoWatts, p_Categoria, p_Modelo, p_IdUsuario);
END;

BEGIN
    PROC_INSERT_EW_APARELHO_ELETRONICO('Geladeira', 150, 'Eletrodoméstico', 'Modelo X', 1);
    PROC_INSERT_EW_APARELHO_ELETRONICO('Televisão', 100, 'Eletrônico', 'Modelo Y', 1);
    PROC_INSERT_EW_APARELHO_ELETRONICO('Microondas', 1200, 'Eletrodoméstico', 'Modelo Z', 1);
    PROC_INSERT_EW_APARELHO_ELETRONICO('Ar Condicionado', 2000, 'Climatização', 'Modelo A', 2);
    PROC_INSERT_EW_APARELHO_ELETRONICO('Máquina de Lavar', 500, 'Eletrodoméstico', 'Modelo B', 2);
    PROC_INSERT_EW_APARELHO_ELETRONICO('Secador de Cabelo', 1800, 'Eletrônico', 'Modelo C', 2);
    PROC_INSERT_EW_APARELHO_ELETRONICO('Computador', 250, 'Eletrônico', 'Modelo D', 1);
    PROC_INSERT_EW_APARELHO_ELETRONICO('Ventilador', 50, 'Climatização', 'Modelo E', 2);
    PROC_INSERT_EW_APARELHO_ELETRONICO('Forno Elétrico', 1400, 'Eletrodoméstico', 'Modelo F', 1);
    PROC_INSERT_EW_APARELHO_ELETRONICO('Aspirador de Pó', 600, 'Eletrodoméstico', 'Modelo G', 2);
END;
---
---
CREATE OR REPLACE PROCEDURE PROC_INSERT_EW_CONSUMO_DIARIO_TOTAL(
    p_ValorTotal NUMBER,
    p_Data DATE
) AS
BEGIN
    INSERT INTO T_EW_CONSUMO_DIARIO_TOTAL (id_consumo_total, vl_total_da_diaria, dt_da_diaria)
    VALUES (SEQ_CONSUMO_DIARIO_TOTAL.NEXTVAL, p_ValorTotal, p_Data);
END;

BEGIN
    PROC_INSERT_EW_CONSUMO_DIARIO_TOTAL(15, TO_DATE('01/11/2024','DD/MM/YYYY'));
    PROC_INSERT_EW_CONSUMO_DIARIO_TOTAL(20, TO_DATE('01/11/2024','DD/MM/YYYY'));
    PROC_INSERT_EW_CONSUMO_DIARIO_TOTAL(18, TO_DATE('01/11/2024','DD/MM/YYYY'));
    PROC_INSERT_EW_CONSUMO_DIARIO_TOTAL(22, TO_DATE('01/11/2024','DD/MM/YYYY'));
    PROC_INSERT_EW_CONSUMO_DIARIO_TOTAL(19, TO_DATE('01/11/2024','DD/MM/YYYY'));
    PROC_INSERT_EW_CONSUMO_DIARIO_TOTAL(21, TO_DATE('02/11/2024','DD/MM/YYYY'));
    PROC_INSERT_EW_CONSUMO_DIARIO_TOTAL(23, TO_DATE('02/11/2024','DD/MM/YYYY'));
    PROC_INSERT_EW_CONSUMO_DIARIO_TOTAL(17, TO_DATE('02/11/2024','DD/MM/YYYY'));
    PROC_INSERT_EW_CONSUMO_DIARIO_TOTAL(16, TO_DATE('02/11/2024','DD/MM/YYYY'));
    PROC_INSERT_EW_CONSUMO_DIARIO_TOTAL(20, TO_DATE('02/11/2024','DD/MM/YYYY'));
END;
---
---
CREATE OR REPLACE PROCEDURE PROC_INSERT_EW_CONSUMO_DIARIO_APARELHO(
    p_HorasUso NUMBER,
    p_DataConsumo DATE,
    p_ConsumoWatts NUMBER,
    p_IdAparelhoEletronico INTEGER,
    p_IdConsumoTotal INTEGER
) AS
BEGIN
    INSERT INTO T_EW_CONSUMO_DIARIO_APARELHO (id_consumo_diario, qt_horas_uso, dt_consumo, vl_aparelho_consumo_watt, id_aparelho_eletronico, id_consumo_total)
    VALUES (SEQ_CONSUMO_DIARIO_APARELHO.NEXTVAL, p_HorasUso, p_DataConsumo, p_ConsumoWatts, p_IdAparelhoEletronico, p_IdConsumoTotal);
END;

BEGIN
    PROC_INSERT_EW_CONSUMO_DIARIO_APARELHO(5, TO_DATE('01/11/2024', 'DD/MM/YYYY'), 150, 1, 1);
    PROC_INSERT_EW_CONSUMO_DIARIO_APARELHO(3, TO_DATE('01/11/2024', 'DD/MM/YYYY'), 100, 2, 1);
    PROC_INSERT_EW_CONSUMO_DIARIO_APARELHO(2, TO_DATE('01/11/2024', 'DD/MM/YYYY'), 1200, 3, 1);
    PROC_INSERT_EW_CONSUMO_DIARIO_APARELHO(4, TO_DATE('01/11/2024', 'DD/MM/YYYY'), 2000, 4, 1);
    PROC_INSERT_EW_CONSUMO_DIARIO_APARELHO(6, TO_DATE('01/11/2024', 'DD/MM/YYYY'), 500, 5, 1);
    PROC_INSERT_EW_CONSUMO_DIARIO_APARELHO(1, TO_DATE('02/11/2024', 'DD/MM/YYYY'), 1800, 6, 2);
    PROC_INSERT_EW_CONSUMO_DIARIO_APARELHO(8, TO_DATE('02/11/2024', 'DD/MM/YYYY'), 250, 7, 2);
    PROC_INSERT_EW_CONSUMO_DIARIO_APARELHO(5, TO_DATE('02/11/2024', 'DD/MM/YYYY'), 50, 8, 2);
    PROC_INSERT_EW_CONSUMO_DIARIO_APARELHO(2, TO_DATE('02/11/2024', 'DD/MM/YYYY'), 1400, 9, 2);
    PROC_INSERT_EW_CONSUMO_DIARIO_APARELHO(3, TO_DATE('02/11/2024', 'DD/MM/YYYY'), 600, 10, 2);
END;
---
---
CREATE OR REPLACE PROCEDURE PROC_INSERT_EW_PREVISAO_CONSUMO(
    p_MediaHorasDia NUMBER,
    p_ConsumoPrevistoMensal NUMBER,
    p_DataPrevisao DATE,
    p_IdUsuario INTEGER
) AS
BEGIN
    INSERT INTO T_EW_PREVISAO_CONSUMO (id_previsao, qt_media_horas_dia, vl_consumo_previsto_mensal, dt_previsao, id_usuario)
    VALUES (SEQ_PREVISAO_CONSUMO.NEXTVAL, p_MediaHorasDia, p_ConsumoPrevistoMensal, p_DataPrevisao, p_IdUsuario);
END;

BEGIN
    PROC_INSERT_EW_PREVISAO_CONSUMO(4, 300, TO_DATE('01/11/2024', 'DD/MM/YYYY'), 1);
    PROC_INSERT_EW_PREVISAO_CONSUMO(6, 450, TO_DATE('01/11/2024', 'DD/MM/YYYY'), 2);
    PROC_INSERT_EW_PREVISAO_CONSUMO(5, 400, TO_DATE('01/11/2024', 'DD/MM/YYYY'), 1);
    PROC_INSERT_EW_PREVISAO_CONSUMO(3, 250, TO_DATE('01/11/2024', 'DD/MM/YYYY'), 2);
    PROC_INSERT_EW_PREVISAO_CONSUMO(7, 500, TO_DATE('01/11/2024', 'DD/MM/YYYY'), 1);
    PROC_INSERT_EW_PREVISAO_CONSUMO(2, 150, TO_DATE('02/11/2024', 'DD/MM/YYYY'), 2);
    PROC_INSERT_EW_PREVISAO_CONSUMO(8, 600, TO_DATE('02/11/2024', 'DD/MM/YYYY'), 1);
    PROC_INSERT_EW_PREVISAO_CONSUMO(9, 650, TO_DATE('02/11/2024', 'DD/MM/YYYY'), 2);
    PROC_INSERT_EW_PREVISAO_CONSUMO(1, 100, TO_DATE('02/11/2024', 'DD/MM/YYYY'), 1);
    PROC_INSERT_EW_PREVISAO_CONSUMO(10, 700, TO_DATE('02/11/2024', 'DD/MM/YYYY'), 2);
END;
---
---
CREATE OR REPLACE PROCEDURE PROC_INSERT_EW_VALOR_KWH(
    p_ValorKWH NUMBER,
    p_IdUsuario INTEGER
) AS
BEGIN
    INSERT INTO T_EW_VALOR_KWH (id_kwh, vl_valor_kwh, id_usuario)
    VALUES (SEQ_VALOR_KWH.NEXTVAL, p_ValorKWH, p_IdUsuario);
END;

BEGIN
    PROC_INSERT_EW_VALOR_KWH(TO_NUMBER('0.656', '999.999'), 1);
    PROC_INSERT_EW_VALOR_KWH(TO_NUMBER('0.700', '999.999'), 2);
    PROC_INSERT_EW_VALOR_KWH(TO_NUMBER('0.680', '999.999'), 1);
    PROC_INSERT_EW_VALOR_KWH(TO_NUMBER('0.650', '999.999'), 2);
    PROC_INSERT_EW_VALOR_KWH(TO_NUMBER('0.690', '999.999'), 1);
    PROC_INSERT_EW_VALOR_KWH(TO_NUMBER('0.675', '999.999'), 2);
    PROC_INSERT_EW_VALOR_KWH(TO_NUMBER('0.710', '999.999'), 1);
    PROC_INSERT_EW_VALOR_KWH(TO_NUMBER('0.660', '999.999'), 2);
    PROC_INSERT_EW_VALOR_KWH(TO_NUMBER('0.685', '999.999'), 1);
    PROC_INSERT_EW_VALOR_KWH(TO_NUMBER('0.695', '999.999'), 2);
END;
---
---
CREATE OR REPLACE PROCEDURE PROC_INSERT_EW_META_CONSUMO_MENSAL(
    p_MetaWatts NUMBER,
    p_MetaFinanceira NUMBER,
    p_IdUsuario INTEGER
) AS
BEGIN
    INSERT INTO T_EW_META_CONSUMO_MENSAL (id_meta, ds_meta_watts, ds_meta_financeira, id_usuario)
    VALUES (SEQ_META_CONSUMO_MENSAL.NEXTVAL, p_MetaWatts, p_MetaFinanceira, p_IdUsuario);
END;

BEGIN
    PROC_INSERT_EW_META_CONSUMO_MENSAL(300, 200, 1);
    PROC_INSERT_EW_META_CONSUMO_MENSAL(350, 250, 2);
    PROC_INSERT_EW_META_CONSUMO_MENSAL(400, 300, 1);
    PROC_INSERT_EW_META_CONSUMO_MENSAL(250, 180, 2);
    PROC_INSERT_EW_META_CONSUMO_MENSAL(450, 320, 1);
    PROC_INSERT_EW_META_CONSUMO_MENSAL(500, 350, 2);
    PROC_INSERT_EW_META_CONSUMO_MENSAL(380, 270, 1);
    PROC_INSERT_EW_META_CONSUMO_MENSAL(420, 290, 2);
    PROC_INSERT_EW_META_CONSUMO_MENSAL(310, 210, 1);
    PROC_INSERT_EW_META_CONSUMO_MENSAL(330, 230, 2);
END; 
---
---
SELECT * FROM T_EW_USUARIO;
SELECT * FROM T_EW_APARELHO_ELETRONICO;
SELECT * FROM T_EW_CONSUMO_DIARIO_TOTAL;
SELECT * FROM T_EW_CONSUMO_DIARIO_APARELHO;
SELECT * FROM T_EW_PREVISAO_CONSUMO;
SELECT * FROM T_EW_VALOR_KWH;
SELECT * FROM T_EW_META_CONSUMO_MENSAL;

-------------------------------------------------------------
-------------------------FUNÇÕES-----------------------------


set serveroutput on
SET VERIFY OFF
---
CREATE OR REPLACE FUNCTION ValidarFormatoCEP(p_CEP VARCHAR2)
RETURN BOOLEAN IS
    cep_invalido EXCEPTION;
BEGIN
    IF NOT REGEXP_LIKE(p_CEP, '^\d{5}-\d{3}$') THEN
        RAISE cep_invalido;
    END IF;
    RETURN TRUE;
EXCEPTION
    WHEN cep_invalido THEN
        DBMS_OUTPUT.PUT_LINE('Erro: CEP inválido. Formato esperado: XXXXX-XXX.');
        RETURN FALSE;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro inesperado ao validar o CEP.');
        RETURN FALSE;
END;
---TESTE VALIDO
DECLARE
    resultado BOOLEAN;
BEGIN
    resultado := ValidarFormatoCEP('12345-678'); 
    IF resultado THEN
        DBMS_OUTPUT.PUT_LINE('Teste de CEP válido: Sucesso');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Teste de CEP válido: Falha');
    END IF;
END;
---TESTE INVALIDO
DECLARE
    resultado BOOLEAN;
BEGIN
    resultado := ValidarFormatoCEP('12345678'); 
    IF resultado THEN
        DBMS_OUTPUT.PUT_LINE('Teste de CEP inválido: Sucesso');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Teste de CEP inválido: Falha');
    END IF;
END;
---
---
CREATE OR REPLACE FUNCTION CalcularConsumoTotalPorData(
    p_Data DATE,
    p_IdUsuario INTEGER
) RETURN NUMBER IS
    v_ConsumoTotal NUMBER := 0;
BEGIN
    SELECT SUM((cda.vl_aparelho_consumo_watt * cda.qt_horas_uso) / 1000)
    INTO v_ConsumoTotal
    FROM T_EW_CONSUMO_DIARIO_APARELHO cda
    JOIN T_EW_APARELHO_ELETRONICO ae ON cda.id_aparelho_eletronico = ae.id_aparelho_eletronico
    WHERE cda.dt_consumo = p_Data
      AND ae.id_usuario = p_IdUsuario;

    RETURN v_ConsumoTotal;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao calcular o consumo total: ' || SQLERRM);
        RETURN -1;
END;
---TESTE 1
DECLARE
    consumo_total NUMBER;
BEGIN
    consumo_total := CalcularConsumoTotalPorData(TO_DATE('01/11/2024', 'DD/MM/YYYY'), 2);
    DBMS_OUTPUT.PUT_LINE('Consumo total em kWh: ' || consumo_total);
END;
---TESTE 2
DECLARE
    consumo_total NUMBER;
BEGIN
    consumo_total := CalcularConsumoTotalPorData(TO_DATE('02/11/2024', 'DD/MM/YYYY'), 1);
    DBMS_OUTPUT.PUT_LINE('Consumo total em kWh: ' || consumo_total);
END;
---


-------------------------------------------------------------
---------------------PROCEDURE - JSON------------------------


set serveroutput on
SET VERIFY OFF
---
CREATE OR REPLACE PROCEDURE GeraJSONEstruturado IS
    CURSOR c_usuarios IS
        SELECT id_usuario, nm_nome, ds_email, cd_senha, cd_cep
        FROM T_EW_USUARIO;

    CURSOR c_aparelhos(p_id_usuario INTEGER) IS
        SELECT id_aparelho_eletronico, nm_nome, vl_consumo_watts, ds_categoria, ds_modelo
        FROM T_EW_APARELHO_ELETRONICO
        WHERE id_usuario = p_id_usuario;

    CURSOR c_previsao_consumo(p_id_usuario INTEGER) IS
        SELECT id_previsao, qt_media_horas_dia, vl_consumo_previsto_mensal, dt_previsao
        FROM T_EW_PREVISAO_CONSUMO
        WHERE id_usuario = p_id_usuario;

    CURSOR c_valor_kwh(p_id_usuario INTEGER) IS
        SELECT id_kwh, vl_valor_kwh
        FROM T_EW_VALOR_KWH
        WHERE id_usuario = p_id_usuario;

    CURSOR c_meta_consumo(p_id_usuario INTEGER) IS
        SELECT id_meta, ds_meta_watts, ds_meta_financeira
        FROM T_EW_META_CONSUMO_MENSAL
        WHERE id_usuario = p_id_usuario;

    v_json CLOB := '';
    v_temp CLOB := '';
BEGIN
    DBMS_LOB.CREATETEMPORARY(v_json, TRUE);

    FOR rec_usu IN c_usuarios LOOP
        v_json := v_json || '{' || CHR(10);
        v_json := v_json || '    "_id": ' || rec_usu.id_usuario || ',' || CHR(10);
        v_json := v_json || '    "nm_nome": "' || rec_usu.nm_nome || '",' || CHR(10);
        v_json := v_json || '    "ds_email": "' || rec_usu.ds_email || '",' || CHR(10);
        v_json := v_json || '    "cd_senha": "' || rec_usu.cd_senha || '",' || CHR(10);
        v_json := v_json || '    "cd_cep": "' || rec_usu.cd_cep || '",' || CHR(10);

        v_json := v_json || '    "aparelhos": [' || CHR(10);
        DBMS_LOB.CREATETEMPORARY(v_temp, TRUE);
        FOR rec_ap IN c_aparelhos(rec_usu.id_usuario) LOOP
            v_temp := v_temp || '        {"id_aparelho_eletronico": ' || rec_ap.id_aparelho_eletronico ||
                      ', "nm_nome": "' || rec_ap.nm_nome || '", "vl_consumo_watts": ' || TRIM(TO_CHAR(rec_ap.vl_consumo_watts, 'FM9999990.00')) ||
                      ', "ds_categoria": "' || rec_ap.ds_categoria || '", "ds_modelo": "' || rec_ap.ds_modelo || '"},' || CHR(10);
        END LOOP;
        IF LENGTH(v_temp) > 0 THEN
            v_json := v_json || SUBSTR(v_temp, 1, LENGTH(v_temp)-2) || CHR(10); 
        END IF;
        v_json := v_json || '    ],' || CHR(10);
        DBMS_LOB.FREETEMPORARY(v_temp);

        v_json := v_json || '    "previsao_consumo": [' || CHR(10);
        DBMS_LOB.CREATETEMPORARY(v_temp, TRUE);
        FOR rec_prev IN c_previsao_consumo(rec_usu.id_usuario) LOOP
            v_temp := v_temp || '        {"id_previsao": ' || rec_prev.id_previsao ||
                      ', "qt_media_horas_dia": ' || TRIM(TO_CHAR(rec_prev.qt_media_horas_dia, 'FM999990.00')) ||
                      ', "vl_consumo_previsto_mensal": ' || TRIM(TO_CHAR(rec_prev.vl_consumo_previsto_mensal, 'FM999990.00')) ||
                      ', "dt_previsao": "' || TO_CHAR(rec_prev.dt_previsao, 'YYYY-MM-DD') || '"},' || CHR(10);
        END LOOP;
        IF LENGTH(v_temp) > 0 THEN
            v_json := v_json || SUBSTR(v_temp, 1, LENGTH(v_temp)-2) || CHR(10); 
        END IF;
        v_json := v_json || '    ],' || CHR(10);
        DBMS_LOB.FREETEMPORARY(v_temp);

        v_json := v_json || '    "valor_kwh": [' || CHR(10);
        DBMS_LOB.CREATETEMPORARY(v_temp, TRUE);
        FOR rec_kwh IN c_valor_kwh(rec_usu.id_usuario) LOOP
            v_temp := v_temp || '        {"id_kwh": ' || rec_kwh.id_kwh ||
                      ', "vl_valor_kwh": ' || TRIM(TO_CHAR(rec_kwh.vl_valor_kwh, 'FM9990.000')) || '},' || CHR(10);
        END LOOP;
        IF LENGTH(v_temp) > 0 THEN
            v_json := v_json || SUBSTR(v_temp, 1, LENGTH(v_temp)-2) || CHR(10); 
        END IF;
        v_json := v_json || '    ],' || CHR(10);
        DBMS_LOB.FREETEMPORARY(v_temp);

        v_json := v_json || '    "meta_consumo_mensal": [' || CHR(10);
        DBMS_LOB.CREATETEMPORARY(v_temp, TRUE);
        FOR rec_meta IN c_meta_consumo(rec_usu.id_usuario) LOOP
            v_temp := v_temp || '        {"id_meta": ' || rec_meta.id_meta ||
                      ', "ds_meta_watts": ' || TRIM(TO_CHAR(rec_meta.ds_meta_watts, 'FM999990.00')) ||
                      ', "ds_meta_financeira": ' || TRIM(TO_CHAR(rec_meta.ds_meta_financeira, 'FM999990.00')) || '},' || CHR(10);
        END LOOP;
        IF LENGTH(v_temp) > 0 THEN
            v_json := v_json || SUBSTR(v_temp, 1, LENGTH(v_temp)-2) || CHR(10);
        END IF;
        v_json := v_json || '    ]' || CHR(10);
        DBMS_LOB.FREETEMPORARY(v_temp);

        v_json := v_json || '},' || CHR(10);
    END LOOP;

    v_json := TRIM(TRAILING ',' FROM v_json);

    DBMS_OUTPUT.PUT_LINE(v_json);
    DBMS_LOB.FREETEMPORARY(v_json);
END GeraJSONEstruturado;
---

BEGIN
    GeraJSONEstruturado;
END;

---
-------------------------------------------------------------
