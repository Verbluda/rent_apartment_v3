CREATE TABLE booking_info (
                              id int8 PRIMARY KEY,
                              start_date TIMESTAMP,
                              end_date TIMESTAMP,
                              amount VARCHAR,
                              discount VARCHAR,
                              apartment_id int8 REFERENCES apartment(id),
                              user_id BIGINT REFERENCES user_info(id)
);

CREATE SEQUENCE booking_info_sequence START WITH 3 INCREMENT BY 1;

INSERT INTO booking_info (id, start_date, end_date, amount, discount, apartment_id, user_id)
VALUES
    (1,'2024-10-01 10:00:00', '2024-10-10 12:00:00', '1000', '10', 1, 1),
    (2, '2024-12-09 15:24:13', '2024-12-15 15:24:13', '500', '0', 2, 2),
    (3, '2024-12-23 15:24:13', '2024-12-29 15:24:13', '500', '0', 2, 2);