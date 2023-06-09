-- Our Users
INSERT INTO Users (name,phone,email,postalZip,region,country)
VALUES
  ('admin','919875123','admin@trotinet.pt','0000-000','Lisbon','Portugal'), -- id -> 1
  ('edu','939585218','edu@edu.pt','3750-811','Agueda','Portugal'), -- id -> 2
  ('afonso','964419133','afonso@afonso.pt','3800-311','Aveiro','Portugal'); -- id -> 3
INSERT INTO Users (name,phone,email,postalZip,region,country)
VALUES
  ('Myra Nieves','(926) 370-4452','pede.cras@google.couk','5954 QQ','South Jeolla','Nigeria'),
  ('Teegan Hampton','1-221-123-4255','phasellus.vitae@google.org','4625','Rio Grande do Sul','Mexico'),
  ('Elizabeth Hutchinson','(877) 956-7839','at.arcu.vestibulum@yahoo.com','6774','Gauteng','Spain'),
  ('Talon Hart','1-306-752-3160','a@outlook.ca','829577','Galicia','Canada'),
  ('Sydney Stanton','1-430-371-3838','sit@hotmail.edu','11963','Maryland','Australia'),
  ('Ciaran Clements','(584) 564-0443','magna.suspendisse@google.couk','1618','North Island','Spain'),
  ('Solomon Osborne','1-138-810-3831','varius.ultrices@protonmail.edu','8675 TL','Stockholms län','Peru'),
  ('Tatum Thomas','1-906-717-3213','semper.rutrum@aol.ca','1036 VA','Free State','Norway'),
  ('Mona Cameron','1-861-573-7956','arcu.vestibulum@aol.com','03485','Kano','Russian Federation'),
  ('Maxwell Bender','(761) 485-3209','montes.nascetur.ridiculus@icloud.couk','2021','Xīnán','Belgium');
INSERT INTO Users (name,phone,email,postalZip,region,country)
VALUES
  ('Catherine Dickerson','1-673-121-4815','eleifend.cras.sed@google.edu','330335','North Kalimantan','New Zealand'),
  ('Mufutau Head','1-931-518-4223','INTEGER.aliquam@icloud.com','6658','South Gyeongsang','Nigeria'),
  ('Imogene Roth','(815) 828-4523','at.auctor@yahoo.com','87-140','Sutherland','Pakistan'),
  ('Diana Barron','(426) 360-4534','nec@protonmail.couk','2535','Ivanovo Oblast','Belgium'),
  ('Hu Branch','1-562-616-6921','urna.nullam.lobortis@hotmail.com','72166','Cartago','Netherlands'),
  ('Madison Benson','(946) 864-4412','pede.nonummy.ut@protonmail.edu','68352','Kogi','Colombia'),
  ('Emery Frazier','1-161-324-0572','imperdiet.ornare@protonmail.couk','S1M 8T3','Chernihiv oblast','Sweden'),
  ('Brett Wise','(591) 811-1632','enim.consequat@outlook.net','601758','Zuid Holland','South Africa'),
  ('Damian Shannon','(960) 374-5532','proin.nisl.sem@protonmail.com','9781','Kentucky','Pakistan'),
  ('Harriet Reed','(858) 840-6043','feugiat.metus.sit@hotmail.net','690652','Guerrero','Peru');

INSERT INTO UAuthentication (id,username,upass)
VALUES
  (1,'admin','admin'),
  (2,'edu','edu'),
  (3,'afonso','afonso');

INSERT INTO TGroups (gname) 
VALUES
  (''), -- empty string is used when group has two users
  (''),
  ('edu_afonso_admin'), -- this is just the name
  ('chat_group');

INSERT INTO TGroupMembers (user_id, group_id)
VALUES
  (1, 1),
  (2, 1),
  (3, 2),
  (1, 2),
  (1, 3),
  (2, 3),
  (3, 3);

-- -- MESSAGES INSERTION
INSERT INTO Messages (msg, sent_date, user_id, group_id) 
VALUES
  ('Hey everyone! I''m excited to be here!', '2023-06-02 10:00:00', 1, 3),
  ('Me too! I can''t wait to get started!', '2023-06-02 10:01:00', 2, 3),
  ('I''m looking forward to working with you all!', '2023-06-02 10:02:00', 3, 3),
  ('Same here! Let''s do this!', '2023-06-02 10:03:00', 1, 3),
  ('Hello everyone! Welcome to our group!', '2023-06-03 10:00:00', 2, 3),
  ('Hi! I''m excited to be here!', '2023-06-03 10:01:00', 3, 3);




