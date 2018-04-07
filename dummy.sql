insert into Employee( Password, Name, DOB, Gender, Address, PhoneNo, Salary, DOJ,Bank) 
      values ('A12aaaaaaa#','Sooraj Tom','1996-02-28','M','Kandathil House','919928472188','70000','2018-02-28','SBI');
insert into Employee( Password, Name, DOB, Gender, Address, PhoneNo, Salary, DOJ,Bank) 
      values ('A12aaaaaa@','Clint Antony','1996-05-12','M','Neymelil House','919999999999','68000','2017-02-28','SBU');
insert into Employee( Password, Name, DOB, Gender, Address, PhoneNo, Salary, DOJ,Bank) 
      values ('Bla1234!','Libin N George','1996-06-12','M','Neymelil House','919999999998','72000','2017-01-28','SBI');
insert into Employee( Password, Name, DOB, Gender, Address, PhoneNo, Salary, DOJ,Bank)
      values ('Bla1234!','Luke Skywalker','1986-06-12','M','Tatooine','919999999997','100000','2010-01-28','SBI');
insert into Employee( Password, Name, DOB, Gender, Address, PhoneNo, Salary, DOJ,Bank)
      values ('aaaa3aaa','Padme Amidala','1987-06-12','F','Tatooine','919999999997','70000','2010-01-28','Canara');
insert into Employee( Password, Name, DOB, Gender, Address, PhoneNo, Salary, DOJ,Bank)
      values ('Bla1234!','Yoda','1986-06-12','M','Nowhere','919999999990','100000','2010-01-28','LSF');
insert into Employee( Password, Name, DOB, Gender, Address, PhoneNo, Salary, DOJ,Bank)
      values ('aaa222212','Wandu','1987-06-12','F','Everywhere','919999999997','70000','2010-01-28','LSF');

insert into Technician 
      values (1,'Engine');

insert into Pilot
      values (3,1);

insert into Other
      values (2,'HR');


insert into Manages
      values(4,3),(4,2);

insert into Airport( Latitude, Longitude, Name, City,Country) 
      values (51.47,-0.46,"London Heathrow Airport","London", "United Kingdom");
insert into Airport( Latitude, Longitude, Name, City,Country) 
      values (68.53,-89.80,"Kugaaruk Airport","Pelly Bay", "Canada");
insert into Airport( Latitude, Longitude, Name, City,Country) 
      values (28.20,83.98,"Pokhara Airport","Pokhara", "Nepal");
insert into Airport( Latitude, Longitude, Name, City,Country) 
      values (53.55,10.00,"Hamburg Hbf","Hamburg", "Germany");


-- insert into Model (Name, Economy, Business, FirstClass, CargoLimit, Manufacturer) 
--       values ('Boeing 747 8',700,600,467,3000,'Boeing');
-- insert into Model (Name, Economy, Business, FirstClass, CargoLimit, Manufacturer) 
--       values ('Boeing 777 200ER',440,400,301,5000,'Boeing');
-- insert into Model (Name, Economy, Business, FirstClass, CargoLimit, Manufacturer) 
--       values ('Airbus A340 300',295,267,0,10000,'Airbus Industrie');
-- insert into Model (Name, Economy, Business, FirstClass, CargoLimit, Manufacturer) 
--       values ('Airbus A340 600',420,380,0,10000,'Airbus Industrie');


insert into Model (Name, Economy, Business, FirstClass, CargoLimit, Manufacturer) 
      values ('Boeing 747 8',100,100,100,3000,'Boeing');
insert into Model (Name, Economy, Business, FirstClass, CargoLimit, Manufacturer) 
      values ('Boeing 777 200ER',12,10,10,5000,'Boeing');
insert into Model (Name, Economy, Business, FirstClass, CargoLimit, Manufacturer) 
      values ('Airbus A340 300',11,11,10,10000,'Airbus');
insert into Model (Name, Economy, Business, FirstClass, CargoLimit, Manufacturer) 
      values ('Airbus A340 600',11,10,10,10000,'Airbus');

insert into Plane( Model, Inducted_on) 
      values (1,'2011-10-11',);
insert into Plane( Model, Inducted_on) 
      values (2,'2011-11-18',);
insert into Plane( Model, Inducted_on) 
      values (2,'2013-04-11',);
insert into Plane( Model, Inducted_on) 
      values (3,'2014-06-01',);


insert into Seat(Class,SeatNo,PlaneID)
      values ('Economy','E1',1);
insert into Seat(Class,SeatNo,PlaneID)
      values ('Economy','E2',1);
insert into Seat(Class,SeatNo,PlaneID)
      values ('Economy','E3',1);
insert into Seat(Class,SeatNo,PlaneID)
      values ('Economy','E4',1);
insert into Seat(Class,SeatNo,PlaneID)
      values ('Economy','E5',1);
insert into Seat(Class,SeatNo,PlaneID)
      values ('Business','B1',1);
insert into Seat(Class,SeatNo,PlaneID)
      values ('Business','B2',1);
insert into Seat(Class,SeatNo,PlaneID)
      values ('Business','B3',1);
insert into Seat(Class,SeatNo,PlaneID)
      values ('FirstClass','F1',1);
insert into Seat(Class,SeatNo,PlaneID)
      values ('FirstClass','F2',1);

insert into Seat(Class,SeatNo,PlaneID)
      values ('Economy','E1',2);
insert into Seat(Class,SeatNo,PlaneID)
      values ('Economy','E2',2);
insert into Seat(Class,SeatNo,PlaneID)
      values ('Economy','E3',2);
insert into Seat(Class,SeatNo,PlaneID)
      values ('Economy','E4',2);
