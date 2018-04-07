create or replace database Airlines;
use Airlines;
create or replace table Employee(
                        ID         int auto_increment  not null,
                        Password   varchar(30) not null,
                        Name       varchar(30) not null,
                        DOB        date not null,
                        Gender     enum('M', 'F', 'Other') not null,
                        Address    varchar(30) not null,
                        PhoneNo    varchar(15) not null,  
                        Bank       varchar(30) not null,
                        Salary     float not null,
                        DOJ        date not null,
                        primary key(ID)
                    );

create or replace table Technician(
                        ID      int not null,
                        AOExp   varchar(30) not null,
                        primary key(ID),
                        foreign key(ID) references Employee(ID)
                                  On delete cascade
                                  On update cascade
                       );

create or replace table Pilot(
                    ID         int not null,
                    Experience int unsigned not null,
                    primary key(ID),
                    foreign key(ID) references Employee(ID)
                      On delete cascade
                      On update cascade
                   );

create or replace table Other(
                    ID      int not null,
                    Type    enum('Hostess', 'HR', 'Accounting', 'Administration') not null,
                    primary key(ID),
                    foreign key(ID) references Employee(ID)
                      On delete cascade
                      On update cascade
                   );

create or replace table Manages(
                      Manager  int not null,
                      Manages  int not null,
                      primary key (Manager, Manages),
                      foreign key(Manager) references Employee(ID)
                      On delete cascade
                      On update cascade,
                      foreign key(Manages) references Employee(ID)
                      On delete cascade
                      On update cascade
                     );

create or replace table Airport(
                        ID         int auto_increment not null,
                        Latitude   float not null,
                        Longitude  float not null,
                        Name       varchar(50) not null,
                        City       varchar(30) not null,
                        Country    varchar(30) not null,
                        primary key (ID)
                    );

create or replace table Model(
                    ID            int auto_increment not null,
                    Name          varchar(30),
                    Economy       int unsigned not null default 0,
                    Business      int unsigned not null default 0,
                    FirstClass    int unsigned not null default 0,
                    CargoLimit    numeric(5,2) default 0,
                    Manufacturer  varchar(30) not null,
                    primary key (ID)
                  );

create or replacecreate or replacecreate or replace table Plane(
                    ID                 int auto_increment not null,
                    Model              int not null,
                    Inducted_on        Date not null, 
                    Status             enum('Safe', 'Needs Inspection', 'Not safe') not null default 'Needs Inspection',
                    primary key (ID) ,
                    foreign key(Model) references Model(ID)
                        on delete no action
                        on update no action

                  );

create or replacecreate or replace table Seat(
                    ID         int auto_increment not null,
                    Class      enum('Business','Economy','FirstClass') not null,
                    SeatNo     varchar(50) not null,
                    PlaneID    int not null,
                    primary key (ID),
                    foreign key (PlaneID) references Plane(ID)
                    on delete cascade
                    on update cascade
                 );

create or replace table Inspection(
                        ID          int auto_increment not null,
                        Technician  int not null,
                        PlaneID     int not null,
                        Date        date not null,
                        primary key (ID),
                        foreign key (Technician) references Technician(ID)
                            On delete no action
                            On update cascade,
                        foreign key (PlaneID) references Plane(ID)
                            On delete no action
                            On update cascade
                        );

create or replace table Customer_profile(
                               ID               int auto_increment not null,
                               Password         varchar(30) not null,
                               Name             varchar(30) not null,
                               DOB              date not null,
                               Gender           enum('M', 'F', 'Other') not null,
                               Address          varchar(30) not null,
                               PhoneNo          varchar(30) not null,
                               PassportNo       numeric(15, 0),
                               Bank             varchar(30) not null,  
                               MilesTravelled   int not null default 0,
                               primary key (ID)
                             ); 

create or replace table Customer_phone_nos(
                                CustomerID int not null,
                                PhoneNo    varchar(15) not null,
                                foreign key(CustomerID) references Customer_profile(ID)
                               );

create or replace table Loyalty_type(
                          Program          varchar(30) not null,
                          MinimumMiles     int unsigned default 0,
                          FreeMiles        int unsigned default 0,
                          FoodDiscount     int unsigned default 0,
                          Status           enum('active','inactive'),
                          primary key(Program)
                        );