-- Inserts for the Insurance table
INSERT INTO Insurance (description, validity, price)
VALUES ('Insurance 1', '2023-06-01', 100.00);

INSERT INTO Insurance (description, validity, price)
VALUES ('Insurance 2', '2023-06-01', 150.00);

INSERT INTO Insurance (description, validity, price)
VALUES ('Insurance 3', '2023-06-01', 200.00);

INSERT INTO Insurance (description, validity, price)
VALUES ('Insurance 4', '2023-06-01', 250.00);

INSERT INTO Insurance (description, validity, price)
VALUES ('Insurance 5', '2023-06-01', 300.00);

INSERT INTO Insurance (description, validity, price)
VALUES ('Insurance 6', '2023-06-01', 350.00);

INSERT INTO Insurance (description, validity, price)
VALUES ('Insurance 7', '2023-06-01', 400.00);

INSERT INTO Insurance (description, validity, price)
VALUES ('Insurance 8', '2023-06-01', 450.00);

INSERT INTO Insurance (description, validity, price)
VALUES ('Insurance 9', '2023-06-01', 500.00);

INSERT INTO Insurance (description, validity, price)
VALUES ('Insurance 10', '2023-06-01', 550.00);

-- Inserts for the Supplier table
-- INSERT INTO Supplier (nif, name, phone, email, address)
-- VALUES ('123456789', 'Supplier 1', '1923941923', 'supplier1@example.com', 'Address 1');

-- INSERT INTO Supplier (nif, name, phone, email, address)
-- VALUES ('987654321', 'Supplier 2', '910291924', 'supplier2@example.com', 'Address 2');

-- INSERT INTO Supplier (nif, name, phone, email, address)
-- VALUES ('111111111', 'Supplier 3', '1111111112', 'supplier3@example.com', 'Address 3');

-- INSERT INTO Supplier (nif, name, phone, email, address)
-- VALUES ('222222222', 'Supplier 4', '2222222221', 'supplier4@example.com', 'Address 4');

-- INSERT INTO Supplier (nif, name, phone, email, address)
-- VALUES ('333333333', 'Supplier 5', '3333333331', 'supplier5@example.com', 'Address 5');

-- INSERT INTO Supplier (nif, name, phone, email, address)
-- VALUES ('444444444', 'Supplier 6', '4444444441', 'supplier6@example.com', 'Address 6');

-- INSERT INTO Supplier (nif, name, phone, email, address)
-- VALUES ('555555555', 'Supplier 7', '5555555551', 'supplier7@example.com', 'Address 7');

-- INSERT INTO Supplier (nif, name, phone, email, address)
-- VALUES ('666666666', 'Supplier 8', '6666666661', 'supplier8@example.com', 'Address 8');

-- INSERT INTO Supplier (nif, name, phone, email, address)
-- VALUES ('777777777', 'Supplier 9', '7777777771', 'supplier9@example.com', 'Address 9');

-- INSERT INTO Supplier (nif, name, phone, email, address)
-- VALUES ('888888888', 'Supplier 10', '8888888881', 'supplier10@example.com', 'Address 10');



-- Inserts for the Product table
-- INSERT INTO Product (battery, availability_status, loc_lat, loc_long, alarm, insurance, Supplier_nif)
-- VALUES (90, 'available', 40.6339, -8.6579, 1, 1, '123456789');

-- INSERT INTO Product (battery, availability_status, loc_lat, loc_long, alarm, insurance, Supplier_nif)
-- VALUES (75, 'available', 40.6339, -8.6580, 2, 2, '987654321');

-- INSERT INTO Product (battery, availability_status, loc_lat, loc_long, alarm, insurance, Supplier_nif)
-- VALUES (80, 'available', 40.6343, -8.6580, 3, 3, '111111111');

-- INSERT INTO Product (battery, availability_status, loc_lat, loc_long, alarm, insurance, Supplier_nif)
-- VALUES (35, 'available', 40.6338, -8.6571, 4, 4, '333333333');

-- INSERT INTO Product (battery, availability_status, loc_lat, loc_long, alarm, insurance, Supplier_nif)
-- VALUES (20, 'available', 40.6340, -8.6584, 5, 5, '222222222');

