
--confirm that the vendorinvoicesdec table has been brought in correctly
Select *
From [PwC Bibitor LLC]..VendorInvoicesDec

--Select only vendornumber and vendorname columns from this table
Select VendorNumber, VendorName, InvoiceDate
From [PwC Bibitor LLC]..VendorInvoicesDec
--IN command lets you select multiple rows but only the ones you specify. "LIKE" searches for close matches, while "=" searches for exact matches. 
Where VendorNumber IN ('105', '4466', '388') AND InvoiceDate = '2016-01-09'

--Ex: Obtain the total freight costs by vendornumber of transactions which the total dollars value was greater than $100 and the quantity was less than or equal to 1000 units. Which had the largest freight cost?
Select VendorNumber, SUM(Quantity) as QuantitySum, SUM(Dollars) as DollarsSum, SUM(Freight) as TotalFreightCost 
From [PwC Bibitor LLC]..VendorInvoicesDec
Where Quantity <= 1000 AND Dollars > 100
Group by VendorNumber
Order by TotalFreightCost desc

--According to the analysis, vendor 2561!
--Another method of doing this:
Select VendorNumber, sum(Freight) as TotalFreight
From [PwC Bibitor LLC]..VendorInvoicesDec
Where Quantity <= 1000 AND Dollars > 100
Group by VendorNumber
Order by TotalFreight desc

--Using the join command to left join the two tables to see starting and ending inventory side by side. 
Select *
From [PwC Bibitor LLC]..EndInvDec
Left join [PwC Bibitor LLC]..BegInvDec
On EndInvDec.InventoryId = BegInvDec.InventoryId

--How to manually perform the join command if necessary 

Select a.*
Into #TempTable1
From [PwC Bibitor LLC]..EndInvDec as a
Left outer join [PwC Bibitor LLC]..BegInvDec as b
On a.InventoryId = b.InventoryId

Select *
From [PwC Bibitor LLC]..#TempTable1


Select a.*
Into #TempTable2
From [PwC Bibitor LLC]..EndInvDec as a
inner join [PwC Bibitor LLC]..BegInvDec as b
On a.InventoryId = b.InventoryId

Select *
From [PwC Bibitor LLC]..#TempTable2

Select * 
From [PwC Bibitor LLC]..#TempTable1
Union 
select *
From [PwC Bibitor LLC]..#TempTable2