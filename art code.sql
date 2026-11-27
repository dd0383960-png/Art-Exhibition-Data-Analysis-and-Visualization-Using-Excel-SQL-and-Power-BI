CREATE DATABASE ArtExhibitionDB;

 USE ArtExhibitionDB;
CREATE TABLE Exhibition (
    Exhibition_ID INT PRIMARY KEY,
    Start_Date DATE,
    End_Date DATE,
    Exhibition_Type VARCHAR(100),
    Title VARCHAR(255)
);
CREATE TABLE Artist (
    Artist_ID VARCHAR(30) PRIMARY KEY,
    Artist_Name VARCHAR(255),
    Nationality VARCHAR(100),
    Gender VARCHAR(30),
    Birth_Year INT
);
CREATE TABLE Artworks (
    Artwork_ID INT PRIMARY KEY,
    Artwork_Title VARCHAR(500),
    Artist_ID VARCHAR(30),
    Artist_Name VARCHAR(255),
    Artwork_Date VARCHAR(30),
    Medium VARCHAR(255),
    Acquisition_Date DATE,
    Credit VARCHAR(500),
    Department VARCHAR(150),
    Classification VARCHAR(150)
);
USE ArtExhibitionDB;
SELECT
    Artist_Name,
    COUNT(*) AS Total_Artworks
FROM Artworks
WHERE Artist_Name IS NOT NULL
GROUP BY Artist_Name
ORDER BY Total_Artworks DESC
LIMIT 10;
SELECT
    Nationality,
    COUNT(*) AS Total_Artists
FROM Artist
WHERE Nationality IS NOT NULL
GROUP BY Nationality
ORDER BY Total_Artists DESC;
SELECT
    Gender,
    COUNT(*) AS Total_Artists,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Artist),
        2
    ) AS Percentage
FROM Artist
WHERE Gender IS NOT NULL
GROUP BY Gender;
SELECT
    Department,
    COUNT(*) AS Total_Artworks
FROM Artworks
WHERE Department IS NOT NULL
GROUP BY Department
ORDER BY Total_Artworks DESC;
SELECT
    Classification,
    COUNT(*) AS Total_Artworks
FROM Artworks
WHERE Classification IS NOT NULL
GROUP BY Classification
ORDER BY Total_Artworks DESC;
SELECT
    Medium,
    COUNT(*) AS Total_Artworks
FROM Artworks
WHERE Medium IS NOT NULL
GROUP BY Medium
ORDER BY Total_Artworks DESC
LIMIT 10;
SELECT
    CASE
        WHEN CAST(Artwork_Date AS UNSIGNED) < 1800 THEN 'Before 1800'
        WHEN CAST(Artwork_Date AS UNSIGNED) BETWEEN 1800 AND 1899 THEN '1800-1899'
        WHEN CAST(Artwork_Date AS UNSIGNED) BETWEEN 1900 AND 1999 THEN '1900-1999'
        WHEN CAST(Artwork_Date AS UNSIGNED) >= 2000 THEN '2000 onwards'
        ELSE 'Unknown'
    END AS Creation_Period,
    COUNT(*) AS Total_Artworks
FROM Artworks
GROUP BY Creation_Period
ORDER BY Creation_Period;
SELECT
    Artist_ID,
    Artist_Name,
    MIN(CAST(Artwork_Date AS UNSIGNED)) AS First_Artwork_Year,
    MAX(CAST(Artwork_Date AS UNSIGNED)) AS Last_Artwork_Year,
    MAX(CAST(Artwork_Date AS UNSIGNED))
      - MIN(CAST(Artwork_Date AS UNSIGNED)) AS Career_Span_Years
FROM Artworks
WHERE Artwork_Date REGEXP '^[0-9]{4}$'
GROUP BY Artist_ID, Artist_Name
HAVING COUNT(*) > 1
ORDER BY Career_Span_Years DESC
LIMIT 10;
SELECT
    COUNT(*) AS Unknown_Birth_Year_Artists,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Artist),
        2
    ) AS Unknown_Percentage
FROM Artist
WHERE Birth_Year IS NULL;
SELECT
    Department,
    COUNT(DISTINCT Artist_ID) AS Unique_Artists,
    COUNT(*) AS Total_Artworks
FROM Artworks
WHERE Department IS NOT NULL
GROUP BY Department
ORDER BY Unique_Artists DESC;
USE artexhibitiondb;

SELECT COUNT(*) AS Total_Records
FROM Exhibition;
