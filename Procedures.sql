--1) Register on the website with a unique email along with the needed information. Choose which type
--of user you will be using @usertype (Admin). (Clara Amir)
GO
CREATE PROCEDURE UserRegister
    @usertype VARCHAR(20),
    @email VARCHAR(50),
    @first_name VARCHAR(20),
    @last_name VARCHAR(20),
    @birth_date DATETIME,
    @password VARCHAR(10),
    @user_id INT OUTPUT
AS
BEGIN
    IF @email in (select email from users)
        return;
    IF @usertype = 'Admin'
    BEGIN
        INSERT INTO Users
            (f_Name, l_Name, [password], email, [type], birthdate)
        VALUES
            (@first_name, @last_name, @password, @email,
                'Admin', @birth_date)
        SET @user_id = SCOPE_IDENTITY()
        INSERT INTO [Admin]
            (admin_id, no_of_guests_allowed)
        VALUES
            (@user_id, 30)    
    END
    ELSE
    BEGIN
        INSERT INTO Users
            (f_Name, l_Name, [password], email, [type], birthdate)
        VALUES
            (@first_name, @last_name, @password, @email,
                'Guest', @birth_date)
        SET @user_id = SCOPE_IDENTITY()
        INSERT INTO Guest
            (guest_id)
        VALUES
            (@user_id)
    END
END;

GO
--1) Login using my email and password. In the event that the user is not registered, the @user_id value
--will be (-1). (Clara Amir)
CREATE PROCEDURE UserLogin
    @email varchar(50),
    @password varchar(10),
    @success bit OUTPUT ,
    @user_id int OUTPUT
AS
BEGIN 
    IF EXISTS ( SELECT * FROM [Users] 
                WHERE email =@email 
                AND [password]= @password)
    BEGIN 
        SET @success = 1 
        SET @user_id= (SELECT ID 
                        FROM [Users] 
                        WHERE email= @email)
    END 
    ELSE 
    BEGIN 
        SET @success =0 
        SET @user_id= -1 
    END 
END;

GO
--2) View all the details of my profile. (Clara Amir)
CREATE PROCEDURE ViewProfile
    @user_id int
    AS
BEGIN 
    SELECT *
    FROM Users
    WHERE id = @user_id;
END;

GO
--4) View their task. (You should check if the deadline has passed or not if it passed set the status to
--done). (Clara Amir)
CREATE PROCEDURE ViewMyTask --This procedure first updates the status of tasks with deadlines that have passed to 'done' for the given [user_id]. Then, it retrieves all the details of tasks assigned to the user, including the task details and the admin responsible for the task
    @user_id int
AS
BEGIN
    UPDATE Task
    SET [status] = 'done'
    WHERE due_date < GETDATE() AND Task_id IN (
        SELECT Task_id
        FROM Assign_to
        WHERE [user_id] = @user_id
    );
    SELECT Task.*, Assign_to.admin_id
    FROM Task
    INNER JOIN Assign_to 
    ON Task.Task_id = Assign_to.task_id
    WHERE Assign_to.[user_id] = @user_id;
END;


GO
--5) Finish their task.(Clara Amir)
CREATE PROCEDURE FinishMyTask
    @user_id int,
    @title varchar(50)
AS
BEGIN
    UPDATE Task
    SET status = 'done'
    WHERE Task_id IN (
        SELECT Task.Task_id
        FROM Task
        INNER JOIN Assign_to ON Task.Task_id = Assign_to.task_id
        WHERE Assign_to.[user_id] = @user_id
          AND Task.name = @title
    );
END;

GO
--6) View task status given the @user_id and the @creator of the task. (The recently created reports
--should be shown first). (Clara Amir)
CREATE PROCEDURE ViewTask 
    @user_id int,
    @creator int
AS
BEGIN
    SELECT Task.*
    FROM Task
    INNER JOIN Assign_to 
    ON Task.Task_id = Assign_to.task_id
        WHERE Assign_to.[user_id] = @user_id
              AND Task.creator = @creator
    ORDER BY Task.creation_date DESC
END;

GO
--7) View device charge (Clara Amir)
CREATE PROCEDURE ViewMyDeviceCharge 
    @device_id int
