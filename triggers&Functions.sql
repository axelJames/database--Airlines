delimiter \\

create trigger check_Employee_phone_Number
before insert on Employees
for each row
begin
if (!Valid_Phone_Number(new.PhoneNo))
then 
begin 
SIGNAL SQLSTATE VALUE '45000'
SET MESSAGE_TEXT = 'Please enter a valid phone number';
end;
end if;
end;
//

create trigger check_Customer_phone_Number
before insert on CustomerProfiles
for each row
begin
if (!Valid_Phone_Number(new.PhoneNo))
then 
begin 
SIGNAL SQLSTATE VALUE '45000'
SET MESSAGE_TEXT = 'Please enter a valid phone number';
end;
end if;
end;
//

create function Valid_Phone(int phNo)
returns bool
deterministic
begin
declare @Validity = bool;
if phNo NOT RLIKE '^(\\+?[0-9]{1,3})?[0-9]{10}$' then
set @Validity = True;
else
set @Validity = False;
end if;
return True;
end;
//

create trigger CargoLimit 
before insert on Cargo
for each row
begin
set @TotalWeight = select sum(Weight) from Cargo where flightID = new.flightID;
set @TotalWeight = @TotalWeight + new.Weight;
set @Cargolimit = select CargoLimit from Model where ID = (select Model from Planes, ScheduledFlights where Planes.ID = ScheduledFlights.PlaneID and ScheduledFlights.ID = new.flightID);
if @TotalWeight > @Cargolimit
then
begin
SIGNAL SQLSTATE. '45000'
SET MESSAGE_TEXT = 'Cargo Limit exceeded';
end;
end if;
end;
//

create trigger check_Customer_Password
before insert on CustomerProfiles
for each row
begin
set @Validity = Valid_Password(new.Password)
case @Validity
when then begin 
SIGNAL SQLSTATE VALUE '45000'
SET MESSAGE_TEXT = 'Please enter a password having a special character';
end;
when then begin 
SIGNAL SQLSTATE VALUE '45000'
SET MESSAGE_TEXT = 'Please enter a password having a number';
end;
else begin 
SIGNAL SQLSTATE VALUE '45000'
SET MESSAGE_TEXT = CONCAT('Please enter a password of length', @Validity);
end;
end case;
end;
//

create function Valid_Password(int passwd)
returns int
deterministic
begin
declare @Validity = int;
if phNo NOT RLIKE '^(\\+?[0-9]{1,3})?[0-9]{10}$' then
set @Validity = True;
else
set @Validity = False;
end if;
return True;
end;


#create function LimitExceeded(int wt)
#returns int
#deterministic
#begin
#set @TotalWeight = select sum(Weight) from Cargo where flightID = new.flightID;
#set @TotalWeight = @TotalWeight + new.Weight;
#set @Cargolimit = select CargoLimit from Model where ID = (select Model from Planes, ScheduledFlights where Planes.ID = ScheduledFlights.PlaneID and ScheduledFlights.ID = new.flightID);
#set @validity = bool;
#if @TotalWeight > @Cargolimit
#then set @validity = True;
#else
#set @validity = False;
#end if;
#return @validity;
#end;
#//

SELECT DATEDIFF(Date1, Date2); 

create function distance_between_airports (fromPort int, toPort  int)
	returns int
	deterministic
	begin
	set @fromLat = select latitude from airports where ID = fromPort;
	set @fromLon = select longitude from airports where ID = fromPort;
	set @toLat = select latitude from airports where ID = toPort;
	set @toLon = select longitude from airports where ID = toPort;

	set @fromLat = case 
					when @fromLat < 0 then Radians(90 + @fromLat)
					else Radians(@fromLat)
				   end;

	set @fromLong = case 
					when @fromLong < 0 then Radians(360 + @fromLong)
					else Radians(@fromLong)
				   end;

	set @toLat = case 
					when @toLat < 0 then Radians(90 + @toLat)
					else Radians(@toLat)
				   end;

	set @toLong = case 
					when @toLong < 0 then Radians(360 + @toLong)
					else Radians(@toLong)
				   end;

	set @a = pow(sin((@fromLat - @toLat) / 2), 2) + cos(@fromLat) * cos(@toLat) * pow(sin((@fromLong - @toLong) / 2), 2);
	set @c = 2 * atan2(sqrt(@a), sqrt(1 - @a));

	return (6,371 * @c);
	end;

