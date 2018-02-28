CREATE USER DBA@localhost IDENTIFIED BY 'abc';
CREATE ROLE Administrator;
GRANT ALL ON Airlines.* TO Administrator;
GRANT Administrator TO DBA@localhost;

CREATE USER Accountant@localhost IDENTIFIED BY 'abc';
CREATE ROLE SalaryManager;
GRANT ALL ON Airlines.SalaryPaid TO SalaryManager;
GRANT ALL ON Airlines.Payments TO SalaryManager;
GRANT SELECT ON Airlines.Employees TO SalaryManager;
CREATE ROLE BookingsManager;
GRANT ALL ON Airlines.Booking TO BookingsManager;
GRANT ALL ON Airlines.Payments TO BookingsManager;
GRANT SalaryManager TO Accountant@localhost;
GRANT BookingsManager TO Accountant@localhost;

CREATE USER Manager@localhost IDENTIFIED BY 'abc';
CREATE ROLE TeamManager;
GRANT ALL ON Airlines.Manages TO TeamManager;
GRANT ALL ON Airlines.Crew TO TeamManager;
CREATE ROLE EmployeeReader;
GRANT SELECT ON Airlines.Employees TO EmployeeReader;
GRANT SELECT ON Airlines.Pilots TO EmployeeReader;
GRANT SELECT ON Airlines.Technicians TO EmployeeReader;
GRANT SELECT ON Airlines.Other TO EmployeeReader;
GRANT TeamManager TO Manager@localhost;
GRANT EmployeeReader TO Manager@localhost;

CREATE USER Operator@localhost IDENTIFIED BY 'abc';
CREATE ROLE Operator;
GRANT ALL ON Airlines.ScheduledFlights TO Operator;
GRANT ALL ON Airlines.StartedFlights TO Operator;
GRANT ALL ON Airlines.Planes TO Operator;
GRANT ALL ON Airlines.Airports TO Operator;
GRANT ALL ON Airlines.Crew TO Operator;
GRANT ALL ON Airlines.Cargo TO Operator;
GRANT ALL ON Airlines.Seats TO Operator;
GRANT ALL ON Airlines.Model TO Operator;
GRANT Operator TO Operator@localhost;

CREATE USER ReservationPersonnel@localhost IDENTIFIED BY 'abc';
CREATE ROLE Reserve;
GRANT ALL ON Airlines.Tickets TO Reserve;
GRANT ALL ON Airlines.Cargo TO Reserve;
GRANT ALL ON Airlines.Booking TO Reserve;
GRANT SELECT ON Airlines.Planes TO Reserve;
GRANT SELECT ON Airlines.Airports TO Reserve;
GRANT SELECT ON Airlines.Seats TO Reserve;
GRANT SELECT ON Airlines.ScheduledFlights TO Reserve;
GRANT Reserve TO ReservationPersonnel@localhost;

CREATE USER Inspector@localhost IDENTIFIED BY 'abc';
CREATE ROLE Inspector;
GRANT ALL ON Airlines.Inspection TO Inspector;
CREATE ROLE PlaneOverlooker;
GRANT SELECT,UPDATE ON Airlines.Planes TO PlaneOverlooker;
GRANT SELECT ON Airlines.Technician TO PlaneOverlooker;
GRANT SELECT ON Airlines.Model TO PlaneOverlooker;
GRANT Inspector TO Inspector@localhost;
GRANT PlaneOverlooker TO Inspector@localhost;

CREATE USER HR@localhost IDENTIFIED BY 'abc';
CREATE ROLE EmployeeWriter;
GRANT ALL ON Airlines.Employees TO EmployeeWriter;
GRANT ALL ON Airlines.Pilots TO EmployeeWriter;
GRANT ALL ON Airlines.Technicians TO EmployeeWriter;
GRANT ALL ON Airlines.Other TO EmployeeWriter;
GRANT SELECT ON Airlines.SalaryPaid TO EmployeeWriter;
CREATE ROLE CustomerRelations;
GRANT ALL ON Airlines.CustomerProfiles TO CustomerRelations;
GRANT ALL ON Airlines.loyaltyType TO CustomerRelations;
GRANT ALL ON Airlines.loyaltyProfiles TO CustomerRelations;
GRANT CustomerRelations TO HR@localhost;
GRANT EmployeeWriter TO HR@localhost;

CREATE ROLE DefaultRole;
GRANT SELECT ON ScheduledFlights TO DefaultRole;
GRANT INSERT ON CustomerProfiles TO DefaultRole;