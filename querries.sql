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
CONCAT(g.[first_name],' ', g.[last_name]) AS 'Guest Name',
Count b.[room_type_requested] as 'total'
FROM [dbo].[guest] g
INNER JOIN [dbo].[booking] b ON g.[id] = b.[guest_id]
ORDER  BY room_type DESC



SET STATISTICS IO OFF
GO

SET STATISTICS IO OFF
GO



