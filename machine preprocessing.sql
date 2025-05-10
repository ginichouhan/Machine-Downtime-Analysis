Use machinedowntime;

SHOW databases;

# Creating a table
CREATE TABLE Machine_Downtime_Preprocessed(
Date text,
Machine_ID text, 
Assembly_Line_No text, 
Hydraulic_Pressure double, 
Coolant_Pressure double, 
Air_System_Pressure double, 
Coolant_Temperature double, 
Hydraulic_Oil_Temperature double, 
Spindle_Bearing_Temperature double, 
Spindle_Vibration double, 
Tool_Vibration double, 
Spindle_Speed int, 
Voltage int, 
Torque double, 
Cutting double, 
Downtime text
);
drop table Machine_Downtime_Preprocessed;
SHOW TABLES;

SELECT * FROM Machine_Downtime_Preprocessed;

SHOW GLOBAL VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 'ON';
SET GLOBAL local_infile = 1;

# Importing the data from csv file into a table
LOAD DATA LOCAL INFILE 'C:/Users/ragin/OneDrive/Desktop/dataset/dataset sql/machine_downtime1.csv'
INTO TABLE Machine_Downtime_Preprocessed
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SET SQL_SAFE_UPDATES = 0;

SELECT * FROM Machine_Downtime_Preprocessed;

# -- Find duplicate values
# There are no duplicate values
SELECT Date, Machine_ID, Assembly_Line_No, Hydraulic_Pressure, Coolant_Pressure, 
		Air_System_Pressure, Coolant_Temperature, Hydraulic_Oil_Temperature, Spindle_Bearing_Temperature,
		Spindle_Vibration, Tool_Vibration, Spindle_Speed, Voltage, Torque, Cutting, Downtime, COUNT(*) AS duplicate_count
FROM Machine_Downtime_Preprocessed
GROUP BY Date, Machine_ID, Assembly_Line_No, Hydraulic_Pressure, Coolant_Pressure, 
		Air_System_Pressure, Coolant_Temperature, Hydraulic_Oil_Temperature, Spindle_Bearing_Temperature,
		Spindle_Vibration, Tool_Vibration, Spindle_Speed, Voltage, Torque, Cutting, Downtime
HAVING COUNT(*) > 1;

# -- Imputing missing values
# 1.  Missing values for Hydraulic_Pressure
SELECT Hydraulic_Pressure FROM Machine_Downtime_Preprocessed WHERE Hydraulic_Pressure = 0;

#Imputing missing values with mean
UPDATE Machine_Downtime_Preprocessed
SET Hydraulic_Pressure = ( SELECT * FROM (
    SELECT AVG(Hydraulic_Pressure)
    FROM Machine_Downtime_Preprocessed
    WHERE Hydraulic_Pressure != 0
) AS x) 
WHERE Hydraulic_Pressure = 0;

# 2.  Missing values for Coolant_Pressure
SELECT Coolant_Pressure FROM Machine_Downtime_Preprocessed WHERE Coolant_Pressure = 0;

#Imputing missing values with mean
UPDATE Machine_Downtime_Preprocessed
SET Coolant_Pressure = ( SELECT * FROM (
    SELECT AVG(Coolant_Pressure)
    FROM Machine_Downtime_Preprocessed
    WHERE Coolant_Pressure != 0
) AS x) 
WHERE Coolant_Pressure = 0;


# 3.  Missing values for Air_System_Pressure
SELECT Air_System_Pressure FROM Machine_Downtime_Preprocessed WHERE Air_System_Pressure = 0;

#Imputing missing values with mean
UPDATE Machine_Downtime_Preprocessed
SET Air_System_Pressure = ( SELECT * FROM (
    SELECT AVG(Air_System_Pressure)
    FROM Machine_Downtime_Preprocessed
    WHERE Air_System_Pressure != 0
) AS x) 
WHERE Air_System_Pressure = 0;

# 4.  Missing values for Coolant_Temperature
SELECT Coolant_Temperature FROM Machine_Downtime_Preprocessed WHERE Coolant_Temperature = 0;

#Imputing missing values with mean
UPDATE Machine_Downtime_Preprocessed
SET Coolant_Temperature = ( SELECT * FROM (
    SELECT AVG(Coolant_Temperature)
    FROM Machine_Downtime_Preprocessed
    WHERE Coolant_Temperature != 0
) AS x) 
WHERE Coolant_Temperature = 0;

# 5.  Missing values for Hydraulic_Oil_Temperature
SELECT Hydraulic_Oil_Temperature FROM Machine_Downtime_Preprocessed WHERE Hydraulic_Oil_Temperature = 0;

#Imputing missing values with mean
UPDATE Machine_Downtime_Preprocessed
SET Hydraulic_Oil_Temperature = ( SELECT * FROM (
    SELECT AVG(Hydraulic_Oil_Temperature)
    FROM Machine_Downtime_Preprocessed
    WHERE Hydraulic_Oil_Temperature != 0
) AS x) 
WHERE Hydraulic_Oil_Temperature = 0;

# 6.  Missing values for Spindle_Bearing_Temperature
SELECT Spindle_Bearing_Temperature FROM Machine_Downtime_Preprocessed WHERE Spindle_Bearing_Temperature = 0;

#Imputing missing values with mean
UPDATE Machine_Downtime_Preprocessed
SET Spindle_Bearing_Temperature = ( SELECT * FROM (
    SELECT AVG(Spindle_Bearing_Temperature)
    FROM Machine_Downtime_Preprocessed
    WHERE Spindle_Bearing_Temperature != 0
) AS x) 
WHERE Spindle_Bearing_Temperature = 0;

# 7.  Missing values for Spindle_Vibration
SELECT Spindle_Vibration FROM Machine_Downtime_Preprocessed WHERE Spindle_Vibration = 0;

#Imputing missing values with mean
UPDATE Machine_Downtime_Preprocessed
SET Spindle_Vibration = ( SELECT * FROM (
    SELECT AVG(Spindle_Vibration)
    FROM Machine_Downtime_Preprocessed
    WHERE Spindle_Vibration != 0
) AS x) 
WHERE Spindle_Vibration = 0;

