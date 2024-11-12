-----------------------DROP TABLE----------------------------

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