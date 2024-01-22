--1
declare @user_id int
EXEC UserRegister  @usertype ='Guest',@email ='CLARAEMAIL',@first_name ='clara',@last_name ='Amir', @birth_date ='10/10/2025',@password ='1234',@user_id =@user_id OUTPUT 
--1
declare @success bit
declare @user_id int 
exec UserLogin @email ='sss',@password ='1234',@success =@success output, @user_id=@user_id output
PRINT @success
PRINT @user_id
--2
EXEC ViewProfile @user_id=2;
  
--4
EXEC ViewMyTask @user_id =2


--5
EXEC FinishMyTask @user_id=2 , @title='Print';

--6
EXEC ViewTask @user_id=2,@creator=3;

--7
EXEC ViewMyDeviceCharge @device_id=1

--8
EXEC AssignRoom @user_id=1 ,@room_id=2

--9
EXEC CreateEvent @event_id=1,@user_id=1,@name='EVENT',@description='DESCRIPTION',@location='NEW GAIRO',@reminder_date='10/10/2025 10:10:10',@other_user_id=2

--10
EXEC AssignUser @user_id=2,@event_id=1

--11
EXEC AddReminder 1,'2023-12-25 10:30:00';

--12
EXEC Uninvited @event_id = 1, @user_id = 3;

--13
EXEC UpdateTaskDeadline @deadline = '2023-12-31 23:59:59', @task_id = 1;

--14
EXEC ViewEvent @User_id =1, @Event_id =NULL;

--15
EXEC ViewRecommendation;

--16
EXEC CreateNote @User_id = 1, @note_id = 101, @title = 'Sample Title', @Content = 'Sample Content', @creation_date = '2023-11-28';

--17
EXEC ReceiveMoney @sender_id=1, @type='Income', @amount=100.00, @status= 'Pending', @date ='2023-12-31';

--18
EXEC PlanPayment @sender_id=1, @receiver_id=2, @amount=200.00, @status='Payment', @deadline='2023-12-31 23:59:59';

--19
EXEC SendMessage @sender_id=1, @receiver_id=2, @title= 'Hello',
@content='This is a sample message', @timesent='12:34:56', @timereceived='12:45:00';

--20
EXEC NoteTitle @user_id=1, @note_title='Updated Title';

--21
EXEC ShowMessages @user_id=2, @sender_id=1;

--1
EXEC ViewUsers @user_type='Admin' ;


--2
EXEC RemoveEvent @event_id=1, @user_id=1;

--3
EXEC CreateSchedule @creator_id =1, @room_id=1,  @start_time='2023-12-31 23:59:59',@end_time='2023-12-31 1:59:59',@action='Action1';

--4
DECLARE @numberOfAllowedGuests INT;
EXEC GuestRemove @guest_id =6, @admin_id=1,@number_of_allowed_guests = @numberOfAllowedGuests OUTPUT;
PRINT @numberOfAllowedGuests;
--5
EXEC RecommendTD @Guest_id=1, @destination='Paris', @age=30, @preference_no=1;

--6
EXEC Servailance @user_id =2,@location=1,@camera_id=1;

--7)
EXEC RoomAvailability @location = 1, @status = 'Under Cleaning';

--8)
EXEC Sp_Inventory @item_id = 12, @name = 'Item1', @quantity = 100, @expirydate = '2023-12-31', @price = 19.99, @manufacturer = ' Manufacturer1', @category = 'Category1';

--9)
DECLARE @total_price DECIMAL(10,2);
EXEC Shopping @id = 1, @quantity = 5, @total_price =@total_price OUTPUT;
PRINT @total_price 

--10)
EXEC LogActivityDuration @room_id = 1, @device_id = 2, @user_id = 1, @date = '2023-01-01 10:00', @duration = 'Original Duration';

--11)
EXEC TabletConsumption @consumption = 60; 

--12)
EXEC MakePreferencesRoomTemp @user_id = 2, @category = 'RoomTemperature', @preferences_number = 3;         

--13)
EXEC ViewMyLogEntry @user_id = 5; 

--14)
EXEC UpdateLogEntry @user_id = 5, @room_id = 1, @device_id = 2, @activity = 'Activity1'; 

--15)
EXEC ViewRoom;

--16)
EXEC ViewMeeting @room_id = NULL, @user_id =11;  

--17)
EXEC AdminAddTask  
@user_id=1,
    @creator = 1,                 
    @name = 'New Task',              
    @category = 'General',        
    @priority = 1,                  
    @status = 'Not Started',        
    @reminder = '2023-01-01 08:00',  
    @deadline = '2023-01-15 17:00',
    @other_user=1;

--18)
DECLARE @number_of_allowed_guests INT;
EXEC AddGuest @email = 'guest@example.com', @first_name = 'John', @address = '123 Main St', @password = 'GuestPassword', @guest_of = 1, @room_id = 1, @number_of_allowed_guests =@number_of_allowed_guests OUTPUT;
PRINT @number_of_allowed_guests 

--19)
EXEC AssignTask @user_id = 2, @task_id = 1, @creator_id = 1;  

--20)
EXEC DeleteMsg;

-- 21
EXEC AddItinerary @trip_no = 100, @flight_num = 16, @flight_date = '2023-12-12',@destination = 'London';

-- 22
EXEC ChangeFlight;

-- 23
EXEC UpdateFlight @date = '2023-12-1', @trip_no = 4, @destination = 'London';

-- 24
EXEC AddDevice @device_id  = 8, @status = 'full battary', @Battery = 100, @location = 1 , @type = 'laptop';

-- 25
EXEC OutOfBattery;

-- 26
EXEC Charging;

-- 27
EXEC GuestsAllowed @admin_id = 5, @number_of_guests = 15;

-- 28
EXEC Penalize @Penalty_amount = 10;

-- 29
EXEC GuestNumber @admin_id = 1;

-- 30
EXEC Youngest;

-- 31
EXEC AveragaPayment @amount = 300.00;

-- 32
EXEC Purchase;

-- 33
EXEC NeedCharge;

-- 34
EXEC Admins;