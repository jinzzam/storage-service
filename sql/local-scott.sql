SELECT 'DROP TABLE "' || TABLE_NAME || '" CASCADE CONSTRAINTS;' FROM user_tables;
commit;
drop table QNA;
select * from QNA;
delete from QNA;
commit;
CREATE TABLE QNA (
    q_id        number(3),
    q_type      VARCHAR2(20),
    writer_id   VARCHAR2(10) NOT NULL,
    q_title     VARCHAR2(50),
    q_content   VARCHAR2(100),
    q_date      TIMESTAMP DEFAULT sysdate,
    q_pwd       VARCHAR2(20) NOT NULL,
    q_ref       number(3),
    q_step      number(1),
    q_level     number(1),
    fileName    VARCHAR2(30),
    fileRealName VARCHAR2(30),
    fileSize    number(4,1)
);
ALTER TABLE QNA MODIFY q_title VARCHAR2(50);
ALTER TABLE QNA MODIFY fileName VARCHAR2(100);
ALTER TABLE QNA MODIFY fileRealName VARCHAR2(100);

CREATE TABLE delivery_matching (
    d_id          VARCHAR2(20) NOT NULL,
    c_id          VARCHAR2(20) NOT NULL,
    item_id       VARCHAR2(10) NOT NULL,
    delivery_type VARCHAR2(30)
);
drop table delivery_matching;
select * from delivery_matching;

drop table mem_delivery;
drop table mem_client;
drop table mem_manager;
drop table memberT;
commit;
select * from memberT;
CREATE TABLE memberT (
    m_id         VARCHAR2(20) NOT NULL,
    pwd        VARCHAR2(20) NOT NULL,
    m_name       VARCHAR2(20) NOT NULL,
    email      VARCHAR2(40),
    address    VARCHAR2(100),
    phone      VARCHAR2(20),
    m_type       VARCHAR2(20),
    company    VARCHAR2(20)
);
select m_id, pwd, m_name, email, address, phone, m_type, company from memberT where m_id='hihello';
update memberT set pwd=?, m_name=?, email='', address='서울시 동작구', phone='01049229999', m_type='client', company='' where m_id='hihello';

update memberT set m_name='cutey' where m_id='hihello';
drop table company_info;
CREATE TABLE company_info (
    company_id VARCHAR2(20),
    name       VARCHAR2(40),
    tel        VARCHAR2(13),
    address    VARCHAR2(50)
);
select * from company_info ;

select * from payment;
drop table payment;
CREATE TABLE payment (
    c_id            VARCHAR2(20) NOT NULL,
    s_id            VARCHAR2(20) NOT NULL,
    company_id      VARCHAR2(20), 
    item_id         VARCHAR2(20) NOT NULL,
    p_basic_price    NUMBER(4),
    p_period_price   NUMBER(4),
    p_delivery_price NUMBER(4),
    p_total_price    NUMBER(8),
    p_deposit_status char(1) default '0'
                    CONSTRAINT payment_status_ck 
                    CHECK(p_deposit_status in('0', '1'))
);
select * from storage_info;
drop table storage_info;
CREATE TABLE storage_info (
    s_id       VARCHAR2(20) NOT NULL,
    m_id       VARCHAR2(20) NOT NULL,
    s_location VARCHAR2(40),
    s_name     VARCHAR2(50),
    s_max      NUMBER(3),
    s_address  VARCHAR2(100),
    company_id VARCHAR2(30)
);
drop table stored_items;

select * from stored_items;
CREATE TABLE stored_items (
    item_id     VARCHAR2(20) NOT NULL,
    item_name   VARCHAR2(40),
    item_weight NUMBER(3),
    s_id        VARCHAR2(20) NOT NULL,
    stored_date DATE default sysdate,
    expire_date DATE
);
commit;

drop table place_an_order;
select * from place_an_order;
commit;
select order_id, s_id, item_id, item_name, item_weight,  ordered_date, ordered_period, confirm_status
						 from place_an_order;
CREATE TABLE place_an_order (
    order_id        VARCHAR2(20),
    orderer_id      VARCHAR2(20),
    s_id            VARCHAR2(20),
    item_id         VARCHAR2(20),
    item_name       VARCHAR2(40),
    item_weight     NUMBER(3),
    ordered_date    DATE default sysdate,
    ordered_period  DATE,
    confirm_status  char(1) default '0'
                    CONSTRAINT order_status_ck 
                    CHECK(confirm_status in('0', '1')),
    fileName        VARCHAR2(100),
    fileRealName    VARCHAR2(100),
    fileSize        number(4,1)
);
select m_name from memberT where m_id='pbickell2s';
select orderer_id from place_an_order where orderer_id='cglassford2v';