-- INSERT INTO Product (battery, availability_status, loc_lat, loc_long, alarm, insurance, Supplier_nif)
-- VALUES (15, 'available', 40.6434, -8.6406, 6, 6, '444444444');

-- INSERT INTO Product (battery, availability_status, loc_lat, loc_long, alarm, insurance, Supplier_nif)
-- VALUES (5, 'available', 40.6424, -8.6426, 7, 7, '555555555');

-- INSERT INTO Product (battery, availability_status, loc_lat, loc_long, alarm, insurance, Supplier_nif)
-- VALUES (10, 'available', 40.6428, -8.6416, 8, 8, '666666666');

-- INSERT INTO Product (battery, availability_status, loc_lat, loc_long, alarm, insurance, Supplier_nif)
-- VALUES (70, 'available', 40.6347, -8.6574, 9, 9, '777777777');

-- INSERT INTO Product (battery, availability_status, loc_lat, loc_long, alarm, insurance, Supplier_nif)
-- VALUES (60, 'available', 40.6343, -8.6580, 10, 10, '888888888');

-- -- Inserts for the Alarm table
-- INSERT INTO Alarm (name, description)
-- VALUES ('Alarm 1', 'Alarm 1 description');

-- INSERT INTO Alarm (name, description)
-- VALUES ('Alarm 2', 'Alarm 2 description');

-- INSERT INTO Alarm (name, description)
-- VALUES ('Alarm 3', 'Alarm 3 description');

-- INSERT INTO Alarm (name, description)
-- VALUES ('Alarm 4', 'Alarm 4 description');

-- INSERT INTO Alarm (name, description)
-- VALUES ('Alarm 5', 'Alarm 5 description');

-- INSERT INTO Alarm (name, description)
-- VALUES ('Alarm 6', 'Alarm 6 description');

-- INSERT INTO Alarm (name, description)
-- VALUES ('Alarm 7', 'Alarm 7 description');

-- INSERT INTO Alarm (name, description)
-- VALUES ('Alarm 8', 'Alarm 8 description');

-- INSERT INTO Alarm (name, description)
-- VALUES ('Alarm 9', 'Alarm 9 description');

-- INSERT INTO Alarm (name, description)
-- VALUES ('Alarm 10', 'Alarm 10 description');


INSERT INTO Payment (total, pay_date)
VALUES (100, '2020-01-01');

INSERT INTO Payment (total, pay_date)
VALUES (200, '2020-02-02');

INSERT INTO Payment (total, pay_date)
VALUES (300, '2020-03-03');

INSERT INTO Payment (total, pay_date)
VALUES (400, '2020-04-04');

INSERT INTO Payment (total, pay_date)
VALUES (500, '2020-05-05'); 

INSERT INTO Payment (total, pay_date)
VALUES (600, '2020-06-06');

INSERT INTO Payment (total, pay_date)
VALUES (700, '2020-07-07');

INSERT INTO Payment (total, pay_date)
VALUES (900, '2020-08-07');

INSERT INTO Payment (total, pay_date)
VALUES (1000, '2020-09-07');


-- INSERT INTO UAuthentication (id,username,upass,utoken) VALUES
--   (1,'admin','admin','token'),
--   (2,'edu','edu','token'),
--   (3,'afonso','afonso','token'),
--   (4,'miraNieves','miranocu','token');
-- INSERT INTO UAuthentication (id,username,upass,utoken) VALUES
--   (1,'admin','admin','token'),
--   (2,'edu','edu','token'),
--   (3,'afonso','afonso','token');


