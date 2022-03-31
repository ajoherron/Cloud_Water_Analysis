# Lab 3: Spark and Parquet Optimization Report

Name: Alex Herron
 
NetID: ah5865

## Part 1: Spark

#### Question 1: 
How would you express the following computation using SQL instead of the object interface: `sailors.filter(sailors.age > 40).select(sailors.sid, sailors.sname, sailors.age)`?

Code:
```SQL

q1_result = spark.sql('SELECT sailors.sid, sailors.sname, sailors.age FROM sailors WHERE age > 40')
q1_result.show()

```


Output:
```
Question 1:
+---+-------+----+
|sid|  sname| age|
+---+-------+----+
| 22|dusting|45.0|
| 31| lubber|55.5|
| 95|    bob|63.5|
+---+-------+----+
```


#### Question 2: 
How would you express the following using the object interface instead of SQL: `spark.sql('SELECT sid, COUNT(bid) from reserves WHERE bid != 101 GROUP BY sid')`?

Code:
```python
q2_result = reserves.filter(reserves.bid != 101).groupby(reserves.sid).count()
q2_result.show()
```


Output:
```
Question 2:
+---+-----+
|sid|count|
+---+-----+
| 22|    3|
| 31|    3|
| 74|    1|
| 64|    1|
+---+-----+
```

#### Question 3: 
Using a single SQL query, how many distinct boats did each sailor reserve? 
The resulting DataFrame should include the sailor's id, name, and the count of distinct boats. 
(Hint: you may need to use `first(...)` aggregation function on some columns.) 
Provide both your query and the resulting DataFrame in your response to this question.

Code:
```SQL
q3_result = spark.sql('SELECT s.sid, s.sname, COUNT(DISTINCT r.bid) FROM sailors s LEFT JOIN reserves r ON s.sid = r.sid GROUP BY s.sid, s.sname')
q3_result.show()
```


Output:
```
Question 3:
+---+-------+-------------------+
|sid|  sname|count(DISTINCT bid)|
+---+-------+-------------------+
| 58|  rusty|                  0|
| 64|horatio|                  2|
| 29| brutus|                  0|
| 22|dusting|                  4|
| 31| lubber|                  3|
| 71|  zorba|                  0|
| 85|    art|                  0|
| 74|horatio|                  1|
| 95|    bob|                  0|
| 32|   andy|                  0|
+---+-------+-------------------+
```

#### Question 4: 
Implement a query using Spark transformations which finds for each artist term, compute the median year of release, maximum track duration, and the total number of artists for that term (by ID).
  What are the results for the ten terms with the shortest *average* track durations?
  Include both your query code and resulting DataFrame in your response.


Code:
```python
q4_A_result = spark.sql('SELECT a.term, percentile(t.year, 0.5) as median_year, MAX(t.duration), COUNT(a.artistID)  FROM artist a LEFT JOIN tracks t ON a.artistID = t.artistID GROUP BY a.term')
q4_A_result.show()

q4_B_result = spark.sql('SELECT a.term, AVG(t.duration) FROM artist a JOIN tracks t ON a.artistID = t.artistID GROUP BY a.term ORDER BY AVG(t.duration) LIMIT 10')
q4_B_result.show()
```


Output:
```
Question 4 part A:
+--------------------+-----------+-------------+---------------+
|                term|median_year|max(duration)|count(artistID)|
+--------------------+-----------+-------------+---------------+
|  adult contemporary|     1979.0|    938.89264|            704|
|               anime|        0.0|     1613.322|            253|
|            dub rock|     2003.0|    243.17342|              9|
|electronica latin...|        0.0|     384.3914|              6|
|      french electro|     2005.5|    409.93915|             16|
|        german metal|     2004.0|    553.89996|             86|
| gramusels bluesrock|     1969.0|     637.1522|             60|
|        haldern 2008|        0.0|     375.8232|             10|
|         indie music|        0.0|     416.1824|             26|
|          indigenous|        0.0|    473.52118|              8|
|             lyrical|        0.0|    1904.7963|            587|
|          medwaybeat|        0.0|    286.35382|             13|
|             melodic|     1999.0|     896.1824|           1477|
|          micromusic|        0.0|    384.83545|              1|
|            oc remix|        0.0|    366.36688|              6|
| persian traditional|        0.0|    412.31628|              4|
|              poetry|     1979.0|    1270.8044|            433|
|   polish electronic|        0.0|    408.21506|              2|
|            priority|        0.0|    314.17422|              8|
|        pukkelpop 07|     2007.0|    174.54974|              1|
+--------------------+-----------+-------------+---------------+

Question 4 part B:
+----------------+------------------+
|            term|     avg(duration)|
+----------------+------------------+
|       mope rock|13.661589622497559|
|      murder rap| 15.46403980255127|
|    abstract rap| 25.91301918029785|
|experimental rap| 25.91301918029785|
|  brutal rapcore|26.461589813232422|
|     ghetto rock|26.461589813232422|
|     punk styles| 41.29914093017578|
|     turntablist| 43.32922387123108|
| german hardcore|45.086891174316406|
|     noise grind| 47.68869247436523|
+----------------+------------------+
```
#### Question 5: 
Create a query using Spark transformations that finds the number of distinct tracks associated (through artistID) to each term.
  Modify this query to return only the top 10 most popular terms, and again for the bottom 10.
  Include each query and the tables for the top 10 most popular terms and the 10 least popular terms in your response. 


