flights=# CREATE TABLE flight_info (year integer, month integer, day integer, dep_time varchar(5), sched_dep_time varchar(5), dep_delay varcha
r(5), arr_time varchar(5), sched_arr_time varchar(5), arr_delay varchar(5), carrier varchar(2), flight integer, tailnum varchar(6), origin var
char(3), dest varchar(3), air_time varchar(5), distance integer, hour integer, minute integer, time_hour date);
CREATE TABLE

flights=# COPY flight_info FROM '/home/kunal/Workspace/PCS/Assignment_Allan/flight_info.tsv' DELIMITER E'\t';
COPY 336776

flights=# select count(*) from flight_info where dep_delay = 'NA';
 count 
-------
  8255
(1 row)

flights=# select carrier, count(flight) from flight_info group by carrier order by count desc;
 carrier | count 
---------+-------
 UA      | 58665
 B6      | 54635
 EV      | 54173
 DL      | 48110
 AA      | 32729
 MQ      | 26397
 US      | 20536
 9E      | 18460
 WN      | 12275
 VX      |  5162
 FL      |  3260
 AS      |   714
 F9      |   685
 YV      |   601
 HA      |   342
 OO      |    32
(16 rows)

flights=# create table flight_info_clean as select * from flight_info where dep_delay != 'NA' and arr_delay != 'NA';
SELECT 327346
flights=# ALTER TABLE flight_info_clean ALTER COLUMN dep_delay TYPE integer USING dep_delay::integer;
ALTER TABLE
flights=# ALTER TABLE flight_info_clean ALTER COLUMN arr_delay TYPE integer USING arr_delay::integer;
ALTER TABLE

flights=# select flight, avg(dep_delay) as avg_dep_delay, avg(arr_delay) as avg_arr_delay from flight_info_clean group by flight order by flight;

flights=# \d
               List of relations
 Schema |       Name        | Type  |  Owner   
--------+-------------------+-------+----------
 public | flight_info       | table | postgres
 public | flight_info_clean | table | postgres
(2 rows)

flights=# UPDATE flight_info SET arr_delay = '0' WHERE arr_delay='NA';
UPDATE 9430
flights=# ALTER TABLE flight_info ALTER COLUMN arr_delay TYPE integer USING arr_delay::integer;
ALTER TABLE
flights=# ALTER TABLE flight_info ALTER COLUMN dep_delay TYPE integer USING dep_delay::integer;
ALTER TABLE

flights=# select flight, avg(dep_delay) as avg_dep_delay, avg(arr_delay) as avg_arr_delay from flight_info group by flight order by flight;


