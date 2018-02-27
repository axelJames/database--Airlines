CREATE PROCEDURE new_user_view (IN ID int,OUT param1 INT)
 BEGIN
  CREATE VIEW cast(ID as string) AS SELECT ;
 END;
//

CREATE FUNCTION check_seat_available ( CHAR(20))
    RETURNS CHAR(50) DETERMINISTIC
    RETURN CONCAT('Hello, ',s,'!');