-- Supplier Insertion
-- INSERT INTO Supplier (nif, sname, phone, email, saddress, postalZip, country)
-- VALUES
--     (123456799, 'John Doe Suppliers', '123-456-7890', 'john.doe.suppliers@example.com', '123 Main Street', '12345', 'United States'),
--     (987654321, 'Jane Smith Suppliers', '987-654-3210', 'jane.smith.suppliers@example.com', '456 Elm Street', '54321', 'United Kingdom'),
--     (456789123, 'Michael Johnson Suppliers', '456-789-1230', 'michael.johnson.suppliers@example.com', '789 Oak Street', '98765', 'Canada'),
--     (321654987, 'Emily Brown Suppliers', '321-654-9870', 'emily.brown.suppliers@example.com', '987 Pine Street', '56789', 'Australia'),
--     (654123987, 'Daniel Wilson Suppliers', '654-123-9870', 'daniel.wilson.suppliers@example.com', '654 Maple Street', '67890', 'Germany'),
--     (789456123, 'Sophia Taylor Suppliers', '789-456-1230', 'sophia.taylor.suppliers@example.com', '321 Cedar Street', '45678', 'France'),
--     (852963741, 'Oliver Anderson Suppliers', '852-963-7410', 'oliver.anderson.suppliers@example.com', '159 Walnut Street', '34567', 'Spain'),
--     (963852741, 'Emma Martinez Suppliers', '963-852-7410', 'emma.martinez.suppliers@example.com', '753 Birch Street', '23456', 'Italy'),
--     (741852963, 'Jacob Thompson Suppliers', '741-852-9630', 'jacob.thompson.suppliers@example.com', '258 Ash Street', '12345', 'Brazil'),
--     (258963147, 'Isabella Davis Suppliers', '258-963-1470', 'isabella.davis.suppliers@example.com', '852 Sycamore Street', '01234', 'Japan'),
--     (147258369, 'William Wilson Suppliers', '147-258-3690', 'william.wilson.suppliers@example.com', '369 Oak Street', '98765', 'Canada'),
--     (369258147, 'Ava Thompson Suppliers', '369-258-1470', 'ava.thompson.suppliers@example.com', '741 Cedar Street', '45678', 'France'),
--     (852741963, 'James Martinez Suppliers', '852-741-9630', 'james.martinez.suppliers@example.com', '963 Birch Street', '23456', 'Italy'),
--     (741963852, 'Sophia Thompson Suppliers', '741-963-8520', 'sophia.thompson.suppliers@example.com', '852 Ash Street', '12345', 'Brazil'),
--     (369741852, 'Alexander Davis Suppliers', '369-741-8520', 'alexander.davis.suppliers@example.com', '741 Sycamore Street', '01234', 'Japan'),
--     (258147369, 'Mia Anderson Suppliers', '258-147-3690', 'mia.anderson.suppliers@example.com', '369 Walnut Street', '34567', 'Spain'),
--     (147963852, 'Lucas Wilson Suppliers', '147-963-8520', 'lucas.wilson.suppliers@example.com', '852 Elm Street', '54321', 'United Kingdom'),
--     (963741852, 'Harper Thompson Suppliers', '963-741-8520', 'harper.thompson.suppliers@example.com', '741 Pine Street', '56789', 'Australia'),
--     (852369147, 'Benjamin Martinez Suppliers', '852-369-1470', 'benjamin.martinez.suppliers@example.com', '147 Cedar Street', '45678', 'France'),
--     (369852741, 'Evelyn Davis Suppliers', '369-852-7410', 'evelyn.davis.suppliers@example.com', '963 Sycamore Street', '23456', 'Italy');


-- Orders Insertion
-- INSERT INTO Orders (oname, price, quantity, odate, users_id)
-- VALUES
--     ('Order 1', 100.00, 1, '2020-01-01', 1),
--     ('Order 2', 200.00, 2, '2020-02-02', 2),
--     ('Order 3', 300.00, 3, '2020-03-03', 3),
--     ('Order 4', 400.00, 4, '2020-04-04', 4),
--     ('Order 5', 500.00, 5, '2020-05-05', 5),
--     ('Order 6', 600.00, 6, '2020-06-06', 6),
--     ('Order 7', 700.00, 7, '2020-07-07', 7),
--     ('Order 8', 800.00, 8, '2020-08-08', 8),
--     ('Order 9', 900.00, 9, '2020-09-09', 9),
--     ('Order 10', 1000.00, 10, '2020-10-10', 10);

-- INSERT INTO Orders (oname, price, quantity, odate, users_id)
-- VALUES
--     ('Unique Order', 123.76, 1, '2023-05-29', 11),
--     ('Special Order', 456.89, 2, '2023-05-29', 12),
--     ('Exclusive Order', 789.12, 3, '2023-05-29', 13),
--     ('Premium Order', 321.54, 4, '2023-05-29', 14),
--     ('Deluxe Order', 654.87, 5, '2023-05-29', 15),
--     ('Premium Order', 777.77, 3, '2023-05-29', 16),
--     ('Exclusive Order', 999.99, 2, '2023-05-29', 17),
--     ('Special Order', 555.55, 4, '2023-05-29', 18),
--     ('Unique Order', 888.88, 1, '2023-05-29', 19),
--     ('Deluxe Order', 666.66, 5, '2023-05-29', 20);

