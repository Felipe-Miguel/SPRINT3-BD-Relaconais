
CREATE TABLE t_rpj_atributo (
    id_atributo NUMBER(9) NOT NULL,
    nm_atributo VARCHAR2(80) NOT NULL
);

ALTER TABLE t_rpj_atributo ADD CONSTRAINT t_rpj_atributo_pk PRIMARY KEY ( id_atributo );

CREATE TABLE t_rpj_atributo_campanha (
    id_atributo NUMBER(9) NOT NULL,
    id_campanha NUMBER(9) NOT NULL
);

ALTER TABLE t_rpj_atributo_campanha ADD CONSTRAINT t_rpj_atributo_campanha_pk PRIMARY KEY ( id_atributo,
                                                                                            id_campanha );

CREATE TABLE t_rpj_atributo_ficha (
    id_atributo NUMBER(9) NOT NULL,
    id_ficha    NUMBER(9) NOT NULL
);

ALTER TABLE t_rpj_atributo_ficha ADD CONSTRAINT t_rpj_atributo_ficha_pk PRIMARY KEY ( id_atributo,
                                                                                      id_ficha );

CREATE TABLE t_rpj_aventura (
    id_aventura      NUMBER(9) NOT NULL,
    id_ficha         NUMBER(9) NOT NULL,
    nm_aventura      VARCHAR2(80) NOT NULL,
    nm_instituicao   VARCHAR2(80) NOT NULL,
    tp_aventura      CHAR(1) NOT NULL,
    ds_grau_aventura CHAR(1) NOT NULL,
    dt_inicio        DATE NOT NULL,
    dt_termino       DATE NOT NULL,
    nr_xp            NUMBER(4) NOT NULL
);

ALTER TABLE t_rpj_aventura
    ADD CONSTRAINT aventura_ck CHECK ( tp_aventura IN ( 'A', 'P' ) );

ALTER TABLE t_rpj_aventura
    ADD CONSTRAINT grau_ck CHECK ( ds_grau_aventura IN ( 'B', 'C', 'M', 'T' ) );

ALTER TABLE t_rpj_aventura ADD CONSTRAINT t_rpj_aventura_pk PRIMARY KEY ( id_aventura );

CREATE TABLE t_rpj_beneficio (
    id_campanha  NUMBER(9) NOT NULL,
    id_beneficio NUMBER(9) NOT NULL,
    ds_beneficio VARCHAR2(30) NOT NULL
);

ALTER TABLE t_rpj_beneficio ADD CONSTRAINT t_rpj_beneficio_pk PRIMARY KEY ( id_beneficio,
                                                                            id_campanha );

CREATE TABLE t_rpj_campanha (
    id_campanha     NUMBER(9) NOT NULL,
    id_usuario      NUMBER(9) NOT NULL,
    nm_campanha     VARCHAR2(80) NOT NULL,
    ds_area_atuacao VARCHAR2(40) NOT NULL,
    ds_campanha     VARCHAR2(300) NOT NULL,
    ds_local        VARCHAR2(40),
    tp_contrato     CHAR(3) NOT NULL,
    ds_jornada      CHAR(1) NOT NULL,
    dt_criacao      DATE NOT NULL,
    ds_periodo      CHAR(1) NOT NULL,
    ds_feedback     VARCHAR2(200)
);

ALTER TABLE t_rpj_campanha
    ADD CONSTRAINT contrato_ck CHECK ( tp_contrato IN ( 'CLT', 'PJ' ) );

ALTER TABLE t_rpj_campanha
    ADD CONSTRAINT jornada_ck CHECK ( ds_jornada IN ( 'H', 'O', 'P' ) );

ALTER TABLE t_rpj_campanha
    ADD CONSTRAINT periodo_ck CHECK ( ds_periodo IN ( 'I', 'M', 'N', 'V' ) );

COMMENT ON COLUMN t_rpj_campanha.ds_feedback IS
    'FEEDBACK DO NARRADOR PARA O JOGADOR';

