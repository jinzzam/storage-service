-- 생성자 Oracle SQL Developer Data Modeler 24.3.1.347.1153
--   위치:        2025-09-20 11:57:36 KST
--   사이트:      Oracle Database 11g
--   유형:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE delivery_client_qna (
    c_id        VARCHAR2(10) NOT NULL,
    d_id        VARCHAR2(10) NOT NULL,
    q_type      VARCHAR2(20),
    q_etc_title VARCHAR2(20),
    q_pwd       VARCHAR2(20) NOT NULL
);

ALTER TABLE delivery_client_qna ADD CONSTRAINT delivery_client_qna_pk PRIMARY KEY ( d_id,
                                                                                    c_id );

CREATE TABLE delivery_matching (
    d_id          VARCHAR2(10) NOT NULL,
    c_id          VARCHAR2(10) NOT NULL,
    item_id       VARCHAR2(10) NOT NULL,
    delivery_type VARCHAR2(10) NOT NULL
);

ALTER TABLE delivery_matching
    ADD CONSTRAINT delivery_matching_pk PRIMARY KEY ( d_id,
                                                      c_id,
                                                      item_id );

CREATE TABLE manager_client_qna (
    c_id        VARCHAR2(10) NOT NULL,
    m_id        VARCHAR2(10) NOT NULL,
    q_type      VARCHAR2(20),
    q_etc_title VARCHAR2(20),
    q_pwd       VARCHAR2(20) NOT NULL
);

ALTER TABLE manager_client_qna ADD CONSTRAINT delivery_client_qnav1_pk PRIMARY KEY ( m_id,
                                                                                     c_id );

CREATE TABLE mem_client (
    c_id      VARCHAR2(10) NOT NULL,
    c_pwd     VARCHAR2(20) NOT NULL,
    c_name    VARCHAR2(20) NOT NULL,
    c_email   VARCHAR2(30) NOT NULL,
    c_address VARCHAR2(100) NOT NULL,
    c_class   VARCHAR2(20) NOT NULL,
    c_phone   VARCHAR2(13)
);

ALTER TABLE mem_client ADD CONSTRAINT mem_client_pk PRIMARY KEY ( c_id );

CREATE TABLE mem_delivery (
    d_id       VARCHAR2(10) NOT NULL,
    d_pwd      VARCHAR2(20) NOT NULL,
    d_name     VARCHAR2(20) NOT NULL,
    d_email    VARCHAR2(30) NOT NULL,
    d_address  VARCHAR2(100) NOT NULL,
    d_position VARCHAR2(20) NOT NULL,
    d_phone    VARCHAR2(13)
);

ALTER TABLE mem_delivery ADD CONSTRAINT mem_delivery_pk PRIMARY KEY ( d_id );

CREATE TABLE mem_manager (
    m_id       VARCHAR2(10) NOT NULL,
    m_pwd      VARCHAR2(20) NOT NULL,
    m_name     VARCHAR2(20) NOT NULL,
    m_email    VARCHAR2(30),
    m_address  VARCHAR2(100),
    m_position VARCHAR2(20),
    m_boss_id  VARCHAR2 
--  ERROR: VARCHAR2 size not specified 
    ,
    m_phone    VARCHAR2(13),
    storage_id VARCHAR2(10) NOT NULL
);

ALTER TABLE mem_manager ADD CONSTRAINT mem_manager_pk PRIMARY KEY ( m_id );

CREATE TABLE payment (
    c_id            VARCHAR2(10) NOT NULL,
    s_id            VARCHAR2(10) NOT NULL,
    item_id         VARCHAR2(10) NOT NULL,
    p_basicprice    NUMBER(5),
    p_periodprice   NUMBER(4),
    p_deliveryprice NUMBER(4),
    p_totalprice    NUMBER(7) NOT NULL,
    p_depositstatus CHAR(1) NOT NULL
);

ALTER TABLE payment
    ADD CONSTRAINT payment_pk PRIMARY KEY ( c_id,
                                            s_id,
                                            item_id );

CREATE TABLE storage_info (
    s_id      VARCHAR2(10) NOT NULL,
    m_id      VARCHAR2(10) NOT NULL,
    s_type    VARCHAR2(10),
    s_max     NUMBER(4),
    s_address VARCHAR2(100)
);

ALTER TABLE storage_info ADD CONSTRAINT storage_info_pk PRIMARY KEY ( s_id );

CREATE TABLE stored_items (
    item_id     VARCHAR2(10) NOT NULL,
    item_name   VARCHAR2(20),
    item_weight NUMBER(3),
    s_id        VARCHAR2(10) NOT NULL,
    stored_date DATE NOT NULL,
    expire_date DATE
);

ALTER TABLE stored_items ADD CONSTRAINT stored_items_pk PRIMARY KEY ( item_id );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE delivery_client_qna
    ADD CONSTRAINT delivery_client_qna_mem_client_fk
        FOREIGN KEY ( c_id )
            REFERENCES mem_client ( c_id )
                ON DELETE CASCADE;

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE manager_client_qna
    ADD CONSTRAINT delivery_client_qna_mem_client_fkv1
        FOREIGN KEY ( c_id )
            REFERENCES mem_client ( c_id )
                ON DELETE CASCADE;

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE delivery_client_qna
    ADD CONSTRAINT delivery_client_qna_mem_delivery_fk
        FOREIGN KEY ( d_id )
            REFERENCES mem_delivery ( d_id )
                ON DELETE CASCADE;

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE manager_client_qna
    ADD CONSTRAINT delivery_client_qna_mem_manager_fk
        FOREIGN KEY ( m_id )
            REFERENCES mem_manager ( m_id )
                ON DELETE CASCADE;

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE delivery_matching
    ADD CONSTRAINT delivery_matching_mem_client_fk FOREIGN KEY ( c_id )
        REFERENCES mem_client ( c_id );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE delivery_matching
    ADD CONSTRAINT delivery_matching_mem_delivery_fk FOREIGN KEY ( d_id )
        REFERENCES mem_delivery ( d_id );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE delivery_matching
    ADD CONSTRAINT delivery_matching_stored_items_fk
        FOREIGN KEY ( item_id )
            REFERENCES stored_items ( item_id )
                ON DELETE CASCADE;

ALTER TABLE mem_manager
    ADD CONSTRAINT mem_manager_storage_info_fk FOREIGN KEY ( storage_id )
        REFERENCES storage_info ( s_id );

ALTER TABLE payment
    ADD CONSTRAINT payment_mem_client_fk FOREIGN KEY ( c_id )
        REFERENCES mem_client ( c_id );

ALTER TABLE payment
    ADD CONSTRAINT payment_storage_info_fk FOREIGN KEY ( s_id )
        REFERENCES storage_info ( s_id );

ALTER TABLE payment
    ADD CONSTRAINT payment_stored_items_fk FOREIGN KEY ( item_id )
        REFERENCES stored_items ( item_id );

ALTER TABLE storage_info
    ADD CONSTRAINT storage_info_mem_manager_fk FOREIGN KEY ( m_id )
        REFERENCES mem_manager ( m_id );

ALTER TABLE stored_items
    ADD CONSTRAINT stored_items_storage_info_fk FOREIGN KEY ( s_id )
        REFERENCES storage_info ( s_id );



-- Oracle SQL Developer Data Modeler 요약 보고서: 
-- 
-- CREATE TABLE                             9
-- CREATE INDEX                             0
-- ALTER TABLE                             22
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   8
-- WARNINGS                                 0
