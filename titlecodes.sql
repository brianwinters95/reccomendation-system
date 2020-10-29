test=> UPDATE movies3
test-> SET rank = ts_rank(lexemesTitle,plainto_tsquery(
test(> (
test(> SELECT Title FROM movies3 WHERE title='Abominable')));
UPDATE 5229
test=> CREATE TABLE recommendationsBasedOnTitle AS
test-> SELECT title, rank FROM movies3 WHERE rank > 0.01 ORDER BY rank DESC LIMIT 50;
SELECT 1
test=> CREATE TABLE recommendationsBasedOnTitle AS
SELECT title, rank FROM movies3 WHERE rank > 0.0 ORDER BY rank DESC LIMIT 50;
ERROR:  relation "recommendationsbasedontitle" already exists
test=> CREATE TABLE recommendationsBasedOnTitle2 AS
SELECT title, rank FROM movies3 WHERE rank > 0.0 ORDER BY rank DESC LIMIT 50;
SELECT 1
test=> \copy (SELECT * FROM recommendationsBasedOnTitle) to '/home/pi/RSL2/recommendationsByTitle.csv' WITH csv;
COPY 1
