pi@raspberrypi:~ $ psql test
psql (11.7 (Raspbian 11.7-0+deb10u1))
Type "help" for help.

test=> q
test-> \q
pi@raspberrypi:~ $ RSL
bash: RSL: command not found
pi@raspberrypi:~ $ cd RSL
pi@raspberrypi:~/RSL $ psql test
psql (11.7 (Raspbian 11.7-0+deb10u1))
Type "help" for help.

test=> CREATE TABLE recommendationsBasedOnSummaryField AS SELECT url, rank FROM movies2 WHERE rank > 0.7 ORDER BY rank DESC LIMIT 50;
ERROR:  relation "recommendationsbasedonsummaryfield" already exists
test=> CREATE TABLE recommendationsBasedOnSummaryField5 AS SELECT url, rank FROM movies2 WHERE rank > 0.7 ORDER BY rank DESC LIMIT 50;
SELECT 0
test=> SELECT * FROM movies where url='pirates-of-the-caribbean-the-curse-of-the-black-pearl';
test=> ALTER TABLE movies2 ADD lexemesSummary tsvector;
ERROR:  column "lexemessummary" of relation "movies2" already exists
test=> UPDATE movies SET lexemesSummary = to_tsvector(Summary);
ERROR:  column "lexemessummary" of relation "movies" does not exist
LINE 1: UPDATE movies SET lexemesSummary = to_tsvector(Summary);
                          ^
test=> UPDATE movies2 SET lexemesSummary = to_tsvector(Summary);
UPDATE 5229
test=> SELECT url FROM movies2 WHERE lexemesSummary @@ to_tsquery('pirate');
                          url                          
-------------------------------------------------------
 bukowski-born-into-this
 captain-phillips
 pan
 the-princess-bride
 lucky-number-slevin
 the-pirates-who-dont-do-anything-a-veggietales-movie
 the-pirates!-band-of-misfits
 pirates-of-the-caribbean-the-curse-of-the-black-pearl
 pirates-of-the-caribbean-at-worlds-end
 pirates-of-the-caribbean-dead-men-tell-no-tales
 stardust
(11 rows)