# 8.  Missing values for Tool_Vibration
SELECT Tool_Vibration FROM Machine_Downtime_Preprocessed WHERE Tool_Vibration = 0;

#Imputing missing values with mean
UPDATE Machine_Downtime_Preprocessed
SET Tool_Vibration = ( SELECT * FROM (
    SELECT AVG(Tool_Vibration)
    FROM Machine_Downtime_Preprocessed
    WHERE Tool_Vibration != 0
) AS x) 
WHERE Tool_Vibration = 0;

# 9.  Missing values for Spindle_Speed
SELECT Spindle_Speed FROM Machine_Downtime_Preprocessed WHERE Spindle_Speed = 0;

#Imputing missing values with mean
UPDATE Machine_Downtime_Preprocessed
SET Spindle_Speed = ( SELECT * FROM (
    SELECT AVG(Spindle_Speed)
    FROM Machine_Downtime_Preprocessed
    WHERE Spindle_Speed != 0
) AS x) 
WHERE Spindle_Speed = 0;

# 10.  Missing values for Voltage
SELECT Voltage FROM Machine_Downtime_Preprocessed WHERE Voltage = 0;

#Imputing missing values with mean
UPDATE Machine_Downtime_Preprocessed
SET Voltage = ( SELECT * FROM (
    SELECT AVG(Voltage)
    FROM Machine_Downtime_Preprocessed
    WHERE Voltage != 0
) AS x) 
WHERE Voltage = 0;

# 11.  Missing values for Torque
SELECT Torque FROM Machine_Downtime_Preprocessed WHERE Torque = 0;

#Imputing missing values with mean
UPDATE Machine_Downtime_Preprocessed
SET Torque = ( SELECT * FROM (
    SELECT AVG(Torque)
    FROM Machine_Downtime_Preprocessed
    WHERE Torque != 0
) AS x) 
WHERE Torque = 0;

# 12.  Missing values for Cutting
SELECT Cutting FROM Machine_Downtime_Preprocessed WHERE Cutting = 0;

#Imputing missing values with mean
UPDATE Machine_Downtime_Preprocessed
SET Cutting = ( SELECT * FROM (
    SELECT AVG(Cutting)
    FROM Machine_Downtime_Preprocessed
    WHERE Cutting != 0
) AS x) 
WHERE Cutting = 0;

#Check again for missing values
SELECT
    SUM(CASE WHEN Date IS NULL THEN 1 ELSE 0 END) AS Missing_Date,
    SUM(CASE WHEN Machine_ID IS NULL THEN 1 ELSE 0 END) AS Missing_Machine_ID,
    SUM(CASE WHEN Assembly_Line_No IS NULL THEN 1 ELSE 0 END) AS Missing_Assembly_Line_No,
    SUM(CASE WHEN Hydraulic_Pressure = 0 THEN 1 ELSE 0 END) AS Missing_Hydraulic_Pressure,
    SUM(CASE WHEN Coolant_Pressure = 0 THEN 1 ELSE 0 END) AS Missing_Coolant_Pressure,
    SUM(CASE WHEN Air_System_Pressure = 0 THEN 1 ELSE 0 END) AS Missing_Air_System_Pressure,
    SUM(CASE WHEN Coolant_Temperature = 0 THEN 1 ELSE 0 END) AS Missing_Coolant_Temperature,
    SUM(CASE WHEN Hydraulic_Oil_Temperature = 0 THEN 1 ELSE 0 END) AS Missing_Hydraulic_Oil_Temperature,
    SUM(CASE WHEN Spindle_Bearing_Temperature = 0 THEN 1 ELSE 0 END) AS Missing_Spindle_Bearing_Temperature,
    SUM(CASE WHEN Spindle_Vibration = 0 THEN 1 ELSE 0 END) AS Missing_Spindle_Vibration,
    SUM(CASE WHEN Tool_Vibration = 0 THEN 1 ELSE 0 END) AS Missing_Tool_Vibration,
    SUM(CASE WHEN Spindle_Speed = 0 THEN 1 ELSE 0 END) AS Missing_Spindle_Speed,
    SUM(CASE WHEN Voltage = 0 THEN 1 ELSE 0 END) AS Missing_Voltage,
    SUM(CASE WHEN Torque = 0 THEN 1 ELSE 0 END) AS Missing_Torque,
    SUM(CASE WHEN Cutting = 0 THEN 1 ELSE 0 END) AS Missing_Cutting,
    SUM(CASE WHEN Downtime IS NULL THEN 1 ELSE 0 END) AS Missing_Downtime
FROM Machine_Downtime_Preprocessed;


