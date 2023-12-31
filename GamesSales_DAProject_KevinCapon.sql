/*
Game Sales Data Exploration (https://www.kaggle.com/datasets/arslanali4343/sales-of-video-games)

Skills used: SUBQUERY, CASE, SUM, ROUND, VIEW, COUNT, DISTINCT, BETWEEN, MIN, MAX, IN, LIKE, LIMIT.

By: Kevin Capon Goldszmidt

*/

-- DATA EXPLORATION

-- TABLE VIEW

SELECT *
FROM `daproject2.GamingSales.game_data_clean`
WHERE Year != 'N/A'
ORDER BY rank;

-- USE THESE QUERIES TO FIND THE LAST AND MOST RECENT YEAR OF DATA RECORDED

SELECT MIN(Year)
FROM `daproject2.GamingSales.game_data_clean`
WHERE Year != 'N/A' ;

SELECT MAX(Year)
FROM `daproject2.GamingSales.game_data_clean`
WHERE Year != 'N/A' ;

-- USE THIS QUERY TO FIND HOW MANY COD GAMES WERE PUBLISHED (1st, COUNT / 2nd, LIST WITH NAMES)

SELECT COUNT (DISTINCT (Name))
FROM `daproject2.GamingSales.game_data_clean`
WHERE Name LIKE 'Call of Duty%';


SELECT DISTINCT (Name)
FROM `daproject2.GamingSales.game_data_clean`
WHERE Name LIKE 'Call of Duty%';


-- USE THIS QUERY TO FIND OUT HOW MANY DIFFERNT GENRES ARE IN THIS TABLE (12)

SELECT DISTINCT(Genre)
FROM `daproject2.GamingSales.game_data_clean`;

SELECT COUNT (DISTINCT(Genre))
FROM `daproject2.GamingSales.game_data_clean`;


-- USE THIS QUERY TO FIND OUT THE TOTAL AMOUNT OF COPIES SOLD PER GENRE
-- THE TOP FIVE GENRES WERE ACTION, SPORTS, MISC, ROLE-PLAYING AND SHOOTER

SELECT Genre, ROUND(SUM(Global_Sales)) AS Copies_sold
FROM `daproject2.GamingSales.game_data_clean`
WHERE Year != 'N/A'
GROUP BY Genre
ORDER BY Copies_sold DESC;


-- USE THIS QUERY TO FIND OUT THE TOTAL AMOUNT OF GAMES RELEASED PER GENRE
-- THE TOP GENRES ARE ACTION, SPORTS, MISC, RPG AND SHOOTER

SELECT Genre, COUNT(Global_Sales) AS Games_released
FROM `daproject2.GamingSales.game_data_clean`
WHERE Year != 'N/A'
GROUP BY Genre
ORDER BY Games_released DESC;

-- USE THIS QUERY TO FIND OUT WHICH PLATFORM HAD THE MOST RELEASES

SELECT Platform, COUNT(Name) AS PlatformGames
FROM `daproject2.GamingSales.game_data_clean`
WHERE Year != 'N/A'
GROUP BY Platform
ORDER BY PlatformGames DESC;

-- USE THIS QUERY TO FIND OUT WHICH PUBLISHERS RELEASED THE MOST GAMES

SELECT Publisher, COUNT(Name) AS PublisherGames
FROM `daproject2.GamingSales.game_data_clean`
WHERE Year != 'N/A'
GROUP BY Publisher
ORDER BY PublisherGames DESC;

-- USE THIS QUERY TO FIND OUT THE TOP FIVE PUBLISHER WHICH SOLD THE MOST COPIES
-- Nintendo, EA, Activison, Sony, Ubisoft

SELECT Publisher, ROUND(SUM(Global_Sales)) AS copiesbypublisher
FROM `daproject2.GamingSales.game_data_clean`
WHERE Year != 'N/A'
GROUP BY Publisher
ORDER BY copiesbypublisher DESC
LIMIT 5;

-- CREATE VIEW: A TABLE OF NINTENDO'S RELEASED GAMES FOR VISUALIZATION

CREATE VIEW `daproject2.GamingSales.nintendogames` AS
SELECT Name, Platform, Genre, Year, Global_Sales
FROM `daproject2.GamingSales.game_data_clean`
WHERE Publisher = 'Nintendo' AND Year != 'N/A'
ORDER BY Rank;