-- INVENTORY INSERTION
-- INSERT INTO Inventory (iname, idescription, stock, cost, order_id)
-- VALUES
--     ('Troti 1', 'Description 1', 10, 50.00, 1),
--     ('Troti 2', 'Description 2', 5, 20.00, 2),
--     ('Troti 3', 'Description 3', 15, 30.00, 3),
--     ('Troti 4', 'Description 4', 20, 40.00, 4),
--     ('Troti 5', 'Description 5', 8, 15.00, 5),
--     ('Troti 6', 'Troti in perfect condition', 10, 200.25, 6),
--     ('Troti 7', 'Troti slightly degraded', 5, 201.50, 7),
--     ('Troti 8', 'Troti in medium degraded state', 8, 199.75, 8),
--     ('Troti 9', 'Troti in need of revision', 3, 198.80, 9),
--     ('Troti 10', 'Troti in perfect condition', 12, 203.10, 10);

-- INSERT INTO Inventory (iname, idescription, stock, cost, order_id)
-- VALUES
--     ('Troti 11', 'Troti slightly degraded', 6, 197.35, 11),
--     ('Troti 12', 'Troti in medium degraded state', 9, 204.70, 12),
--     ('Troti 13', 'Troti in need of revision', 2, 206.15, 13),
--     ('Troti 14', 'Troti in perfect condition', 7, 195.90, 14),
--     ('Troti 15', 'Troti slightly degraded', 4, 208.45, 15),
--     ('Troti 16', 'Troti in medium degraded state', 11, 193.60, 16),
--     ('Troti 17', 'Troti in need of revision', 6, 210.80, 17),
--     ('Troti 18', 'Troti in perfect condition', 3, 212.25, 18),
--     ('Troti 19', 'Troti slightly degraded', 8, 191.40, 19),
--     ('Troti 20', 'Troti in medium degraded state', 5, 214.70, 20);

-- INSURANCE INSERTION
-- INSERT INTO Insurance (idescription, idate, iprice, productId)
-- VALUES
--     ('Travel insurance for adventurous trips', '2020-01-01', 159.99, 1),
--     ('Pet insurance for your furry companions', '2020-01-02', 199.50, 2),
--     ('Business insurance for comprehensive coverage', '2020-01-03', 549.75, 3),
--     ('Rental insurance for property protection', '2020-01-04', 249.25, 4),
--     ('Life insurance for financial security', '2020-01-05', 899.80, 5),
--     ('Event insurance for worry-free celebrations', '2020-01-06', 99.99, 6),
--     ('Medical insurance for peace of mind', '2020-01-07', 429.50, 7),
--     ('Gadget insurance for device protection', '2020-01-08', 179.25, 8),
--     ('Art insurance for valuable artwork', '2020-01-09', 679.80, 9),
--     ('Motorcycle insurance with comprehensive coverage', '2020-01-10', 319.99, 10);

-- INSERT INTO Insurance (idescription, idate, iprice, productId)
-- VALUES
--     ('Crop insurance for agricultural protection', '2020-01-11', 499.50, 11),
--     ('Sports insurance for injury coverage', '2020-01-12', 129.75, 12),
--     ('Home insurance for property protection', '2020-01-13', 349.25, 13),
--     ('Car insurance for comprehensive coverage', '2020-01-14', 799.80, 14),
--     ('Travel insurance for adventurous trips', '2020-01-15', 159.99, 15),
--     ('Pet insurance for your furry companions', '2020-01-16', 199.50, 16),
--     ('Business insurance for comprehensive coverage', '2020-01-17', 549.75, 17),
--     ('Rental insurance for property protection', '2020-01-18', 249.25, 18),
--     ('Life insurance for financial security', '2020-01-19', 899.80, 19),
--     ('Event insurance for worry-free celebrations', '2020-01-20', 99.99, 20);

