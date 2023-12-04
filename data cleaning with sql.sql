-- View dataset
select * from netflix;

-- the show_id column is the unique id for the dataset, therefore we are going to check for duplicates
SELECT 
    show_id, COUNT(*)
FROM
    netflix
GROUP BY show_id
ORDER BY COUNT(*) DESC;
-- no duplicates

-- check null values across columns
SELECT COUNT(CASE WHEN show_id IS NULL THEN 1 ELSE NULL END) AS show_id_nulls,
	   COUNT(CASE WHEN type IS NULL THEN 1 ELSE NULL END) AS type_nulls,
	   COUNT(CASE WHEN title IS NULL THEN 1 ELSE NULL END) AS title_nulls,
	   COUNT(CASE WHEN director IS NULL THEN 1 ELSE NULL END) AS director_nulls,
       COUNT(CASE WHEN cast IS NULL THEN 1 ELSE NULL END) AS cast_nulls ,
       COUNT(CASE WHEN country IS NULL THEN 1 ELSE NULL END) AS country_nulls  ,
       COUNT(CASE WHEN date_added IS NULL THEN 1 ELSE NULL END) AS date_added_nulls ,
       COUNT(CASE WHEN release_year IS NULL THEN 1 ELSE NULL END) AS release_year_nulls,
       COUNT(CASE WHEN rating IS NULL THEN 1 ELSE NULL END) AS rating_nulls ,
       COUNT(CASE WHEN duration IS NULL THEN 1 ELSE NULL END) AS duration_nulls,
       COUNT(CASE WHEN listed_in IS NULL THEN 1 ELSE NULL END) AS listed_in_nulls,
       COUNT(CASE WHEN description  IS NULL THEN 1 ELSE NULL END) AS description_nulls 
FROM netflix;

-- convert blank spaces to null values
update netflix 
set show_id=NULLIF(show_id, ''),type =NULLIF(type , ''),title=NULLIF(title, '')
,director=NULLIF(director, ''),cast=NULLIF(cast, ''),country =NULLIF(country , '')
,date_added =NULLIF(date_added , ''),release_year  =NULLIF(release_year  , '')
,rating=NULLIF(rating, ''),duration =NULLIF(duration , ''),description =NULLIF(description , '');

/*
We can see that there are NULLS. 
director_nulls = 2631
movie_cast_nulls = 825
country_nulls = 830
date_added_nulls = 10
rating_nulls = 4
duration_nulls = 3  
*/

WITH cte AS
(
SELECT title, CONCAT(director, '---',cast) AS director_cast 
FROM netflix
)

SELECT director_cast, COUNT(*) AS count
FROM cte
GROUP BY director_cast
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC;

UPDATE netflix 
SET director = 'Alastair Fothergill'
WHERE cast = 'David Attenborough'
AND director IS NULL ;


SELECT director, country, date_added
FROM netflix
WHERE country IS NULL;


UPDATE netflix 
SET country = 'Not Given'
WHERE country IS NULL;

select show_id , date_added
FROM netflix
WHERE date_added IS NULL;

-- delete 10 rows that has date_added is null
delete
FROM netflix
WHERE date_added IS NULL;


-- delete 4 rows that has rating is null
DELETE FROM netflix 
WHERE
    rating IS NULL;
   

-- delete 4 rows that has duration is null

DELETE FROM netflix 
WHERE
    duration IS NULL;

-- Drop unneeded columns
ALTER TABLE netflix
DROP COLUMN cast, 
DROP COLUMN description;

SELECT *,
       SUBSTRING_INDEX(country,',',1) AS countryy,
       SUBSTRING_INDEX(SUBSTRING_INDEX(country,',',2),',',-1) AS country2,
       SUBSTRING_INDEX(SUBSTRING_INDEX(country,',',3),',',-1) AS country3,
       SUBSTRING_INDEX(SUBSTRING_INDEX(country,',',4),',',-1) AS country4,
       SUBSTRING_INDEX(SUBSTRING_INDEX(country,',',5),',',-1) AS country5,
       SUBSTRING_INDEX(SUBSTRING_INDEX(country,',',6),',',-1) AS country6,
       SUBSTRING_INDEX(SUBSTRING_INDEX(country,',',7),',',-1) AS country7,
       SUBSTRING_INDEX(SUBSTRING_INDEX(country,',',8),',',-1) AS country8,
       SUBSTRING_INDEX(SUBSTRING_INDEX(country,',',9),',',-1) AS country9,
       SUBSTRING_INDEX(SUBSTRING_INDEX(country,',',10),',',-1) AS country10
FROM netflix;


ALTER TABLE netflix 
ADD country1 varchar(500);


UPDATE netflix 
SET country1 =  SUBSTRING_INDEX(country,',',1);

ALTER TABLE netflix 
DROP COLUMN country;
