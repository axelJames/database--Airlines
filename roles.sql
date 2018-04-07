CREATE USER DBA@localhost IDENTIFIED BY 'abc';
CREATE ROLE Administrator;
GRANT ALL ON Airlines.* TO Administrator;
GRANT Administrator TO DBA@localhost;

CREATE USER Accountant@localhost IDENTIFIED BY 'abc';
CREATE ROLE SalaryManager;
GRANT ALL ON Airlines.SalaryPaid TO SalaryManager;
GRANT ALL ON Airlines.Payment TO SalaryManager;
GRANT SELECT ON Airlines.Employee TO SalaryManager;
CREATE ROLE BookingsManager;
GRANT ALL ON Airlines.Booking TO BookingsManager;
GRANT ALL ON Airlines.Payment TO BookingsManager;
GRANT SalaryManager TO Accountant@localhost;
GRANT BookingsManager TO Accountant@localhost;

CREATE USER Manager@localhost IDENTIFIED BY 'abc';
CREATE ROLE TeamManager;
GRANT ALL ON Airlines.Manages TO TeamManager;
GRANT ALL ON Airlines.Crew TO TeamManager;
CREATE ROLE EmployeeReader;
GRANT SELECT ON Airlines.Employee TO EmployeeReader;
GRANT SELECT ON Airlines.Pilot TO EmployeeReader;
GRANT SELECT ON Airlines.Technician TO EmployeeReader;
GRANT SELECT ON Airlines.Other TO EmployeeReader;
GRANT TeamManager TO Manager@localhost;
GRANT EmployeeReader TO Manager@localhost;

CREATE USER Operator@localhost IDENTIFIED BY 'abc';
CREATE ROLE Operator;
GRANT ALL ON Airlines.Scheduled_flight TO Operator;
GRANT ALL ON Airlines.Commenced_flight TO Operator;
GRANT ALL ON Airlines.Plane TO Operator;
GRANT ALL ON Airlines.Airport TO Operator;
GRANT ALL ON Airlines.Crew TO Operator;
GRANT ALL ON Airlines.Cargo TO Operator;
GRANT ALL ON Airlines.Seat TO Operator;
GRANT ALL ON Airlines.Model TO Operator;
GRANT Operator TO Operator@localhost;

CREATE USER ReservationPersonnel@localhost IDENTIFIED BY 'abc';
CREATE ROLE Reserve;
GRANT ALL ON Airlines.Ticket TO Reserve;
GRANT ALL ON Airlines.Cargo TO Reserve;
GRANT ALL ON Airlines.Booking TO Reserve;
GRANT SELECT ON Airlines.Plane TO Reserve;
GRANT SELECT ON Airlines.Airport TO Reserve;
GRANT SELECT ON Airlines.Seat TO Reserve;
GRANT SELECT ON Airlines.Scheduled_flight TO Reserve;
GRANT Reserve TO ReservationPersonnel@localhost;

CREATE USER Inspector@localhost IDENTIFIED BY 'abc';
CREATE ROLE Inspector;
GRANT ALL ON Airlines.Inspection TO Inspector;
CREATE ROLE PlaneOverlooker;
GRANT SELECT,UPDATE ON Airlines.Plane TO PlaneOverlooker;
GRANT SELECT ON Airlines.Technician TO PlaneOverlooker;
GRANT SELECT ON Airlines.Model TO PlaneOverlooker;
GRANT Inspector TO Inspector@localhost;
GRANT PlaneOverlooker TO Inspector@localhost;

CREATE USER HR@localhost IDENTIFIED BY 'abc';
CREATE ROLE EmployeeWriter;
GRANT ALL ON Airlines.Employee TO EmployeeWriter;
GRANT ALL ON Airlines.Pilot TO EmployeeWriter;
GRANT ALL ON Airlines.Technician TO EmployeeWriter;
GRANT ALL ON Airlines.Other TO EmployeeWriter;
GRANT SELECT ON Airlines.Salary_paid TO EmployeeWriter;
CREATE ROLE CustomerRelations;
GRANT ALL ON Airlines.Customer_profile TO CustomerRelations;
GRANT ALL ON Airlines.Loyalty_type TO CustomerRelations;
GRANT ALL ON Airlines.Loyalty_profile TO CustomerRelations;
GRANT CustomerRelations TO HR@localhost;
GRANT EmployeeWriter TO HR@localhost;

CREATE ROLE DefaultRole;
GRANT SELECT ON Scheduled_flight TO DefaultRole;
GRANT INSERT ON Customer_profile TO DefaultRole;