pi@raspberrypi:~ $ cd RSL
pi@raspberrypi:~/RSL $ psql test
psql (11.7 (Raspbian 11.7-0+deb10u1))
Type "help" for help.

test=> ALTER TABLE movies3 ADD lexemesstarring tsvector;
ERROR:  column "lexemesstarring" of relation "movies3" already exists
test=> UPDATE movies3 SET lexemesstarring = to_tsvector(Starring);
UPDATE 5229
test=> SELECT url FROM movies3 WHERE lexemesSummary @@ to_tsquery('depp');
 url 
-----
(0 rows)

test=> SELECT url FROM movies3 WHERE lexemesstarring @@ to_tsquery('depp');
test=> ALTER TABLE movies3 ADD rank3 float4;
ERROR:  column "rank3" of relation "movies3" already exists
test=> ALTER TABLE movies3 ADD rank4 float4;
ERROR:  column "rank4" of relation "movies3" already exists
test=> ALTER TABLE movies3 ADD rank5 float4;
ALTER TABLE
test=> UPDATE movies SET rank4 = ts_rank(lexemesstarring,plainto_tsquery((SELECT starring FROM movies3 WHERE url='depp')));
ERROR:  column "lexemesstarring" does not exist
LINE 1: UPDATE movies SET rank4 = ts_rank(lexemesstarring,plainto_ts...
                                          ^
test=> SELECT url FROM movies3 WHERE lexemesstarring @@ to_tsquery('depp');
test=> UPDATE movies SET rank4 = ts_rank4(lexemesstarring,plainto_tsquery((SELECT starring FROM movies3 WHERE url='depp')));
ERROR:  column "lexemesstarring" does not exist
LINE 1: UPDATE movies SET rank4 = ts_rank4(lexemesstarring,plainto_t...
                                           ^
test=> UPDATE movies3 SET rank4 = ts_rank4(lexemesstarring,plainto_tsquery((SELECT starring FROM movies3 WHERE url='depp')));
ERROR:  function ts_rank4(tsvector, tsquery) does not exist
LINE 1: UPDATE movies3 SET rank4 = ts_rank4(lexemesstarring,plainto_...
                                   ^
HINT:  No function matches the given name and argument types. You might need to add explicit type casts.
test=> UPDATE movies3 SET rank4 = ts_rank(lexemesstarring,plainto_tsquery((SELECT starring FROM movies3 WHERE url='depp')));
UPDATE 5229
test=> CREATE TABLE recommondationsBasedOnStarringField5 AS SELECT url, rank4 FROM movies3 WHERE rank4 > 0 ORDER BY rank4 DESC LIMIT 50;
SELECT 0
test=> CREATE TABLE recommondationsBasedOnStarringField6 AS SELECT url, rank4 FROM movies3 WHERE rank4 > 0.001 ORDER BY rank4 DESC LIMIT 50;
SELECT 0
test=> CREATE TABLE recommondationsBasedOnStarringField6 AS SELECT url, rank4 FROM movies3 ORDER BY rank4 DESC LIMIT 50;
ERROR:  relation "recommondationsbasedonstarringfield6" already exists
test=> CREATE TABLE recommondationsBasedOnStarringField7 AS SELECT url, rank4 FROM movies3 ORDER BY rank4 DESC LIMIT 50;
SELECT 50
test=> \copy (SELECT * FROM recommendationsBasedOnStarringField7) to '/home/pi/RSL/top50starring.csv' WITH csv;
ERROR:  relation "recommendationsbasedonstarringfield7" does not exist
LINE 1: COPY  ( SELECT * FROM recommendationsBasedOnStarringField7 )...
                              ^
test=> \copy (SELECT * FROM recommondationsBasedOnStarringField7) to '/home/pi/RSL/top50starring.csv' WITH csv;
COPY 50
test=> 