AS
BEGIN
    DECLARE @charge int, @location int;

    SELECT @charge = battery_status, @location = room
    FROM Device
    WHERE device_id = @device_id;

    SELECT @charge AS charge, @location AS location;
END;

GO
--8) Book a room with other users.(Clara Amir)
CREATE PROCEDURE AssignRoom
    @user_id INT,
    @room_id INT
AS
BEGIN
    UPDATE Users
    SET room = @room_id
    WHERE id = @user_id;
END;

GO
--9) Book a room with other users.(Clara Amir)
CREATE PROCEDURE CreateEvent
    @event_id INT ,
    @user_id INT,
    @name VARCHAR(50),
    @description VARCHAR(200),
    @location VARCHAR(40),
    @reminder_date DATETIME,
    @other_user_id INT
AS
BEGIN
    IF @user_id IS NOT NULL And @user_id in (select id from users)
    INSERT INTO Calender
            (event_id, user_assigned_to, [name], describtion, [location], reminder_date)
        VALUES
            (@event_id, @user_id, @name, @description, @location, @reminder_date)
    IF @other_user_id IS NOT NULL And @other_user_id in (select id from users)
    BEGIN
         INSERT INTO Calender
            (event_id, user_assigned_to, [name], describtion, [location], reminder_date)
        VALUES
            (@event_id, @other_user_id, @name, @description, @location, @reminder_date)
    END;
END;

GO
--10) Assign user to attend event. (Clara Amir)
-- this procedure assigns a user to attend an event and retrieves event details.
CREATE PROCEDURE AssignUser
  @user_id INT,
  @event_id INT
AS
BEGIN
          DECLARE @name VARCHAR(20);
          DECLARE @describtion VARCHAR(60);
          DECLARE @location VARCHAR(60);
          DECLARE @reminder_date DATETIME;
      SELECT TOP 1 @name = [name], @describtion = describtion, @location = [location], @reminder_date = reminder_date
      FROM Calender
      WHERE event_id = @event_id;
      INSERT INTO Calender (user_assigned_to, event_id, [name], describtion, [location], reminder_date)
      VALUES (@user_id, @event_id, @name, @describtion, @location, @reminder_date);
  SELECT @user_id AS user_id, @event_id AS event_id, @name AS name, @describtion AS describtion, @location AS location, @reminder_date AS reminder_date;
END;

GO
--11) Add a reminder to a task. (Clara Amir)
CREATE PROCEDURE AddReminder
    @task_id int,
    @reminder datetime
AS
BEGIN
    UPDATE Task
    SET reminder_date = @reminder
    WHERE Task_id = @task_id;
END;

GO
--12) Uninvite a specific user to an event (Clara Amir)
CREATE PROCEDURE Uninvited 
    @event_id int,
    @user_id int
AS
BEGIN
    DELETE FROM Calender
    WHERE event_id = @event_id
      AND user_assigned_to = @user_id;
END;

GO
--13) Update the deadline of a specific task. (Clara Amir)
CREATE PROCEDURE UpdateTaskDeadline 
    @deadline datetime,
    @task_id int
AS
BEGIN
    UPDATE Task
    SET due_date = @deadline
    WHERE Task_id = @task_id;
END;

GO
--14) View their event given the @event_id and if the @event_id is empty then view all events that
--belong to the user order by their date.
CREATE PROC ViewEvent
    @user_id INT,
    @Event_id INT
AS
BEGIN
    IF @Event_id IS NULL
    BEGIN
        SELECT *
        FROM Calendar
        WHERE user_assigned_to = @user_id;
    END
    ELSE
    BEGIN
        SELECT *
        FROM Calendar
        WHERE user_assigned_to = @user_id AND event_ID = @Event_id;
    END
END;

GO
--14) View their event given the @event_id and if the @event_id is empty then view all events that
--belong to the user order by their date.(Marina Emil)
CREATE PROC ViewEvent
    @User_id INT,
    @Event_id INT
AS
BEGIN
    IF @Event_id IS NULL
    BEGIN
        SELECT *
        FROM Calender
        WHERE user_assigned_to = @User_id 
        ORDER BY reminder_date;
    END
    ELSE
    BEGIN
        SELECT *
        FROM Calender
        WHERE user_assigned_to = @User_id AND event_id = @Event_id;
    END
