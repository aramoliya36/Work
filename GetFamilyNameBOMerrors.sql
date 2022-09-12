declare @Date1 nvarchar(30)
declare @Date2 nvarchar(30)

set @Date1='2022-08-26'
set @Date2='2022-09-09'

select left(tb2.Document_Id,8) as [Work Order Number],
       tb2.CREATE_DATE,
       WO.PART_ID as [Family Names],
          CASE
              WHEN WO.PART_ID like '%LI%' then 'Linia'
                 WHEN WO.PART_ID like '3G-DZ%' or WO.PART_ID like '%S_Z%' or WO.PART_ID like '%P_Z%' or WO.PART_ID like '%R_Z%' then 'Zoie'
                 WHEN WO.PART_ID like '3G-DL%' or WO.PART_ID like '3G-4PDSL%'then 'Downlights'
                 WHEN WO.PART_ID like '3G-PDL%' or WO.PART_ID like '3G-SDL%' then 'Cylinder'
                 WHEN WO.PART_ID like '3G-RC%' or WO.PART_ID like '%RMSL%'or WO.PART_ID like '%PM1M%'or WO.PART_ID like '%PIN%'or WO.PART_ID like '%SM%' or WO.PART_ID like '%WIN%'then 'Madison'
                 WHEN WO.PART_ID like '3G-_KU%' or WO.PART_ID like '3G-_RU%' then 'Rubo/Kubo'
				 WHEN WO.PART_ID like '3G-__RMSL%' or WO.PART_ID like '3G-_PMZ%' or WO.PART_ID like '3G-PMZ%'or WO.PART_ID like '3G-RMZ%'then 'MSL-RMZSL/PMZSL'
				 WHEN WO.PART_ID='PACKING' THEN 'PACKING'
				 ELSE 'ASSM'
          END AS [Family Type],
          tb2.OLD_VALUE,
          tb2.NEW_VALUE as [Status] 
          from (select tb1.USER_ID,
                       tb1.TBL_NAME,
                       tb1.CREATE_DATE,
                       SUBSTRING(tb1.PRIMARY_KEY,1,8) as Programm_Id,
                       SUBSTRING(tb1.PRIMARY_KEY,21,28) as Document_Id,
                                  tb1.OLD_VALUE,
                       tb1.NEW_VALUE
             from (select * from HISTORY_DATA where PRIMARY_KEY like '%WO%' and CREATE_DATE between @Date1 and @Date2) as tb1
       where --tb1.NEW_VALUE like '%Packaging%'or 
          tb1.NEW_VALUE like '%Ready to Ship%') as tb2
      left join (select * from WORK_ORDER where SUB_ID = 0) as WO
      on left(tb2.Document_Id,8)= WO.BASE_ID
      --where WO.PART_ID like '%3G%'




--EXEC SelectAllWO @Date1='2022-08-26',@Date2='2022-09-08'

