use [3GLighting_Production]

----------------------------------------------Quote Summury ---------------------------------------------------------------
select tb1.LatestStatus,
tb1.today_status,
case 
 when tb2.update_today is null then 0
 else tb2.update_today 
 End as [Update Today]
 from

(select distinct LatestStatus,COUNT(LatestStatus) over (partition by LatestStatus) as today_status from tbl_quote
where LatestStatusDateTime=CAST(DATEADD(DAY, CASE (DATEPART(WEEKDAY, GETDATE()) + @@DATEFIRST) % 7
                                WHEN 1 THEN -2 
	                            WHEN 2 THEN -3 
	                            ELSE -1 END, DATEDIFF(DAY, 0, GETDATE()))as date) AND LatestStatus IN ('Pending','Approved','Hold for Release')) as tb1

left join
(select distinct LatestStatus,
	   COUNT(tb.LatestStatus) over (partition by tb.LatestStatus) as update_today
from tbl_quote  as tb

where CAST(tb.LatestUpdatedDate AS DATE) = CAST(DATEADD(DAY, CASE (DATEPART(WEEKDAY, GETDATE()) + @@DATEFIRST) % 7
                                WHEN 1 THEN -2 
	                            WHEN 2 THEN -3 
	                            ELSE -1 END, DATEDIFF(DAY, 0, GETDATE()))as date))as tb2
on tb1.LatestStatus=tb2.LatestStatus
order by tb1.LatestStatus desc

-------------------------------Detail for Today Update column-----------------------------------------------------------------






select tb1.QuoteID,
       tb1.LatestStatusDateTime,
	   tb1.ProjectName,
	   tb1.LatestStatus,
	   CASE 
	    When tb1.LatestUpdatedBy is null then 0
		else tb1.LatestUpdatedBy
		end as [User ID],
		tb2.UserName
from tbl_quote as tb1 left join tbl_admin as tb2
ON tb1.LatestUpdatedBy=tb2.UserID
where tb1.LatestStatusDateTime=CAST(DATEADD(DAY, CASE (DATEPART(WEEKDAY, GETDATE()) + @@DATEFIRST) % 7
                                WHEN 1 THEN -2 
	                            WHEN 2 THEN -3 
	                            ELSE -1 END, DATEDIFF(DAY, 0, GETDATE()))as date) AND tb1.LatestStatus IN ('Pending','Approved','Hold for Release')




select tb1.QuoteID,tb1.LatestUpdatedDate,tb1.ProjectName,tb1.LatestStatus,tb2.UserName
from tbl_quote  as tb1 left join tbl_admin as tb2
on tb1.UserID=tb2.UserID

where CAST(tb1.LatestUpdatedDate AS DATE) = CAST(DATEADD(DAY, CASE (DATEPART(WEEKDAY, GETDATE()) + @@DATEFIRST) % 7
                                WHEN 1 THEN -2 
	                            WHEN 2 THEN -3 
	                            ELSE -1 END, DATEDIFF(DAY, 0, GETDATE()))as date)





