------database INTERACTIVE
----------Ever 20 work order we applied 1 suction cup
----------maximum 5 suction cup we can give
---------belove report shows if more than 5 suction cup 



SELECT TB1.WORKORDER_TYPE,
       TB1.WORKORDER_BASE_ID,
          TB1.WORKORDER_LOT_ID,
          TB1.WORKORDER_SUB_ID,
          TB2.DESIRED_QTY AS [WO QTY],
          TB1.PART_ID,TB1.CALC_QTY AS [PART QTY] 
FROM
     (Select WORKORDER_TYPE,
                WORKORDER_BASE_ID,
                     WORKORDER_LOT_ID,
                     WORKORDER_SPLIT_ID,
                     WORKORDER_SUB_ID,PART_ID,
                     CALC_QTY 
         from REQUIREMENT  
         where PART_ID='HAR0213' AND WORKORDER_TYPE='W') AS TB1
      LEFT OUTER JOIN
         (SELECT TYPE,
                 BASE_ID,
                       LOT_ID,
                       SPLIT_ID,
                       SUB_ID,
                       DESIRED_QTY
          FROM WORK_ORDER 
          WHERE LOT_ID='1' AND SUB_ID='0' AND TYPE='W') AS TB2
ON TB1.WORKORDER_BASE_ID=TB2.BASE_ID
WHERE TB2.DESIRED_QTY >=100 AND TB1.CALC_QTY>5
