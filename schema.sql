create table CustomerProfiles(
                              ID         numeric(15, 0) not null auto increment,
                              Password   varchar(30) not null default 'axelBourne',
                              Name       varchar(30) not null,
                              DOB        date not null
                              Gender     enum('M', 'F', 'Other') not null,
                              Address    varchar(30) not null,
                              PhoneNo1   numeric(15, 0) not null,
                              PhoneNo2   numeric(15, 0) default 0,
                              PassportNo numeric(15, 0) 
                              loyaltyID  numeric(15, 0) default null,
                              primary key (ID),
                              foreign key (loyaltyID) references loyaltyProfiles(ID)
                                                on delete default
                             );


create table Booking(
                     ID          numeric(15, 0) not null auto increment,
                     PaymentID   numeric(15, 0) not null,
                     CustomerID  numeric(15, 0) not null,
                     TicketID    numeric(15, 0) not null,
                     primary key (ID)
                     foreign key (PaymentID) references Payments(ID)
                                    on delete no action,
                     foreign key (CustomerID) references CustomerProfiles(ID)
                                    on delete no action,
                     foreign key (TicketID) references Ticket(ID)
                                    on delete no action
                    );

create table Payments(
                      ID            numeric(15, 0) not null auto increment,
                      Amount        float(15) default 0.0,
                      cash          enum('Y', 'N') default 'N',
                      Bank          int,
                      transactionID int,
                      timeStamp     timeStamp not null,
                      primary key(ID)
                     );

create table Flights(
                     ID       numeric(15, 0) not null auto increment,
                     PlaneID  numeric(15, 0) not null,
                     Start    numeric(15, 0) not null,
                     Dest     numeric(15, 0) not null,
                     DOD      date not null default 1997-09-21,
                     DOA      date not null default 1997-09-21,
                     TOD      int not null,
                     TOA      int not null,
                     Status   ('CANCELLED', 'ON-TIME', 'DELAYED') not null default 'ON-TIME'
                     primary key(ID),
                     foreign key(PlaneID) references Planes(ID)
                                ON DELETE Set 

                    );

create table Employees(
                        ID         numeric(15, 0) not null auto increment,
                        Password   varchar(30) not null default 'axelBourne',
                        Name       varchar(30) not null,
                        DOB        date not null
                        Gender     enum('M', 'F', 'Other') not null,
                        Address    varchar(30) not null,
                        PhoneNo1   numeric(15, 0) not null,
                        PhoneNo2   numeric(15, 0) default 0,
                        Salary     float not null default 0.0,
                        DOJ        date not null
                        primary key(ID)
                    );

create table Pilots(
                    ID  numeric(15, 0) not null,
                    primary key(ID),
                    foreign key(ID) references Employees
                      On delete cascade
                      On update cascade,
                   );


create table Other(
                    ID      numeric(15, 0) not null,
                    type    enum('Hostess', 'HR', 'Accounting', 'Administration') not null,
                    primary key(ID),
                    foreign key(ID) references Employees
                      On delete cascade
                      On update cascade,
                   );

create table Technician(
                        ID     numeric(15, 0) not null,
                        AOExp  varchar(30) not null,
                        primary key(ID),
                        foreign key(ID) references employees
                                  On delete cascade
                                  On update cascade,
                       );

create table Inspection(
                        ID    numeric(15, 0) not null,
                        Technician  numeric(15, 0) not null,
                        PlaneID     numeric(15, 0) not null,
                        Date        date not null
                        primary key (ID)
                        foreign key (Technician) references Technician(ID)
                            On delete no action
                            On update cascade,
                        foreign key (PlaneID) references Planes(ID)
                            On delete no action
                            On update cascade,
                        );

create table Manages(
                      Manager  numeric(15, 0) not null,
                      Manages  numeric(15, 0) not null,
                      primary key (Manager, Manages),
                      foreign key(Manager) references Employees(ID)
                      On delete cascade
                      On update cascade,
                      foreign key(Manages) references Employees(ID)
                      On delete cascade
                      On update cascade,
                     );

create table Planes(
                    ID                    numeric(15, 0) not null auto increment,
                    Model                 numeric(15, 0) not null,
                    Inducted_on           Date not null,
                    InspectionID          numeric(15, 0)  
                    Status                enum('Safe', 'Needs Inspection', 'Not safe') not null default 'Needs Inspection',
                    primary key (ID) 
                    foreign key(Model) references Model(ID)
                        on delete no action
                        on update no action,
                    foreign key (InspectionID) references Inspection(ID)
                       on delete no action
                       on update cascade

                    );

create table Tickets(
                      ID         numeric(15, 0) not null auto increment,
                      flightID   numeric(15, 0) not null,
                      seatNo     int not null,
                      customerID numeric(15, 0) not null,
                      primary key (ID)
                      foreign key (flightID) references Flights(ID)
                       on delete cascade
                       on update cascade,
                      foreign key (CustomerID) references CustomerProfiles(ID)
                       on delete cascade
                       on update cascade  

                    ); 

create table Cargo(
                      ID        numeric(15, 0) not null auto increment,
                      flightID  numeric(15, 0) not null,
                      OwnerID   numeric(15, 0) not null,
                      Weight    int not null default 0,
                      Type      enum('Animal', 'Mail', 'Luggage'),
                      primary key (ID)
                      foreign key (flightID) references Flights(ID)
                       on delete cascade
                       on update cascade,
                      foreign key (OwnerID) references CustomerProfiles(ID)
                       on delete cascade
                       on update cascade 

                    );

create table Crew(
                    EmployeeID numeric(15, 0) not null,
                    flightID   numeric(15, 0) not null,
                    primary key (EmployeeID, flightID),
                    foreign key (flightID) references Flights(ID)
                       on delete cascade
                       on update cascade,
                    foreign key (EmployeeID) references Employees(ID)
                       on delete cascade
                       on update cascade 
                );

create table Model(
                    ID          numeric(15, 0) not null,
                    Economy       int not null default 0,
                    Business      int not null default 0,
                    FirstClass    int not null default 0,
                    Manufacturer  varchar(30) not null,
                    primary key (Name)
                  );

create table loyaltyProfiles(
                             ID numeric(15, 0) not null,
                             
                             )
            
