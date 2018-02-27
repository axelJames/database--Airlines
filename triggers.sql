
DELIMITER //
CREATE TRIGGER bi_user
  BEFORE INSERT ON user
  FOR EACH ROW
BEGIN
  IF NEW.email NOT LIKE '_%@_%.__%' THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Email field is not valid';
  END IF;
END; //
UPDATE animal_count SET animal_count.animals = animal_count.animals+1;
DELIMITER ;
-----------------------------------------------------------------------

DELIMITER //
CREATE TRIGGER lat_long_check 
BEFORE INSERT ON airports 
FOR EACH ROW 
BEGIN 
 IF ((NEW.latitude <(-90.0)) or (NEW.latitude>90.0) or (NEW.longitude<(-180.0))  or (NEW.longitude>180.0)) THEN 
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid lattitude or longitude';
  END IF;
END; //

CREATE TRIGGER change_total_distance 
AFTER UPDATE ON StartedFlights  
FOR EACH ROW 
BEGIN 
DECLARE @start int;
DECLARE @dest int;
DECLARE @dist int; 
IF NEW.TOA IS NOT NULL THEN 
SET @start = SELECT Start FROM ScheduledFlights WHERE ID= NEW.ID;
SET @dest = SELECT Dest FROM ScheduledFlights WHERE ID= NEW.ID;
SET @dist = SELECT calculate_distance(@start,@dest);
UPDATE CustomerProfiles SET milesTravelled = milesTravelled + @dist WHERE ID IN (SELECT CustomerID FROM Tickets WHERE flightID= New.ID);

END IF;
END; //

CREATE TRIGGER increase_price 
AFTER INSERT ON Booking  
FOR EACH ROW 
BEGIN 
UPDATE ScheduledFlights SET Price = Price + 100 WHERE ID IN (SELECT flightID FROM Tickets WHERE BookingID= New.ID);

END; //

CREATE TRIGGER check_seat_availability 
BEFORE INSERT ON Tickets  
FOR EACH ROW  
BEGIN 
 IF (SELECT COUNT(*) FROM tickets WHERE SeatID= NEW.SeatID and flightID= NEW.flightID)>0 THEN 
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot book this ticket';
  END IF;
END; //

CREATE TRIGGER check_seat_limit 
BEFORE INSERT ON Seats  
FOR EACH ROW  
BEGIN 
 IF (SELECT COUNT(*) FROM Seats WHERE planeId= NEW.PlaneId and class= NEW.class)>( CASE NEW.class 
WHEN 'Bussiness' THEN (SELECT Business FROM Model WHERE ID=(SELECT Model FROM Planes WHERE ID=NEW.planeId));
WHEN 'Economy' THEN (SELECT Economy FROM Model WHERE ID=(SELECT Model FROM Planes WHERE ID=NEW.planeId));
WHEN 'FirstClass' THEN (SELECT FirstClass FROM Model WHERE ID=(SELECT Model FROM Planes WHERE ID=NEW.planeId));
END;
) THEN 
SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot book this ticket';
  END IF;
END; //