END;

GO
--15) View users that have no recommendations.(Marina Emil)
CREATE PROC  ViewRecommendation
AS
BEGIN
SELECT U.f_Name,U.l_name
FROM Users U
LEFT OUTER JOIN  Recommendation r1
on U.id= r1.user_id
WHERE r1.user_id IS NULL;
END;

GO
--16) Create new note.(Marina Emil)
CREATE PROCEDURE CreateNote
    @User_id INT,
    @note_id INT,
    @title VARCHAR(50),
    @Content VARCHAR(500),
    @creation_date DATETIME
AS
BEGIN
SET IDENTITY_INSERT Notes ON;
INSERT INTO Notes(id,user_id,content,creation_date,title)
VALUES(@note_id,@User_id,@Content,@creation_date,@title);
SET IDENTITY_INSERT Notes OFF;
END;

GO
--17) Receive a transaction.(Marina Emil)
CREATE PROCEDURE ReceiveMoney
    @sender_id INT,
    @type VARCHAR(30),
    @amount DECIMAL(13,2),
    @status VARCHAR(10),
    @date datetime
AS
BEGIN
INSERT INTO Finance (user_id,type , amount, status, date)
    VALUES (@sender_id, @type, @amount, @status, @date);
END;

GO
--18) Create a payment on a specific date from one user to the other, each with their separate records(Based on the nature of the schema this can only be done by inserting the record twice, once
--for each user).(Marina Emil)
CREATE PROCEDURE PlanPayment
    @sender_id INT,
    @receiver_id INT,
    @amount DECIMAL(13,2),
    @status VARCHAR(10),
    @deadline DATETIME
AS
BEGIN
    INSERT INTO Finance (user_id, amount, status, deadline)
    VALUES (@sender_id,  @amount, @status, @deadline);

    INSERT INTO Finance (user_id, amount,  status, deadline)
    VALUES (@receiver_id, @amount,  @status, @deadline);
END;


GO
--19) Send message to user.(Marina Emil)
CREATE PROCEDURE SendMessage
@sender_id int,
@receiver_id int,
@title varchar(30),
 @content Varchar(200),
 @timesent time,
 @timereceived time
 AS
 BEGIN
 INSERT INTO Communication (sender_id, receiver_id, title, content, time_sent, time_received)
    VALUES (@sender_id, @receiver_id, @title, @content, @timesent, @timereceived);
END;

GO
--20) Change note title for all notes user created(Marina Emil)
CREATE PROCEDURE  NoteTitle
@user_id int, 
@note_title varchar(50)
AS
BEGIN
UPDATE Notes
SET title = @note_title
WHERE user_id = @user_id;
END;

GO
--21) Show all messages received from a spacific user.(Marina Emil)
CREATE PROCEDURE ShowMessages
@user_id int,
@sender_id int
AS
BEGIN
SELECT *
FROM Communication 
WHERE
sender_id = @sender_id AND receiver_id= @user_id
END;

GO
--1) See details of all users and filter them by @user_type(Marina Emil)
CREATE PROCEDURE ViewUsers
@user_type varchar(20)
AS
BEGIN
SELECT *
FROM
Users
WHERE [type] = @user_type;
END;

GO
--2) Remove an event from the system.(Marina Emil)
CREATE PROCEDURE RemoveEvent
    @event_id INT,
    @user_id INT
AS
BEGIN
DELETE FROM Calender
WHERE event_ID= @event_id AND  user_assigned_to = @user_id;
END;

GO
--3) Create schedule for the rooms.(Marina Emil)
CREATE PROCEDURE CreateSchedule
    @creator_id INT,
    @room_id INT,
    @start_time DATETIME,
    @end_time DATETIME,
    @action VARCHAR(20)
AS
BEGIN
    INSERT INTO RoomSchedule (creator_id, room, start_time, end_time, action)
    VALUES (@creator_id, @room_id, @start_time, @end_time, @action);
END;

GO
--4) Remove a guest from the system.(Marina Emil)
CREATE PROCEDURE GuestRemove 
    @guest_id int,
    @admin_id int,
    @number_of_allowed_guests INT OUTPUT
