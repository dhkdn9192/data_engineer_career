# What's the difference between Sharding and Partitioning?

## Partitioning

I have a set of data items (records). Each record has a key. I can use this key to <b>partition (distribute) these records into multiple different units</b>. If we talk about Oracle RDBMS, table partitioning has been there for quite some time. Using the partition key, records of a table are sub-divided into 2 or more partitions. <b>These partitions are still in the control of same DB Instance</b> : share the same CPU, memory, I/O, storage resources with other peer partitions and also other non-partitioned tables.

Oracle supports Hash, Range, and List based partitioning. The purpose of these and many other distribution schemes is simple: given a key for a record, determine the destination partition that it will belong to.


## Sharding

It turns out that <b>partitioning across different physical machines/nodes is termed as sharding</b>. Now each partition sits on an entirely <b>different physical machine</b>, and thus in a <b>different schema</b> and under the control of a <b>separate database instance</b>. This is what is done in MongoDB. The approaches to distribute data across multiple machines are hash and range.

"Sharding is a method to <b>distribute data across multiple different servers</b>. We achieve horizontal scalability through sharding." - MongoDB’s online manual


## common feature

Both are trying to distribute data to multiple machines and building a <b>scale out</b> database architecture.


## difference

“<b>Sharding is distribution or partition of data across multiple different machines whereas partitioning is distribution of data on the same machine</b>”.


## Reference
- https://www.quora.com/Whats-the-difference-between-sharding-DB-tables-and-partitioning-them
- https://ko.wikipedia.org/wiki/%EB%8D%B0%EC%9D%B4%ED%84%B0%EB%B2%A0%EC%9D%B4%EC%8A%A4_%EB%B6%84%ED%95%A0
- https://gmlwjd9405.github.io/2018/09/24/db-partitioning.html
