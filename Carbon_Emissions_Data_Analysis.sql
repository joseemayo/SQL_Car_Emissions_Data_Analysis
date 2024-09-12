-- Using Carbon Emissions Table (No null entries) --
SELECT * FROM CO2_Emissions_Canada;

SELECT Make, Model, Transmission, "Fuel Type", "Fuel Consumption Comb (mpg)", "CO2 Emissions(g/km)" 
FROM CO2_Emissions_Canada;

-- Finding top 10 highest C02 emission records --
SELECT Make, Model, "CO2 Emissions(g/km)"
FROM CO2_Emissions_Canada
Order By 3 DESC 
Limit 10;

-- Finding to 10 highest carbon emission by makes makes --
SELECT Make, ROUND(AVG("CO2 Emissions(g/km)"),2)
FROM CO2_Emissions_Canada
GROUP BY Make
ORDER BY 2 DESC
LIMIT 10;

-- Finding fuel type for vehicle make --
SELECT Make, "Fuel Type", COUNT("Fuel Type") FROM CO2_Emissions_Canada
GROUP BY Make, "Fuel Type"
ORDER BY 1, 3 DESC;

-- Finding the count of fuel types of the top 5 emisison vehicle makes --
SELECT Make, "Fuel Type", COUNT("Fuel Type") AS Count_Fuel
FROM CO2_Emissions_Canada
	WHERE Make IN
	(
		SELECT Make FROM (
		SELECT Make, AVG("CO2 Emissions(g/km)")
		FROM CO2_Emissions_Canada
		GROUP BY Make
		ORDER BY 2 DESC
		LIMIT 5
		)
	)
GROUP BY Make, "Fuel Type"
ORDER BY 3 DESC;

-- Finding transmission type by vehicle make --
SELECT Make, Transmission, COUNT(Transmission) AS Count_Transmission FROM CO2_Emissions_Canada
GROUP BY Make, Transmission
ORDER BY 1, 3 DESC;

-- Finding the average emissions per transmission type (SD and DF Calculated for reference) --
SELECT Transmission, ROUND(AVG("CO2 Emissions(g/km)"),2) AS Avg_Emissions,
ROUND(STDEV("CO2 Emissions(g/km)"),2) AS Std_Dev, COUNT(Transmission)-1 AS DF 
FROM CO2_Emissions_Canada
GROUP BY Transmission
ORDER BY 1 DESC;

-- Evaluating Emissions by vehicle class --
SELECT "Vehicle Class", COUNT("Vehicle Class") AS Count_VC, ROUND(AVG("CO2 Emissions(g/km)"),2) AS Avg_Emissions FROM CO2_Emissions_Canada
GROUP BY "Vehicle Class"
ORDER BY 3 DESC;