 insert into mem_manager (m_id, m_pwd, m_name, m_email, m_address, m_position, m_boss_id, m_phone, storage_id)
 values ('uriri', 'wewe11', 'wowwow', 'workweo@nate.com', '대전 성심당', null, null, '010-3334-1111', 'M123aa');
 insert into mem_manager (m_id, m_pwd, m_name, m_email, m_address, m_position, m_boss_id, m_phone, storage_id)
 values ('orio', 'ojohoh1f', 'mcDonalds', 'mcmc@myine.com', '광주광역시', null, 'uriri', '010-5532-2103', 'V1622n');
 insert into mem_manager (m_id, m_pwd, m_name, m_email, m_address, m_position, m_boss_id, m_phone, storage_id)
 values ('nemnem', 'yesir', 'hieght', 'hihit@loloo.com', '강원도 원주시', null, 'orio', '010-1123-4629', 'P900ve');



drop table mem_client;
ALTER TABLE mem_client MODIFY (c_class VARCHAR2(20) NULL);
ALTER TABLE mem_client drop (c_class );

select c_id 
  from mem_client c left outer join mem_delivery d 
    on c.c_id = d.d_id
  left outer join mem_manager m
    on m.m_id = c.c_id
 where c_id='dwf221';
 
 desc mem_delivery;
select * from mem_delivery;
insert into mem_delivery (d_id, d_pwd, d_name, d_email, d_address, d_position, d_phone)
 values ('mmmwwi', '12341', 'goodmorn', 'tutui@lllw.com', '부산시 동래구', null, '010-2534-7445');
 insert into mem_delivery(d_id, d_pwd, d_name, d_email, d_address, d_position, d_phone)
 values ('cuty', 'nini2', 'anyjo', 'jihi@naber.com', '부산시 영도구', null, '010-7777-7342');
 insert into mem_delivery (d_id, d_pwd, d_name, d_email, d_address, d_position, d_phone)
 values ('kings', '13131f', 'herry', 'herry@lily.com', '대전광역시', null, '010-6654-2064');

select * from mem_client;
insert into mem_client (c_id, c_pwd, c_name, c_email, c_address, c_class, c_phone)
 values ('dhdh2', '123f', 'gitding', 'djd@novm.com', '서울시 동작구', null, '010-2222-3333');
insert into mem_client (c_id, c_pwd, c_name, c_email, c_address, c_class, c_phone)
 values ('qwert', 'eed', 'gongnong', 'ge@aug.com', '서울시', null, '010-4522-2413');
 insert into mem_client (c_id, c_pwd, c_name, c_email, c_address, c_class, c_phone)
 values ('nmnmii', 'iiel1', 'yeah', 'busan@guem.com', '부산시 금정구', null, '010-5744-1190');

desc mem_client;
drop table mem_client;

desc mem_manager;
select * from mem_manager;
