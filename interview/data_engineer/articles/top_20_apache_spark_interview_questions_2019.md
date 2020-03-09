# Top 20 Apache Spark Interview Questions 2019

follow [link](https://acadgild.com/blog/top-20-apache-spark-interview-questions-2019) for details

---
### 1. What is Apache Spark?
Apache Spark is a <b>cluster computing framework</b> which runs on a cluster of commodity hardware 
and performs data unification i.e., reading and writing of wide variety of data from multiple sources. 
In Spark, a task is an operation that can be a map task or a reduce task. 
<b>Spark Context</b> handles the execution of the job and also provides API’s in different languages 
i.e., Scala, Java and Python to develop applications and <b>faster</b> execution as compared to MapReduce.


---
### 2. How is Spark different from MapReduce? Is Spark faster than MapReduce?
- There is no <b>tight coupling</b> in Spark i.e., there is no mandatory rule that reduce must come after map.
- Spark tries to keep the data <b>in-memory</b> as much as possible.

In MapReduce, the intermediate data will be stored in HDFS and hence takes longer time to get the data from a source.


---
### 3. Explain the Apache Spark Architecture. How to Run Spark applications?
- Apache Spark application contains two programs namely a <b>Driver</b> program and <b>Workers</b> program.
- A <b>cluster manager</b> will be there in-between to interact with these two cluster nodes. 
- <b>Spark Context</b> will keep in touch with the worker nodes with the help of Cluster Manager.
- <b>Spark Context</b> is like a master and Spark workers are like slaves.
- Workers contain the <b>executors</b> to run the job. 
- If any dependencies or arguments have to be passed then Spark Context will take care of that. 
- RDD’s will reside on the Spark Executors.


---
### 4. What is RDD?
- <b>RDD</b> stands for Resilient Distributed Datasets (RDDs). 
- All the data can be <b>distributed</b> across all the nodes 
- <b>Partition</b> is one subset of data and it will be processed by a particular task. 
- RDD's are very close to input splits in MapReduce.


---
### 5. What is the role of coalesce () and repartition () in Map Reduce?
Both coalesce and repartition are used to modify the number of partitions in an RDD but Coalesce avoids full shuffle.

RDD를 생성한 뒤 filter()연산을 비롯한 다양한 트랜스포메이션 연산을 수행하다 보면 최초에 설정된 파티션 개수가 적합하지 않은 경우가 발생할 수 있다.
이 경우 coalesce()나 repartition()연산을 사용해 현재의 RDD의 파티션 개수를 조정할 수 있다.
- <b>repartition()</b>: 파티션 수를 늘리거나 줄이는 것을 모두 할 수 있지만 <b>shuffle이 강제된다</b>. -> 파티션을 늘릴 때만 사용
- <b>coalesce()</b>: 파티션 수를 줄이는 것만 가능하며 <b>shuffle이 강제되지 않는다</b>. -> 파티션을 줄일 때만 사용


---
### 6. How do you specify the number of partitions while creating an RDD? What are the functions?
You can specify the number of partitions while creating a RDD either by using the sc.textFile or by using parallelize functions.
```
val rdd = sc.parallelize(data,4)
val data = sc.textFile(“path”,4)
```


---
### 7. What are actions and transformations?
Transformations create new RDD’s from existing RDD and these transformations are lazy and will not be executed until you call any action.
- <b>Transformations</b>: map(), filter(), flatMap(), ... -> return "new RDD"
- <b>Actions</b>: reduce(), count(), collect(), ... -> return "result of RDD"


---
### 8 What is partition?
RDD는 여러개의 partition들로 구성되며 partition의 개수는 클러스터의 CPU 코어 수에 따라 결정된다. 즉, <b>partition 개수만큼 parallel 수행</b>이 이뤄진다.
- coalesce()와 repartition()
  - 파티션의 개수를 줄일 경우 coalesce()를 사용하며 parallelism은 감소하지만 shuffle은 일어나지 않는다. 주로 HDFS 등에 저장할 때 사용.
  - 파티션의 개수를 늘릴 경우 repartition()을 사용하며 parallelism은 증가하지만 shuffle가 일어난다.


---
### 10. What is the role of cache() and persist()?
Whenever you want to store a RDD into memory such that the <b>RDD will be used multiple times</b> 
or that RDD might have <b>created after lots of complex processing</b> in those situations, 
you can take the advantage of Cache or Persist.

- <b>persist()</b>: you can store the RDD on the <b>disk</b> or in the <b>memory</b> or both.
- <b>cache()</b>: it is like persist() function only, where the <b>storage level</b> is set to <b>memory only</b>.



  


### Reference
- https://acadgild.com/blog/top-20-apache-spark-interview-questions-2019
