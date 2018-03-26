CREATE FUNCTION check_seat_available (FID int,cl enum('Business','FirstClass','Economy'))
    RETURNS INT
    RETURN (SELECT COUNT(*) FROM Seat WHERE ID NOT IN (SELECT SeatID FROM Ticket WHERE FlightID=FID) and Class=cl and PlaneId=(SELECT PlaneID FROM Scheduled_flight WHERE ID=FID)); 


CREATE PROCEDURE show_flights(IN src int, IN dst int,IN fromDate date,IN toDate date)
 BEGIN 
  IF ((fromDate IS NULL) AND (toDate IS NULL)) THEN SELECT * FROM Scheduled_flight WHERE Start=src AND Dest = dst;
  ELSEIF (toDate IS NOT NULL) THEN SELECT * FROM Scheduled_flight WHERE Start=src AND Dest = dst AND TOD<= toDate;
  ELSEIF (fromDate IS NOT NULL) THEN SELECT * FROM Scheduled_flight WHERE Start=src AND Dest = dst AND TOD>= fromDate;
  ELSE SELECT * FROM Scheduled_flight WHERE Start=src AND Dest = dst AND TOD<= toDate AND TOD>=fromDate; 
  END IF; 
 END;
 //


delimiter //
create function Valid_Phone_Number(phNo varchar(15))
returns bool
deterministic
begin
declare Validity bool;
if phNo NOT RLIKE '^(\\+?[0-9]{1,3})?[0-9]{10}$' then
set Validity = False;
else
set Validity = True;
end if;
return Validity;
end;
//
delimiter ;

delimiter //
create function Valid_Password(passwd varchar(30))
returns int
deterministic
begin
set  @MinLength = 8;
set  @Validity = 0;
if char_length(passwd) <  MinLength then
set  @Validity =  MinLength;
elseif passwd NOT LIKE '%[0-9]%' then
set  @Validity = 1;
end if;
return  @Validity;
end;//
delimiter ;


SELECT DATEDIFF(Date1, Date2); 

delimiter //
create function distance_between_Airport (fromPort int, toPort  int)
  returns int
  deterministic
  begin
  set  @fromLat = (select Latitude from Airport where ID = fromPort);
  set  @fromLon = (select Longitude from Airport where ID = fromPort);
  set  @toLat = (select Latitude from Airport where ID = toPort);
  set  @toLon = (select Longitude from Airport where ID = toPort);

  set  @fromLat = case 
          when  @fromLat < 0 then Radians(90 +  @fromLat)
          else Radians( @fromLat)
           end;

  set  @fromLong = case 
          when  @fromLong < 0 then Radians(360 +  @fromLong)
          else Radians( @fromLong)
           end;

  set  @toLat = case 
          when  @toLat < 0 then Radians(90 +  @toLat)
          else Radians( @toLat)
           end;

  set  @toLong = case 
          when  @toLong < 0 then Radians(360 +  @toLong)
          else Radians( @toLong)
           end;

  set  @a = pow(sin(( @fromLat -  @toLat) / 2), 2) + cos( @fromLat) * cos( @toLat) * pow(sin(( @fromLong -  @toLong) / 2), 2);
  set  @c = 2 * atan2(sqrt( @a), sqrt(1 -  @a));

  return (6,371 *  @c);
  end; //

delimiter ;

delimiter //
create procedure Holiday_bonus (in percent int)
  begin
  create or replace view holiday_bonus
  as (select (ID as EmployeeID), ((Salary * percent / 100) as Bonus)
  from Employee);
  end;//
delimiter ;

delimiter //
create procedure Get_seat_list (in FlightID int)
  begin 
  declare PlaneId int;
  set PlaneID = (select PlaneID from Scheduled_flight where ID = FlightID);
  create temporary table Business_Seat select SeatNo from Seat where ID not in (select SeatID from Ticket where Ticket.FlightID = FlightID and Status = 'Active') and Class = 'Business';
  create temporary table FirstClass_Seat select SeatNo from Seat where ID not in (select SeatID from Ticket where Ticket.FlightID = FlightID and Status = 'Active') and Class = 'FirstClass';
  create temporary table Economy_Seat select SeatNo from Seat where ID not in (select SeatID from Ticket where Ticket.FlightID = FlightID and Status = 'Active') and Class = 'Economy';
  end;//
delimiter ;

delimiter //
create procedure Show_eligible_loyalty_programs (in customerID int)
  begin 
  set @milesTravelled = (select MilesTravelled from Customer_profile where ID = customerID);
  create temporary table Eligible_programs select * from Loyalty_type where @milesTravelled >= MinimumMiles;
  end;//
delimiter ;

delimiter //
create procedure distance_travelled_since_last_inspection (in PlaneID int)
  begin
  set@lastInspectionDate = (select max(Date) from Inspection where PlaneID = PlaneID);
  
  return (with distances_travelled as ( 
      select distance_between_Airport(Scheduled_flight.Start, Scheduled_flight.Dest) as distance
      from Scheduled_flight, Commenced_flight
      where Scheduled_flight.ID = Commenced_flight.ID and Commenced_flight.DOA >= @lastInspectionDate and Scheduled_flight.PlaneID = PlaneID;
       )
       select sum(distance)
       from distances_travelled);
  end; //
delimiter ;

delimiter //
create procedure Cancel_booking (in ticketID int)
  begin
  set @customerID = (select CustomerID from Booking where ID in (select BookingID from Ticket where ID = ticketID));
  update Ticket
  set Status = 'Cancelled'
  where ID = ticketID;
  set @ticketPrice = (select Price from Ticket where ID = ticketID);

  insert into Payment (Amount, Cash, Bank, TransactionID, TimeStamp)
  values (@ticketPrice * 0.8,'N', 'National Bank of Poor People', 98989898, CURRENT_TIMESTAMP());

  end;//
delimiter ;

delimiter //
create procedure Cancel_Cargo (in cargoID int)
  begin
  declare customerID int;
  set customerID = (select CustomerID from Booking where ID in (select BookingID from Cargo where ID = cargoID));
  
  set @cargoPrice = (select Amount from Payment, Booking, Cargo where Payment.ID = Booking.PaymentID and Booking.ID = Cargo.BookingID);

  insert into Payment (Amount, Cash, Bank, TransactionID, TimeStamp)
  values (@cargoPrice * 0.8,'N', 'National Bank of Poor People', 98989898, CURRENT_TIMESTAMP());

  delete from Cargo where ID = cargoID;

  end;//
delimiter ;

delimiter //
create procedure Income_expenditure (out income float, out expediture float, in fromDate date, in toDate date, in type varchar(30))
  begin
  if type = '' then
  begin
    select sum(Amount) into income from Payment where Amount > 0 and date(TimeStamp) between fromDate and toDate;
    select sum(Amount) into expediture from Payment where Amount < 0 and date(TimeStamp) between fromDate and toDate;
  end;
  else
  begin
    select sum(Amount) into income from Payment where Amount > 0 and date(TimeStamp) between fromDate and toDate and Description = type;
    select sum(Amount) into expediture from Payment where Amount < 0 and date(TimeStamp) between fromDate and toDate and Description = type;
  end;
  end if;
  end;//
delimiter ;