Code:
```
unpopular = spark.sql('SELECT a.term, COUNT(t.trackID) as track_counts FROM artist a LEFT JOIN tracks t ON a.artistID = t.artistID GROUP BY a.term ORDER BY COUNT(t.trackID) LIMIT 10')
unpopular.show()

popular = spark.sql('SELECT a.term, COUNT(t.trackID) as track_counts FROM artist a LEFT JOIN tracks t ON a.artistID = t.artistID GROUP BY a.term ORDER BY COUNT(t.trackID) DESC LIMIT 10')
popular.show()
```

Output:
```
10 Least Popular Terms:
+--------------------+------------+
|                term|track_counts|
+--------------------+------------+
|      trance melodic|           0|
|       galante music|           0|
|    stonersludgecore|           0|
|       ambient metal|           0|
|            techcore|           0|
|progressive melod...|           0|
|       fonal records|           0|
|               sense|           0|
|blackened doom metal|           0|
| finnish death metal|           0|
+--------------------+------------+

10 Most Popular Terms:
+----------------+------------+
|            term|track_counts|
+----------------+------------+
|            rock|       21796|
|      electronic|       17740|
|             pop|       17129|
|alternative rock|       11402|
|         hip hop|       10926|
|            jazz|       10714|
|   united states|       10345|
|        pop rock|        9236|
|     alternative|        9209|
|           indie|        8569|
+----------------+------------+
```

## Part 2: Parquet Optimization:

What to include in your report:
  - Tables of all numerical results (min, max, median) for each query/size/storage combination for part 2.3, 2.4 and 2.5.
  - How do the results in parts 2.3, 2.4, and 2.5 compare?
  - What did you try in part 2.5 to improve performance for each query?
  - What worked, and what didn't work?

Basic Markdown Guide: https://www.markdownguide.org/basic-syntax/

(All values are in units of seconds with 3 significant figures)

1. Tables of all numerical results:

| avg_income      | Minimum       | Median         | Maximum      |
| --------------- |:-------------:| --------------:| ------------:|
| csv: small      | 0.783         | 3.49           | 8.37         |
| csv: medium     | 0.727         | 0.824          | 9.04         |
| csv: large      | 7.21          | 10.2           | 16.7         |
| pq: small       |               |                |              |
| pq: medium      |               |                |              |
| pq: large       |               |                |              |
| pq_fast: small  |               |                |              |              
| pq_fast: medium |               |                |              |
| pq_fast: large  |               |                |              |


| max_income      |  Minimum      | Median         | Maximum      |
| --------------- |:-------------:| --------------:| ------------:|
| csv: small      | 0.664         | 0.880          | 8.63         |
| csv: medium     | 0.650         | 0.789          | 8.23         |
| csv: large      | 6.81          | 7.01           | 15.7         |
| pq: small       |               |                |              |
| pq: medium      |               |                |              |
| pq: large       |               |                |              |
| pq_fast: small  |               |                |              |              
| pq_fast: medium |               |                |              |
| pq_fast: large  |               |                |              |


| anna            |  Minimum      | Median         | Maximum      |
| --------------- |:-------------:| --------------:| ------------:|
| csv: small      | 0.0801        | 0.104          | 7.03         |
| csv: medium     | 0.312         | 0.337          | 7.63         |
| csv: large      | 7.21          | 10.2           | 19.2         |
| pq: small       |               |                |              |
| pq: medium      |               |                |              |
| pq: large       |               |                |              |
| pq_fast: small  |               |                |              |              
| pq_fast: medium |               |                |              |
| pq_fast: large  |               |                |              |

2. Comparison of results:



3. What I attempted to improve performance for each query:



4. What worked, and what didn't work:
