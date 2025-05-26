
SELECT continent, location, date, new_vaccinations, SUM(CAST(new_vaccinations as int)) OVER (Partition by location)
FROM global..vac$ 

WHERE continent is not null and continent like 'Europe'


SELECT va.continent, va.location, va.date, va.date, dea.population, va.new_vaccinations,SUM(CONVERT(int,va.new_vaccinations)) OVER (Partition by va.location)
FROM global..['new death$'] dea
JOIN global..vac$ va
 On dea.location = va.location
 and dea.date = va.date
WHERE va.continent is not null and va.continent like 'Europe'



SELECT continent, location,  date, new_vaccinations,SUM(CONVERT(int,new_vaccinations)) OVER (Partition by location)
FROM global..vac$
 
WHERE continent is not null and continent like 'Europe'



SELECT*
FROM global..['new death$'] deh
JOIN global..vac$ va
 ON deh.location = va.location 
 AND deh.date = va.date
WHERE va.iso_code like 'GRD'

---Total Number Of people vaccinated


 SELECT*
FROM global..['new death$'] deh
JOIN global..vac$ va
 ON deh.location = va.location 
 AND deh.date = va.date


 SELECT deh.continent, deh.location, deh.date, deh.population, va.new_vaccinations
FROM global..['new death$'] deh
JOIN global..vac$ va
 ON deh.location = va.location 
 AND deh.date = va.date
 WHERE deh.continent is not null 
 ORDER BY 2,3

 -----Total vacinations per country

  SELECT deh.continent, deh.location, deh.date, deh.population, va.new_vaccinations, SUM(cast(va.new_vaccinations as int))  OVER(PARTITION BY deh.location ORDER BY deh.location, deh.date) as total_new_vacinated
FROM global..['new death$'] deh
JOIN global..vac$ va
 ON deh.location = va.location 
 AND deh.date = va.date
 WHERE deh.continent is not null 
 ORDER BY 2,3



 ----- USING CTE 

 WITH POPU_VS_VAC (Contintent, Location, Date, Population, New_Vaccinations, Total_New_Vaccinated)
 as
 (SELECT deh.continent, deh.location, deh.date, deh.population, va.new_vaccinations, SUM(cast(va.new_vaccinations as int))  OVER(PARTITION BY deh.location ORDER BY deh.location, deh.date) as total_new_vaccinated
FROM global..['new death$'] deh
JOIN global..vac$ va
 ON deh.location = va.location 
 AND deh.date = va.date
 WHERE deh.continent is not null 
 --ORDER BY 2,3
 )

 SELECT*, (Total_New_Vaccinated/Population)*100 as Percent_Vaccination_Country
 FROM POPU_VS_VAC
 WHERE Location = 'Albania'

 -----OR YOU CAN DO

 --- TEMP TABLE
 DROP TABLE IF exists #POPULATIONVACCINATED
 CREATE TABLE #POPULATIONVACCINATED
 (
 Continent nvarchar(255),
 Location nvarchar(255),
 Date datetime,
 Population numeric,
 New_Vaccinations numeric,
 Total_New_Vaccinated numeric
 )

 Insert into #POPULATIONVACCINATED
 SELECT deh.continent, deh.location, deh.date, deh.population, va.new_vaccinations, SUM(cast(va.new_vaccinations as int))  OVER(PARTITION BY deh.location ORDER BY deh.location, deh.date) as total_new_vacinated
FROM global..['new death$'] deh
JOIN global..vac$ va
 ON deh.location = va.location 
 AND deh.date = va.date
 WHERE deh.continent is not null 
 --ORDER BY 2,3
 
 SELECT*, (Total_New_Vaccinated/Population)*100 as Percent_Vaccination_Country
 FROM #POPULATIONVACCINATED
 WHERE Location = 'Albania'


 ---VIEW FOR DATA
 Create View p as
 SELECT deh.continent, deh.location, deh.date, deh.population, va.new_vaccinations, SUM(cast(va.new_vaccinations as int))  OVER(PARTITION BY deh.location ORDER BY deh.location, deh.date) as total_new_vacinated
FROM global..['new death$'] deh
JOIN global..vac$ va
 ON deh.location = va.location 
 AND deh.date = va.date
 WHERE deh.continent is not null 


 select*
 from p