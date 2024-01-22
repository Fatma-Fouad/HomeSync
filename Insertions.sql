INSERT INTO Room VALUES
('bedroom', 2, 'empty'),
('bedroom', 2, 'empty'),
('bedroom', 3, 'empty'),
('bedroom', 3, 'empty'),
('bedroom', 3, 'empty'),
('living room', 2, 'empty'),
('kitchen', 1, 'empty'),
('garden', 1, 'empty');

INSERT INTO Users (f_Name, l_name, [password], email, preference, room, [type], birthdate)VALUES 
('Fatma', 'Fouad', '94918', 'fatma.fouad@gmail.com', 'no preference', 1, 'Admin', '2004-09-16'),
('Marina', 'Emil', '71487', 'marina.emil@gmail.com', 'no preference', 5, 'Admin', '2004-01-01'),
('Clara', 'Amir', '67914', 'clara.amir@gmail.com', 'no preference', 4, 'Admin', '2004-03-11'),
('Sandra', 'Narmer', '54541', 'sandra.narmer@gmail.com', 'no preference', 3, 'Admin', '2004-01-01'),
('Khalid', 'Fouad', '66441', 'khalid.fouad@gmail.com', 'no preference', 7, 'Admin', '1994-01-23'),
('Shahd', 'Ali', '75929', 'shahd.ali@gmail.com', 'no preference', 8, 'Guest', '2004-05-17'),
('Manar', 'Ahmad', '41659', 'manar.ahmad@gmail.com', 'no preference', 5, 'Guest', '2004-08-20'),
('Hala', 'Mohamad', '61952', 'hala.mohamad@gmail.com', 'no preference', 2, 'Guest', '2004-10-07'),
('Leqaa', 'Ahmad', '74997', 'leqaa.ahmad@gmail.com', 'no preference', 3, 'Guest', '1999-09-28'),
('Sahar', 'JAmal', '46854', 'sahar.jamal@gmail.com', 'no preference', 6, 'Guest', '1996-03-27');

INSERT INTO Admin VALUES
(1, 5, 1000),
(2, 10, 2300),
(3, 6, 1500),
(4, 3, 3400),
(5, 9, 2000);

INSERT INTO Guest VALUES
(6, 1, 'address of Guest 1', '2023-01-01', '2024-01-01', 'residential of Guest 1'),
(7, 4, 'address of Guest 2', '2023-12-05', '2024-12-05', 'residential of Guest 2'),
(8, 3, 'address of Guest 3', '2023-03-01', '2024-03-01', 'residential of Guest 3'),
(9, 1, 'address of Guest 4', '2023-08-16', '2024-08-16', 'residential of Guest 4'),
(10, 3, 'address of Guest 5', '2023-11-26', '2024-11-26', 'residential of Guest 5');

INSERT INTO Device VALUES
(3, 'AC', 'charging', 96),
(5, 'laptop', 'charging', 20),
(1, 'AC', 'charging', 76),
(3, 'mobile phone', 'charging', 12),
(7, 'microwave', 'charging', 50),
(6, 'tablet', 'charging', 96),
(1, 'tablet', 'charging', 80),
(6, 'tablet 2', 'out of battery', 0);

INSERT INTO Calender VALUES
(1, 'event 1 name', 'event 1 describtion', 'event 1 location', '2023-10-27'),
(3, 'event 2 name', 'event 2 describtion', 'event 2 location', '2023-10-30');

INSERT INTO Task VALUES
('clean bedroom', '2023-10-26', '2023-11-01', 'category name', 5, 'done', '2023-10-30', 3),
('clean kitchen', '2023-11-02', '2023-11-10', 'category name', 5, 'not done yet', '2023-11-05', 1),
('clean living room', '2023-11-12', '2023-11-15', 'category name', 5, 'not done yet', '2023-11-12', 2);

 
INSERT INTO Inventory VALUES
('Item 1', 3, '2025-12-12', 20, 'manufacturer 1', 'category'),
('Item 2', 0, '2025-12-10', 50, 'manufacturer 2', 'category'),
('Item 3', 1, '2025-12-30', 30, 'manufacturer 3', 'category'),
('Item 4', 6, '2025-12-27', 80, 'manufacturer 4', 'category'),
('Item 5', 0, '2025-12-18', 10, 'manufacturer 5', 'category');


INSERT INTO Finance VALUES
(1, 'type', 3000, 'EGP', 'method', 'status', '2023-9-28', 573, '2023-12-12', 50),
(2, 'type', 4000, 'EUR', 'method', 'status', '2023-4-23', 916, '2023-12-12', 50),
(3, 'type', 1000, 'USD', 'method', 'status', '2023-10-23', 776, '2023-12-12', 50),
(4, 'type', 7000, 'CHF', 'method', 'status', '2023-2-28', 471, '2023-12-12', 50),
(5, 'type', 9000, 'KD', 'method', 'status', '2023-11-19', 881, '2023-12-12', 50),
(1, 'type', 3000, 'EGP', 'method', 'status', '2022-9-28', 573, '2022-12-12', 50);

INSERT INTO Travel VALUES
('hotel name', 'london', 8869, 6319, '2024-1-27', '2025-1-27', 'ingoing flight airport', 'outgoing flight airport', 'transport'),
('hotel name', 'london', 4621, 4685, '2024-10-13', '2025-1-27', 'ingoing flight airport', 'outgoing flight airport', 'transport'),
('hotel name', 'london', 6224, 7654, '2025-11-18', '2026-1-27', 'ingoing flight airport', 'outgoing flight airport', 'transport'),
('hotel name', 'london', 6168, 2512, '2023-7-2', '2024-1-27', 'ingoing flight airport', 'outgoing flight airport', 'transport'),
('hotel name', 'london', 7726, 8567, '2022-4-2', '2023-1-27', 'ingoing flight airport', 'outgoing flight airport', 'transport');

INSERT INTO Preferences VALUES
(1,'Preferences','Content1'),
(2,'Preferences','Content2');

INSERT INTO Recommendation VALUES 
(1,'Recommendation1',1,'Content1'),
(2,'Recommendation2',2,'Content2');

INSERT INTO Notes VALUES 
(1,'Content1','2023-1-27','Title'),
(2,'Content2','2024-1-27','Title');

INSERT INTO Communication VALUES
(1,2,'Content1','2023-1-27','2023-1-27','2023-1-27','Title'),
(2,2,'Content2','2023-1-27','2023-1-27','2023-1-27','Title');

INSERT INTO Consumption VALUES
(1,20,'2023-1-27'),
(2,50,'2024-1-27');

INSERT INTO Log VALUES
(1,2,5,'Activity1','2024-1-27',10);

INSERT INTO Assign_to VALUES
(3, 1, 2),
(3, 2, 2);