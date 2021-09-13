CREATE DATABASE GuestHousesAls0885
GO

USE GuestHousesAls0885

--creating a CALENDAR
CREATE TABLE calendar (
	i date NOT NULL,
	PRIMARY KEY (i)
);
SELECT * FROM calendar

bulk insert [GuestHousesAls0885].[dbo].[calendar]
	from 'H:\data\portfolio\DataPortfolioHotel\TablesHotel\calendar.csv'
	with
	(
		FIELDTERMINATOR=',',
		ROWTERMINATOR='\n',
		FIRSTROW=2
	)

DROP TABLE calendar
GO


--Creating a ROOM TYPE 
CREATE TABLE room_type (
	id varchar(10) NOT NULL,
	description varchar(50) NOT NULL,
	PRIMARY KEY (id)


);

bulk insert [GuestHousesAls0885].[dbo].[room_type]
	from 'H:\data\portfolio\DataPortfolioHotel\TablesHotel\room_type.csv'
	with
	(
		FIELDTERMINATOR=',',
		ROWTERMINATOR='\n',
		FIRSTROW=2
	)
SELECT * FROM room_type

DROP TABLE room_type
GO



--creating a table ROOM

CREATE TABLE room (
	id int NOT NULL,
	room_type varchar(10) NOT NULL FOREIGN KEY REFERENCES [dbo].[room_type](id),
	max_occupancy int NOT NULL,
	PRIMARY KEY (id)
	
);
GO 

SELECT * FROM room

bulk insert [GuestHousesAls0885].[dbo].room
	from 'H:\data\portfolio\DataPortfolioHotel\TablesHotel\room.csv'
	with
	(
		FIELDTERMINATOR=',',
		ROWTERMINATOR='\n',
		FIRSTROW=2
	)

DROP TABLE room
GO


--creating a table GUEST

CREATE TABLE guest (
	id int NOT NULL,
	first_name varchar(15) NOT NULL,
	last_name varchar(25) NOT NULL,
	address varchar(50) NOT NULL,
	PRIMARY KEY (id)
);
GO 


SELECT * FROM guest

bulk insert [GuestHousesAls0885].[dbo].guest
	from 'H:\data\portfolio\DataPortfolioHotel\TablesHotel\guest.csv'
	with
	(
		FIELDTERMINATOR=',',
		ROWTERMINATOR='\n',
		FIRSTROW=2
	)

DROP TABLE guest
GO



--creating a table RATE

CREATE TABLE rate (	
	room_type varchar(10) NOT NULL	FOREIGN KEY REFERENCES [dbo].[room_type](id),
	occupancy int NOT NULL,
	ammount int NOT NULL,
	PRIMARY KEY (occupancy,room_type)
	);
GO 


SELECT * FROM rate

bulk insert [GuestHousesAls0885].[dbo].rate
	from 'H:\data\portfolio\DataPortfolioHotel\TablesHotel\rate.csv'
	with
	(
		FIELDTERMINATOR=',',
		ROWTERMINATOR='\n',
		FIRSTROW=2
	)

DROP TABLE rate
GO


--creating a table BOOKING

CREATE TABLE booking (
	booking_id INT NOT NULL PRIMARY KEY,
	booking_date DATE,
	room_no int NOT NULL FOREIGN KEY REFERENCES [dbo].room(id),
	guest_id int NOT NULL FOREIGN KEY REFERENCES [dbo].guest(id),
	occupants int NOT NULL,
	room_type_requested varchar (10) NOT NULL FOREIGN KEY REFERENCES [dbo].[room_type](id),
	nights INT,
	arrival_time TIME,
	   	

	FOREIGN KEY (occupants, room_type_requested) REFERENCES [dbo].rate(occupancy, room_type),
	);
GO 
DROP TABLE booking

SELECT * FROM booking

bulk insert [GuestHousesAls0885].[dbo].booking
	from 'H:\data\portfolio\DataPortfolioHotel\TablesHotel\booking.csv'
	with
	(
		FIELDTERMINATOR=',',
		ROWTERMINATOR='\n',
		FIRSTROW=2
	)

DROP TABLE booking
GO



--creating a table extra

CREATE TABLE extra (	
	extra_id INT NOT NULL PRIMARY KEY,
	booking_id INT NOT NULL FOREIGN KEY REFERENCES [dbo].booking(booking_id),
	description varchar(25),
	ammount decimal(8,2)NOT NULL
	);
GO 


SELECT * FROM extra

bulk insert [GuestHousesAls0885].[dbo].extra
	from 'H:\data\portfolio\DataPortfolioHotel\TablesHotel\extra.csv'
	with
	(
		FIELDTERMINATOR=',',
		ROWTERMINATOR='\n',
		FIRSTROW=2
	)

DROP TABLE extra
GO