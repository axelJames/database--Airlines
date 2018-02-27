create table Employees(
                        ID         int auto_increment  not null,
                        Password   varchar(30) not null default 'judeBourne',
                        Name       varchar(30) not null,
                        DOB        date not null,
                        Gender     enum('M', 'F', 'Other') not null,
                        Address    varchar(30) not null,
                        PhoneNo    numeric(13, 0) not null,
                        Salary     float not null default 0.0,
                        DOJ        date not null,
                        primary key(ID)
                    );

create table Technician(
                        ID      int not null,
                        AOExp   varchar(30) not null,
                        primary key(ID),
                        foreign key(ID) references Employees(ID)
                                  On delete cascade
                                  On update cascade
                       );

create table Pilots(
                    ID         int not null,
                    experience int unsigned not null default 0,
                    primary key(ID),
                    foreign key(ID) references Employees(ID)
                      On delete cascade
                      On update cascade
                   );

create table Other(
                    ID      int not null,
                    type    enum('Hostess', 'HR', 'Accounting', 'Administration') not null,
                    primary key(ID),
                    foreign key(ID) references Employees(ID)
                      On delete cascade
                      On update cascade
                   );

create table Manages(
                      Manager  int not null,
                      Manages  int not null,
                      primary key (Manager, Manages),
                      foreign key(Manager) references Employees(ID)
                      On delete cascade
                      On update cascade,
                      foreign key(Manages) references Employees(ID)
                      On delete cascade
                      On update cascade
                     );

create table airports(
                        ID         int auto_increment not null,
                        latitude   float not null default 0.0,
                        longitude  float not null default 0.0,
                        Name       varchar(50) not null,
                        location   varchar(30),
                        primary key (ID)
                    );

create table Model(
                    ID            int auto_increment not null,
                    Name          varchar(30),
                    Economy       int unsigned not null default 0,
                    Business      int unsigned not null default 0,
                    FirstClass    int unsigned not null default 0,
                    CargoLimit    numeric(5,2) default 0,
                    Manufacturer  varchar(30) not null,
                    primary key (ID)
                  );

create table Planes(
                    ID                 int auto_increment not null,
                    Model              int not null,
                    Inducted_on        Date not null, 
                    Status             enum('Safe', 'Needs Inspection', 'Not safe') not null default 'Needs Inspection',
                    primary key (ID) ,
                    foreign key(Model) references Model(ID)
                        on delete no action
                        on update no action

                    );

create table Seats(
                        ID         int auto_increment not null,
                        class      enum('Business','Economy','FirstClass') not null,
                        seatNo     varchar(50) not null,
                        planeId    int not null,
                        primary key (ID),
                        foreign key (planeId) references Planes(ID)
                        on delete cascade
                        on update cascade
                    );

create table Inspection(
                        ID          int auto_increment not null,
                        Technician  int not null,
                        PlaneID     int not null,
                        Date        date not null,
                        primary key (ID),
                        foreign key (Technician) references Technician(ID)
                            On delete no action
                            On update cascade,
                        foreign key (PlaneID) references Planes(ID)
                            On delete no action
                            On update cascade
                        );

create table CustomerProfiles(
                              ID               int auto_increment not null,
                              Password         varchar(30) not null default 'judeBourne',
                              Name             varchar(30) not null,
                              DOB              date not null,
                              Gender           enum('M', 'F', 'Other') not null,
                              Address          varchar(30) not null,
                              PhoneNo          numeric(15, 0) not null,
                              PassportNo       numeric(15, 0),
                              milesTravelled   int not null default 0,
                              primary key (ID)
                             ); 

create table CustomerPhoneNos(
                              CustomerID int not null,
                              PhoneNo    numeric(15, 0) not null,
                              foreign key(CustomerID) refernces CustomerProfiles(ID));

create table loyaltyType(
                          program          varchar(30) not null,
                          minimumMiles     int unsigned default 0,
                          FreeMiles        int unsigned default 0,
                          foodDiscount     int unsigned default 0,
                          Status           enum('active','passive')
                          primary key(program)
                        );

