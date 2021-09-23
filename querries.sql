USE [GuestHousesAls0885]
GO

--checking performcance of a querries 
SET STATISTICS IO ON
GO

--checking time  performcance of a querries 
SET STATISTICS TIME ON
GO
-- 1. Total number of bookings

SELECT COUNT(b.[booking_id]) AS 'TotalNumberBookings'
FROM [dbo].[booking] b

--2The total number of guests booked

SELECT SUM (b.[occupants]) AS 'Total guests booked '
FROM [dbo].[booking] b

--3List of guests by room type

SELECT b.[room_type_requested] as 'room_type',
CONCAT(g.[first_name],' ', g.[last_name]) AS 'Guest Name'
FROM [dbo].[guest] g
INNER JOIN [dbo].[booking] b ON g.[id] = b.[guest_id]
ORDER  BY room_type DESC

--list of guests (no repeat)
SELECT DISTINCT b.[room_type_requested] as 'room_type',
CONCAT(g.[first_name],' ', g.[last_name]) AS 'Guest Name'
FROM [dbo].[guest] g
INNER JOIN [dbo].[booking] b ON g.[id] = b.[guest_id]
ORDER  BY room_type DESC

--total number of guests by room type
SELECT (b.[room_type_requested]) as 'room_type',
COUNT (b.[guest_id]) AS 'Total reservations'
FROM [dbo].[booking] b
GROUP BY b.[room_type_requested]






















--query for TOTAL number of a double room booked 
SELECT COUNT(b.[room_type_requested]) as 'Total_Double_Rooms'
FROM [dbo].[guest] g
INNER JOIN [dbo].[booking] b ON g.[id] = b.[guest_id]
WHERE b.[room_type_requested] = 'double'
--query for TOTAL number of a double room booked 
SELECT COUNT(b.[room_type_requested]) as 'Total_Single_Rooms'
FROM [dbo].[guest] g
INNER JOIN [dbo].[booking] b ON g.[id] = b.[guest_id]
WHERE b.[room_type_requested] = 'single'
--query for TOTAL number of a double room booked 
SELECT COUNT(b.[room_type_requested]) as 'Total_Family_Rooms'
FROM [dbo].[guest] g
INNER JOIN [dbo].[booking] b ON g.[id] = b.[guest_id]
WHERE b.[room_type_requested] = 'family'



SET STATISTICS IO OFF
GO

SET STATISTICS IO OFF
GO



SELECT b.[room_type_requested] as 'Single_Room_Booked',
CONCAT(g.[first_name],' ', g.[last_name]) AS 'Guest Name'
FROM [dbo].[guest] g
INNER JOIN [dbo].[booking] b ON g.[id] = b.[guest_id]
WHERE b.[room_type_requested] = 'single'

SELECT b.[room_type_requested] as 'Double_Room_Booked',
CONCAT(g.[first_name],' ', g.[last_name]) AS 'Guest Name'
FROM [dbo].[guest] g
INNER JOIN [dbo].[booking] b ON g.[id] = b.[guest_id]
WHERE b.[room_type_requested] = 'double'

SELECT b.[room_type_requested] as 'Family_Room_Booked',
CONCAT(g.[first_name],' ', g.[last_name]) AS 'Guest Name'
FROM [dbo].[guest] g
INNER JOIN [dbo].[booking] b ON g.[id] = b.[guest_id]
WHERE b.[room_type_requested] = 'family'

select g.[first_name] as "guest", b.[room_type_requested] as "room type"
FROM [dbo].[guest] g
join [dbo].[booking] b ON g.[id] = b.[guest_id]
order by b.[room_type_requested] asc