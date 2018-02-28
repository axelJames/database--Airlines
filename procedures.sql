CREATE PROCEDURE new_user_view (IN ID int,OUT param1 INT)
 BEGIN
  CREATE VIEW cast(ID as string) AS SELECT ;
 END;
//

CREATE FUNCTION check_seat_available (FID int,cl enum('Business','FirstClass','Economy'))
    RETURNS INT
    RETURN (SELECT COUNT(*) FROM Seats WHERE ID NOT IN (SELECT SeatID FROM Tickets WHERE FlightID=FID) and class=cl and planeId=(SELECT PlaneID FROM ScheduledFlights WHERE ID=FID)); 

