CREATE PROCEDURE new_user_view (IN ID int,OUT param1 INT)
 BEGIN
  CREATE VIEW cast(ID as string) AS SELECT ;
 END;
//

CREATE FUNCTION check_seat_available (FID int,cl enum('Business','FirstClass','Economy'))
    RETURNS INT
    RETURN (SELECT COUNT(*) FROM Seats WHERE ID NOT IN (SELECT SeatID FROM Tickets WHERE FlightID=FID) and class=cl and planeId=(SELECT PlaneID FROM ScheduledFlights WHERE ID=FID)); 


CREATE PROCEDURE show_flights(IN src int, IN dst int,IN fromDate date,IN toDate date)
 BEGIN 
  IF (fromDate IS NULL) AND (toDate IS NULL) THEN SELECT * FROM ScheduledFlights WHERE Start=src AND Dest = dst;
  ELSEIF (toDate IS NOT NULL) THEN SELECT * FROM ScheduledFlights WHERE Start=src AND Dest = dst AND TOD<= toDate;
  ELSEIF (fromDate IS NOT NULL) THEN SELECT * FROM ScheduledFlights WHERE Start=src AND Dest = dst AND TOD>= fromDate;
  ELSE SELECT * FROM ScheduledFlights WHERE Start=src AND Dest = dst AND TOD<= toDate AND TOD>=fromDate; 
  ENDIF;
 END;
 //

CREATE FUNCTION distance_after_inspection (PID int)
    RETURNS INT 
    BEGIN
    DECLARE distance;
    SET distance = 0;
    REPEAT 
    RETURN (SELECT sum(calculate_distance()) FROM Seats WHERE ID NOT IN (SELECT SeatID FROM Tickets WHERE FlightID=FID) and class=cl and planeId=(SELECT PlaneID FROM ScheduledFlights WHERE ID=FID)); 


CREATE PROCEDURE dorepeat(p1 INT)
  BEGIN
    SET @x = 0;
    REPEAT SET @x = @x + 1; UNTIL @x > p1 END REPEAT;
  END
//
