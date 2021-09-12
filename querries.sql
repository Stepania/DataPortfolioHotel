USE [GuestHousesAls0885]
GO



-- 1. Total number of bookings

SELECT COUNT(b.[booking_id]) AS 'TotalNumberBookings'
FROM [dbo].[booking] b




--2The total number of guests booked

SELECT SUM (b.[occupants]) AS 'Total guests booked '
FROM [dbo].[booking] b


--3List of guests by room type
SELECT  CONCAT(g.[first_name],' ', g.[last_name]) AS 'Guest Name',
FROM [dbo].[guest]
INNER JOIN [dbo].[guest] g ON g.[id] = b.[guest_id]
ORDER  BY room_type






