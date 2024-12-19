DROP TABLE T_EF_INCOME;
DROP SEQUENCE SQ_TB_INCOME;
DROP TABLE T_EF_EXPENSE;
DROP SEQUENCE SQ_TB_EXPENSE;
DROP TABLE T_EF_USERS;
DROP SEQUENCE SQ_TB_USERS;
DROP TABLE T_EF_CATEGORY;
DROP TABLE T_EF_PAYMENTMETHOD;


-- 1. CRIAR TABELAS
-- 2. ADICIONAR CONSTRAINTS: PRIMARY KEY, CHECK E UNIQUE DE INCOME
CREATE TABLE T_EF_INCOME (
    id_income NUMBER PRIMARY KEY,
    ds_income VARCHAR2(255) NOT NULL,
    value_income NUMBER(10, 2) NOT NULL,
    date_income DATE NOT NULL,
    user_id NUMBER NOT NULL,
    source_income VARCHAR2(255) NOT NULL
);

CREATE TABLE T_EF_EXPENSE (
    id_expense NUMBER PRIMARY KEY,
    ds_expense VARCHAR2(255) NOT NULL,
    value_expense NUMBER(10, 2) NOT NULL,
    date_expense DATE NOT NULL,
    user_id NUMBER NOT NULL,
    isPaid_expense NUMBER(1) NOT NULL,
    category_id NUMBER NOT NULL,
    payment_method_id NUMBER NOT NULL
);

CREATE TABLE T_EF_USERS (
    id_user NUMBER PRIMARY KEY,
    nm_user VARCHAR2(100) NOT NULL,
    email_user VARCHAR2(255) NOT NULL,
    password_user VARCHAR2(255) NOT NULL
);

ALTER TABLE T_EF_USERS
    ADD CONSTRAINT un_ef_email
    UNIQUE ( email_user );


CREATE TABLE T_EF_CATEGORY (
    id_category NUMBER PRIMARY KEY,
    nm_category VARCHAR2(50) NOT NULL
);


CREATE TABLE T_EF_PAYMENTMETHOD (
    id_payment_method NUMBER PRIMARY KEY,
    nm_payment_method VARCHAR2(50) NOT NULL
    );

-- 3. CRIAR SEQUENCIAS PARA INCREMENTAR PRIMARY KEYS
CREATE SEQUENCE SQ_TB_INCOME MINVALUE 1 START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE SQ_TB_EXPENSE MINVALUE 1 START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE SQ_TB_USERS MINVALUE 1 START WITH 1 INCREMENT BY 1;

-- 4. ADICIONAS CONSTRAINTS: FOREIGN KEYS
ALTER TABLE T_EF_EXPENSE
    ADD CONSTRAINT fk_ef_expense_user
     FOREIGN KEY ( user_id )
    REFERENCES T_EF_USERS ( id_user );

ALTER TABLE T_EF_INCOME
    ADD CONSTRAINT fk_ef_income_user
     FOREIGN KEY ( user_id )
    REFERENCES T_EF_USERS ( id_user );

ALTER TABLE T_EF_EXPENSE
    ADD CONSTRAINT fk_ef_expense_payMthod
    FOREIGN KEY ( payment_method_id )
    REFERENCES T_EF_PAYMENTMETHOD ( id_payment_method );

ALTER TABLE T_EF_EXPENSE
    ADD CONSTRAINT fk_ef_expense_category
    FOREIGN KEY ( category_id )
    REFERENCES T_EF_CATEGORY ( id_category );

-- 5. ADICIONAR VALORES PRÉ DEFINIDOS DE CATEGORIA E FORMAS DE PAGAMENTO

INSERT INTO T_EF_CATEGORY (id_category, nm_category) VALUES (1, 'Alimentacao');
INSERT INTO T_EF_CATEGORY (id_category, nm_category) VALUES (2, 'Transporte');
INSERT INTO T_EF_CATEGORY (id_category, nm_category) VALUES (3, 'Mercado');
INSERT INTO T_EF_CATEGORY (id_category, nm_category) VALUES (4, 'Educacao');
INSERT INTO T_EF_CATEGORY (id_category, nm_category) VALUES (5, 'Saude');
INSERT INTO T_EF_CATEGORY (id_category, nm_category) VALUES (6, 'Aluguel');
INSERT INTO T_EF_CATEGORY (id_category, nm_category) VALUES (7, 'Parcelamento');
INSERT INTO T_EF_CATEGORY (id_category, nm_category) VALUES (8, 'Outros');

INSERT INTO T_EF_PAYMENTMETHOD (id_payment_method, nm_payment_method) VALUES (1, 'Cartao de Credito');
INSERT INTO T_EF_PAYMENTMETHOD (id_payment_method, nm_payment_method) VALUES (2, 'Dinheiro');
INSERT INTO T_EF_PAYMENTMETHOD (id_payment_method, nm_payment_method) VALUES (3, 'PIX');
INSERT INTO T_EF_PAYMENTMETHOD (id_payment_method, nm_payment_method) VALUES (4, 'Boleto');
INSERT INTO T_EF_PAYMENTMETHOD (id_payment_method, nm_payment_method) VALUES (5, 'Transferencia Bancaria');
INSERT INTO T_EF_PAYMENTMETHOD (id_payment_method, nm_payment_method) VALUES (6, 'Cartao de Debito');
INSERT INTO T_EF_PAYMENTMETHOD (id_payment_method, nm_payment_method) VALUES (7, 'Outros');

commit;