use AdventureWorks2019

SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'

--3. Perform the following with help of the above database:
--a. Get all the details from the person table including email ID, phone number and phone number type. 

select * from [Person].[PersonPhone]
select * from [Person].[EmailAddress]

SELECT PEA.[EMAILADDRESSID] , PP.[PHONENUMBER], PP.[PHONENUMBERTYPEID] FROM [PERSON].[EMAILADDRESS] AS PEA
INNER JOIN [PERSON].[PERSONPHONE] AS PP
ON PEA.[BUSINESSENTITYID]= PP.[BUSINESSENTITYID]

--b. Get the details of the sales header order made in May 2011

SELECT * FROM [Sales].[SalesOrderDetail]
SELECT * FROM [Sales].[SalesOrderHeader]
select * from [Sales].[SalesReason]

SELECT SOD.[SALESORDERID], SOD.[SALESORDERDETAILID], SOH.[SALESORDERNUMBER], SOH.[OrderDate] FROM [Sales].[SalesOrderDetail] AS SOD
INNER JOIN [Sales].[SalesOrderHeader] AS SOH
ON SOD.[SALESORDERID]=SOH.[SALESORDERID]
WHERE year(SOH.OrderDate)=2011 and Month(SOH.OrderDate)=5
ORDER BY SOH.OrderDate

--c. Get the details of the sales details order made in the month of May 2011. 
---JOIN ON 2 TABLES
SELECT SOD.[SALESORDERID], SOD.[SALESORDERDETAILID], SOH.[SALESORDERNUMBER], SOH.[OrderDate], SOHSR.[SALESREASONID], SOHSR.[MODIFIEDDATE] FROM [Sales].[SalesOrderDetail] AS SOD
INNER JOIN [Sales].[SalesOrderHeader] AS SOH
ON SOD.[SALESORDERID]=SOH.[SALESORDERID]
INNER JOIN [Sales].[SalesOrderHeaderSalesReason] AS SOHSR
ON SOH.[SALESORDERID]=SOHSR.[SALESORDERID]
WHERE year(SOH.OrderDate)=2011 and Month(SOH.OrderDate)=5
ORDER BY SOH.OrderDate


---JOIN ON 1 TABLE 
SELECT SOD.[SALESORDERID], SOD.[SALESORDERDETAILID], SOH.[SALESORDERNUMBER], SOH.[OrderDate] FROM [Sales].[SalesOrderDetail] AS SOD
INNER JOIN [Sales].[SalesOrderHeader] AS SOH
ON SOD.[SALESORDERID]=SOH.[SALESORDERID]
WHERE year(SOH.OrderDate)=2011 and Month(SOH.OrderDate)=5
ORDER BY SOH.OrderDate

SELECT * FROM [Sales].[SalesOrderHeader]
SELECT * FROM [Sales].[SalesOrderDetail]
SELECT * FROM [Sales].[SalesOrderHeaderSalesReason]

--d. Get the total sales made in May 2011

select SOH.[SALESORDERNUMBER], SOH.[SalesOrderID], sum(SSP.salesYTD) AS [SUM OF SALES], SSP.[TerritoryID], SSP.[ModifiedDate] FROM [Sales].[SalesPerson] AS SSP
INNER JOIN [Sales].[SalesOrderHeader] AS SOH
ON SSP.[TerritoryID]=SOH.TerritoryID
where  year(SOH.OrderDate)=2011 and Month(SOH.OrderDate)=5
group by SSP.[ModifiedDate], SSP.[TerritoryID], SOH.[SALESORDERNUMBER], SOH.[SalesOrderID]
ORDER BY SSP.[ModifiedDate], SSP.[TerritoryID], SOH.[SALESORDERNUMBER], SOH.[SalesOrderID]


--e. Get the total sales made in the year 2011 by month order by increasing sales?
---YEARLY DATA OF TOTAL SALES , WHERE 2011 HAS ONLY 1 MONTH DATA
select YEAR(ModifiedDate) AS YEAR, DATENAME(MONTH,ModifiedDate) AS MONTH, SUM(SALESYTD) AS [sales made YEARLY, MONTHLY] FROM [Sales].[SalesPerson]
GROUP BY YEAR(ModifiedDate), DATENAME(MONTH,ModifiedDate)
ORDER BY YEAR(ModifiedDate), DATENAME(MONTH,ModifiedDate)

----SO ONLY 1 MONTH DATA IS AVAILABLE , EVEN AFTER APPLYING THE INCTEASING SALES THE VALUE WILL BE SAME

select SUM(SALESYTD) AS [sales made in the year 2011] FROM [Sales].[SalesPerson] AS SSP
WHERE YEAR(SSP.ModifiedDate)=2011 
GROUP BY ModifiedDate
ORDER BY [sales made in the year 2011] ASC


select SUM(SALESYTD) AS [sales made in the year 2012] FROM [Sales].[SalesPerson] AS SSP
WHERE YEAR(SSP.ModifiedDate)=2012
GROUP BY ModifiedDate
ORDER BY [sales made in the year 2012] desc

SELECT * FROM [Sales].[SalesPerson]

---f. Get total sales made to the customer with FirstName='Gustavo' and last name='Achong'

SELECT * FROM [Person].[Person] WHERE FirstName='Gustavo' AND LastName='Achong'
select * from [Sales].[SalesPerson]    

select sum(SSP.salesYTD) AS [SUM OF SALES], SSP.[TerritoryID], SSP.[ModifiedDate], SSP.[BusinessEntityID] FROM [Sales].[SalesPerson] AS SSP
INNER JOIN [Person].[Person] AS PP
ON SSP.[BusinessEntityID]=PP.[BusinessEntityID]
GROUP BY SSP.[TerritoryID], SSP.[ModifiedDate], SSP.[BusinessEntityID]
ORDER BY SSP.[TerritoryID], SSP.[ModifiedDate], SSP.[BusinessEntityID]

---NO DATA FOUND FOR TOTAL SALES MADE TO FirstName='Gustavo' AND LastName='Achong'

select sum(SSP.salesYTD) AS [SUM OF SALES], SSP.[TerritoryID], SSP.[ModifiedDate], SSP.[BusinessEntityID] FROM [Sales].[SalesPerson] AS SSP
INNER JOIN [Person].[Person] AS PP
ON SSP.[BusinessEntityID]=PP.[BusinessEntityID]
WHERE FirstName='Gustavo' AND LastName='Achong'
GROUP BY SSP.[TerritoryID], SSP.[ModifiedDate], SSP.[BusinessEntityID]
ORDER BY SSP.[TerritoryID], SSP.[ModifiedDate], SSP.[BusinessEntityID]

---- DATA FOUND FOR----  FirstName='Ranjit' AND LastName='Varkey Chudukatil'

select sum(SSP.salesYTD) AS [SUM OF SALES], SSP.[TerritoryID], SSP.[ModifiedDate], SSP.[BusinessEntityID] FROM [Sales].[SalesPerson] AS SSP
INNER JOIN [Person].[Person] AS PP
ON SSP.[BusinessEntityID]=PP.[BusinessEntityID]
WHERE FirstName='Ranjit' AND LastName='Varkey Chudukatil'
GROUP BY SSP.[TerritoryID], SSP.[ModifiedDate], SSP.[BusinessEntityID]
ORDER BY SSP.[TerritoryID], SSP.[ModifiedDate], SSP.[BusinessEntityID]