ALTER TABLE t_rpj_campanha ADD CONSTRAINT t_rpj_campanha_pk PRIMARY KEY ( id_campanha );

CREATE TABLE t_rpj_candidatura (
    id_campanha NUMBER(9) NOT NULL,
    id_usuario  NUMBER(9) NOT NULL
);

ALTER TABLE t_rpj_candidatura ADD CONSTRAINT t_rpj_candidatura_pk PRIMARY KEY ( id_usuario,
                                                                                id_campanha );

CREATE TABLE t_rpj_conhecimento (
    id_conhecimento NUMBER(9) NOT NULL,
    nm_conhecimento VARCHAR2(30) NOT NULL
);

ALTER TABLE t_rpj_conhecimento ADD CONSTRAINT t_rpj_conhecimento_pk PRIMARY KEY ( id_conhecimento );

CREATE TABLE t_rpj_conhecimento_aventura (
    id_conhecimento NUMBER(9) NOT NULL,
    id_aventura     NUMBER(9) NOT NULL
);

ALTER TABLE t_rpj_conhecimento_aventura ADD CONSTRAINT t_rpj_conhecimento_aventura_pk PRIMARY KEY ( id_conhecimento,
                                                                                                    id_aventura );

CREATE TABLE t_rpj_conhecimento_campanha (
    id_conhecimento NUMBER(9) NOT NULL,
    id_campanha     NUMBER(9) NOT NULL
);

ALTER TABLE t_rpj_conhecimento_campanha ADD CONSTRAINT t_rpj_conhecimento_campanha_pk PRIMARY KEY ( id_conhecimento,
                                                                                                    id_campanha );

CREATE TABLE t_rpj_endereco_jogador (
    id_endereco NUMBER(9) NOT NULL,
    id_usuario  NUMBER(9) NOT NULL,
    nm_cidade   VARCHAR2(30) NOT NULL,
    nr_cep      NUMBER(8) NOT NULL,
    sg_estado   VARCHAR2(2) NOT NULL,
    nm_pais     VARCHAR2(30) NOT NULL
);

ALTER TABLE t_rpj_endereco_jogador ADD CONSTRAINT t_rpj_endereco_pk PRIMARY KEY ( id_endereco );

CREATE TABLE t_rpj_endereco_narrador (
    id_endereco NUMBER(9) NOT NULL,
    nm_cidade   VARCHAR2(30) NOT NULL,
    nr_cep      NUMBER(8) NOT NULL,
    sg_estado   VARCHAR2(2) NOT NULL,
    nm_pais     VARCHAR2(30) NOT NULL
);

ALTER TABLE t_rpj_endereco_narrador ADD CONSTRAINT t_rpj_endereco_narrador_pk PRIMARY KEY ( id_endereco );

CREATE TABLE t_rpj_ficha_jogador (
    id_ficha   NUMBER(9) NOT NULL,
    id_usuario NUMBER(9) NOT NULL
);

CREATE UNIQUE INDEX t_rpj_ficha_jogador__idx ON
    t_rpj_ficha_jogador (
        id_usuario
    ASC );

ALTER TABLE t_rpj_ficha_jogador ADD CONSTRAINT t_rpj_ficha_jogador_pk PRIMARY KEY ( id_ficha );

CREATE TABLE t_rpj_jogador (
    id_usuario    NUMBER(9) NOT NULL,
    id_ficha      NUMBER(9) NOT NULL,
    nr_cpf        NUMBER(11) NOT NULL,
    nm_jogador    VARCHAR2(30) NOT NULL,
    nm_sobrenome  VARCHAR2(30) NOT NULL,
    dt_nascimento DATE NOT NULL,
    tp_sexo       CHAR(1) NOT NULL,
    nr_nivel      NUMBER(5) NOT NULL
);

ALTER TABLE t_rpj_jogador ADD CHECK ( nr_nivel BETWEEN 0 AND 100 );

CREATE UNIQUE INDEX t_rpj_jogador__idx ON
    t_rpj_jogador (
        id_ficha
    ASC );

ALTER TABLE t_rpj_jogador ADD CONSTRAINT jogador_pk PRIMARY KEY ( id_usuario );

