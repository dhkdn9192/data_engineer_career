# Hive - Partition vs Bucket vs Index

## Partition
Partitions provide segregation of the data at the hdfs level, 
creating sub-directories for each partition. 
Partitioning allows the number of files read and amount of data searched in a query to be limited. 
For this to occur however, partition columns must be specified in your WHERE clauses.

## Index
Indexes are new and evolving (features are being added) but currently Indexes are limited to single tables 
and cannot be used with external tables. 
Creating an index creates a separate table. 
Indexes can be partitioned (matching the partitions of the base table). 
Indexes are used to speed the search of data within tables.

## Bucket
In Hive Tables or partition are subdivided into buckets based on the hash function of a column in the table 
to give extra structure to the data that may be used for more efficient queries.




## Reference
- https://data-flair.training/blogs/hive-partitioning-vs-bucketing/
