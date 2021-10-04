use [GuestHouse2020]
go

set statistics io on
set statistics time on 

--1 querry.List the people who has booked room number 101 on 17th November 2016.
select CONCAT(g.[first_name],' ', g.[last_name]) AS 'Guest Name'
from [dbo].[guest] g
INNER JOIN [dbo].[booking] b ON g.[id] = b.[guest_id]
where b.[room_no] = 101 and b.[booking_date] = '2016-11-03'


--2second querry.Give the booking date and the number of nights for guest 1540.
select b.[booking_date],[nights]
from [dbo].[booking] b
where b.[guest_id] = 1540

--3querry.List the arrival time and the first and last names for all guests
--due to arrive on 2016-11-05, order the output by time of arrival.
select CONCAT(g.[first_name],' ', g.[last_name]) AS 'Guest Name',[arrival_time]
from [dbo].[guest] g
INNER JOIN [dbo].[booking] b ON g.[id] = b.[guest_id]
where [booking_date] = '2016-11-05'

--4 querry.Give the daily rate that should be paid for bookings with ids 5152, 5165, 5154 and 5295.
--Include booking id, room type, number of occupants and the amount.

select b.[booking_id] as 'booking id',b.[occupants] as 'occupants' ,r.[room_type] as 'room type',r.[amount] as ' amount'
from [dbo].[booking] b
INNER JOIN [dbo].[rate]r ON b.[room_type_requested] = r.[room_type] --or just one condition ?
and b.[occupants] = r.[occupancy]
where [booking_id] = 5152  or  [booking_id]= 5165 or  [booking_id] =5154 or  [booking_id] =5295
--it does not exist!!!!!!!booking id 5165
select * from booking
where booking_id= 5165

--Q5. Find who is staying in room 101 on 2016-12-03, include first name, last name and address.
select g.[first_name], g.[last_name],g.[address] as 'Address'
from [dbo].[guest] g
INNER JOIN [dbo].[booking] b ON g.[id] = b.[guest_id]
where [booking_date] = '2016-12-03' and
b.[room_no] = 101

--Q6. For guests 1185 and 1270 show the number of bookings made and the total number of nights.
--Your output should include the guest id and the total number of bookings and the total number of nights.
select b.[guest_id] as 'Guest ID',
count(b.[booking_id]) as 'Total bookings ',SUM(b.[nights]) as 'Total nights'
from [dbo].[booking] b
where b.[guest_id] = 1185 or b.[guest_id] = 1270
group by b.[guest_id] 


--Q7. Show the total amount payable by guest Ruth Cadbury for her room bookings.
--You should JOIN to the rate table using room_type_requested and occupants.
select b.[guest_id] as 'guest ID', concat(g.[first_name], + ' ',+  g.[last_name]) as Customer,  sum(b.[nights]*r.[amount]) as 'total for room'
from [dbo].[booking] b
inner join [dbo].[guest] g on b.[guest_id]=g.[id]
INNER JOIN [dbo].[rate]r ON b.[room_type_requested] = r.[room_type] and b.[occupants] = r.[occupancy]
where [first_name] = 'Ruth' and
[last_name] = 'Cadbury'
group by b.[guest_id],g.[first_name],g.[last_name]

--querry8 Calculate the total bill for booking 5346 including extras!!!not correct yet 
select b.[booking_id] as 'booking ID',(b.[nights]*r.[amount]) as 'total for room', e.[amount] as 'total extra', (b.[nights]*r.[amount]) + e.[amount] as 'total bill'
from [dbo].[booking] b
INNER JOIN [dbo].[rate]r ON b.[room_type_requested] = r.[room_type] and b.[occupants] = r.[occupancy]
INNER JOIN [dbo].[extra] e ON b.[booking_id] = e.[booking_id] 
where b.[booking_id] = 5346


--not the most ellegant version ,need to change for a view alter etc...
	select b.[booking_id], ((select b.[nights]*r.[amount] 
	from [dbo].[booking] b
	INNER JOIN [dbo].[rate]r ON b.[room_type_requested] = r.[room_type] and b.[occupants] = r.[occupancy]
	where b.[booking_id] = 5346)
+
	(select  SUM(e.[amount]) 
	from [dbo].[booking] b
	INNER JOIN [dbo].[rate]r ON b.[room_type_requested] = r.[room_type] and b.[occupants] = r.[occupancy]
	INNER JOIN [dbo].[extra] e ON b.[booking_id] = e.[booking_id]
	where b.[booking_id] = 5346))as 'Total '
	from [dbo].[booking] b
	where b.[booking_id] = 5346



--to check if it is correct
select * from booking
where booking_id = 5346
select * from extra
where booking_id = 5346

--querry 9.For every guest who has the word “Edinburgh” in their address show the total number of nights booked.
--Be sure to include 0 for those guests who have never had a booking.
--Show last name, first name, address and number of nights. Order by last name then first name.

select g.[first_name] as 'First Name', g.[last_name] as 'Last Name',g.[address] as 'Address', ISNULL(SUM(b.[nights]),0) as 'Total nights'
from [dbo].[guest] g
left JOIN [dbo].[booking] b ON g.[id] = b.[guest_id]
where g.[address] like '%Edinburg%' 
group by g.[first_name], g.[last_name], g.[address]



--Q10. For each day of the week beginning 2016-11-25 show the number of bookings starting that day.
--Be sure to show all the days of the week in the correct order.
select count(b.[booking_id]) as 'total',(DATENAME(WEEKDAY,b.[booking_date])) as 'Booking date'
from [dbo].[booking] b
where b.[booking_date] between '2016-11-25' and DATEADD(day,6,'2016-11-25')
group by ( b.[booking_date])
ORDER BY (b.[booking_date])

--Q11. Show the number of guests in the hotel on the night of 2016-11-21.
--Include all occupants who checked in that day but not those who checked out.

SELECT SUM([occupants])  AS 'Total'
FROM [dbo].[booking]
WHERE '2016-11-21' BETWEEN [booking_date] AND DATEADD(day, CASE WHEN [nights] = 1 THEN 1 ELSE [nights]-1 END, [booking_date])

--Q12. List the rooms that are free on the day 25th Nov 2016.

select r.[id] as 'Room ID'
from [dbo].[room] r

where r.[id] NOT IN (
SELECT distinct b.[room_no] AS 'Rooms Available'
FROM [dbo].[booking] b
WHERE '2016-11-25' BETWEEN b.[booking_date] AND DATEADD(day, CASE WHEN b.[nights] = 1 THEN 1 ELSE [nights]-1 END, b.[booking_date])
)