ALTER TABLE t_rpj_jogador ADD CONSTRAINT t_rpj_cpf_uk UNIQUE ( nr_cpf );

CREATE TABLE t_rpj_narrador (
    id_usuario      NUMBER(9) NOT NULL,
    nr_cnpj         NUMBER(14) NOT NULL,
    nm_fantasia     VARCHAR2(80) NOT NULL,
    nm_razao_social VARCHAR2(80) NOT NULL,
    dt_fundacao     DATE NOT NULL,
    ds_area_atuacao VARCHAR2(80) NOT NULL,
    tp_porte        CHAR(3) NOT NULL
);

ALTER TABLE t_rpj_narrador
    ADD CONSTRAINT porte_ck CHECK ( tp_porte IN ( 'EMP', 'EPP', 'GE', 'ME', 'MEI' ) );

ALTER TABLE t_rpj_narrador ADD CONSTRAINT t_rpj_narrador_pk PRIMARY KEY ( id_usuario );

ALTER TABLE t_rpj_narrador ADD CONSTRAINT t_rpj_cnpj_uk UNIQUE ( nr_cnpj );

CREATE TABLE t_rpj_narrador_endereco (
    id_endereco NUMBER(9) NOT NULL,
    id_usuario  NUMBER(9) NOT NULL
);

ALTER TABLE t_rpj_narrador_endereco ADD CONSTRAINT t_rpj_narrador_endereco_pk PRIMARY KEY ( id_endereco,
                                                                                            id_usuario );

CREATE TABLE t_rpj_usuario (
    id_usuario NUMBER(9) NOT NULL,
    ds_email   VARCHAR2(80) NOT NULL,
    ds_senha   VARCHAR2(30) NOT NULL
);

ALTER TABLE t_rpj_usuario
    ADD CONSTRAINT arc_1_lov CHECK ( id_usuario IN ( jogador, narrador ) );

ALTER TABLE t_rpj_usuario ADD CONSTRAINT usuario_pk PRIMARY KEY ( id_usuario );

ALTER TABLE t_rpj_usuario ADD CONSTRAINT t_rpj_email_uk UNIQUE ( ds_email );

ALTER TABLE t_rpj_candidatura
    ADD CONSTRAINT fk_camp_cand FOREIGN KEY ( id_campanha )
        REFERENCES t_rpj_campanha ( id_campanha );

ALTER TABLE t_rpj_candidatura
    ADD CONSTRAINT fk_rpj_jogador_cand FOREIGN KEY ( id_usuario )
        REFERENCES t_rpj_jogador ( id_usuario );

ALTER TABLE t_rpj_jogador
    ADD CONSTRAINT fk_usu_jog FOREIGN KEY ( id_usuario )
        REFERENCES t_rpj_usuario ( id_usuario );

ALTER TABLE t_rpj_narrador
    ADD CONSTRAINT fk_usu_nar FOREIGN KEY ( id_usuario )
        REFERENCES t_rpj_usuario ( id_usuario );

ALTER TABLE t_rpj_atributo_campanha
    ADD CONSTRAINT t_rpj_atr_camp FOREIGN KEY ( id_atributo )
        REFERENCES t_rpj_atributo ( id_atributo );

ALTER TABLE t_rpj_atributo_ficha
    ADD CONSTRAINT t_rpj_atributo_ficha FOREIGN KEY ( id_atributo )
        REFERENCES t_rpj_atributo ( id_atributo );

ALTER TABLE t_rpj_conhecimento_aventura
    ADD CONSTRAINT t_rpj_avent_conh FOREIGN KEY ( id_aventura )
        REFERENCES t_rpj_aventura ( id_aventura );

ALTER TABLE t_rpj_atributo_campanha
    ADD CONSTRAINT t_rpj_camp_atr FOREIGN KEY ( id_campanha )
        REFERENCES t_rpj_campanha ( id_campanha );