-- CREATE VIEW: A TABLE OF EA'S RELEASED GAMES FOR VISUALIZATION

CREATE VIEW `daproject2.GamingSales.EAgames` AS
SELECT Name, Platform, Genre, Year, Global_Sales
FROM `daproject2.GamingSales.game_data_clean`
WHERE Publisher = 'Electronic Arts' AND Year != 'N/A'
ORDER BY Rank;

-- CREATE VIEW: A TABLE OF ACTIVISION'S RELEASED GAMES FOR VISUALIZATION

CREATE VIEW `daproject2.GamingSales.activisiongames` AS
SELECT Name, Platform, Genre, Year, Global_Sales
FROM `daproject2.GamingSales.game_data_clean`
WHERE Publisher = 'Activision'AND Year != 'N/A'
ORDER BY Rank;


-- CREATE VIEW: A TABLE OF SONY'S RELEASED GAMES FOR VISUALIZATION

CREATE VIEW `daproject2.GamingSales.sonygames` AS
SELECT Name, Platform, Genre, Year, Global_Sales
FROM `daproject2.GamingSales.game_data_clean`
WHERE Publisher = 'Sony Computer Entertainment' AND Year != 'N/A'
ORDER BY Rank;

-- CREATE VIEW: A TABLE OF UBISOFT'S RELEASED GAMES FOR VISUALIZATION

CREATE VIEW `daproject2.GamingSales.ubisoftgames` AS
SELECT Name, Platform, Genre, Year, Global_Sales
FROM `daproject2.GamingSales.game_data_clean`
WHERE Publisher = 'Ubisoft' AND Year != 'N/A'
ORDER BY Rank;

-- USE THIS QUERY TO FIND OUT HOW MANY GAMES THE TOP FIVE PUBLISHERS RELEASED BETWEEN 2010 AND 2020

SELECT COUNT(Name) AS Games2010_2020, Publisher
FROM `daproject2.GamingSales.game_data_clean`
WHERE Year BETWEEN '2010' AND '2020' AND Publisher IN ('Electronic Arts','Activision','Ubisoft','Nintendo','Sony Computer Entertainment' )
GROUP BY Publisher
ORDER BY Games2010_2020 DESC;


-- USE THIS QUERY TO FIND OUT HOW MANY GAMES THE TOP FIVE PUBLISHERS RELEASED BETWEEN 2000 AND 2010

SELECT COUNT(Name) AS Games2010_2020, Publisher
FROM `daproject2.GamingSales.game_data_clean`
WHERE Year BETWEEN '2000' AND '2010' AND Publisher IN ('Electronic Arts','Activision','Ubisoft','Nintendo','Sony Computer Entertainment' )
GROUP BY Publisher
ORDER BY Games2010_2020 DESC;

-- USE THIS QUERY TO CHECK THE AVERAGE GLOBAL COPIES SOLD BY EACH OF THE TOP FIVE PUBLISHERS

SELECT AVG(Global_Sales) AS Avg_sales, Publisher
FROM `daproject2.GamingSales.game_data_clean`
WHERE Year != 'N/A' AND Publisher IN ('Electronic Arts','Activision','Ubisoft','Nintendo','Sony Computer Entertainment' )
GROUP BY Publisher
ORDER BY Avg_sales DESC;

-- USE THIS QUERY TO FIND THE AVERAGE OF THE TOTAL COPIES SOLD BY THE TOP FIVE PUBLISHERS = 1.01
SELECT AVG(Global_Sales) AS Avg_sales
FROM `daproject2.GamingSales.game_data_clean`
WHERE Year != 'N/A' AND Publisher IN ('Electronic Arts','Activision','Ubisoft','Nintendo','Sony Computer Entertainment' );


-- USE THIS QUERY TO FIND THE GAMES THAT SOLD MORE COPIES THAN THE OVERALL TOTAL AVERAGE OF SOLD COPIES BY THE TOP FIVE PUBLISHERS
SELECT Name, Publisher
FROM `daproject2.GamingSales.game_data_clean`
WHERE Global_Sales > (SELECT AVG(Global_Sales) FROM `daproject2.GamingSales.game_data_clean` ) AND
Year != 'N/A' AND Publisher IN ('Electronic Arts','Activision','Ubisoft','Nintendo','Sony Computer Entertainment' )
GROUP BY Publisher, Name;

