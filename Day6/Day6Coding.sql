Create database Day6_Coding;
use Day6_Coding;
CREATE TABLE farmers ( 
    farmer_id INT PRIMARY KEY, 
    first_name VARCHAR(50) NOT NULL, 
    last_name VARCHAR(50) NOT NULL, 
    email VARCHAR(100) UNIQUE, 
    hire_date DATE 
); 

INSERT INTO farmers (farmer_id, first_name, last_name, email, hire_date) VALUES 
(1, 'John', 'Doe', 'john.doe@agri-innovate.com', '2020-05-15'), 
(2, 'Jane', 'Smith', 'jane.smith@agri-innovate.com', '2021-02-20'), 
(3, 'Peter', 'Jones', 'peter.jones@agri-innovate.com', '2020-11-10'), 
(4, 'Maria', 'Garcia', 'maria.garcia@agri-innovate.com', '2022-08-01'), 
(5, 'Alex', 'Chen', 'alex.chen@agri-innovate.com', '2023-03-25'); 
select * from farmers;

CREATE TABLE plots ( 
    plot_id INT PRIMARY KEY, 
    plot_name VARCHAR(100) NOT NULL, 
    farmer_id INT, 
    crop_type VARCHAR(50) NOT NULL, 
    soil_type VARCHAR(50), 
    FOREIGN KEY (farmer_id) REFERENCES farmers(farmer_id) 
); 

INSERT INTO plots (plot_id, plot_name, farmer_id, crop_type, soil_type) VALUES 
(101, 'West Field', 1, 'Wheat', 'Loam'), 
(102, 'North Pasture', 2, 'Corn', 'Clay'), 
(103, 'South Farm', 1, 'Soybeans', 'Sand'), 
(104, 'East Meadow', 3, 'Wheat', 'Loam'), 
(105, 'Plot A', 4, 'Corn', 'Clay'), 
(106, 'Plot B', 5, 'Soybeans', 'Sand'), 
(107, 'High Plains', 3, 'Corn', 'Loam'), 
(108, 'Valley View', 2, 'Wheat', 'Clay'); 
select * from plots;

CREATE TABLE yields ( 
    yield_id INT PRIMARY KEY, 
    plot_id INT, 
    harvest_date DATE, 
    yield_kg DECIMAL(10, 2), 
    weather_condition VARCHAR(50), 
    FOREIGN KEY (plot_id) REFERENCES plots(plot_id) 
); 

INSERT INTO yields (yield_id, plot_id, harvest_date, yield_kg, weather_condition) VALUES 
(1, 101, '2024-07-20', 1500.50, 'Sunny'), 
(2, 102, '2024-09-15', 2100.75, 'Rainy'), 
(3, 103, '2024-10-01', 950.20, 'Mild'), 
(4, 104, '2024-07-25', 1650.30, 'Sunny'), 
(5, 105, '2024-09-18', 2200.10, 'Rainy'), 
(6, 106, '2024-10-05', 880.90, 'Mild'), 
(7, 107, '2024-09-20', 2350.40, 'Sunny'), 
(8, 108, '2024-08-01', 1450.60, 'Mild'), 
(9, 101, '2023-07-19', 1400.00, 'Rainy'), 
(10, 102, '2023-09-14', 2050.00, 'Sunny'), 
(11, 103, '2023-10-02', 900.00, 'Mild'), 
(12, 104, '2023-07-24', 1550.00, 'Rainy'), 
(13, 105, '2023-09-17', 2150.00, 'Sunny'), 
(14, 106, '2023-10-04', 850.00, 'Mild'), 
(15, 107, '2023-09-19', 2250.00, 'Rainy'), 
(16, 108, '2023-07-31', 1350.00, 'Mild'), 
(17, 101, '2022-07-21', 1300.00, 'Sunny'), 
(18, 102, '2022-09-16', 2000.00, 'Rainy'), 
(19, 103, '2022-10-03', 800.00, 'Mild'), 
(20, 104, '2022-07-26', 1500.00, 'Sunny'); 

select * from yields;


CREATE TABLE irrigation_logs ( 
    log_id INT PRIMARY KEY, 
    plot_id INT, 
    irrigation_date DATE, 
    water_amount_liters DECIMAL(10, 2), 
    FOREIGN KEY (plot_id) REFERENCES plots(plot_id));
    
