DELIMITER //
CREATE TRIGGER lat_long_check 
BEFORE INSERT ON Airport 
FOR EACH ROW 
BEGIN 
 IF ((NEW.Latitude <(-90.0)) or (NEW.Latitude>90.0) or (NEW.Longitude<(-180.0))  or (NEW.Longitude>180.0)) THEN 
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid Laitude or Longitude';
  END IF;
END; //

CREATE TRIGGER change_total_distance 
AFTER UPDATE ON Commenced_flight  
FOR EACH ROW 
BEGIN 
DECLARE start int;
DECLARE dest int;
DECLARE dist int; 
IF NEW.TOA IS NOT NULL THEN 
SET start = (SELECT Start FROM Scheduled_flight WHERE ID= NEW.ID);
SET dest = (SELECT Dest FROM Scheduled_flight WHERE ID= NEW.ID);
SET dist = (SELECT calculate_distance(@start,@dest));
UPDATE Customer_profile SET MilesTravelled = MilesTravelled + @dist WHERE ID IN (SELECT CustomerID FROM Ticket WHERE FlightID= New.ID);

END IF;
END; //

CREATE TRIGGER increase_price 
AFTER INSERT ON Booking  
FOR EACH ROW 
BEGIN 
UPDATE Scheduled_flight SET Price = Price + 100 WHERE ID IN (SELECT FlightID FROM Ticket WHERE BookingID= New.ID);

END; //

CREATE TRIGGER check_seat_availability 
BEFORE INSERT ON Ticket  
FOR EACH ROW  
BEGIN 
 IF (SELECT COUNT(*) FROM Ticket WHERE SeatID= NEW.SeatID and FlightID= NEW.FlightID)>0 THEN 
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot book this ticket';
  END IF;
END; //

CREATE TRIGGER check_seat_limit 
BEFORE INSERT ON Seat  
FOR EACH ROW  
BEGIN 
 IF (SELECT COUNT(*) FROM Seat WHERE PlaneID= NEW.PlaneID and Class= NEW.Class)>( CASE NEW.Class 
WHEN 'Bussiness' THEN (SELECT Business FROM Model WHERE ID=(SELECT Model FROM Plane WHERE ID=NEW.PlaneID))
WHEN 'Economy' THEN (SELECT Economy FROM Model WHERE ID=(SELECT Model FROM Plane WHERE ID=NEW.PlaneID))
WHEN 'FirstClass' THEN (SELECT FirstClass FROM Model WHERE ID=(SELECT Model FROM Plane WHERE ID=NEW.PlaneID))
END
) THEN 
SIGNAL SQLSTATE VALUE '45000' SET MESSAGE_TEXT = 'Cannot book this ticket';
  END IF;
END; //

delimiter //

create trigger check_Employee_record_validity
before insert on Employee
for each row
begin
if (!Valid_Phone_Number(new.PhoneNo))
then 
begin 
SIGNAL SQLSTATE VALUE '45000'
SET MESSAGE_TEXT = 'Please enter a valid phone number';
end;
end if;
set @validity = Valid_Password(new.Password);
case
when @validity = 1 then begin 
SIGNAL SQLSTATE VALUE '45000'
SET MESSAGE_TEXT = 'Please enter a password having a number';
end;
when @validity > 0 then begin 
SIGNAL SQLSTATE VALUE '45000'
SET MESSAGE_TEXT = 'Please enter a valid password';
end;
end case;
end;
//
delimiter ;



delimiter //
create trigger check_Customer_record_validity
before insert on Customer_profile
for each row
begin
if (!Valid_Phone_Number(new.PhoneNo))
then 
begin 
SIGNAL SQLSTATE VALUE '45000'
SET MESSAGE_TEXT = 'Please enter a valid phone number';
end;
end if;
set @validity = Valid_Password(new.Password);
case
when @validity = 1 then 
begin 
SIGNAL SQLSTATE VALUE '45000'
SET MESSAGE_TEXT = 'Please enter a password having a number';
end;
when @validity > 0 then
begin 
SIGNAL SQLSTATE VALUE '45000'
SET MESSAGE_TEXT = 'Please enter a password of length';
end;
end case;
end;
//
delimiter ;

create trigger check_Customer_phone_Number_Extra
before insert on Customer_phone_nos
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
delimiter ;

delimiter //
create trigger CargoLimit 
before insert on Cargo
for each row
begin
set @TotalWeight = (select sum(Weight) from Cargo where FlightID = new.FlightID);
set @TotalWeight = (@TotalWeight + new.Weight);
set @Cargolimit = (select CargoLimit from Model where ID = (select Model from Plane, Scheduled_flight where Plane.ID = Scheduled_flight.PlaneID and Scheduled_flight.ID = new.FlightID));
if @TotalWeight > @Cargolimit
then
begin
SIGNAL SQLSTATE VALUE '45000'
SET MESSAGE_TEXT = 'Cargo Limit exceeded';
end;
end if;
end;
//

delimiter ;


delimiter //
create trigger check_safety
before insert on Scheduled_flight
for each row
begin
if update_safety(NEW.PlaneID, 5000) = 0 then
begin 
SIGNAL SQLSTATE VALUE '45000'
SET MESSAGE_TEXT = 'The Plane is not safe to fly';
end;
end if;
end;
//
delimiter ;