-- USE THIS QUERY TO FIND OUT HOW MANY GAMES SOLD MORE COPIES THAN THE OVERALL AVERAGE OF SOLD COPIES BY THE TOP FIVE PUBLISHERS

SELECT COUNT (Name) AS CopiesAboveAvg, Publisher
FROM `daproject2.GamingSales.game_data_clean`
WHERE Global_Sales > (SELECT AVG(Global_Sales) FROM `daproject2.GamingSales.game_data_clean` ) AND
Year != 'N/A' AND Publisher IN ('Electronic Arts','Activision','Ubisoft','Nintendo','Sony Computer Entertainment' )
GROUP BY Publisher
ORDER BY CopiesAboveAvg DESC;

-- USE THIS QUERY TO FIND OUT WHICH GAMES BY THE TOP PUBLISHERS SOLD MORE COPIES THAN THE AVARAGE GAME

SELECT Name, Publisher, Global_Sales,
CASE 
  WHEN (Global_Sales >= 1.01) THEN 'Above Average'
  WHEN (Global_Sales < 1.01) THEN 'Below Average'
  ELSE 'Normal'
  END AS game_class
  FROM `daproject2.GamingSales.game_data_clean`
WHERE Year != 'N/A' AND Publisher IN ('Electronic Arts','Activision','Ubisoft','Nintendo','Sony Computer Entertainment' )
ORDER BY Global_Sales;

-- USE THIS QUERY TO COMPARE TOTAL OF GAME COPIES SALES BY REGIONS

SELECT ROUND(SUM(NA_Sales)) AS NA_total, ROUND(SUM(EU_Sales)) AS EU_Total, ROUND(SUM(JP_Sales)) AS JP_Total, ROUND(SUM(Other_Sales)) AS Rest_Total
FROM `daproject2.GamingSales.game_data_clean`
WHERE Year != 'N/A';

-- USE THIS QUERY TO COMPARE THE GAME SALES OF EACH PUBLISHER BY YEAR AND BY REGION - For visualization

SELECT SUM(NA_Sales) AS NA, SUM(EU_Sales) AS EU, SUM(JP_Sales) AS JP ,SUM(Other_Sales) AS Other,SUM(NA_Sales + EU_Sales + JP_Sales + Other_Sales) AS Global_Sales, Year, Publisher
FROM `daproject2.GamingSales.game_data_clean`
WHERE Year != 'N/A' AND Publisher IN ('Electronic Arts','Activision','Ubisoft','Nintendo','Sony Computer Entertainment' )
GROUP BY Year, Publisher
ORDER BY Year;

-- USE THIS QUERY TO COMPARE THE GAME SALES OF EACH PUBLISHER BY YEAR BY REGION ROUNDED UP - For visualization

SELECT ROUND(SUM(NA_Sales)) AS NA_total, ROUND(SUM(EU_Sales)) AS EU_Total, ROUND(SUM(JP_Sales)) AS JP_Total, ROUND(SUM(Other_Sales)) AS Rest_Total, ROUND(SUM(NA_Sales + EU_Sales + JP_Sales + Other_Sales)) AS Global_Sales, Year, Publisher
FROM `daproject2.GamingSales.game_data_clean`
WHERE Year != 'N/A' AND Publisher IN ('Electronic Arts','Activision','Ubisoft','Nintendo','Sony Computer Entertainment' )
GROUP BY Year, Publisher
ORDER BY Year;

-- USE THIS QUERY TO COMPARE THE GAME SALES OF EACH PUBLISHER BY YEAR BY GENRE - For visualization

SELECT ROUND(SUM(NA_Sales)) AS NA_total, ROUND(SUM(EU_Sales)) AS EU_Total, ROUND(SUM(JP_Sales)) AS JP_Total, ROUND(SUM(Other_Sales)) AS Rest_Total, Genre, Publisher, Year
FROM `daproject2.GamingSales.game_data_clean`
WHERE Year != 'N/A' AND Publisher IN ('Electronic Arts','Activision','Ubisoft','Nintendo','Sony Computer Entertainment' )
GROUP BY Genre, Publisher, Year
ORDER BY Genre, Year