AS
BEGIN
IF @guest_id IS NOT NULL AND @admin_id IS NOT NULL AND
(EXISTS(SELECT * FROM Guest WHERE guest_id =@guest_id))
AND (EXISTS (SELECT * FROM Admin WHERE admin_id =@admin_id))
BEGIN
    DELETE 
    FROM Users
    WHERE id = @guest_id;
    DECLARE @C int;
    SELECT @C =COUNT(*)
    FROM Guest
    WHERE guest_of =@guest_id
    DECLARE @L int
    SELECT @L = @number_of_allowed_guests
    FROM Admin
    WHERE admin_id = @admin_id;
    SET @number_of_allowed_guests=@L - @C;
    END
    ELSE
    PRINT 'Enter :'
END;

GO
--5) Recommend travel destinations for guests under certain age(Marina Emil)
CREATE PROCEDURE RecommendTD
    @Guest_id INT,
    @destination VARCHAR(10),
    @age INT,
    @preference_no INT
AS
BEGIN
    INSERT INTO Recommendation (user_id, category, preference_No, content)
    VALUES (@Guest_id, 'Travel', @preference_no, @destination);
 END;

 GO
 --6) Access cameras in the house.(Marina Emil)
CREATE PROCEDURE Servailance
    @user_id INT,
    @location INT,
    @camera_id INT
AS
BEGIN
        INSERT INTO Camera(monitor_id, camera_id, room_id)
        VALUES (@user_id,@camera_id,@location);
END;

GO
--7) Change status of room.(Sandra Narmer)
CREATE PROCEDURE RoomAvailability
@location INT,
@status VARCHAR(40)
AS
BEGIN
UPDATE Room
SET status= @status
WHERE room_id = @location;
END;

GO
--8) Create an inventory for a specific item.(Sandra Narmer)
CREATE PROCEDURE Sp_Inventory
    @item_id INT,
    @name VARCHAR(30),
    @quantity INT,
    @expirydate DATETIME,
    @price DECIMAL(10,2),
    @manufacturer VARCHAR(30),
    @category VARCHAR(20)
AS
BEGIN
SET IDENTITY_INSERT Inventory ON;
    INSERT INTO Inventory (supply_id, name, quantity, expiry_date, price, manufacturer, category)
    VALUES (@item_id, @name, @quantity, @expirydate, @price, @manufacturer, @category);
    SET IDENTITY_INSERT Inventory OFF;
END;

GO
--9) Calculate price of purchasing a certain item.(Sandra Narmer)
CREATE PROCEDURE Shopping
@id int , 
@quantity int , 
@total_price decimal(10,2) OUTPUT
AS
BEGIN
    SELECT @total_price = price * @quantity
    FROM Inventory
    WHERE supply_id = @id;
END;

GO
--10) If current user had an activity set its duration to 1 hour.(Sandra Narmer)
CREATE PROCEDURE LogActivityDuration
@room_id int ,
@device_id int, 
@user_id int,
@date datetime, 
@duration VARCHAR(50)
AS
BEGIN
INSERT INTO Log(room_id,device_id,user_id,date,duration)
VALUES(@room_id,@device_id,@user_id,@date,@duration)
UPDATE Log
SET duration = '1 HOUR'
WHERE user_id = @user_id
AND date=@date;
END;

GO
--11) Set device consumption for all tablets.(Sandra Narmer)
CREATE PROCEDURE TabletConsumption
@consumption int
AS
BEGIN
UPDATE Device
SET battery_status=@consumption
WHERE type ='tablet';
END;

GO
--12) Make preferences for Room temperature to be 30 if a user is older then 40 .hint : ussenestedquery
--(Sandra Narmer)
CREATE PROCEDURE MakePreferencesRoomTemp
    @user_id INT,
    @category VARCHAR(20),
    @preferences_number INT
AS
BEGIN
INSERT INTO Preferences (user_id, category, preference_no)
VALUES (@user_id, @category, @preferences_number);
END;

GO
--13) View Log entries involving the user.(Sandra Narmer)
CREATE PROCEDURE ViewMyLogEntry
@user_id int
AS 
BEGIN
SELECT L.*
FROM Log L
WHERE user_id=@user_id;
END;