-- -- PAYMENT INSERTION
-- INSERT INTO Payment (pdescription, subtotal, pdate, productId)
-- VALUES
--     ('Payment for service', 99.50, '2013-01-01', 1),
--     ('Online purchase payment', 199.75, '2013-02-02', 2),
--     ('Subscription payment', 299.25, '2013-03-03', 3),
--     ('Payment for product', 399.80, '2013-04-04', 4),
--     ('Membership fee payment', 49.99, '2013-05-05', 5),
--     ('Payment for maintenance', 149.50, '2013-06-06', 6),
--     ('Donation payment', 99.75, '2013-07-07', 7),
--     ('Service fee payment', 249.25, '2013-08-08', 8),
--     ('Payment for consultation', 399.80, '2013-09-09', 9),
--     ('Rent payment', 199.99, '2013-10-10', 10),
--     ('Payment for subscription', 129.50, '2013-11-11', 11),
--     ('Product purchase payment', 349.75, '2013-12-12', 12),
--     ('Payment for maintenance', 449.25, '2014-01-13', 13),
--     ('Donation payment', 99.80, '2014-02-14', 14),
--     ('Service fee payment', 149.99, '2014-03-15', 15),
--     ('Payment for consultation', 299.50, '2014-04-16', 16),
--     ('Rent payment', 399.75, '2014-05-17', 17),
--     ('Payment for subscription', 49.25, '2014-06-18', 18),
--     ('Product purchase payment', 99.80, '2014-07-19', 19),
--     ('Payment for maintenance', 199.99, '2014-08-20', 20);

-- -- PRODUCT INSERTION
-- INSERT INTO Product (pname, price, insurance_id, orders_id, supplier_nif, payment_id)
-- VALUES
--   ('Troti #53634', 10.99, 1, 1, 123456799, 1),
--   ('Troti 2', 19.99, 2, 2, 987654321, 2),
--   ('Troti 3', 15.99, 3, 3, 456789123, 3),
--   ('Troti 4', 12.99, 4, 4, 321654987, 4),
--   ('Troti 5', 9.99, 5, 5, 654123987, 5),
--   ('Troti 6', 14.99, 6, 6, 789456123, 6),
--   ('Troti 7', 11.99, 7, 7, 852963741, 7),
--   ('Troti 8', 17.99, 8, 8, 963852741, 8),
--   ('Troti 9', 13.99, 9, 9, 741852963, 9),
--   ('Troti 10', 16.99, 10, 10, 258963147, 10),
--   ('Troti 11', 10.99, 11, 11, 147258369, 11),
--   ('Troti 12', 19.99, 12, 12, 369258147, 12),
--   ('Troti 13', 15.99, 13, 13, 852741963, 13),
--   ('Troti 14', 12.99, 14, 14, 741963852, 14),
--   ('Troti 15', 9.99, 15, 15, 369741852, 15),
--   ('Troti 16', 14.99, 16, 16, 258147369, 16),
--   ('Troti 17', 11.99, 17, 17, 147963852, 17),
--   ('Troti 18', 17.99, 18, 18, 963741852, 18),
--   ('Troti 19', 13.99, 19, 19, 852369147, 19),
--   ('Troti 20', 16.99, 20, 20, 369852741, 20);

-- ALARM INSERTION
-- INSERT INTO Alarm (alarm_name, alarm_description, alarm_date, alarm_time, product_id)
-- VALUES
--   ('Sunrise Alarm', 'Wake up to a beautiful sunrise', '2023-05-30', '06:30:00', 1),
--   ('Coffee Break Reminder', 'Take a break and enjoy a cup of coffee', '2023-05-31', '10:30:00', 2),
--   ('Stretching Time', 'Time to stretch and relax your muscles', '2023-06-01', '14:00:00', 3),
--   ('Productivity Booster', 'Boost your productivity with a quick task', '2023-06-02', '11:00:00', 4),
--   ('Creative Inspiration', 'Get inspired by exploring new ideas', '2023-06-03', '15:30:00', 5),
--   ('Healthy Snack Time', 'Grab a nutritious snack for energy', '2023-06-04', '16:30:00', 6),
--   ('Nature Walk Reminder', 'Take a walk and enjoy the beauty of nature', '2023-06-05', '18:00:00', 7),
--   ('Mindful Meditation', 'Practice mindfulness and find inner peace', '2023-06-06', '08:00:00', 8),
--   ('Fun Exercise Break', 'Get moving with a fun exercise routine', '2023-06-07', '17:00:00', 9),
--   ('Book Reading Time', 'Dive into a captivating book', '2023-06-08', '19:30:00', 10),
--   ('Music Break', 'Listen to your favorite tunes and relax', '2023-06-09', '13:00:00', 11),
--   ('Brain Teaser Challenge', 'Sharpen your mind with a brain teaser', '2023-06-10', '16:00:00', 12),
--   ('Product Launch Countdown', 'Exciting new product launch coming soon', '2023-06-11', '09:30:00', 13),
--   ('Positive Affirmation', 'Remind yourself of your strengths and goals', '2023-06-12', '07:30:00', 14),
--   ('Artistic Inspiration', 'Find inspiration in art and unleash your creativity', '2023-06-13', '12:30:00', 15),
--   ('Healthy Lunch Reminder', 'Fuel your body with a nutritious lunch', '2023-06-14', '13:30:00', 16),
--   ('Goal Review Time', 'Reflect on your goals and progress', '2023-06-15', '16:30:00', 17),
--   ('Relaxing Nature Sounds', 'Take a moment to relax with soothing nature sounds', '2023-06-16', '20:00:00', 18),
--   ('Inspiring Podcast Break', 'Listen to an inspiring podcast episode', '2023-06-17', '11:30:00', 19),
--   ('Evening Reflection', 'Reflect on your day and practice gratitude', '2023-06-18', '21:00:00', 20);