create procedure Holiday_bonus (in percent int)
	begin
	create or replace view holiday_bonus
	as select ID as EmployeeID, (Salary * percent / 100) as Bonus
	from Employees;
	end;

create procedure Get_seat_list (in flightID int)
	begin 
	set @planeID = select PlaneID from ScheduledFlights where ID = flightID;
	create temporary table Business_Seats select seatNo from Seats where ID not in (select SeatID from Tickets where Tickets.flightID = flightID and Status = 'Active') and class = 'Business'
	create temporary table FirstClass_Seats select seatNo from Seats where ID not in (select SeatID from Tickets where Tickets.flightID = flightID and Status = 'Active') and class = 'FirstClass'
	create temporary table Economy_Seats select seatNo from Seats where ID not in (select SeatID from Tickets where Tickets.flightID = flightID and Status = 'Active') and class = 'Economy'
	end;

create procedure Show_eligible_loyalty_programs (in customerID int)
	begin 
	set @milesTravelled = select milesTravelled from CustomerProfiles where ID = customerID;
	create temporary table Eligible_programs select * from loyaltyType where @milesTravelled >= minimumMiles;
	end;

create procedure distance_travelled_since_last_inspection (in planeID int)
	begin
	set@lastInspectionDate = select max(Date) from Inspection where PlaneID = planeID;
	
	return (with distances_travelled as ( 
			select distance_between_airports(ScheduledFlights.Start, ScheduledFlights.Dest) as distance
			from ScheduledFlights, Doneflights
			where ScheduledFlights.ID = Doneflights.ID and Doneflights.DOA >= @lastInspectionDate and ScheduledFlights.PlaneID = planeID;
		   )
		   select sum(distance)
		   from distances_travelled);

create procedure Cancel_booking (in ticketID int)
	begin
	set @customerID = select customerID from Booking where ID in (select BookingID from Tickets where ID = ticketID);
	update Tickets
	set Status = 'Cancelled'
	where ID = ticketID;
	set @ticketPrice = case (select class from Seats, Tickets where Seats.ID = Ticket.seatID and Ticket.ID = ticketID)
						when 'FirstClass' then 10000
						when 'Business' then 5000
						when 'Economy' then 1000 
						end;

	insert into Payments (Amount, cash, Bank, transactionID, timeStamp)
	values (@ticketPrice * 0.8,'N', 'National Bank of Poor People', 98989898, CURRENT_TIMESTAMP());

	end;

create procedure Cancel_Cargo (in cargoID int)
	begin
	set @customerID = select customerID from Booking where ID in (select BookingID from Cargo where ID = cargoID);
	
	set @cargoPrice = select Amount from Payments, Bookings, Cargo where Payments.ID = Bookings.paymentsID and Booking.ID = Cargo.BookingID;

	insert into Payments (Amount, cash, Bank, transactionID, timeStamp)
	values (@cargoPrice * 0.8,'N', 'National Bank of Poor People', 98989898, CURRENT_TIMESTAMP());

	end;

create procedure Income_expenditure (out Income float, out expediture float, in fromDate date, in toDate date, in type varchar(50) )
	begin
	if type = '' then
	begin
		select sum(amount) into income from Payments where amount > 0 and date(timeStamp) betweem fromDate and toDate;
		select sum(amount) into expediture from Payments where amount < 0 and date(timeStamp) betweem fromDate and toDate;
	end;
	else
	begin
		select sum(amount) into income from Payments where amount > 0 and date(timeStamp) betweem fromDate and toDate and description = type;
		select sum(amount) into expediture from Payments where amount < 0 and date(timeStamp) betweem fromDate and toDate and description = type;
	end;
	end if;
	end;







