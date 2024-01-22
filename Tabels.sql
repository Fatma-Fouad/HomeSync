CREATE DATABASE HomeSync;

CREATE TABLE Room (
  room_id INT IDENTITY,
  type VARCHAR(255),
  floor INT,
  status VARCHAR(255),
  PRIMARY KEY (room_id)
);

CREATE TABLE Users (
    id INT PRIMARY KEY IDENTITY,
    f_Name VARCHAR(20),
    l_name VARCHAR(20),
    [password] VARCHAR(20),
    email VARCHAR(50),
    preference VARCHAR(20),
    room int,
    [type] VARCHAR(20),
    birthdate DATETIME,
    age AS (YEAR(GETDATE()) - YEAR(birthdate)),
    FOREIGN KEY (room) REFERENCES Room(room_id)
);

CREATE TABLE Admin (
    admin_id INT PRIMARY KEY ,
    no_of_guests_allowed INT,
    salary INT,
    FOREIGN KEY (admin_id) REFERENCES Users(id)
);

CREATE TABLE Guest (
    guest_id INT PRIMARY KEY,
    guest_of INT, 
    [address] VARCHAR(70),
    arrival_date DATETIME NOT NULL,
    departure_date DATETIME NOT NULL,
    residential VARCHAR(30),
    FOREIGN KEY (guest_id) REFERENCES Users(id), 
    FOREIGN KEY (guest_of) REFERENCES Users(id)  
);

CREATE TABLE Task(
    Task_id INT PRIMARY KEY IDENTITY,
    [name] VARCHAR(20),
    creation_date DATETIME,
    due_date DATETIME, 
    category VARCHAR(20), 
    creator INT, 
    [status] VARCHAR(20), 
    reminder_date DATETIME, 
    [priority] INT,
    FOREIGN KEY (creator) REFERENCES Admin(admin_id)
);

CREATE TABLE Assign_to(
    admin_id INT,
    task_id INT,
    user_id INT,
    PRIMARY KEY(admin_id, task_id, user_id),
    FOREIGN KEY (admin_id) REFERENCES Admin (admin_id),
    FOREIGN KEY (task_id) REFERENCES Task (Task_id),
    FOREIGN KEY (user_id) REFERENCES Users(id)
);

CREATE TABLE Calender(
    event_id INT IDENTITY,
    user_assigned_to INT ,
    [name] VARCHAR(20),
    describtion VARCHAR(60),
    [location] VARCHAR(60),
    reminder_date DATETIME
    PRIMARY KEY(event_id,user_assigned_to),
    FOREIGN KEY (user_assigned_to) REFERENCES Users(id)
);

CREATE TABLE Notes(
    id INT PRIMARY KEY IDENTITY,
    user_id INT,
    content VARCHAR(50),
    creation_date DATETIME,
    title VARCHAR(20),
    FOREIGN KEY (user_id) REFERENCES Users(id)
);

CREATE TABLE Travel(
    trip_no int PRIMARY KEY IDENTITY,
    hotel_name VARCHAR(20),
    destination VARCHAR(50),
    ingoing_flight_num int,
    outgoing_flight_num int,
    ingoing_flight_date datetime NOT NULL,
    outgoing_flight_date datetime NOT NULL,
    ingoing_flight_airport VARCHAR(20),
    outgoing_flight_airport VARCHAR(20),
    transport VARCHAR(20)
);

CREATE TABLE User_trip(
    trip_no INT,
    user_id INT,
    hotel_room_no INT,
    in_going_flight_seat_number INT,
    out_going_flight_seat_number INT,
    PRIMARY KEY(trip_no, user_id),
    FOREIGN KEY (trip_no) REFERENCES Travel(trip_no),
    FOREIGN KEY(user_id) REFERENCES Users(id)
);

CREATE TABLE Finance(
    payement_id INT PRIMARY KEY IDENTITY,
    user_id INT,
    type VARCHAR(20),
    amount INT,
    currency VARCHAR(10),
    method VARCHAR (20),
    status VARCHAR (30),
    date DATETIME,
    receipt_no INT,
    deadline DATETIME,
    penalty INT,
    FOREIGN key (user_id)REFERENCES Users(id)
);

CREATE TABLE Health(
    date DATETIME,
    activity VARCHAR(20),
    user_id INT,
    hours_slept INT,
    food VARCHAR(20),
    PRIMARY KEY(date,activity),
    FOREIGN key (user_id) REFERENCES Users(id)
);

CREATE TABLE Communication(
    message_id INT PRIMARY KEY IDENTITY,
    sender_id INT, 
    receiver_id INT,
    content VARCHAR(70),
    time_sent DATETIME,
    time_received DATETIME,
    time_read DATETIME,
    title VARCHAR(20),
    FOREIGN KEY (sender_id) REFERENCES Users(id),
    FOREIGN KEY (receiver_id) REFERENCES Users(id)
);

CREATE TABLE Device (
    device_id INT PRIMARY KEY IDENTITY,
    room INT,
    type VARCHAR(255),
    status VARCHAR(255),
    battery_status INT,
    FOREIGN KEY (room) REFERENCES Room(room_id)
);

CREATE TABLE RoomSchedule (
    creator_id INT,
    action VARCHAR(255),
    room INT,
    start_time DATETIME,
    end_time DATETIME,
    PRIMARY KEY (creator_id, start_time),
    FOREIGN KEY(creator_id) REFERENCES Users(id),
    FOREIGN KEY (room) REFERENCES Room(room_id)
);

CREATE TABLE Log (
    room_id INT,
    device_id INT,
    user_id INT,
    activity VARCHAR(30),
    date DATE,
    duration INt,
    PRIMARY KEY (room_id, device_id, user_id, date),
    FOREIGN KEY (room_id) REFERENCES Room(room_id),
    FOREIGN KEY (device_id) REFERENCES Device(device_id),
    FOREIGN KEY (user_id) REFERENCES Users(id)
);

CREATE TABLE Consumption (
    device_id INT,
    consumption INT,
    date DATE,
    PRIMARY KEY (device_id, date),
    FOREIGN KEY (device_ID) REFERENCES Device(device_id)
);

CREATE TABLE Preferences(
    user_id INT,
    category VARCHAR(30),
    preference_no INT IDENTITY,
    content VARCHAR(30),
    PRIMARY KEY (user_id, preference_no),
    FOREIGN KEY (user_id) REFERENCES Users(id)
);

CREATE TABLE Recommendation (
    Recommendation_id INT PRIMARY KEY IDENTITY,
    user_id INT,
    category VARCHAR(30),
    preference_No INT,
    content VARCHAR(30),
    FOREIGN KEY (user_id, preference_No) REFERENCES Preferences(user_id, preference_No)
);
CREATE TABLE Inventory(
    supply_id INT PRIMARY KEY IDENTITY,
    [name] VARCHAR(20),
    quantity INT,
    [expiry_date] DATETIME,
    price INT,
    manufacturer VARCHAR(50),
    category VARCHAR(20)
);

CREATE TABLE Camera(
    monitor_id INT PRIMARY KEY,
    camera_id INT ,
    room_id INT,
    FOREIGN KEY (monitor_id) REFERENCES Users(id),
    FOREIGN KEY (room_id) REFERENCES Room(room_id)
);