-- TGROUPS INSERTION
-- INSERT INTO TGroups (group_name, created_at)
-- VALUES
--   ('The Innovators', '2023-05-30'),
--   ('Dream Team', '2023-05-31'),
--   ('Power Squad', '2023-06-01'),
--   ('Visionaries', '2023-06-02'),
--   ('The Mavericks', '2023-06-03'),
--   ('Trailblazers', '2023-06-04'),
--   ('The Avengers', '2023-06-05'),
--   ('The Dreamweavers', '2023-06-06'),
--   ('Chaos Crew', '2023-06-07'),
--   ('The Phoenixes', '2023-06-08'),
--   ('The Rockstars', '2023-06-09'),
--   ('The Fireflies', '2023-06-10'),
--   ('The Magic Makers', '2023-06-11'),
--   ('The Journeyers', '2023-06-12'),
--   ('The Outliers', '2023-06-13'),
--   ('The Whiz Kids', '2023-06-14'),
--   ('The Game Changers', '2023-06-15'),
--   ('The Innovators', '2023-06-16'),
--   ('The Illuminators', '2023-06-17'),
--   ('The Explorers', '2023-06-18');
  
-- -- TGROUPSMEMBERS INSERTION  
-- INSERT INTO TGroupsMembers (user_id, group_id)
-- VALUES
--   (1, 1),
--   (2, 1),
--   (3, 1),
--   (4, 1),
--   (5, 1),
--   (6, 2),
--   (7, 2),
--   (8, 2),
--   (9, 2),
--   (10, 2),
--   (11, 3),
--   (12, 3),
--   (13, 3),
--   (14, 3),
--   (15, 3),
--   (16, 4),
--   (17, 4),
--   (18, 4),
--   (19, 4),
--   (20, 4);

-- -- MESSAGES INSERTION
-- INSERT INTO Messages (msg_text, sent_at, user_id, group_id) 
-- VALUES
--   ('Hey everyone! I''m excited to be here!', '2023-06-02 10:00:00', 15, 4),
--   ('Me too! I can''t wait to get started!', '2023-06-02 10:01:00', 16, 4),
--   ('I''m looking forward to working with you all!', '2023-06-02 10:02:00', 17, 4),
--   ('Same here! Let''s do this!', '2023-06-02 10:03:00', 18, 4),
--   ('Hello everyone! Welcome to our group!', '2023-06-03 10:00:00', 19, 5),
--   ('Hi! I''m excited to be here!', '2023-06-03 10:01:00', 20, 5);



-- insert into TGroups (group_name) values
--   (''), -- empty string is used when group has two users
--   (''),
--   ('edu_afonso_admin'), -- this is just the name
--   ('chat_group');

-- insert into TGroupsMembers (group_id, user_id) VALUES
--   (1,1), -- group 1 -> admin
--   (1,2), -- group 1 -> edu
--   (2,1), -- group 2 -> admin
--   (2,3), -- group 2 -> afonso
--   (3,1), -- group 3 -> admin
--   (3,2), -- group 3 -> edu
--   (3,3); -- group 3 -> afonso

-- insert into Messages (msg_text,group_id,user_id) VALUES
--   ('ola',1,1),
--   ('entao',1,2),
--   ('ola123',3,1),
--   ('ola123',3,2),
--   ('ola123',3,3),
--   ('ola123',1,2);