insert into Seat(Class,SeatNo,PlaneID)
      values ('Economy','E5',2);
insert into Seat(Class,SeatNo,PlaneID)
      values ('Business','B1',2);
insert into Seat(Class,SeatNo,PlaneID)
      values ('Business','B2',2);
insert into Seat(Class,SeatNo,PlaneID)
      values ('Business','B3',2);
insert into Seat(Class,SeatNo,PlaneID)
      values ('FirstClass','F1',2);
insert into Seat(Class,SeatNo,PlaneID)
      values ('FirstClass','F2',2);

insert into Seat(Class,SeatNo,PlaneID)
      values ('Economy','E1',3);
insert into Seat(Class,SeatNo,PlaneID)
      values ('Economy','E2',3);
insert into Seat(Class,SeatNo,PlaneID)
      values ('Economy','E3',3);
insert into Seat(Class,SeatNo,PlaneID)
      values ('Economy','E4',3);
insert into Seat(Class,SeatNo,PlaneID)
      values ('Economy','E5',3);
insert into Seat(Class,SeatNo,PlaneID)
      values ('Business','B1',3);
insert into Seat(Class,SeatNo,PlaneID)
      values ('Business','B2',3);
insert into Seat(Class,SeatNo,PlaneID)
      values ('Business','B3',3);
insert into Seat(Class,SeatNo,PlaneID)
      values ('FirstClass','F1',3);
insert into Seat(Class,SeatNo,PlaneID)
      values ('FirstClass','F2',3);

insert into Seat(Class,SeatNo,PlaneID)
      values ('Economy','E1',4);
insert into Seat(Class,SeatNo,PlaneID)
      values ('Economy','E2',4);
insert into Seat(Class,SeatNo,PlaneID)
      values ('Economy','E3',4);
insert into Seat(Class,SeatNo,PlaneID)
      values ('Economy','E4',4);
insert into Seat(Class,SeatNo,PlaneID)
      values ('Economy','E5',4);
insert into Seat(Class,SeatNo,PlaneID)
      values ('Business','B1',4);
insert into Seat(Class,SeatNo,PlaneID)
      values ('Business','B2',4);
insert into Seat(Class,SeatNo,PlaneID)
      values ('Business','B3',4);
insert into Seat(Class,SeatNo,PlaneID)
      values ('FirstClass','F1',4);
insert into Seat(Class,SeatNo,PlaneID)
      values ('FirstClass','F2',4);


insert into Inspection(Technician,PlaneID,Date)
      values (1,1,'2015-10-10');
insert into Inspection(Technician,PlaneID,Date)
      values (1,2,'2015-10-10');
insert into Inspection(Technician,PlaneID,Date)
      values (1,3,'2015-10-15');


insert into  Customer_profile(Password,Name,DOB,Gender,Address,PhoneNo,PassportNo,MilesTravelled)
      values ('aA1234!','Han Solo','1935-10-15','M','Mos Eisley Spaceport',04852345678,1122335566,20);

insert into  Customer_profile(Password,Name,DOB,Gender,Address,PhoneNo,PassportNo,MilesTravelled)
      values ('aA1234!','Leia Organa','1960-12-15','F','Alderaan',04852345679,1122335567,50);

insert into Customer_phone_nos(CustomerID,PhoneNo)
      values (1,918888899999);

insert into Loyalty_type 
      values ('Golden',1000,30,0,'active');

insert into Payment(Amount,Cash,Bank,TransactionID,Description) 
      values (-10000000,'N',2,12345678,'Plane Purchase');
insert into Payment(Amount,Cash,Description) 
      values (+10000,'Y','Ticket Booking');
insert into Payment(Amount,Cash,Description) 
      values (+11000,'Y','Ticket Booking');
insert into Payment(Amount,Cash,Description) 
      values (+5000,'Y','Cargo Booking');
insert into Payment(Amount,Cash,Description) 
      values (+72000,'Y','Salary');

insert into Scheduled_flight(PlaneID,Start,Dest,DOD,DOA,TOD,TOA,Status,Price) 
      values (1,1,2,'2018-03-01','2018-03-01','05:10:00','15:20:00','ON-TIME',30000);
insert into Scheduled_flight(PlaneID,Start,Dest,DOD,DOA,TOD,TOA,Status,Price) 
      values (1,2,3,'2018-03-02','2018-03-02','05:10:00','15:20:00','ON-TIME',30000);
insert into Scheduled_flight(PlaneID,Start,Dest,DOD,DOA,TOD,TOA,Status,Price) 
      values (2,2,3,'2018-02-02','2018-02-02','05:10:00','15:20:00','ON-TIME',30000);

insert into Commenced_flight(ID,DOD,DOA,TOD,TOA,Status) 
      values (3,'2018-02-02','2018-02-02','05:10:00','15:20:00','ON-TIME');

insert into Booking(PaymentID,CustomerID) 
      values (2,1);
insert into Booking(PaymentID,CustomerID) 
      values (3,2);
insert into Booking(PaymentID,CustomerID) 
      values (4,2);

insert into Ticket(BookingID, FlightID, SeatID, CustomerID) 
      values (1,1,4,1);
insert into Ticket(BookingID, FlightID, SeatID, CustomerID) 
      values (2,2,1,2);
insert into Ticket(BookingID, FlightID, SeatID, CustomerID) 
      values (1,2,2,1);
insert into Ticket(BookingID, FlightID, SeatID, CustomerID) 
      values (2,2,3,2);

insert into Cargo( FlightID, OwnerID, Weight, Type, BookingID) 
      values (1,2,5,'Luggage',3);

insert into Crew 
      values (3,1);

insert into Salary_paid 
      values (3,5);
