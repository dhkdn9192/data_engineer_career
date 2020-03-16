# Top Hadoop Interview Questions 2020 – Apache Hive


## Apache Hive – A Brief Introduction
- a <b>data warehouse</b> system built on top of Hadoop 
- used for <b>analyzing structured and semi-structured</b> data.
- provides a mechanism to project structure onto the data and perform <b>queries written in HiveQL</b> (similar to SQL).
- Internally, these queries or HiveQL gets <b>converted to map reduce jobs</b> by the Hive compiler.


---
### 1. Define the difference between Hive and HBase?
| HBase | Hive |
| :--- | :--- |
| HBase is built on the top of HDFS | It is a data warehousing infrastructure|
| HBase operations run in a real-time on its database rather | Hive queries are executed as MapReduce jobs internally |
| Provides low latency to single rows from huge datasets | Provides high latency for huge datasets |
| Provides random access to data | Provides random access to data |


---
### 3. Where does the data of a Hive table gets stored?
By default, the Hive table is stored in an HDFS directory – ```/user/hive/warehouse```. 
One can change it by specifying the desired directory in ```hive.metastore.warehouse.dir``` configuration parameter 
present in the ```hive-site.xml```. 


---
### 4. What is a metastore in Hive?
Metastore in Hive stores the <b>meta data information using RDBMS</b> 
and an open source ORM (Object Relational Model) layer called Data Nucleus 
which converts the object representation into relational schema and vice versa.


---
### 5. Why Hive does not store metadata information in HDFS?
Hive stores metadata information in the metastore using RDBMS instead of HDFS. 
The reason for choosing RDBMS is <b>to achieve low latency</b> as HDFS read/write operations are time consuming processes.


---
### 6. What is the difference between local and remote metastore?

#### Local Metastore:

In local metastore configuration, the metastore service runs in the same JVM in which the Hive service is running and connects to a database running in a separate JVM, either on the same machine or on a remote machine.

![hive_local_metastore](img/hive_local_metastore.png)

#### Remote Metastore:

In the remote metastore configuration, the metastore service runs on its own separate JVM and not in the Hive service JVM. Other processes communicate with the metastore server using Thrift Network APIs. You can have one or more metastore servers in this case to provide more availability.

The main advantage of using remote metastore is <b>you do not need to share JDBC login credential with each Hive user to access the metastore database</b>.

![hive_remote_metastore](img/hive_remote_metastore.png)

---
### 7. What is the default database provided by Apache Hive for metastore?
By default, Hive provides an embedded <b>Derby database</b> instance backed by the local disk for the metastore. 
This is called the embedded metastore configuration.

In this case, <b>only one user can connect to metastore database at a time</b>. 
If you start a second instance of Hive driver, you will get an error. 
This is good for unit testing, but not for the practical solutions.

![hive_embedded_metastore](img/hive_embedded_metastore.png)


---
### 9. What is the difference between external table and managed table?

#### Managed Table
In case of managed table, If one drops a managed table, the metadata information along with the table data is deleted from the Hive warehouse directory.

#### External Table
On the contrary, in case of an external table, Hive <b>just deletes the metadata</b> information regarding the table and <b>leaves the table data present in HDFS untouched</b>. 


---
### 11. When should we use SORT BY instead of ORDER BY?

| SORT BY | ORDER BY |
| :---: | :---: |
|sorts the data using <b>multiple reducers</b>|sorts all of the data together using a <b>single reducer</b>|

We should use <b>SORT BY instead of ORDER BY when we have to sort huge datasets</b> 
because SORT BY clause sorts the data using multiple reducers 
whereas ORDER BY sorts all of the data together using a single reducer. 
Therefore, using ORDER BY against a large number of inputs will take a lot of time to execute. 


---
### 12. What is a partition in Hive?
Hive organizes tables into partitions for <b>grouping similar type of data together</b> based on a <b>column or partition key</b>. 
Each Table can have one or more partition keys to identify a particular partition. 
Physically, a partition is nothing but a sub-directory in the table directory.

```WHERE``` 구를 지정해서 특정 조건의 데이터를 추출할 때, 대량의 데이터 중에서 극히 일부의 데이터만 사용하게 된다.
따라서 데이터를 특정 조건으로 분할해서 물리적으로 저장하면 효율적으로 원하는 데이터를 추출할 수 있다.
이를 "파티셔닝"이라 하며, 분할된 개별 단위는 "파티션"이라 한다.

Hive는 ```CREATE TABLE``` 구문 안에서 ```PARTITIONED BY```를 이용하여 파티션에 사용할 칼럼명, 데이터형을 지정할 수 있다.


---
### 13. Why do we perform partitioning in Hive?
Partitioning provides granularity in a Hive table and 
therefore, <b>reduces the query latency</b> by scanning <b>only relevant partitioned data</b> instead of the whole data set.

For example, we can partition a transaction log of an e – commerce website based on month like Jan, February, etc. So, any analytics regarding a particular month, say Jan, will have to scan the Jan partition (sub – directory) only instead of the whole table data.


---
### 14. What is dynamic partitioning and when is it used?
In dynamic partitioning values for partition columns are known in the runtime, i.e. 
It is known during loading of the data into a Hive table. 

One may use dynamic partition in following two cases:

- Loading data from an existing non-partitioned table to improve the sampling and therefore, decrease the query latency. 
- When one <b>does not know all the values of the partitions</b> before hand and therefore, finding these partition values manually from a huge data sets is a tedious task. 

#### 정적 파티션
정적 파티션은 data 삽입을 위해서 partition의 값을 명시적으로 입력해야 한다. 
```
insert into table salesdata partition (date_of_sale='10-27-2017')
```

#### 동적 파티션
파티션 칼럼의 값을 기반으로 hive engine 이 동적으로 파티션을 수행할 수 있도록 하는 방식이 있다.
```
set hive.exec.dynamic.partition.mode=nonstrict;
```
```
hive> insert into table salesdata partition (date_of_sale)
select salesperson_id,product_id,date_of_sale from salesdata_source ;
```


---
### 16. How can you add a new partition for the month December in the above partitioned table?
For adding a new partition in the above table partitioned_transaction, we will issue the command give below:
```
ALTER TABLE partitioned_transaction ADD PARTITION (month='Dec') LOCATION  '/partitioned_transaction';
```




## Reference
- https://www.edureka.co/blog/interview-questions/hive-interview-questions/
- https://www.edureka.co/blog/hive-tutorial/