GO
--14) Update log entries involving the user.(Sandra Narmer)
CREATE PROCEDURE UpdateLogEntry
    @user_id INT,
    @room_id INT,
    @device_id INT,
    @activity VARCHAR(30)
AS
BEGIN
    UPDATE Log
    SET activity = @activity ,room_id = @room_id,device_id = @device_id
    WHERE user_id = @user_id;
END;

GO
--15) View rooms that are not being used.(Sandra Narmer)
CREATE PROCEDURE ViewRoom
AS
BEGIN
    SELECT R.*
    FROM Room R
    RIGHT OUTER JOIN Users U ON R.room_id=U.room
    WHERE U.id IS NULL;
END;

GO
--16) View the details of the booked rooms given @user_id and @room_id . (If @room_id is not booked
--then show all rooms that are booked by this user).(Sandra Narmer)
CREATE PROCEDURE ViewMeeting
    @room_id INT,
    @user_id INT
AS
BEGIN
    SELECT activity
    FROM
        Rooms 
        INNER JOIN Log L ON R.room_id = L.room_id
        INNER JOIN Users U ON R.room_id = U.room
    WHERE
        R.room_id = @room_id
    SELECT U.f_Name,U.l_name
    FROM
        Users U
    WHERE
      U.id = @user_id
END;

GO
--17) Add to the tasks.(Sandra Narmer)
CREATE PROCEDURE AdminAddTask
    @user_id INT,
    @creator INT,
    @name VARCHAR(30),
    @category VARCHAR(20),
    @priority INT,
    @status VARCHAR(20),
    @reminder DATETIME,
    @deadline DATETIME,
    @other_user VARCHAR(20)
AS
BEGIN

    INSERT INTO Task ([name], due_date, category, creator, [status], reminder_date, priority)
    VALUES (@name, @deadline, @category, @creator, @status, @reminder, @priority);

END;

GO
--18) Add Guests to the system , generate passwords for themand reserve rooms under their name.(Sandra Narmer)
CREATE PROCEDURE AddGuest
    @email VARCHAR(30),
    @first_name VARCHAR(10),
    @address VARCHAR(30),
    @password VARCHAR(30),
    @guest_of INT,
    @room_id INT,
    @number_of_allowed_guests INT OUTPUT
AS
BEGIN
 UPDATE Admin
 SET no_of_guests_allowed = @number_of_allowed_guests + 1
 WHERE admin_id = @guest_of;

 INSERT INTO Users(email,f_Name,password,room)
 VALUES(@email,@first_name,@password,@room_id);
END;

GO
--19) Assign task to a specific User.(Sandra Narmer)
CREATE PROCEDURE AssignTask
    @user_id INT,
    @task_id INT,
    @creator_id INT
AS
BEGIN
    INSERT INTO Assign_to (admin_id, task_id, user_id)
    VALUES (@creator_id, @task_id, @user_id);
END;

GO
--20) Delete last message sent.(Sandra Narmer)
CREATE PROCEDURE DeleteMsg
AS
BEGIN
    WITH Latest AS (
        SELECT TOP 1 message_id
        FROM Communication
        WHERE receiver_id IS NOT NULL  -- Assuming NULL indicates messages not yet received
        ORDER BY time_received DESC
    )
    DELETE FROM Communication
    WHERE message_id IN (SELECT message_id FROM Latest);
END;

GO
-- 21) Add outgoing flight itinerary for a specific flight.(Fatma Fouad)
CREATE PROCEDURE AddItinerary @trip_no INT, @flight_num VARCHAR(30), @flight_date DATETIME ,@destination VARCHAR(40)
AS
BEGIN
SET IDENTITY_INSERT Travel ON;
    INSERT INTO Travel (trip_no, outgoing_flight_num, outgoing_flight_date, destination)
    VALUES (@trip_no, @flight_num, @flight_date, @destination);
    SET IDENTITY_INSERT Travel OFF;
END;

GO
-- 22) Change flight date to next year for all flights in current year.(Fatma Fouad)
CREATE PROCEDURE ChangeFlight
AS
BEGIN
    UPDATE Travel
    SET ingoing_flight_date = DATEADD(YEAR, 1, outgoing_flight_date)
    WHERE YEAR(ingoing_flight_date) = YEAR(GETDATE());

    UPDATE Travel
    SET outgoing_flight_date = DATEADD(YEAR, 1, outgoing_flight_date)
    WHERE YEAR(outgoing_flight_date) = YEAR(GETDATE());
