# Creating a database
CREATE DATABASE MachineDowntime;

# To work on current database
USE machinedowntime;

# Check and set variable for importing the data from local file
SHOW GLOBAL VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 'ON';
SET GLOBAL local_infile = 1;

# Creating a table
CREATE TABLE Machine(
Date date,
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


SHOW tables;

# Importing the data from csv file into a table
LOAD DATA LOCAL INFILE 'C:/Users/ragin/OneDrive/Desktop/dataset/dataset sql/down/machine.csv'
INTO TABLE machine
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

# Displaying the imported records
SELECT * FROM machine;

# EDA on Machine Downtime

# -- Shape of the data
# No of rows and No of columns

# --Count the number of records
# There are total 2500 rows in the dataset
SELECT count(*) FROM machine;

# There are 16 columns
# Column names with datatypes
# Date(date), Machine_ID(text), Assembly_Line_No(text), Hydraulic_Pressure(double), Coolant_Pressure(double), Air_System_Pressure(double), 
# Coolant_Temperature(double), Hydraulic_Oil_Temperature(double), Spindle_Bearing_Temperature(double), Spindle_Vibration(double),
# Tool_Vibration(double), Spindle_Speed(int), Voltage(int), Torque(double), Cutting(double), Downtime(text)
# Null values can be stored in all columns. There is no primary key.
SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'machine';

# -- Check Data Types and Structure
DESCRIBE machine;

# -- Display first 10 rows
SELECT * FROM machine LIMIT 10 ;

# -- Display last 10 rows
SELECT * FROM machine ORDER BY Date DESC LIMIT 10;

# -- Display random 5 rows
SELECT * FROM machine ORDER BY rand() LIMIT 10;

# --Check for null values
# Date, Machine_ID, Assembly_Line_No, Downtime columns have no null values
# Hydraulic_Pressure has 10 null values
# Coolant_Pressure has 19 null values
# Air_System_Pressure has 17 null values
# Coolant_Temperature has 12 null values
# Hydraulic_Oil_Temperature has 16 null values
# Spindle_Bearing_Temperature has 7 null values
# Spindle_Vibration has 11 null values
# Tool_Vibration has 11 null values
# Spindle_Speed has 13 null values
# Voltage has 6 null values
# Torque has 23 null values
# Cutting has 7 null values
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
FROM machine;

# There are 3 types of machines
SELECT DISTINCT(Machine_ID) FROM machine;

# There are 3 assembly line numbers
SELECT DISTINCT(Assembly_Line_No) FROM machine;

# There is a single machine in each assembly line. Makino-L1-Unit1-2013 in Shopfloor-L1; Makino-L2-Unit1-2015 in Shopfloor-L2 and 
# Makino-L3-Unit1-2015 in Shopfloor-L3
SELECT Machine_ID, Assembly_Line_No FROM machine GROUP BY Assembly_Line_No;

#There are 2 categories with Machine_Failure and No_Machine_Failure categories
SELECT DISTINCT(Downtime) FROM machine;

# There are 1265 rows data show machine failure and 1235 no machine failure
SELECT Downtime, count(*) FROM machine GROUP BY Downtime;

# Count of machine failures
# Makino-L1-Unit1-2013	454
# Makino-L3-Unit1-2015	415
# Makino-L2-Unit1-2015	396
SELECT Machine_ID, count(Downtime)  FROM machine WHERE Downtime LIKE 'Machine_Failure%' group by Machine_ID;

# Count of no machine failures
# Makino-L3-Unit1-2015	403
# Makino-L2-Unit1-2015	412
# Makino-L1-Unit1-2013	420
SELECT Machine_ID, count(Downtime)  FROM machine WHERE Downtime LIKE 'No_Machine_Failure%' group by Machine_ID;

#Data is collected for 2 years 2021, 2022
SELECT DISTINCT(YEAR(Date)) FROM machine;

# -- Display count, min, max, avg, std values for a column
# column - Hydraulic_Pressure
# count - 2500
# min - -14.32645418
# max - 191
# avg - 101.0034474424439
# std - 30.89297100377616
SELECT
    COUNT(Hydraulic_Pressure) AS Count_Hydraulic_Pressure,
    MIN(Hydraulic_Pressure) AS Min_Hydraulic_Pressure,
    MAX(Hydraulic_Pressure) AS Max_Hydraulic_Pressure,
    AVG(Hydraulic_Pressure) AS Avg_Hydraulic_Pressure,
    STDDEV(Hydraulic_Pressure) AS StdDev_Hydraulic_Pressure
FROM machine;

# --Find Time Series Analysis
SELECT Date, AVG(Hydraulic_Pressure) AS Avg_Hydraulic_Pressure FROM machine GROUP BY Date ORDER BY Date;

SELECT Date, COUNT(*) AS Frequency FROM machine GROUP BY Date;

SELECT Date, count(Downtime) as FrequencyDowntime FROM machine WHERE Downtime LIKE 'Machine_Failure%' GROUP BY Date ORDER BY FrequencyDowntime DESC;

# March, February, April are the months machines most down
SELECT monthname(Date) AS Months, count(Downtime) as FrequencyDowntime FROM machine WHERE Downtime LIKE 'Machine_Failure%' GROUP BY monthname(Date) ORDER BY FrequencyDowntime DESC;

SELECT dayname(Date) AS DayOfMonth, Date, count(Downtime) as FrequencyDowntime FROM machine WHERE Downtime LIKE 'Machine_Failure%' GROUP BY dayname(Date), Date ORDER BY FrequencyDowntime DESC;

#Tuesday and Wednesday are the days most machines are down
SELECT dayname(Date) AS DayOfMonth, count(Downtime) as FrequencyDowntime FROM machine WHERE Downtime LIKE 'Machine_Failure%' GROUP BY dayname(Date) ORDER BY FrequencyDowntime DESC;

# -- Find Data Distribution.
SELECT Hydraulic_Pressure, COUNT(*) AS Frequency FROM machine GROUP BY Hydraulic_Pressure;

#--  Create a histogram for Hydraulic_Pressure
SELECT Hydraulic_Pressure, COUNT(*) AS Frequency FROM machine GROUP BY Hydraulic_Pressure ORDER BY Hydraulic_Pressure;

#--  Calculate the average Hydraulic_Pressure by Machine_ID
SELECT Machine_ID, AVG(Hydraulic_Pressure) AS AvgHydraulicPressure FROM machine GROUP BY Machine_ID;

# -- Find Data Distribution for Coolant_Temperature.
SELECT Coolant_Temperature, COUNT(*) AS Frequency FROM machine GROUP BY Coolant_Temperature;

#--  Calculate the average Coolant_Temperature by Machine_ID
SELECT Machine_ID, AVG(Coolant_Temperature) AS AvgCoolantTemperature FROM machine GROUP BY Machine_ID;

SELECT Coolant_Temperature, Downtime FROM machine WHERE Downtime LIKE 'Machine_Failure%' GROUP BY Coolant_Temperature ORDER BY Coolant_Temperature DESC;

# most machines are down when coolant temperature is between 25 -30 degree C
SELECT Coolant_Temperature, count(Downtime) AS FrequencyDowntime FROM machine WHERE Downtime LIKE 'Machine_Failure%' GROUP BY Coolant_Temperature ORDER BY FrequencyDowntime DESC;

#-- Total downtime for Vibration ranges
# When vibration range is between 0.7 to 1.3 most machines are down
SELECT ROUND(Spindle_Vibration, 1) AS VibrationRange, count(Downtime) AS TotalDowntime
FROM machine WHERE Downtime LIKE 'Machine_Failure%'  GROUP BY VibrationRange ORDER BY TotalDowntime DESC;

#--  Calculate the average Spindle_Vibration by Machine_ID
SELECT Machine_ID, AVG(Spindle_Vibration) AS AvgSpindleVibration FROM machine GROUP BY Machine_ID;

#-- Summary statistics for Spindle_Vibration
SELECT
    AVG(Spindle_Vibration) AS AvgSpindleVibration,
    MIN(Spindle_Vibration) AS MinSpindleVibration,
    MAX(Spindle_Vibration) AS MaxSpindleVibration,
    STDDEV(Spindle_Vibration) AS StdDevSpindleVibration
FROM machine;

#--  Bivariate analysis of Spindle_Vibration and machine downtime
SELECT Spindle_Vibration, Downtime FROM machine GROUP BY Spindle_Vibration ORDER BY Spindle_Vibration DESC;

# When Spindle_Vibration is between 1.2 - 1.4, most machines are down
SELECT Spindle_Vibration, count(Downtime) AS FrequencyDowntime FROM machine WHERE Downtime LIKE 'Machine_Failure%' GROUP BY Spindle_Vibration ORDER BY FrequencyDowntime DESC;

#-- Relationship between Spindle Speed and Tool Vibration
SELECT Spindle_Speed, AVG(Tool_Vibration) AS AvgToolVibration FROM machine GROUP BY Spindle_Speed;

#--  Calculate the average Spindle_Speed force by Machine_ID
SELECT Machine_ID, AVG(Spindle_Speed) AS AvgSpindleSpeed FROM machine GROUP BY Machine_ID;

#-- Summary statistics for Spindle_Speed
SELECT
    AVG(Spindle_Speed) AS AvgSpindleSpeed,
    MIN(Spindle_Speed) AS MinSpindleSpeed,
    MAX(Spindle_Speed) AS MaxSpindleSpeed,
    STDDEV(Spindle_Speed) AS StdDevSpindleSpeed
FROM machine;

#--  Bivariate analysis of Spindle_Speed and machine downtime
SELECT Spindle_Speed, Downtime FROM machine GROUP BY Spindle_Speed ORDER BY Spindle_Speed DESC;

# When spindle speed is greater than 20500, most machines are down
SELECT Spindle_Speed, count(Downtime) AS FrequencyDowntime FROM machine WHERE Downtime LIKE 'Machine_Failure%' GROUP BY Spindle_Speed ORDER BY FrequencyDowntime DESC;

#-- Histogram for Voltage
SELECT FLOOR(Voltage) AS VoltageRange, COUNT(*) AS Frequency FROM machine GROUP BY VoltageRange ORDER BY VoltageRange;

#-- Summary statistics for Voltage
SELECT
    AVG(Voltage) AS AvgVoltage,
    MIN(Voltage) AS MinVoltage,
    MAX(Voltage) AS MaxVoltage,
    STDDEV(Voltage) AS StdDevVoltage
FROM machine;

# -- what is highest voltage 
select MAX( voltage) as highest_voltage from machine;

# -- voltage  with downtime
select Downtime, MAX( voltage) from machine;
select Downtime, min( voltage) from machine where voltage != 0;
select Downtime, avg( voltage)  from machine;

# Bivariate analysis
select Downtime, voltage, Machine_ID from machine order by voltage;

# When voltage is between 340 - 363, most machines are down
SELECT voltage, count(Downtime) AS FrequencyDowntime FROM machine WHERE Downtime LIKE 'Machine_Failure%' GROUP BY voltage ORDER BY FrequencyDowntime DESC;


#--  Calculate the average Cutting force by Machine_ID
SELECT Machine_ID, AVG(Cutting) AS AvgCutting FROM machine GROUP BY Machine_ID;

#--  Bivariate analysis of cutting and machine downtime
SELECT Cutting, Downtime FROM machine GROUP BY Cutting ORDER BY Cutting DESC;

# most machines are down when Cutting force is above 3kN
SELECT Cutting, count(Downtime) AS FrequencyDowntime FROM machine WHERE Downtime LIKE 'Machine_Failure%' GROUP BY Cutting ORDER BY FrequencyDowntime DESC;


#--  Calculate the average Torque force by Machine_ID
SELECT Machine_ID, AVG(Torque) AS AvgTorque FROM machine GROUP BY Machine_ID;

#-- Summary statistics for Torque
SELECT
    AVG(Torque) AS AvgTorque,
    MIN(Torque) AS MinTorque,
    MAX(Torque) AS MaxTorque,
    STDDEV(Torque) AS StdDevTorque
FROM machine;

#--  Bivariate analysis of Torque and machine downtime
SELECT Torque, Downtime FROM machine GROUP BY Torque ORDER BY Torque DESC;

# most machines are down when Torque is less than 20Nm
SELECT Torque, count(Downtime) AS FrequencyDowntime FROM machine WHERE Downtime LIKE 'Machine_Failure%' GROUP BY Torque ORDER BY FrequencyDowntime DESC;

show GLOBAL VARIABLES like 'sql_mode'; 
         SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

