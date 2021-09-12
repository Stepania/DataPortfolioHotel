CREATE DATABASE GuestHousesAls0885
GO

USE GuestHousesAls0885

--creating a CALENDAR
CREATE TABLE calendar (
	i date,
	PRIMARY KEY (i)
);
SELECT * FROM calendar

bulk insert [GuestHousesAls0885].[dbo].[calendar]
	from 'C:\study\DATA\Portfolio\TablesHotel\calendar.csv'
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
	id varchar(10),
	description varchar(50)
	PRIMARY KEY (id)
);
GO 

SELECT * FROM room_type

bulk insert [GuestHousesAls0885].[dbo].[room_type]
	from 'C:\study\DATA\Portfolio\TablesHotel\room_type.csv'
	with
	(
		FIELDTERMINATOR=',',
		ROWTERMINATOR='\n',
		FIRSTROW=2
	)

DROP TABLE room_type
GO

--creating a table ROOM

CREATE TABLE room (
	id int,
	room_type varchar(10),
	max_occupancy int,
	PRIMARY KEY (id)
);
GO 


SELECT * FROM room

bulk insert [GuestHousesAls0885].[dbo].room
	from 'C:\study\DATA\Portfolio\TablesHotel\room.csv'
	with
	(
		FIELDTERMINATOR=',',
		ROWTERMINATOR='\n',
		FIRSTROW=2
	)

DROP TABLE room
GO