# -- Finding outliers
#1. Hydraulic_Pressure
# 1 row : -14.32645418
SELECT *
FROM Machine_Downtime_Preprocessed
WHERE Hydraulic_Pressure > (SELECT mean_value + 3 * std_deviation FROM (SELECT AVG(Hydraulic_Pressure) AS mean_value, STDDEV(Hydraulic_Pressure) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats)
   OR Hydraulic_Pressure < (SELECT mean_value - 3 * std_deviation FROM (SELECT AVG(Hydraulic_Pressure) AS mean_value, STDDEV(Hydraulic_Pressure) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats);
   
#Imputing outliers with mean
UPDATE Machine_Downtime_Preprocessed
SET Hydraulic_Pressure =  ( SELECT * FROM ((SELECT AVG(Hydraulic_Pressure) FROM Machine_Downtime_Preprocessed)) AS x) 
WHERE Hydraulic_Pressure > (SELECT mean_value + 3 * std_deviation FROM (SELECT AVG(Hydraulic_Pressure) AS mean_value, STDDEV(Hydraulic_Pressure) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats)
   OR Hydraulic_Pressure < (SELECT mean_value - 3 * std_deviation FROM (SELECT AVG(Hydraulic_Pressure) AS mean_value, STDDEV(Hydraulic_Pressure) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats);
   
#2. Coolant_Pressure
# 3 outliers : 11.35, 11.3, 0.325
SELECT *
FROM Machine_Downtime_Preprocessed
WHERE Coolant_Pressure > (SELECT mean_value + 3 * std_deviation FROM (SELECT AVG(Coolant_Pressure) AS mean_value, STDDEV(Coolant_Pressure) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats)
   OR Coolant_Pressure < (SELECT mean_value - 3 * std_deviation FROM (SELECT AVG(Coolant_Pressure) AS mean_value, STDDEV(Coolant_Pressure) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats);
   
#Imputing outliers with mean
UPDATE Machine_Downtime_Preprocessed
SET Coolant_Pressure =  ( SELECT * FROM ((SELECT AVG(Coolant_Pressure) FROM Machine_Downtime_Preprocessed)) AS x) 
WHERE Coolant_Pressure > (SELECT mean_value + 3 * std_deviation FROM (SELECT AVG(Coolant_Pressure) AS mean_value, STDDEV(Coolant_Pressure) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats)
   OR Coolant_Pressure < (SELECT mean_value - 3 * std_deviation FROM (SELECT AVG(Coolant_Pressure) AS mean_value, STDDEV(Coolant_Pressure) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats);

#3. Air_System_Pressure
# 7 outliers : 5.091411159, 5.063480035, 7.971606819, 7.804750131, 7.973991528, 7.781150882, 5.151876018
SELECT *
FROM Machine_Downtime_Preprocessed
WHERE Air_System_Pressure > (SELECT mean_value + 3 * std_deviation FROM (SELECT AVG(Air_System_Pressure) AS mean_value, STDDEV(Air_System_Pressure) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats)
   OR Air_System_Pressure < (SELECT mean_value - 3 * std_deviation FROM (SELECT AVG(Air_System_Pressure) AS mean_value, STDDEV(Air_System_Pressure) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats);
   
#Imputing outliers with mean
UPDATE Machine_Downtime_Preprocessed
SET Air_System_Pressure =  ( SELECT * FROM ((SELECT AVG(Air_System_Pressure) FROM Machine_Downtime_Preprocessed)) AS x) 
WHERE Air_System_Pressure > (SELECT mean_value + 3 * std_deviation FROM (SELECT AVG(Air_System_Pressure) AS mean_value, STDDEV(Air_System_Pressure) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats)
   OR Air_System_Pressure < (SELECT mean_value - 3 * std_deviation FROM (SELECT AVG(Air_System_Pressure) AS mean_value, STDDEV(Air_System_Pressure) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats);

#4. Coolant_Temperature
# 1 outlier : 98.2
SELECT *
FROM Machine_Downtime_Preprocessed
WHERE Coolant_Temperature > (SELECT mean_value + 3 * std_deviation FROM (SELECT AVG(Coolant_Temperature) AS mean_value, STDDEV(Coolant_Temperature) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats)
   OR Coolant_Temperature < (SELECT mean_value - 3 * std_deviation FROM (SELECT AVG(Coolant_Temperature) AS mean_value, STDDEV(Coolant_Temperature) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats);
   
#Imputing outliers with mean
UPDATE Machine_Downtime_Preprocessed
SET Coolant_Temperature =  ( SELECT * FROM ((SELECT AVG(Coolant_Temperature) FROM Machine_Downtime_Preprocessed)) AS x) 
WHERE Coolant_Temperature > (SELECT mean_value + 3 * std_deviation FROM (SELECT AVG(Coolant_Temperature) AS mean_value, STDDEV(Coolant_Temperature) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats)
   OR Coolant_Temperature < (SELECT mean_value - 3 * std_deviation FROM (SELECT AVG(Coolant_Temperature) AS mean_value, STDDEV(Coolant_Temperature) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats);

#5. Hydraulic_Oil_Temperature
# 11 outliers : 59.5, 61.4, 59.2, 35.2, 60.3, 59.5, 36.2, 59.1, 36.1, 59.2, 35.8
SELECT *
FROM Machine_Downtime_Preprocessed
WHERE Hydraulic_Oil_Temperature > (SELECT mean_value + 3 * std_deviation FROM (SELECT AVG(Hydraulic_Oil_Temperature) AS mean_value, STDDEV(Hydraulic_Oil_Temperature) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats)
   OR Hydraulic_Oil_Temperature < (SELECT mean_value - 3 * std_deviation FROM (SELECT AVG(Hydraulic_Oil_Temperature) AS mean_value, STDDEV(Hydraulic_Oil_Temperature) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats);
   
#Imputing outliers with mean
UPDATE Machine_Downtime_Preprocessed
SET Hydraulic_Oil_Temperature =  ( SELECT * FROM ((SELECT AVG(Hydraulic_Oil_Temperature) FROM Machine_Downtime_Preprocessed)) AS x) 
WHERE Hydraulic_Oil_Temperature > (SELECT mean_value + 3 * std_deviation FROM (SELECT AVG(Hydraulic_Oil_Temperature) AS mean_value, STDDEV(Hydraulic_Oil_Temperature) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats)
   OR Hydraulic_Oil_Temperature < (SELECT mean_value - 3 * std_deviation FROM (SELECT AVG(Hydraulic_Oil_Temperature) AS mean_value, STDDEV(Hydraulic_Oil_Temperature) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats);

#6. Spindle_Bearing_Temperature
# 5 Outliers : 49.5, 23.2, 22.6, 23.5, 23.4
SELECT *
FROM Machine_Downtime_Preprocessed
WHERE Spindle_Bearing_Temperature > (SELECT mean_value + 3 * std_deviation FROM (SELECT AVG(Spindle_Bearing_Temperature) AS mean_value, STDDEV(Spindle_Bearing_Temperature) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats)
   OR Spindle_Bearing_Temperature < (SELECT mean_value - 3 * std_deviation FROM (SELECT AVG(Spindle_Bearing_Temperature) AS mean_value, STDDEV(Spindle_Bearing_Temperature) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats);
   
#Imputing outliers with mean
UPDATE Machine_Downtime_Preprocessed
SET Spindle_Bearing_Temperature =  ( SELECT * FROM ((SELECT AVG(Spindle_Bearing_Temperature) FROM Machine_Downtime_Preprocessed)) AS x) 
WHERE Spindle_Bearing_Temperature > (SELECT mean_value + 3 * std_deviation FROM (SELECT AVG(Spindle_Bearing_Temperature) AS mean_value, STDDEV(Spindle_Bearing_Temperature) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats)
   OR Spindle_Bearing_Temperature < (SELECT mean_value - 3 * std_deviation FROM (SELECT AVG(Spindle_Bearing_Temperature) AS mean_value, STDDEV(Spindle_Bearing_Temperature) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats);

#7. Spindle_Vibration
# 1 outlier : -0.461
SELECT *
FROM Machine_Downtime_Preprocessed
WHERE Spindle_Vibration > (SELECT mean_value + 3 * std_deviation FROM (SELECT AVG(Spindle_Vibration) AS mean_value, STDDEV(Spindle_Vibration) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats)
   OR Spindle_Vibration < (SELECT mean_value - 3 * std_deviation FROM (SELECT AVG(Spindle_Vibration) AS mean_value, STDDEV(Spindle_Vibration) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats);
   
#Imputing outliers with mean
UPDATE Machine_Downtime_Preprocessed
SET Spindle_Vibration =  ( SELECT * FROM ((SELECT AVG(Spindle_Vibration) FROM Machine_Downtime_Preprocessed)) AS x) 
WHERE Spindle_Vibration > (SELECT mean_value + 3 * std_deviation FROM (SELECT AVG(Spindle_Vibration) AS mean_value, STDDEV(Spindle_Vibration) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats)
   OR Spindle_Vibration < (SELECT mean_value - 3 * std_deviation FROM (SELECT AVG(Spindle_Vibration) AS mean_value, STDDEV(Spindle_Vibration) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats);

#8. Tool_Vibration
# 7 outliers : 2.161, 45.726, 5.892, 5.775, 44.839, 3.469, 45.492
SELECT *
FROM Machine_Downtime_Preprocessed
WHERE Tool_Vibration > (SELECT mean_value + 3 * std_deviation FROM (SELECT AVG(Tool_Vibration) AS mean_value, STDDEV(Tool_Vibration) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats)
   OR Tool_Vibration < (SELECT mean_value - 3 * std_deviation FROM (SELECT AVG(Tool_Vibration) AS mean_value, STDDEV(Tool_Vibration) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats);
   
#Imputing outliers with mean
UPDATE Machine_Downtime_Preprocessed
SET Tool_Vibration =  ( SELECT * FROM ((SELECT AVG(Tool_Vibration) FROM Machine_Downtime_Preprocessed)) AS x) 
WHERE Tool_Vibration > (SELECT mean_value + 3 * std_deviation FROM (SELECT AVG(Tool_Vibration) AS mean_value, STDDEV(Tool_Vibration) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats)
   OR Tool_Vibration < (SELECT mean_value - 3 * std_deviation FROM (SELECT AVG(Tool_Vibration) AS mean_value, STDDEV(Tool_Vibration) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats);

#9. Spindle_Speed
# No outliers
SELECT *
FROM Machine_Downtime_Preprocessed
WHERE Spindle_Speed > (SELECT mean_value + 3 * std_deviation FROM (SELECT AVG(Spindle_Speed) AS mean_value, STDDEV(Spindle_Speed) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats)
   OR Spindle_Speed < (SELECT mean_value - 3 * std_deviation FROM (SELECT AVG(Spindle_Speed) AS mean_value, STDDEV(Spindle_Speed) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats);
   
#Imputing outliers with mean
UPDATE Machine_Downtime_Preprocessed
SET Spindle_Speed =  ( SELECT * FROM ((SELECT AVG(Spindle_Speed) FROM Machine_Downtime_Preprocessed)) AS x) 
WHERE Spindle_Speed > (SELECT mean_value + 3 * std_deviation FROM (SELECT AVG(Spindle_Speed) AS mean_value, STDDEV(Spindle_Speed) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats)
   OR Spindle_Speed < (SELECT mean_value - 3 * std_deviation FROM (SELECT AVG(Spindle_Speed) AS mean_value, STDDEV(Spindle_Speed) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats);

#10. Voltage
# 4 outliers : 211, 202, 202, 207
SELECT *
FROM Machine_Downtime_Preprocessed
WHERE Voltage > (SELECT mean_value + 3 * std_deviation FROM (SELECT AVG(Voltage) AS mean_value, STDDEV(Voltage) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats)
   OR Voltage < (SELECT mean_value - 3 * std_deviation FROM (SELECT AVG(Voltage) AS mean_value, STDDEV(Voltage) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats);
   
#Imputing outliers with mean
UPDATE Machine_Downtime_Preprocessed
SET Voltage =  ( SELECT * FROM ((SELECT AVG(Voltage) FROM Machine_Downtime_Preprocessed)) AS x) 
WHERE Voltage > (SELECT mean_value + 3 * std_deviation FROM (SELECT AVG(Voltage) AS mean_value, STDDEV(Voltage) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats)
   OR Voltage < (SELECT mean_value - 3 * std_deviation FROM (SELECT AVG(Voltage) AS mean_value, STDDEV(Voltage) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats);

#11. Torque
# 1 outlier : 55.5524
SELECT *
FROM Machine_Downtime_Preprocessed
WHERE Torque > (SELECT mean_value + 3 * std_deviation FROM (SELECT AVG(Torque) AS mean_value, STDDEV(Torque) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats)
   OR Torque < (SELECT mean_value - 3 * std_deviation FROM (SELECT AVG(Torque) AS mean_value, STDDEV(Torque) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats);
   
#Imputing outliers with mean
UPDATE Machine_Downtime_Preprocessed
SET Torque =  ( SELECT * FROM ((SELECT AVG(Torque) FROM Machine_Downtime_Preprocessed)) AS x) 
WHERE Torque > (SELECT mean_value + 3 * std_deviation FROM (SELECT AVG(Torque) AS mean_value, STDDEV(Torque) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats)
   OR Torque < (SELECT mean_value - 3 * std_deviation FROM (SELECT AVG(Torque) AS mean_value, STDDEV(Torque) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats);

#12. Cutting
#no outliers
SELECT *
FROM Machine_Downtime_Preprocessed
WHERE Cutting > (SELECT mean_value + 3 * std_deviation FROM (SELECT AVG(Cutting) AS mean_value, STDDEV(Cutting) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats)
   OR Cutting < (SELECT mean_value - 3 * std_deviation FROM (SELECT AVG(Cutting) AS mean_value, STDDEV(Cutting) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats);
   
#Imputing outliers with mean
UPDATE Machine_Downtime_Preprocessed
SET Cutting =  ( SELECT * FROM ((SELECT AVG(Cutting) FROM Machine_Downtime_Preprocessed)) AS x) 
WHERE Cutting > (SELECT mean_value + 3 * std_deviation FROM (SELECT AVG(Cutting) AS mean_value, STDDEV(Cutting) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats)
   OR Cutting < (SELECT mean_value - 3 * std_deviation FROM (SELECT AVG(Cutting) AS mean_value, STDDEV(Cutting) AS std_deviation FROM Machine_Downtime_Preprocessed) AS stats);



#---------------EDA on Processed data---------------------------------

show GLOBAL VARIABLES like 'sql_mode'; 
         SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
         
# Displaying the processed records
SELECT * FROM Machine_Downtime_Preprocessed;

# EDA on Machine Downtime

# -- Shape of the data
# No of rows and No of columns

# --Count the number of records
# There are total 2500 rows in the dataset
SELECT count(*) FROM Machine_Downtime_Preprocessed;

# There are 16 columns
# Column names with datatypes
SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Machine_Downtime_Preprocessed';

# -- Check Data Types and Structure
DESCRIBE Machine_Downtime_Preprocessed;

# --Check for null values
# There are no null values
SELECT
    SUM(CASE WHEN Date IS NULL THEN 1 ELSE 0 END) AS Missing_Date,
    SUM(CASE WHEN Machine_ID IS NULL THEN 1 ELSE 0 END) AS Missing_Machine_ID,
    SUM(CASE WHEN Assembly_Line_No IS NULL THEN 1 ELSE 0 END) AS Missing_Assembly_Line_No,
    SUM(CASE WHEN Hydraulic_Pressure = 0 THEN 1 ELSE 0 END) AS Missing_Hydraulic_Pressure,
    SUM(CASE WHEN Coolant_Pressure = 0 THEN 1 ELSE 0 END) AS Missing_Coolant_Pressure,
    SUM(CASE WHEN Air_System_Pressure = 0 THEN 1 ELSE 0 END) AS Missing_Air_System_Pressure,
    SUM(CASE WHEN Coolant_Temperature = 0 THEN 1 ELSE 0 END) AS Missing_Coolant_Temperature,
    SUM(CASE WHEN Hydraulic_Oil_Temperature = 0 THEN 1 ELSE 0 END) AS Missing_Hydraulic_Oil_Temperature,
    SUM(CASE WHEN Spindle_Bearing_Temperature = 0 THEN 1 ELSE 0 END) AS Missing_Spindle_Bearing_Temperature,
    SUM(CASE WHEN Spindle_Vibration = 0 THEN 1 ELSE 0 END) AS Missing_Spindle_Vibration,
    SUM(CASE WHEN Tool_Vibration = 0 THEN 1 ELSE 0 END) AS Missing_Tool_Vibration,
    SUM(CASE WHEN Spindle_Speed = 0 THEN 1 ELSE 0 END) AS Missing_Spindle_Speed,
    SUM(CASE WHEN Voltage = 0 THEN 1 ELSE 0 END) AS Missing_Voltage,
    SUM(CASE WHEN Torque = 0 THEN 1 ELSE 0 END) AS Missing_Torque,
    SUM(CASE WHEN Cutting = 0 THEN 1 ELSE 0 END) AS Missing_Cutting,
    SUM(CASE WHEN Downtime IS NULL THEN 1 ELSE 0 END) AS Missing_Downtime
FROM Machine_Downtime_Preprocessed;

# -- Display first 5 rows
SELECT * FROM Machine_Downtime_Preprocessed LIMIT 5;

# -- Display last 5 rows
SELECT * FROM Machine_Downtime_Preprocessed ORDER BY Date DESC LIMIT 5;

# -- Display random 5 rows
SELECT * FROM Machine_Downtime_Preprocessed ORDER BY rand() LIMIT 5;

# There are 3 types of machines
SELECT DISTINCT(Machine_ID) FROM Machine_Downtime_Preprocessed;

# There are 3 assembly line numbers
SELECT DISTINCT(Assembly_Line_No) FROM Machine_Downtime_Preprocessed;

# There is a single machine in each assembly line. Makino-L1-Unit1-2013 in Shopfloor-L1; Makino-L2-Unit1-2015 in Shopfloor-L2 and 
# Makino-L3-Unit1-2015 in Shopfloor-L3
SELECT Machine_ID, Assembly_Line_No FROM Machine_Downtime_Preprocessed GROUP BY Assembly_Line_No;

#There are 2 categories with Machine_Failure and No_Machine_Failure categories
SELECT DISTINCT(Downtime) FROM Machine_Downtime_Preprocessed;

# There are 1265 rows data show machine failure and 1235 no machine failure
SELECT Downtime, count(*) FROM Machine_Downtime_Preprocessed GROUP BY Downtime;

# Count of machine failures
# Makino-L1-Unit1-2013	454
# Makino-L3-Unit1-2015	415
# Makino-L2-Unit1-2015	396
SELECT Machine_ID, count(Downtime)  FROM Machine_Downtime_Preprocessed WHERE Downtime LIKE 'Machine_Failure%' group by Machine_ID;

# Count of no machine failures
# Makino-L3-Unit1-2015	403
# Makino-L2-Unit1-2015	412
# Makino-L1-Unit1-2013	420
SELECT Machine_ID, count(Downtime)  FROM Machine_Downtime_Preprocessed WHERE Downtime LIKE 'No_Machine_Failure%' group by Machine_ID;

#Data is collected for 2 years 2021, 2022
SELECT DISTINCT(YEAR(Date)) FROM Machine_Downtime_Preprocessed;

#2021 (25 rows), 2022(2475 rows)
select year(Date) as years, count(*) as counts, 
round((count(*)/(select count(*) from machine_downtime4))* 100, 1) as perctg from Machine_Downtime_Preprocessed 
group by year(Date);

# --Find Time Series Analysis
SELECT Date, AVG(Hydraulic_Pressure) AS Avg_Hydraulic_Pressure FROM Machine_Downtime_Preprocessed GROUP BY Date ORDER BY Date;

SELECT Date, COUNT(*) AS Frequency FROM Machine_Downtime_Preprocessed GROUP BY Date;

SELECT Date, count(Downtime) as FrequencyDowntime FROM Machine_Downtime_Preprocessed WHERE Downtime LIKE 'Machine_Failure%' GROUP BY Date ORDER BY FrequencyDowntime DESC;

# March, February, April are the months machines most down
SELECT monthname(Date) AS Months, count(Downtime) as FrequencyDowntime FROM Machine_Downtime_Preprocessed WHERE Downtime LIKE 'Machine_Failure%' GROUP BY monthname(Date) ORDER BY FrequencyDowntime DESC;

SELECT dayname(Date) AS DayOfMonth, Date, count(Downtime) as FrequencyDowntime FROM Machine_Downtime_Preprocessed WHERE Downtime LIKE 'Machine_Failure%' GROUP BY dayname(Date), Date ORDER BY FrequencyDowntime DESC;

#Tuesday and Wednesday are the days most machines are down
SELECT dayname(Date) AS DayOfMonth, count(Downtime) as FrequencyDowntime FROM Machine_Downtime_Preprocessed WHERE Downtime LIKE 'Machine_Failure%' GROUP BY dayname(Date) ORDER BY FrequencyDowntime DESC;

# -- Find Data Distribution.
SELECT Hydraulic_Pressure, COUNT(*) AS Frequency FROM Machine_Downtime_Preprocessed GROUP BY Hydraulic_Pressure;

#--  Create a histogram for Hydraulic_Pressure
SELECT Hydraulic_Pressure, COUNT(*) AS Frequency FROM Machine_Downtime_Preprocessed GROUP BY Hydraulic_Pressure ORDER BY Hydraulic_Pressure;

#--  Calculate the average Hydraulic_Pressure by Machine_ID
SELECT Machine_ID, AVG(Hydraulic_Pressure) AS AvgHydraulicPressure FROM Machine_Downtime_Preprocessed GROUP BY Machine_ID;

#-- Summary statistics for Hydraulic_Pressure
SELECT
    AVG(Hydraulic_Pressure) AS AvgHydraulicPressure,
    MIN(Hydraulic_Pressure) AS MinHydraulicPressure,
    MAX(Hydraulic_Pressure) AS MaxHydraulicPressure,
    STDDEV(Hydraulic_Pressure) AS StdDevHydraulicPressure
FROM Machine_Downtime_Preprocessed;

SELECT Hydraulic_Pressure, Downtime FROM Machine_Downtime_Preprocessed WHERE Downtime LIKE 'Machine_Failure%' GROUP BY Hydraulic_Pressure ORDER BY Hydraulic_Pressure DESC;

# most machines are down when Hydraulic_Pressure is above 120
SELECT Hydraulic_Pressure, count(Downtime) AS FrequencyDowntime FROM Machine_Downtime_Preprocessed WHERE Downtime LIKE 'Machine_Failure%' GROUP BY Hydraulic_Pressure ORDER BY FrequencyDowntime DESC;

SELECT Hydraulic_Pressure, count(Downtime) AS FrequencyDowntime FROM Machine_Downtime_Preprocessed WHERE Downtime LIKE 'Machine_Failure%' AND Hydraulic_Pressure BETWEEN 100 AND 150 GROUP BY Hydraulic_Pressure ORDER BY FrequencyDowntime DESC;

#--  Calculate the average Coolant_Pressure by Machine_ID
SELECT Machine_ID, AVG(Coolant_Pressure) AS AvgCoolantPressure FROM Machine_Downtime_Preprocessed GROUP BY Machine_ID;

#-- Summary statistics for Coolant_Pressure
SELECT
    AVG(Coolant_Pressure) AS AvgCoolantPressure,
    MIN(Coolant_Pressure) AS MinCoolantPressure,
    MAX(Coolant_Pressure) AS MaxCoolantPressure,
    STDDEV(Coolant_Pressure) AS StdDevCoolantPressure
FROM Machine_Downtime_Preprocessed;

SELECT Coolant_Pressure, Downtime FROM Machine_Downtime_Preprocessed WHERE Downtime LIKE 'Machine_Failure%' GROUP BY Coolant_Pressure ORDER BY Coolant_Pressure DESC;

# most machines are down when Coolant_Pressure is above 5
SELECT Coolant_Pressure, count(Downtime) AS FrequencyDowntime FROM Machine_Downtime_Preprocessed WHERE Downtime LIKE 'Machine_Failure%' GROUP BY Coolant_Pressure ORDER BY FrequencyDowntime DESC;

#--  Calculate the average Air_System_Pressure by Machine_ID
SELECT Machine_ID, AVG(Air_System_Pressure) AS AvgAirSystemPressure FROM Machine_Downtime_Preprocessed GROUP BY Machine_ID;

#-- Summary statistics for Air_System_Pressure
SELECT
    AVG(Air_System_Pressure) AS AvgAirSystemPressure,
    MIN(Air_System_Pressure) AS MinAirSystemPressure,
    MAX(Air_System_Pressure) AS MaxAirSystemPressure,
    STDDEV(Air_System_Pressure) AS StdDevAirSystemPressure
FROM Machine_Downtime_Preprocessed;

SELECT Air_System_Pressure, Downtime FROM Machine_Downtime_Preprocessed WHERE Downtime LIKE 'Machine_Failure%' GROUP BY Air_System_Pressure ORDER BY Air_System_Pressure DESC;

# Air_System_Pressure is not affecting the machine downtime
SELECT Air_System_Pressure, count(Downtime) AS FrequencyDowntime FROM Machine_Downtime_Preprocessed WHERE Downtime LIKE 'Machine_Failure%' GROUP BY Air_System_Pressure ORDER BY FrequencyDowntime DESC;

# -- Find Data Distribution for Coolant_Temperature.
SELECT Coolant_Temperature, COUNT(*) AS Frequency FROM Machine_Downtime_Preprocessed GROUP BY Coolant_Temperature;

#--  Calculate the average Coolant_Temperature by Machine_ID
SELECT Machine_ID, AVG(Coolant_Temperature) AS AvgCoolantTemperature FROM Machine_Downtime_Preprocessed GROUP BY Machine_ID;

SELECT Coolant_Temperature, Downtime FROM Machine_Downtime_Preprocessed WHERE Downtime LIKE 'Machine_Failure%' GROUP BY Coolant_Temperature ORDER BY Coolant_Temperature DESC;

# most machines are down when coolant temperature is between 25 -30 degree C
SELECT Coolant_Temperature, count(Downtime) AS FrequencyDowntime FROM Machine_Downtime_Preprocessed WHERE Downtime LIKE 'Machine_Failure%' GROUP BY Coolant_Temperature ORDER BY FrequencyDowntime DESC;


#--  Calculate the average Hydraulic_Oil_Temperature by Machine_ID
SELECT Machine_ID, AVG(Hydraulic_Oil_Temperature) AS AvgHydraulicOilTemperature FROM Machine_Downtime_Preprocessed GROUP BY Machine_ID;

#-- Summary statistics for Hydraulic_Oil_Temperature
SELECT
    AVG(Hydraulic_Oil_Temperature) AS AvgHydraulicOilTemperature,
    MIN(Hydraulic_Oil_Temperature) AS MinHydraulicOilTemperature,
    MAX(Hydraulic_Oil_Temperature) AS MaxHydraulicOilTemperature,
    STDDEV(Hydraulic_Oil_Temperature) AS StdDevHydraulicOilTemperature
FROM Machine_Downtime_Preprocessed;

SELECT Hydraulic_Oil_Temperature, Downtime FROM Machine_Downtime_Preprocessed WHERE Downtime LIKE 'Machine_Failure%' GROUP BY Hydraulic_Oil_Temperature ORDER BY Hydraulic_Oil_Temperature DESC;

# most machines are down when Hydraulic_Oil_Temperature is between 45 -52 degree C
SELECT Hydraulic_Oil_Temperature, count(Downtime) AS FrequencyDowntime FROM Machine_Downtime_Preprocessed WHERE Downtime LIKE 'Machine_Failure%' GROUP BY Hydraulic_Oil_Temperature ORDER BY FrequencyDowntime DESC;


#--  Calculate the average Spindle_Bearing_Temperature by Machine_ID
SELECT Machine_ID, AVG(Spindle_Bearing_Temperature) AS AvgSpindleBearingTemperature FROM Machine_Downtime_Preprocessed GROUP BY Machine_ID;

#-- Summary statistics for Spindle_Bearing_Temperature
SELECT
    AVG(Spindle_Bearing_Temperature) AS AvgSpindleBearingTemperature,
    MIN(Spindle_Bearing_Temperature) AS MinSpindleBearingTemperature,
    MAX(Spindle_Bearing_Temperature) AS MaxSpindleBearingTemperature,
    STDDEV(Spindle_Bearing_Temperature) AS StdDevSpindleBearingTemperature
FROM Machine_Downtime_Preprocessed;

SELECT Spindle_Bearing_Temperature, Downtime FROM Machine_Downtime_Preprocessed WHERE Downtime LIKE 'Machine_Failure%' GROUP BY Spindle_Bearing_Temperature ORDER BY Spindle_Bearing_Temperature DESC;

# most machines are down when Spindle_Bearing_Temperature is between 35 -40 degree C
SELECT Spindle_Bearing_Temperature, count(Downtime) AS FrequencyDowntime FROM Machine_Downtime_Preprocessed WHERE Downtime LIKE 'Machine_Failure%' GROUP BY Spindle_Bearing_Temperature ORDER BY FrequencyDowntime DESC;

#-- Total downtime for Vibration ranges
# When vibration range is between 0.7 to 1.3 most machines are down
SELECT ROUND(Spindle_Vibration, 1) AS VibrationRange, count(Downtime) AS TotalDowntime
FROM Machine_Downtime_Preprocessed WHERE Downtime LIKE 'Machine_Failure%'  GROUP BY VibrationRange ORDER BY TotalDowntime DESC;

#--  Calculate the average Spindle_Vibration by Machine_ID
SELECT Machine_ID, AVG(Spindle_Vibration) AS AvgSpindleVibration FROM Machine_Downtime_Preprocessed GROUP BY Machine_ID;

#-- Summary statistics for Spindle_Vibration
SELECT
    AVG(Spindle_Vibration) AS AvgSpindleVibration,
    MIN(Spindle_Vibration) AS MinSpindleVibration,
    MAX(Spindle_Vibration) AS MaxSpindleVibration,
    STDDEV(Spindle_Vibration) AS StdDevSpindleVibration
FROM Machine_Downtime_Preprocessed;

#--  Bivariate analysis of Spindle_Vibration and machine downtime
SELECT Spindle_Vibration, Downtime FROM Machine_Downtime_Preprocessed GROUP BY Spindle_Vibration ORDER BY Spindle_Vibration DESC;

# When Spindle_Vibration is between 1.2 - 1.4, most machines are down
SELECT Spindle_Vibration, count(Downtime) AS FrequencyDowntime FROM Machine_Downtime_Preprocessed WHERE Downtime LIKE 'Machine_Failure%' GROUP BY Spindle_Vibration ORDER BY FrequencyDowntime DESC;


#--  Calculate the average Tool_Vibration by Machine_ID
SELECT Machine_ID, AVG(Tool_Vibration) AS AvgToolVibration FROM Machine_Downtime_Preprocessed GROUP BY Machine_ID;

#-- Summary statistics for Tool_Vibration
SELECT
    AVG(Tool_Vibration) AS AvgToolVibration,
    MIN(Tool_Vibration) AS MinToolVibration,
    MAX(Tool_Vibration) AS MaxToolVibration,
    STDDEV(Tool_Vibration) AS StdDevToolVibration
FROM Machine_Downtime_Preprocessed;

#--  Bivariate analysis of Tool_Vibration and machine downtime
SELECT Tool_Vibration, Downtime FROM Machine_Downtime_Preprocessed GROUP BY Tool_Vibration ORDER BY Tool_Vibration DESC;

# Tool_Vibration is not affecting machines to be down
SELECT Tool_Vibration, count(Downtime) AS FrequencyDowntime FROM Machine_Downtime_Preprocessed WHERE Downtime LIKE 'Machine_Failure%' GROUP BY Tool_Vibration ORDER BY FrequencyDowntime DESC;

#-- Relationship between Spindle Speed and Tool Vibration
SELECT Spindle_Speed, AVG(Tool_Vibration) AS AvgToolVibration FROM Machine_Downtime_Preprocessed GROUP BY Spindle_Speed;

#--  Calculate the average Spindle_Speed by Machine_ID
SELECT Machine_ID, AVG(Spindle_Speed) AS AvgSpindleSpeed FROM Machine_Downtime_Preprocessed GROUP BY Machine_ID;

#-- Summary statistics for Spindle_Speed
SELECT
    AVG(Spindle_Speed) AS AvgSpindleSpeed,
    MIN(Spindle_Speed) AS MinSpindleSpeed,
    MAX(Spindle_Speed) AS MaxSpindleSpeed,
    STDDEV(Spindle_Speed) AS StdDevSpindleSpeed
FROM Machine_Downtime_Preprocessed;

#--  Bivariate analysis of Spindle_Speed and machine downtime
SELECT Spindle_Speed, Downtime FROM Machine_Downtime_Preprocessed GROUP BY Spindle_Speed ORDER BY Spindle_Speed DESC;

# When spindle speed is greater than 20500, most machines are down
SELECT Spindle_Speed, count(Downtime) AS FrequencyDowntime FROM Machine_Downtime_Preprocessed WHERE Downtime LIKE 'Machine_Failure%' GROUP BY Spindle_Speed ORDER BY FrequencyDowntime DESC;

#-- Histogram for Voltage
SELECT FLOOR(Voltage) AS VoltageRange, COUNT(*) AS Frequency FROM Machine_Downtime_Preprocessed GROUP BY VoltageRange ORDER BY VoltageRange;

#-- Summary statistics for Voltage
SELECT
    AVG(Voltage) AS AvgVoltage,
    MIN(Voltage) AS MinVoltage,
    MAX(Voltage) AS MaxVoltage,
    STDDEV(Voltage) AS StdDevVoltage
FROM Machine_Downtime_Preprocessed;

# -- what is highest voltage 
select MAX( voltage) as highest_voltage from Machine_Downtime_Preprocessed;

# -- voltage  with downtime
select Downtime, MAX( voltage) from Machine_Downtime_Preprocessed;
select Downtime, min( voltage) from Machine_Downtime_Preprocessed where voltage != 0;
select Downtime, avg( voltage)  from Machine_Downtime_Preprocessed;

# Bivariate analysis
select Downtime, voltage, Machine_ID from Machine_Downtime_Preprocessed order by voltage;

# When voltage is between 340 - 363, most machines are down
SELECT voltage, count(Downtime) AS FrequencyDowntime FROM Machine_Downtime_Preprocessed WHERE Downtime LIKE 'Machine_Failure%' GROUP BY voltage ORDER BY FrequencyDowntime DESC;


#--  Calculate the average Cutting force by Machine_ID
SELECT Machine_ID, AVG(Cutting) AS AvgCutting FROM Machine_Downtime_Preprocessed GROUP BY Machine_ID;

#--  Bivariate analysis of cutting and machine downtime
SELECT Cutting, Downtime FROM Machine_Downtime_Preprocessed GROUP BY Cutting ORDER BY Cutting DESC;

# most machines are down when Cutting force is above 3kN
SELECT Cutting, count(Downtime) AS FrequencyDowntime FROM Machine_Downtime_Preprocessed WHERE Downtime LIKE 'Machine_Failure%' GROUP BY Cutting ORDER BY FrequencyDowntime DESC;


#--  Calculate the average Torque by Machine_ID
SELECT Machine_ID, AVG(Torque) AS AvgTorque FROM Machine_Downtime_Preprocessed GROUP BY Machine_ID;

#-- Summary statistics for Torque
SELECT
    AVG(Torque) AS AvgTorque,
    MIN(Torque) AS MinTorque,
    MAX(Torque) AS MaxTorque,
    STDDEV(Torque) AS StdDevTorque
FROM Machine_Downtime_Preprocessed;

#--  Bivariate analysis of Torque and machine downtime
SELECT Torque, Downtime FROM Machine_Downtime_Preprocessed GROUP BY Torque ORDER BY Torque DESC;

# most machines are down when Torque is less than 20Nm
SELECT Torque, count(Downtime) AS FrequencyDowntime FROM Machine_Downtime_Preprocessed WHERE Downtime LIKE 'Machine_Failure%' GROUP BY Torque ORDER BY FrequencyDowntime DESC;