test=> ALTER TABLE movies2 ADD rank float4;
ERROR:  column "rank" of relation "movies2" already exists
test=> ALTER TABLE movies2 ADD rank2 float4;
ALTER TABLE
test=> UPDATE movies2 SET rank2 = ts_rank(tsvectorSummary,plainto_tsquery((SELECT Summary FROM movies2 WHERE url='pirates-of-the-caribbean-the-curse-of-the-black-pearl')));
ERROR:  column "tsvectorsummary" does not exist
LINE 1: UPDATE movies2 SET rank2 = ts_rank(tsvectorSummary,plainto_t...
                                           ^
test=> UPDATE movies2 SET rank2 = ts_rank(lexemesSummary,plainto_tsquery((SELECT Summary FROM movies2 WHERE url='pirates-of-the-caribbean-the-curse-of-the-black-pearl')));
UPDATE 5229
test=> CREATE TABLE recommendationsBasedOnSummaryField AS SELECT url, rank2 FROMmovies2 WHERE rank > 0.2 ORDER BY rank2 DESC LIMIT 50;
ERROR:  column "url" does not exist
LINE 1: ...ABLE recommendationsBasedOnSummaryField AS SELECT url, rank2...
                                                             ^
test=> CREATE TABLE recommendationsBasedOnSummaryField AS SELECT url, rank FROMmovies2 WHERE rank > 0.2 ORDER BY rank2 DESC LIMIT 50;
ERROR:  column "url" does not exist
LINE 1: ...ABLE recommendationsBasedOnSummaryField AS SELECT url, rank ...
                                                             ^
test=> CREATE TABLE recommendationsBasedOnSummaryField8 AS SELECT url, rank2 FROM movies2 WHERE rank > 0.2 ORDER BY rank DESC LIMIT 50;
SELECT 0
test=> CREATE TABLE recommendationsBasedOnSummaryField8 AS SELECT url, rank2 FROM movies2 WHERE rank > 0.01 ORDER BY rank DESC LIMIT 50;
ERROR:  relation "recommendationsbasedonsummaryfield8" already exists
test=> CREATE TABLE recommendationsBasedOnSummaryField9 AS SELECT url, rank2 FROM movies2 WHERE rank > 0.01 ORDER BY rank DESC LIMIT 50;
SELECT 0
test=> ALTER TABLE movies2 ADD lexemesTitle ts^C
test=> SELECT * FROM movies where url='pirates-of-the-caribbean-the-curse-of-the-black-pearl';
test=> SELECT * FROM movies where url='pirates-of-the-caribbean-the-curse-of-the-black-pearl';
test=> \copy movies2 FROM '/home/pi/RSL/moviesFromMetacritic (1).csv' delimiter ';' csv header;
ERROR:  missing data for column "lexemessummary"
CONTEXT:  COPY movies2, line 2: "4;4;38902;"[ ""Leisure Time Features"", "" | "" ]";[];;"[ ""Ilya Khrjanovsky"" ]";"[ """", ""Drama""..."
test=> CREATE TABLE movies3 (url text, title text, ReleaseDate text, Distributor text, Starring text, Summary text, Director text, Genre text, Rating text Runtime text, Userscore text, Metascore text, scoreCounts);
ERROR:  syntax error at or near "Runtime"
LINE 1: ...mary text, Director text, Genre text, Rating text Runtime te...
                                                             ^
test=> CREATE TABLE movies3 (url text, title text, ReleaseDate text, Distributor text, Starring text, Summary text, Director text, Genre text, Rating text, Runtime text, Userscore text, Metascore text, scoreCounts);
ERROR:  syntax error at or near ")"
LINE 1: ... Runtime text, Userscore text, Metascore text, scoreCounts);
                                                                     ^
test=> CREATE TABLE movies3(url text, title text, ReleaseDate text, Distributor text, Starring text, Summary text, Director text, Genre text, Rating text, Runtime text, Userscore text, Metascore text, scoreCounts text);
CREATE TABLE
test=> \copy movies FROM '/home/pi/RSL/moviesfrommetacritic.csv' delimiter ';' csv header;
ERROR:  extra data after last expected column
CONTEXT:  COPY movies, line 2: "4;4;38902;"[ ""Leisure Time Features"", "" | "" ]";[];;"[ ""Ilya Khrjanovsky"" ]";"[ """", ""Drama""..."
test=> \copy movies3 FROM '/home/pi/RSL/moviesfrommetacritic.csv' delimiter ';' csv header;
COPY 5229
test=> SELECT*FROM movies where url='pirates-of-the-caribbean-the-curse-of-the-black-pearl';
test=> SELECT*FROM movies where url='pirates-of-the-caribbean-the-curse-of-the-black-pearl';
test=> SELECT*FROM movies where url='pirates-of-the-caribbean-the-curse-of-the-black-pearl';
test=> SELECT*FROM movies where url='pirates-of-the-caribbean-the-curse-of-the-black-pea
ERROR:  syntax error at or near "s"
LINE 1: s where url='pirates-of-the-caribbean-the-curse-of-the-black...
        ^
test=> SELECT * FROM movies3 where url='pirates-of-the-caribbean-the-curse-of-the-black-pearl';
test=> ALTER TABLE movies3 ADD lexemesSummary tsvector;
ALTER TABLE
test=> UPDATE movies3 SET lexemesSummary = to_tsvector(Summary);
UPDATE 5229
test=> SELECT url FROM movies3 WHERE lexemesSummary @@ to_tsquerry('pirate');
ERROR:  function to_tsquerry(unknown) does not exist
LINE 1: SELECT url FROM movies3 WHERE lexemesSummary @@ to_tsquerry(...
                                                        ^
HINT:  No function matches the given name and argument types. You might need to add explicit type casts.
test=> SELECT url FROM movies3 WHERE lexemesSummary @@ to_tsquerry('pirate');
ERROR:  function to_tsquerry(unknown) does not exist
LINE 1: SELECT url FROM movies3 WHERE lexemesSummary @@ to_tsquerry(...
                                                        ^
HINT:  No function matches the given name and argument types. You might need to add explicit type casts.
test=> ALTER TABLE movies ADD rank float4;
ALTER TABLE
the-ca UPDATE movies SET rank=ts_rank(tsvectorSummary,plainto_tsquery((SELECT Summary FROM movies WHERE url='pirates-of- 
test'> 
test'> UPDATE movies
test'> SET rank=ts_rank(tsvectorSummary,plainto_tsquery(
test'> (
test'> SELECT Summary From movies WHERE url='pirates-of-the-caribbean-the-curse-of-the-black-pearl'
test'> )
test'> ));
test'> \q
Use control-D to quit.
test'> \q
pi@raspberrypi:~/RSL $ psql test
psql (11.7 (Raspbian 11.7-0+deb10u1))
Type "help" for help.

test=> ALTER TABLE movies3 ADD rank float4;
ALTER TABLE
test=> UPDATE movies SET rank=ts_rank(lexemesSummary,plainto_tsquerry((SELECT Summary FROM movies3 WHERE url='pirates-of-the-caribbean-the-curse-of-the-black-pearl')));
ERROR:  column "lexemessummary" does not exist
LINE 1: UPDATE movies SET rank=ts_rank(lexemesSummary,plainto_tsquer...
                                       ^
test=> ALTER TABLE movies ADD lexemesSummary tsvector;
ALTER TABLE
test=> ALETR TABLE movies3 ADD lexemesSummary tsvector;
ERROR:  syntax error at or near "ALETR"
LINE 1: ALETR TABLE movies3 ADD lexemesSummary tsvector;
        ^
test=> ALTER TABLE movies3 ADD lexemesSummary tsvector;
ERROR:  column "lexemessummary" of relation "movies3" already exists
test=> UPDATE movies3 SET lexemesSummary = to_tsvector(Summary);
UPDATE 5229
test=> SELECT url FROM movies3 WHERE lexemesSummary @@ to_tsquery('pirate');
                          url                          
-------------------------------------------------------
 bukowski-born-into-this
 captain-phillips
 pan
 the-princess-bride
 lucky-number-slevin
 the-pirates-who-dont-do-anything-a-veggietales-movie
 the-pirates!-band-of-misfits
 pirates-of-the-caribbean-the-curse-of-the-black-pearl
 pirates-of-the-caribbean-at-worlds-end
 pirates-of-the-caribbean-dead-men-tell-no-tales
 stardust
(11 rows)

test=> ALTER TABLE movies3 ADD rank float4;
ERROR:  column "rank" of relation "movies3" already exists
test=> ALTER TABLE movies3 ADD rank3 float4;
ALTER TABLE
test=> UPDATE movies3 SET rank3=ts_rank(lexemesSummary,plainto_tsquery((SELECT Summary FROM movies3 WHERE url='pirates-of-the-caribbean-the-curse-of-the-black-pearl')));
UPDATE 5229
test=> CREATE TABLE recommendationsBasedOnSummaryField AS SELECT url, rank3 FROM movies3 WHERE rank > 0.7 rank DESC LIMIT 50;
ERROR:  syntax error at or near "rank"
LINE 1: ...S SELECT url, rank3 FROM movies3 WHERE rank > 0.7 rank DESC ...
                                                             ^
test=> CREATE TABLE recommendationsBasedOnSummaryField AS SELECT url, rank FROM movies3 WHERE rank > 0.7 rank DESC LIMIT 50;
ERROR:  syntax error at or near "rank"
LINE 1: ...AS SELECT url, rank FROM movies3 WHERE rank > 0.7 rank DESC ...
                                                             ^
test=> CREATE TABLE recommendationsBasedOnSummaryField AS SELECT url, rank3 FROM movies3 WHERE rank3 > 0.7 rank DESC LIMIT 50;
ERROR:  syntax error at or near "rank"
LINE 1: ... SELECT url, rank3 FROM movies3 WHERE rank3 > 0.7 rank DESC ...
                                                             ^
test=> CREATE TABLE recommendationsBasedOnSummaryField AS SELECT url, rank FROM movies3 WHERE rank >0.01 rank DESC LIMIT 50; 
ERROR:  syntax error at or near "rank"
LINE 1: ...AS SELECT url, rank FROM movies3 WHERE rank >0.01 rank DESC ...
                                                             ^
test=> CREATE TABLE recommendationsBasedOnSummaryField AS SELECT url, rank3 FROM movies3 WHERE rank3 >0.01 rank3 DESC LIMIT 50; 
ERROR:  syntax error at or near "rank3"
LINE 1: ... SELECT url, rank3 FROM movies3 WHERE rank3 >0.01 rank3 DESC...
                                                             ^
test=> CREATE TABLE recommendationsBasedOnSummaryField AS SELECT url, rank3 FROM movies3 WHERE rank3 > 0.01 rank3 DESC LIMIT 50; 
ERROR:  syntax error at or near "rank3"
LINE 1: ...SELECT url, rank3 FROM movies3 WHERE rank3 > 0.01 rank3 DESC...
                                                             ^
test=> CREATE TABLE recommendationsBasedOnSummaryField AS SELECT url, rank FROM movies3 WHERE rank > 0.01 rank DESC LIMIT 50; 
ERROR:  syntax error at or near "rank"
LINE 1: ...S SELECT url, rank FROM movies3 WHERE rank > 0.01 rank DESC ...
                                                             ^
test=> CREATE TABLE recommendationsBasedOnSummaryField AS SELECT url, rank FROM movies WHERE rank > 0.01 rank DESC LIMIT 50; 
ERROR:  syntax error at or near "rank"
LINE 1: ...AS SELECT url, rank FROM movies WHERE rank > 0.01 rank DESC ...
                                                             ^
test=> CREATE TABLE recommendationsBasedOnSummaryField AS SELECT url, rank3 FROM movies3 WHERE rank > 0.01 ORDER BY rank3 DESC LIMIT 50; 
ERROR:  relation "recommendationsbasedonsummaryfield" already exists
test=> CREATE TABLE recommendationsBasedOnSummaryField11 AS SELECT url, rank3 FROM movies3 WHERE rank > 0.01 ORDER BY rank3 DESC LIMIT 50; 
SELECT 0
test=> CREATE TABLE recommendationsBasedOnSummaryField11 AS SELECT url, rank3 FROM movies3 WHERE rank > 0.7 ORDER BY rank3 DESC LIMIT 50; 
ERROR:  relation "recommendationsbasedonsummaryfield11" already exists
test=> 
test=> CREATE TABLE recommendationsBasedOnSummaryField12 AS SELECT url, rank3 FROM movies3 WHERE rank > 0.7 ORDER BY rank3 DESC LIMIT 50; 
SELECT 0
test=> CREATE TABLE recommendationsBasedOnSummaryField12 AS SELECT url, rank3 FROM movies3 WHERE rank3 > 0.7 ORDER BY rank3 DESC LIMIT 50; 
ERROR:  relation "recommendationsbasedonsummaryfield12" already exists
test=> CREATE TABLE recommendationsBasedOnSummaryField13 AS SELECT url, rank3 FROM movies3 WHERE rank3 > 0.7 ORDER BY rank3 DESC LIMIT 50; 
SELECT 2
test=> CREATE TABLE recommendationsBasedOnSummaryField14 AS SELECT url, rank3 FROM movies3 WHERE rank3 > 0.01 ORDER BY rank3 DESC LIMIT 50;  
SELECT 50
test=> \copy (SELECT * FROM recommendationsBasedOnSummaryField14) to 'home/pi/RSL/top50recommendations.csv' WITH csv;
home/pi/RSL/top50recommendations.csv: No such file or directory
test=> \copy (SELECT * FROM recommendationsBasedOnSummaryField14) to '/home/pi/RSL/top50recommendations.csv' WITH csv;
COPY 50
test=> \q
pi@raspberrypi:~/RSL $ psql test -f recommendationsBasedOnSummaryField14.sql
recommendationsBasedOnSummaryField14.sql: No such file or directory
pi@raspberrypi:~/RSL $ psql test -f top50recommendations.sql
top50recommendations.sql: No such file or directory
pi@raspberrypi:~/RSL $ psql test -f  top50recommendations.sql
top50recommendations.sql: No such file or directory
pi@raspberrypi:~/RSL $ psql test
psql (11.7 (Raspbian 11.7-0+deb10u1))
Type "help" for help.

test=> psql test -f top50recommendations.sql
test-> \q
pi@raspberrypi:~/RSL $ psqp^C
pi@raspberrypi:~/RSL $ 
