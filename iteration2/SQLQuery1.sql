select b.[booking_id] as 'booking ID', (SUM(r.[amount]) + SUM(e.[amount])) as 'total bill'
from [dbo].[booking] b
INNER JOIN [dbo].[rate]r ON b.[room_type_requested] = r.[room_type] and b.[occupants] = r.[occupancy]
INNER JOIN [dbo].[extra] e ON b.[booking_id] = e.[booking_id] 
where b.[booking_id] = 5346
group by b.[booking_id]




sp_helpindex '[dbo].[booking]'

sp_helpindex '[dbo].[calendar]'

sp_helpindex '[dbo].[extra]'

sp_helpindex '[dbo].[guest]'

sp_helpindex '[dbo].[rate]'

sp_helpindex '[dbo].[room]'

sp_helpindex '[dbo].[room_type]'


drop index if exists name_of_index
	on table_name;




create nonclustered idx_tablename