ALTER TABLE t_rpj_conhecimento_campanha
    ADD CONSTRAINT t_rpj_camp_conh FOREIGN KEY ( id_campanha )
        REFERENCES t_rpj_campanha ( id_campanha );

ALTER TABLE t_rpj_beneficio
    ADD CONSTRAINT t_rpj_campanha_beneficio FOREIGN KEY ( id_campanha )
        REFERENCES t_rpj_campanha ( id_campanha );

ALTER TABLE t_rpj_conhecimento_aventura
    ADD CONSTRAINT t_rpj_conh_avent FOREIGN KEY ( id_conhecimento )
        REFERENCES t_rpj_conhecimento ( id_conhecimento );

ALTER TABLE t_rpj_conhecimento_campanha
    ADD CONSTRAINT t_rpj_conh_camp FOREIGN KEY ( id_conhecimento )
        REFERENCES t_rpj_conhecimento ( id_conhecimento );

ALTER TABLE t_rpj_narrador_endereco
    ADD CONSTRAINT t_rpj_ende_nar FOREIGN KEY ( id_endereco )
        REFERENCES t_rpj_endereco_narrador ( id_endereco );

ALTER TABLE t_rpj_atributo_ficha
    ADD CONSTRAINT t_rpj_ficha_atr FOREIGN KEY ( id_ficha )
        REFERENCES t_rpj_ficha_jogador ( id_ficha );

ALTER TABLE t_rpj_aventura
    ADD CONSTRAINT t_rpj_ficha_aventura FOREIGN KEY ( id_ficha )
        REFERENCES t_rpj_ficha_jogador ( id_ficha );

ALTER TABLE t_rpj_jogador
    ADD CONSTRAINT t_rpj_jogador_ficha FOREIGN KEY ( id_ficha )
        REFERENCES t_rpj_ficha_jogador ( id_ficha );

ALTER TABLE t_rpj_ficha_jogador
    ADD CONSTRAINT t_rpj_jogador_fichav1 FOREIGN KEY ( id_usuario )
        REFERENCES t_rpj_jogador ( id_usuario );

ALTER TABLE t_rpj_narrador_endereco
    ADD CONSTRAINT t_rpj_nar_ende FOREIGN KEY ( id_usuario )
        REFERENCES t_rpj_narrador ( id_usuario );

ALTER TABLE t_rpj_campanha
    ADD CONSTRAINT t_rpj_narrador_campanha FOREIGN KEY ( id_usuario )
        REFERENCES t_rpj_narrador ( id_usuario );

ALTER TABLE t_rpj_endereco_jogador
    ADD CONSTRAINT t_rpj_usuario_endereco FOREIGN KEY ( id_usuario )
        REFERENCES t_rpj_jogador ( id_usuario );

CREATE OR REPLACE TRIGGER arc_arc_1_t_rpj_jogador BEFORE
    INSERT OR UPDATE OF id_usuario ON t_rpj_jogador
    FOR EACH ROW
DECLARE
    d NUMBER(9);
BEGIN
    SELECT
        a.id_usuario
    INTO d
    FROM
        t_rpj_usuario a
    WHERE
        a.id_usuario = :new.id_usuario;

    IF ( d IS NULL OR d <> jogador ) THEN
        raise_application_error(-20223, 'FK FK_USU_JOG in Table T_RPJ_JOGADOR violates Arc constraint on Table T_RPJ_USUARIO - discriminator column ID_USUARIO doesn''t have value jogador');
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_arc_1_t_rpj_narrador BEFORE
    INSERT OR UPDATE OF id_usuario ON t_rpj_narrador
    FOR EACH ROW
DECLARE
    d NUMBER(9);
BEGIN
    SELECT
        a.id_usuario
    INTO d
    FROM
        t_rpj_usuario a
    WHERE
        a.id_usuario = :new.id_usuario;

    IF ( d IS NULL OR d <> narrador ) THEN
        raise_application_error(-20223, 'FK FK_USU_NAR in Table T_RPJ_NARRADOR violates Arc constraint on Table T_RPJ_USUARIO - discriminator column ID_USUARIO doesn''t have value narrador');
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/