INSERT INTO irrigation_logs (log_id, plot_id, irrigation_date, water_amount_liters) VALUES 
(1, 101, '2024-05-10', 50000.00), 
(2, 102, '2024-06-12', 75000.00), 
(3, 103, '2024-07-15', 30000.00), 
(4, 104, '2024-05-12', 45000.00), 
(5, 105, '2024-06-15', 80000.00), 
(6, 106, '2024-07-18', 25000.00), 
(7, 107, '2024-06-20', 70000.00), 
(8, 108, '2024-05-25', 55000.00), 
(9, 101, '2023-05-11', 48000.00), 
(10, 102, '2023-06-13', 72000.00), 
(11, 103, '2023-07-16', 28000.00), 
(12, 104, '2023-05-13', 43000.00), 
(13, 105, '2023-06-16', 78000.00), 
(14, 106, '2023-07-19', 23000.00), 
(15, 107, '2023-06-21', 68000.00); 

select * from irrigation_logs;

/*The Tasks  

1. Productivity & Performance 
• Identify the top 3 most productive plots based on average yield per harvest. Show the 
plot_name, crop_type, and average_yield_kg. 
• Calculate the total water consumption for each plot and rank them from highest to 
lowest. Show plot_name and total_water_liters.*/

select p.plot_name, p.crop_type, round(avg(yield_kg),2) as average_yield_kg 
from plots p
join yields y
on p.plot_id=y.plot_id
group by p.plot_name, p.crop_type
order by average_yield_kg desc
limit 3;

select p.plot_name, sum(il.water_amount_liters) as  total_water_liters
from plots p 
join irrigation_logs il
on p.plot_id=il.plot_id
group by p.plot_name
order by total_water_liters desc;

/*2. Yield & Environmental Analysis 
• Determine the average yield for each crop type under different weather conditions. The 
output should have crop_type, weather_condition, and average_yield_kg. 
• Find the highest-yielding plot for each soil type. Show the soil_type, plot_name, and 
highest_yield_kg. */

select p.crop_type, round(avg(y.yield_kg),2) as average_yield_kg, y.weather_condition
from plots p 
join yields y
group by p.crop_type, y.weather_condition
order by  p.crop_type, average_yield_kg desc;

select p.plot_name, p.soil_type , sum(y.yield_kg) as highest_yield_kg
from plots p 
join yields y
group by p.plot_name, p.soil_type
order by p.soil_type, highest_yield_kg desc
limit 1;

/*3. Farmer & Resource Management 
• Identify the farmer who manages the plots with the lowest average water 
consumption. Show the first_name, last_name, and their plots' 
average_water_liters_per_plot. 
• Calculate the number of harvests per month for the last 12 months. Show the month 
and the number of harvests. */

select f.first_name, f.last_name,  p.plot_name, round(AVG(il.water_amount_liters),2) AS average_water_liters_per_plot
from plots p 
join farmers f on f.farmer_id= p.farmer_id
join irrigation_logs il on il.plot_id= p.plot_id
GROUP BY f.first_name, f.last_name, p.plot_name
ORDER BY average_water_liters_per_plot ASC;

select 
      year(harvest_date) as year,
      month(harvest_date) as month,
      count(yield_id) as number_of_harvests
      from yields
      where harvest_date>= DATE_SUB(CURDATE(), INTERVAL 12 MONTH)
      group by year,month
      order by number_of_harvests;
      
/*4. Advanced Analysis (Bonus) 
• Find plots that have a below-average yield for their specific crop type but an above
average water consumption compared to all other plots with the same crop. List the 
plot_name, crop_type, yield_kg, and water_amount_liters. */


select round(avg(yield_kg),2) as avg_yield from yields;
select round(AVG(water_amount_liters),2) as avg_water from irrigation_logs;

SELECT 
  p.plot_name,
  p.crop_type,
  ROUND(AVG(y.yield_kg), 2) AS yield_avg,
  ROUND(AVG(il.water_amount_liters), 2) AS water_avg
FROM plots p
JOIN yields y ON p.plot_id = y.plot_id
JOIN irrigation_logs il ON p.plot_id = il.plot_id
GROUP BY p.plot_name, p.crop_type
HAVING AVG(y.yield_kg) < 1559.19
   AND AVG(il.water_amount_liters) > 52666.67
ORDER BY yield_avg, water_avg;




