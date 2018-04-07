DELIMITER //
CREATE TRIGGER lat_long_check 
BEFORE INSERT ON airports 
FOR EACH ROW 
BEGIN 
 IF ((NEW.latitude <(-90.0)) or (NEW.latitude>90.0) or (NEW.longitude<(-180.0))  or (NEW.longitude>180.0)) THEN 
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid Laitude or Longitude';
  END IF;
END; //

CREATE TRIGGER change_total_distance 
AFTER UPDATE ON commenced_flights  
FOR EACH ROW 
BEGIN 
DECLARE start int;
DECLARE dest int;
DECLARE dist int; 
IF NEW.TOA IS NOT NULL THEN 
SET start = (SELECT Start FROM scheduled_flights WHERE id= NEW.id);
SET dest = (SELECT Dest FROM scheduled_flights WHERE id= NEW.id);
SET dist = (SELECT calculate_distance(@start,@dest));
UPDATE customer_profiles SET miles_travelled = miles_travelled + @dist WHERE id IN (SELECT customer_id FROM tickets WHERE flight_id= New.id);

END IF;
END; //

CREATE TRIGGER increase_price 
AFTER INSERT ON bookings
FOR EACH ROW 
BEGIN 
UPDATE scheduled_flights SET price = price + 100 WHERE id IN (SELECT flight_id FROM tickets WHERE booking_id = New.id);

END; //

CREATE TRIGGER check_seat_availability 
BEFORE INSERT ON tickets  
FOR EACH ROW  
BEGIN 
 IF (SELECT COUNT(*) FROM tickets WHERE seat_id = NEW.seat_id and flight_id = NEW.flight_id) > 0 THEN 
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot book this ticket';
  END IF;
END; //

CREATE TRIGGER check_seat_limit 
BEFORE INSERT ON seats  
FOR EACH ROW  
BEGIN 
 IF (SELECT COUNT(*) FROM seats WHERE plane_id = NEW.plane_id and class = NEW.class)>( CASE NEW.class 
WHEN 'Bussiness' THEN (SELECT business FROM plane_models WHERE id=(SELECT model FROM planes WHERE id=NEW.plane_id))
WHEN 'Economy' THEN (SELECT economy FROM plane_models WHERE id=(SELECT model FROM planes WHERE id=NEW.plane_id))
WHEN 'FirstClass' THEN (SELECT firstclass FROM plane_models WHERE id=(SELECT model FROM planes WHERE id=NEW.plane_id))
END
) THEN 
SIGNAL SQLSTATE VALUE '45000' SET MESSAGE_TEXT = 'Cannot book this ticket';
  END IF;
END; //

delimiter //

create trigger check_Employee_record_validity
before insert on employees
for each row
begin
if (!Valid_Phone_Number(new.phone_no))
then 
begin 
SIGNAL SQLSTATE VALUE '45000'
SET MESSAGE_TEXT = 'Please enter a valid phone number';
end;
end if;
end;
//
delimiter ;

create trigger check_Employee_record_validity
before insert on users
for each row
begin
set @validity = Valid_Password(new.password);
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
before insert on customer_profiles
for each row
begin
if (!Valid_Phone_Number(new.phone_no))
then 
begin 
SIGNAL SQLSTATE VALUE '45000'
SET MESSAGE_TEXT = 'Please enter a valid phone number';
end;
end if;
end;
//
delimiter ;

create trigger check_Customer_phone_Number_Extra
before insert on customer_phone_numbers
for each row
begin
if (!Valid_Phone_Number(new.phone_no))
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
before insert on cargos
for each row
begin
set @TotalWeight = (select sum(weight) from cargos where flight_id = new.flight_id);
set @TotalWeight = (@TotalWeight + new.weight);
set @Cargolimit = (select cargo_limit from plane_models where id = (select model from planes, scheduled_flights where planes.id = scheduled_flights.plane_id and scheduled_flights.id = new.flight_id));
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
before insert on scheduled_flights
for each row
begin
if update_safety(NEW.plane_id, 5000) = 0 then
begin 
SIGNAL SQLSTATE VALUE '45000'
SET MESSAGE_TEXT = 'The Plane is not safe to fly';
end;
end if;
end;
//
delimiter ;

