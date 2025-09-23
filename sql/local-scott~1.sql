ALTER TABLE delivery_client_qna ADD CONSTRAINT delivery_client_qna_pk PRIMARY KEY ( d_id,
                                                                                    c_id );
ALTER TABLE delivery_matching
    ADD CONSTRAINT delivery_matching_pk PRIMARY KEY ( d_id,
                                                      c_id,
                                                      item_id );

ALTER TABLE manager_client_qna ADD CONSTRAINT delivery_client_qnav1_pk PRIMARY KEY ( m_id,
                                                                                     c_id );
ALTER TABLE mem_client ADD CONSTRAINT mem_client_pk PRIMARY KEY ( c_id );

ALTER TABLE mem_delivery ADD CONSTRAINT mem_delivery_pk PRIMARY KEY ( d_id );

ALTER TABLE mem_manager ADD CONSTRAINT mem_manager_pk PRIMARY KEY ( m_id );

ALTER TABLE storage_info ADD CONSTRAINT storage_info_pk PRIMARY KEY ( s_id );

ALTER TABLE payment
    ADD CONSTRAINT payment_pk PRIMARY KEY ( c_id,
                                            s_id,
                                            item_id );
                                            
ALTER TABLE stored_items ADD CONSTRAINT stored_items_pk PRIMARY KEY ( item_id );

ALTER TABLE delivery_client_qna
    ADD CONSTRAINT delivery_client_qna_mem_client_fk
        FOREIGN KEY ( c_id )
            REFERENCES mem_client ( c_id )
                ON DELETE CASCADE;
                

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE manager_client_qna
    ADD CONSTRAINT delivery_cl_qna_mem_fk
        FOREIGN KEY ( c_id )
            REFERENCES mem_client ( c_id )
                ON DELETE CASCADE;

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE delivery_client_qna
    ADD CONSTRAINT delivery_cl_qna_fk
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
    ADD CONSTRAINT delivery_mat_mem_delivery_fk FOREIGN KEY ( d_id )
        REFERENCES mem_delivery ( d_id );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE delivery_matching
    ADD CONSTRAINT delivery_mat_stored_items_fk
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

ALTER TABLE mem_client ADD CONSTRAINT mem_client_pk PRIMARY KEY ( c_id );