END;

GO
-- 23) Update incoming flights.(Fatma Fouad)
CREATE PROCEDURE UpdateFlight @date DATETIME, @trip_no INT, @destination VARCHAR(15)
AS
BEGIN
    UPDATE Travel
    SET ingoing_flight_date = @date, destination = @destination
    WHERE trip_no = @trip_no;
END;

GO
-- 24) Add a new device.(Fatma Fouad)
CREATE PROCEDURE AddDevice @device_id INT, @status VARCHAR(20), @battery INT,@location INT, @type VARCHAR(20)
AS
BEGIN
SET IDENTITY_INSERT Device ON;
    INSERT INTO Device (device_id, room, type, status, battery_status)
    VALUES (@device_id, @location, @type, @status, @battery);
    SET IDENTITY_INSERT Device OFF;
END;

GO
-- 25) Find the location of all devices out of battery.(Fatma Fouad)
CREATE PROCEDURE OutOfBattery
AS
BEGIN
    SELECT R.*
    FROM Device D INNER JOIN Room R ON D.room = R.room_id
    WHERE battery_status = 0;
END;

GO
-- 26) Set the status of all devices out of battery to charging.(Fatma Fouad)
CREATE PROCEDURE Charging
AS
BEGIN
    UPDATE Device
    SET status = 'Charging'
    WHERE status = 'out of battery';
END;

GO
-- 27) Set the number of allowed guests for an admin.(Fatma Fouad)
CREATE PROCEDURE GuestsAllowed @admin_id INT, @number_of_guests INT
AS
BEGIN
    UPDATE Admin
    SET no_of_guests_allowed = @number_of_guests
    WHERE admin_id = @admin_id;
END;

GO
-- 28) Add a penalty for all unpaid transactions where the deadline has passed.(Fatma Fouad)
CREATE PROCEDURE Penalize @Penalty_amount INT
AS
BEGIN
    UPDATE Finance
    SET penalty = @Penalty_amount
    WHERE deadline < GETDATE();
END;

GO
-- 29) Get the number of all guests currently present for a certain admin.(Fatma Fouad)
CREATE PROCEDURE GuestNumber @admin_id INT
AS
BEGIN
    SELECT COUNT(*)
    FROM Guest G
    WHERE G.guest_of = @admin_id AND GETDATE() BETWEEN arrival_date AND departure_date;
END;

GO
-- 30) Get the youngest user in the system.
CREATE PROCEDURE Youngest
AS
BEGIN
    SELECT TOP 1 *
    FROM Users
    ORDER BY age;
END;

GO
-- 31) Get the users whose average income per month is greater then a specific amount.(Fatma Fouad)
CREATE PROCEDURE AveragaPayment @amount DECIMAL(10,2)
AS
BEGIN
    SELECT U.f_Name, U.l_name
    FROM Users U INNER JOIN Admin A ON U.id = A.admin_id
    WHERE (SELECT AVG(salary) FROM Admin WHERE admin_id = U.id) > @amount;
END;

GO
-- 32) Get sum the sum of all purchases needed in the home inventory .(Fatma Fouad)
CREATE PROCEDURE Purchase
AS
BEGIN
    SELECT SUM(price)
    FROM Inventory
    WHERE quantity = 0;
END;

GO
-- 33) Get the location where more then two devices have a dead battery.(Fatma Fouad)
CREATE PROCEDURE NeedCharge
AS
BEGIN
    SELECT R.*
    FROM Device D INNER JOIN Room R ON D.room = R.room_id
    WHERE D.battery_status = 0
    GROUP BY D.device_id, R.room_id, R.type, R.floor, R.status
    HAVING COUNT(D.device_id) > 2;
END;

GO
-- 34) Get the admin with more then 2 guests.(Fatma Fouad)
CREATE PROCEDURE Admins
AS
BEGIN
    SELECT U.f_Name, U.l_Name
    FROM Users U INNER JOIN Admin A ON U.id = A.admin_id
    WHERE A.no_of_guests_allowed > 2;
END;