create table loyaltyProfiles(
                             customerID       int not null,
                             program          varchar(30) not null,           
                             FreeMiles        int unsigned not null default 0,
                             primary key (customerID),
                             foreign key (customerID) references CustomerProfiles(ID)
                             on delete cascade
                             on update cascade,                             
                             foreign key (program) references loyaltyType(program)
                             on delete cascade
                             on update cascade
                             );

create table Payments(
                      ID            int auto_increment not null,
                      Amount        float(15) default 0.0,
                      cash          enum('Y', 'N') default 'N',
                      Bank          int,
                      transactionID int,
                      Description   enum('Plane Purchase','Ticket Booking','Cargo Booking','Fuel Purchase','Salary','Insurance','Other'),
                      timeStamp     timeStamp not null,
                      primary key(ID)
                     );

create table ScheduledFlights(
                     ID       int auto_increment not null primary key,
                     PlaneID  int,
                     Start    int,
                     Dest     int,
                     DOD      date not null default '1997-09-21',
                     DOA      date not null default '1997-09-21',
                     TOD      time not null,
                     TOA      time not null,
                     Status   enum('CANCELLED', 'ON-TIME', 'DELAYED') default 'ON-TIME',
                     Price    numeric(7,2),
                     foreign key(PlaneID) references Planes(ID)
                     on delete set null
                     on update cascade,
                     foreign key(Start) references airports(ID)
                     on delete set null
                     on update cascade,
                     foreign key(Dest) references airports(ID)
                     on delete set null
                     on update cascade
                    );

create table StartedFlights(
                     ID       int not null primary key,
                     DOD      date not null default '1997-09-21',
                     DOA      date default '1997-09-21',
                     TOD      time not null,
                     TOA      time ,
                     Status   enum('ON-TIME', 'DELAYED') default 'ON-TIME',
                     foreign key(PlaneID) references Planes(ID)
                     on delete set null
                     on update cascade,
                     foreign key(Start) references airports(ID)
                     on delete set null
                     on update cascade,
                     foreign key(Dest) references airports(ID)
                     on delete set null
                     on update cascade
                    );

create table Booking(
                     ID          int auto_increment not null,
                     PaymentID   int not null,
                     CustomerID  int not null,
                     primary key (ID),
                     foreign key (PaymentID) references Payments(ID)
                     on delete cascade
                     on update cascade,
                     foreign key (CustomerID) references CustomerProfiles(ID)
                     on delete cascade
                     on update cascade
                    );

create table Tickets(
                      BookingID  int not null,
                      flightID   int not null,
                      SeatID     int not null,
                      CustomerID int not null,
                      primary key (BookingID, CustomerID),
                      foreign key (BookingID) references Booking(ID)
                        on delete cascade
                        on update cascade,
                      foreign key (flightID) references ScheduledFlights(ID)
                       on delete cascade
                       on update cascade,
                      foreign key (CustomerID) references CustomerProfiles(ID)
                       on delete cascade
                       on update cascade,
                      foreign key (SeatID) references Seats(ID)
                       on delete cascade
                       on update cascade  

                    ); 

create table Cargo(
                      ID        int auto_increment not null,
                      flightID  int not null,
                      OwnerID   int not null,
                      Weight    int not null default 0,
                      Type      enum('Animal', 'Mail', 'Luggage'),
                      BookingID int not null,
                      primary key (ID),
                      foreign key (flightID) references ScheduledFlights(ID)
                       on delete cascade
                       on update cascade,
                      foreign key (OwnerID) references CustomerProfiles(ID)
                       on delete cascade
                       on update cascade, 
                      foreign key (BookingID) references Booking(ID)
                       on delete cascade
                       on update cascade
                    );

create table Crew(
                    EmployeeID int not null,
                    flightID   int not null,
                    primary key (EmployeeID, flightID),
                    foreign key (flightID) references ScheduledFlights(ID)
                       on delete cascade
                       on update cascade,
                    foreign key (EmployeeID) references Employees(ID)
                       on delete cascade
                       on update cascade 
                );


create table salaryPaid( 
                         EmployeeID int not null,
                         PaymentID  int not null,
                         primary key (EmployeeID, PaymentID),
                         foreign key (EmployeeID) references Employees(ID)
                         on delete cascade
                         on update cascade,
                         foreign key (PaymentID) references Payments(ID)
                         on delete cascade
                         on update cascade
                      );
