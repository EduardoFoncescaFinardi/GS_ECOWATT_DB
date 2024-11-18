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
CREATE OR REPLACE PROCEDURE ExportarDadosParaJSON(p_Json OUT CLOB) AS
    v_Comma VARCHAR2(2) := '';
BEGIN
    DBMS_LOB.CREATETEMPORARY(p_Json, TRUE);
    DBMS_LOB.TRIM(p_Json, 0);
    DBMS_LOB.WRITEAPPEND(p_Json, LENGTH('{ "data": {'), '{ "data": {');
    
    DBMS_LOB.WRITEAPPEND(p_Json, LENGTH('"usuarios": ['), '"usuarios": [');
    FOR rec IN (SELECT id_usuario, nm_nome, ds_email, cd_senha, cd_cep FROM T_EW_USUARIO) LOOP
        DBMS_LOB.WRITEAPPEND(p_Json, LENGTH(v_Comma || '{"id_usuario": ' || rec.id_usuario ||
                           ', "nm_nome": "' || rec.nm_nome || '"' ||
                           ', "ds_email": "' || rec.ds_email || '"' ||
                           ', "cd_senha": "' || rec.cd_senha || '"' ||
                           ', "cd_cep": "' || rec.cd_cep || '"}'),
                           v_Comma || '{"id_usuario": ' || rec.id_usuario ||
                           ', "nm_nome": "' || rec.nm_nome || '"' ||
                           ', "ds_email": "' || rec.ds_email || '"' ||
                           ', "cd_senha": "' || rec.cd_senha || '"' ||
                           ', "cd_cep": "' || rec.cd_cep || '"}');
        v_Comma := ',';
    END LOOP;
    DBMS_LOB.WRITEAPPEND(p_Json, LENGTH('], '), '], ');
    v_Comma := '';

    DBMS_LOB.WRITEAPPEND(p_Json, LENGTH('"aparelhos": ['), '"aparelhos": [');
    FOR rec IN (SELECT id_aparelho_eletronico, nm_nome, vl_consumo_watts, ds_categoria, ds_modelo, id_usuario FROM T_EW_APARELHO_ELETRONICO) LOOP
        DBMS_LOB.WRITEAPPEND(p_Json, LENGTH(v_Comma || '{"id_aparelho_eletronico": ' || rec.id_aparelho_eletronico ||
                           ', "nm_nome": "' || rec.nm_nome || '"' ||
                           ', "vl_consumo_watts": ' || rec.vl_consumo_watts ||
                           ', "ds_categoria": "' || rec.ds_categoria || '"' ||
                           ', "ds_modelo": "' || rec.ds_modelo || '"' ||
                           ', "id_usuario": ' || rec.id_usuario || '}'),
                           v_Comma || '{"id_aparelho_eletronico": ' || rec.id_aparelho_eletronico ||
                           ', "nm_nome": "' || rec.nm_nome || '"' ||
                           ', "vl_consumo_watts": ' || rec.vl_consumo_watts ||
                           ', "ds_categoria": "' || rec.ds_categoria || '"' ||
                           ', "ds_modelo": "' || rec.ds_modelo || '"' ||
                           ', "id_usuario": ' || rec.id_usuario || '}');
        v_Comma := ',';
    END LOOP;
    DBMS_LOB.WRITEAPPEND(p_Json, LENGTH('], '), '], ');
    v_Comma := '';

    DBMS_LOB.WRITEAPPEND(p_Json, LENGTH('"consumo_diario_total": ['), '"consumo_diario_total": [');
    FOR rec IN (SELECT id_consumo_total, vl_total_da_diaria, dt_da_diaria FROM T_EW_CONSUMO_DIARIO_TOTAL) LOOP
        DBMS_LOB.WRITEAPPEND(p_Json, LENGTH(v_Comma || '{"id_consumo_total": ' || rec.id_consumo_total ||
                           ', "vl_total_da_diaria": ' || rec.vl_total_da_diaria ||
                           ', "dt_da_diaria": "' || TO_CHAR(rec.dt_da_diaria, 'YYYY-MM-DD') || '"}'),
                           v_Comma || '{"id_consumo_total": ' || rec.id_consumo_total ||
                           ', "vl_total_da_diaria": ' || rec.vl_total_da_diaria ||
                           ', "dt_da_diaria": "' || TO_CHAR(rec.dt_da_diaria, 'YYYY-MM-DD') || '"}');
        v_Comma := ',';
    END LOOP;
    DBMS_LOB.WRITEAPPEND(p_Json, LENGTH('], '), '], ');
    v_Comma := '';

    DBMS_LOB.WRITEAPPEND(p_Json, LENGTH('"consumo_diario_aparelho": ['), '"consumo_diario_aparelho": [');
    FOR rec IN (SELECT id_consumo_diario, qt_horas_uso, dt_consumo, vl_aparelho_consumo_watt, id_aparelho_eletronico, id_consumo_total FROM T_EW_CONSUMO_DIARIO_APARELHO) LOOP
        DBMS_LOB.WRITEAPPEND(p_Json, LENGTH(v_Comma || '{"id_consumo_diario": ' || rec.id_consumo_diario ||
                           ', "qt_horas_uso": ' || rec.qt_horas_uso ||
                           ', "dt_consumo": "' || TO_CHAR(rec.dt_consumo, 'YYYY-MM-DD') || '"' ||
                           ', "vl_aparelho_consumo_watt": ' || rec.vl_aparelho_consumo_watt ||
                           ', "id_aparelho_eletronico": ' || rec.id_aparelho_eletronico ||
                           ', "id_consumo_total": ' || rec.id_consumo_total || '}'),
                           v_Comma || '{"id_consumo_diario": ' || rec.id_consumo_diario ||
                           ', "qt_horas_uso": ' || rec.qt_horas_uso ||
                           ', "dt_consumo": "' || TO_CHAR(rec.dt_consumo, 'YYYY-MM-DD') || '"' ||
                           ', "vl_aparelho_consumo_watt": ' || rec.vl_aparelho_consumo_watt ||
                           ', "id_aparelho_eletronico": ' || rec.id_aparelho_eletronico ||
                           ', "id_consumo_total": ' || rec.id_consumo_total || '}');
        v_Comma := ',';
    END LOOP;
    DBMS_LOB.WRITEAPPEND(p_Json, LENGTH('], '), '], ');
    v_Comma := '';

    DBMS_LOB.WRITEAPPEND(p_Json, LENGTH('"previsao_consumo": ['), '"previsao_consumo": [');
    FOR rec IN (SELECT id_previsao, qt_media_horas_dia, vl_consumo_previsto_mensal, dt_previsao, id_usuario FROM T_EW_PREVISAO_CONSUMO) LOOP
        DBMS_LOB.WRITEAPPEND(p_Json, LENGTH(v_Comma || '{"id_previsao": ' || rec.id_previsao ||
                           ', "qt_media_horas_dia": ' || rec.qt_media_horas_dia ||
                           ', "vl_consumo_previsto_mensal": ' || rec.vl_consumo_previsto_mensal ||
                           ', "dt_previsao": "' || TO_CHAR(rec.dt_previsao, 'YYYY-MM-DD') || '"' ||
                           ', "id_usuario": ' || rec.id_usuario || '}'),
                           v_Comma || '{"id_previsao": ' || rec.id_previsao ||
                           ', "qt_media_horas_dia": ' || rec.qt_media_horas_dia ||
                           ', "vl_consumo_previsto_mensal": ' || rec.vl_consumo_previsto_mensal ||
                           ', "dt_previsao": "' || TO_CHAR(rec.dt_previsao, 'YYYY-MM-DD') || '"' ||
                           ', "id_usuario": ' || rec.id_usuario || '}');
        v_Comma := ',';
    END LOOP;
    DBMS_LOB.WRITEAPPEND(p_Json, LENGTH('], '), '], ');
    v_Comma := '';

    DBMS_LOB.WRITEAPPEND(p_Json, LENGTH('"valor_kwh": ['), '"valor_kwh": [');
    FOR rec IN (SELECT id_kwh, vl_valor_kwh, id_usuario FROM T_EW_VALOR_KWH) LOOP
        DBMS_LOB.WRITEAPPEND(p_Json, LENGTH(v_Comma || '{"id_kwh": ' || rec.id_kwh ||
                           ', "vl_valor_kwh": ' || rec.vl_valor_kwh ||
                           ', "id_usuario": ' || rec.id_usuario || '}'),
                           v_Comma || '{"id_kwh": ' || rec.id_kwh ||
                           ', "vl_valor_kwh": ' || rec.vl_valor_kwh ||
                           ', "id_usuario": ' || rec.id_usuario || '}');
        v_Comma := ',';
    END LOOP;
    DBMS_LOB.WRITEAPPEND(p_Json, LENGTH('], '), '], ');
    v_Comma := '';

    DBMS_LOB.WRITEAPPEND(p_Json, LENGTH('"meta_consumo_mensal": ['), '"meta_consumo_mensal": [');
    FOR rec IN (SELECT id_meta, ds_meta_watts, ds_meta_financeira, id_usuario FROM T_EW_META_CONSUMO_MENSAL) LOOP
        DBMS_LOB.WRITEAPPEND(p_Json, LENGTH(v_Comma || '{"id_meta": ' || rec.id_meta ||
                           ', "ds_meta_watts": ' || rec.ds_meta_watts ||
                           ', "ds_meta_financeira": ' || rec.ds_meta_financeira ||
                           ', "id_usuario": ' || rec.id_usuario || '}'),
                           v_Comma || '{"id_meta": ' || rec.id_meta ||
                           ', "ds_meta_watts": ' || rec.ds_meta_watts ||
                           ', "ds_meta_financeira": ' || rec.ds_meta_financeira ||
                           ', "id_usuario": ' || rec.id_usuario || '}');
        v_Comma := ',';
    END LOOP;
    DBMS_LOB.WRITEAPPEND(p_Json, LENGTH(']'), ']');

    DBMS_LOB.WRITEAPPEND(p_Json, LENGTH('}}'), '}}');

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro ao gerar JSON: ' || SQLERRM);
END;
---

DECLARE
    json_output CLOB;
BEGIN
    ExportarDadosParaJSON(json_output);
    DBMS_OUTPUT.PUT_LINE(json_output);
END;
