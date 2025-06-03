SELECT*
FROM CLEAN..DataClean


-----CHANGING DATE FORMAT
SELECT SaleDate, CONVERT(Date,SaleDate)
FROM CLEAN..DataClean

Update CLEAN..DataClean 
SET SaleDate = CONVERT(Date,SaleDate)

ALTER TABLE DataClean
ADD SaleDateConverted Date;

Update CLEAN..DataClean 
SET SaleDateConverted = CONVERT(Date,SaleDate)


SELECT SaleDateConverted, CONVERT(Date,SaleDate)
FROM CLEAN..DataClean

----PROPETRY ADDRESS


SELECT *
FROM CLEAN..DataClean
--WHERE PropertyAddress is null
ORDER BY ParcelID


SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM CLEAN..DataClean a
JOIN CLEAN..DataClean b
  ON a.ParcelID = b.ParcelID 
  AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress is null

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM CLEAN..DataClean a
JOIN CLEAN..DataClean b
  ON a.ParcelID = b.ParcelID 
  AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress is null


-------- BREAKING INTO IN DIVIUAL COLOUMS (ADDRESS, CITY,STATE)

 SELECT PropertyAddress
FROM CLEAN..DataClean

 SELECT
 SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1) as Address, 
 SUBSTRING(PropertyAddress,  CHARINDEX(',',PropertyAddress)+1, LEN(PropertyAddress)) as Address

 FROM CLEAN..DataClean


 ALTER TABLE DataClean
 ADD New_Property_Address Nvarchar(255);

 Update CLEAN..DataClean 
SET New_Property_Address =  SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1)


ALTER TABLE DataClean
ADD New_Property_City Nvarchar(255);

Update CLEAN..DataClean 
SET New_Property_City= SUBSTRING(PropertyAddress,  CHARINDEX(',',PropertyAddress)+1, LEN(PropertyAddress)) 


------  OWNER ADDRESS

SELECT
PARSENAME(REPLACE(OwnerAddress, ',', '.'),3),
PARSENAME(REPLACE(OwnerAddress, ',', '.'),2),
PARSENAME(REPLACE(OwnerAddress, ',', '.'),1) 
FROM CLEAN..DataClean


 ALTER TABLE DataClean
 ADD New_Owner_Address Nvarchar(255);

 Update CLEAN..DataClean 
SET New_Owner_Address =  PARSENAME(REPLACE(OwnerAddress, ',', '.'),3)


ALTER TABLE DataClean
ADD New_Owner_City Nvarchar(255);

Update CLEAN..DataClean 
SET New_Owner_City= PARSENAME(REPLACE(OwnerAddress, ',', '.'),2)


 ALTER TABLE DataClean
 ADD New_Owner_State Nvarchar(255);

 Update CLEAN..DataClean 
SET New_Owner_State = PARSENAME(REPLACE(OwnerAddress, ',', '.'),1)

----- CHANGE Y and N to YES and NO in "SoldAsVacant"


SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
FROM CLEAN..DataClean
GROUP BY SoldAsVacant
ORDER BY 2


SELECT SoldAsVacant,
 CASE WHEN SoldAsVacant ='Y' THEN 'Yes'
      WHEN SoldAsVacant = 'N' THEN 'No'
	  ELSE SoldAsVacant
	  END
FROM CLEAN..DataClean


 Update CLEAN..DataClean 
SET SoldAsVacant = CASE WHEN SoldAsVacant ='Y' THEN 'Yes'
      WHEN SoldAsVacant = 'N' THEN 'No'
	  ELSE SoldAsVacant
	  END



------ DUPLICATES

WITH ROWNUMCT AS(
 SELECT*,
 ROW_NUMBER() OVER ( PARTITION BY ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference 
 ORDER BY  [UniqueID ]) row_num
FROM CLEAN..DataClean
)

SELECT*
FROM ROWNUMCT
WHERE row_num > 1
--ORDER BY PropertyAddress



------- DELETE COLUMS  NOT USED 

SELECT*
FROM CLEAN..DataClean


ALTER TABLE CLEAN..DataClean
DROP COLUMN OwnerAddress, PropertyAddress, TaxDistrict


ALTER TABLE CLEAN..DataClean
DROP COLUMN SaleDate