create or replace table Loyalty_profile(
                             CustomerID       int not null,
                             Program          varchar(30) not null,           
                             FreeMiles        int unsigned not null default 0,
                             primary key (CustomerID),
                             foreign key (CustomerID) references Customer_profile(ID)
                             on delete cascade
                             on update cascade,                             
                             foreign key (Program) references Loyalty_type(Program)
                             on delete cascade
                             on update cascade
                            );

create or replace table Payment(
                      ID            int auto_increment not null,
                      Amount        float(15) default 0.0,
                      Cash          enum('Y', 'N') default 'N',
                      Bank          varchar(30),
                      TransactionID int,
                      Description   enum('Plane Purchase','Ticket Booking','Ticket Refund','Cargo Booking','Fuel Purchase','Salary','Insurance','Other'),
                      TimeStamp     timeStamp not null,
                      primary key(ID)
                     );

create or replace table Scheduled_flight(
                              ID       int auto_increment not null ,
                              PlaneID  int,
                              Start    int,
                              Dest     int,
                              DOD      date not null, 
                              DOA      date not null,
                              TOD      time not null,
                              TOA      time not null,
                              Status   enum('CANCELLED', 'ON-TIME', 'DELAYED') default 'ON-TIME',
                              Price    numeric(7,2),
                              primary key(ID),
                              foreign key(PlaneID) references Plane(ID)
                              on delete set null
                              on update cascade,
                              foreign key(Start) references Airport(ID)
                              on delete set null
                              on update cascade,
                              foreign key(Dest) references Airport(ID)
                              on delete set null
                              on update cascade
                            );

create or replace table Commenced_flight(
                                ID       int not null,
                                DOD      date not null,
                                DOA      date not null,
                                TOD      time not null,
                                TOA      time ,
                                Status   enum('ON-TIME', 'DELAYED') default 'ON-TIME',
                                primary key(ID),
                                foreign key(ID) references Scheduled_flight(ID)
                                on delete no action 
                                on update cascade
                              );

create or replace table Booking(
                     ID          int auto_increment not null,
                     PaymentID   int not null,
                     CustomerID  int not null,
                     primary key (ID),
                     foreign key (PaymentID) references Payment(ID)
                     on delete cascade
                     on update cascade,
                     foreign key (CustomerID) references Customer_profile(ID)
                     on delete cascade
                     on update cascade
                    );

create or replace table Ticket(
                      ID         int auto_increment not null,
                      BookingID  int not null,
                      FlightID   int not null,
                      SeatID     int not null,
                      CustomerID int not null,
                      Price      int unsigned not null,
                      Status     enum('Active', 'Cancelled', 'Over') default 'Active',
                      primary key (ID),
                      foreign key (BookingID) references Booking(ID)
                        on delete cascade
                        on update cascade,
                      foreign key (FlightID) references Scheduled_flight(ID)
                       on delete cascade
                       on update cascade,
                      foreign key (CustomerID) references Customer_profile(ID)
                       on delete cascade
                       on update cascade,
                      foreign key (SeatID) references Seat(ID)
                       on delete cascade
                       on update cascade  
                   ); 

create or replace table Cargo(
                      ID        int auto_increment not null,
                      FlightID  int not null,
                      OwnerID   int not null,
                      Weight    int not null,
                      Type      enum('Animal', 'Mail', 'Luggage'),
                      BookingID int not null,
                      primary key (ID),
                      foreign key (FlightID) references Scheduled_flight(ID)
                       on delete cascade
                       on update cascade,
                      foreign key (OwnerID) references Customer_profile(ID)
                       on delete cascade
                       on update cascade, 
                      foreign key (BookingID) references Booking(ID)
                       on delete cascade
                       on update cascade
                    );

create or replace table Crew(
                    EmployeeID int not null,
                    FlightID   int not null,
                    primary key (EmployeeID, FlightID),
                    foreign key (flightID) references Scheduled_flight(ID)
                       on delete cascade
                       on update cascade,
                    foreign key (EmployeeID) references Employee(ID)
                       on delete cascade
                       on update cascade 
                );


create or replace table Salary_paid( 
                         EmployeeID int not null,
                         PaymentID  int not null,
                         primary key (EmployeeID, PaymentID),
                         foreign key (EmployeeID) references Employee(ID)
                         on delete cascade
                         on update cascade,
                         foreign key (PaymentID) references Payment(ID)
                         on delete cascade
                         on update cascade
                      );