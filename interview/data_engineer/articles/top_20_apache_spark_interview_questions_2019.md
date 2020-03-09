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
### 8. What is partition?
RDD는 여러개의 partition들로 구성되며 partition의 개수는 클러스터의 CPU 코어 수에 따라 결정된다. 즉, <b>partition 개수만큼 parallel 수행</b>이 이뤄진다.
- coalesce()와 repartition()
  - 파티션의 개수를 줄일 경우 coalesce()를 사용하며 parallelism은 감소하지만 shuffle은 일어나지 않는다. 주로 HDFS 등에 저장할 때 사용.
  - 파티션의 개수를 늘릴 경우 repartition()을 사용하며 parallelism은 증가하지만 shuffle가 일어난다.


---
### 9. What is data locality in Spark?
Data Locality는 데이터와 코드가 얼마나 가까이에 있는지를 나타내는 Spark job 퍼포먼스의 중대한 요소 중 하나이다. 
Spark은 locality를 위해 데이터가 위치한 서버의 CPU가 사용 가능한 상태가 될 때까지 일정시간(default 3초) 대기한다.
대기시간 만료 후엔 가용 CPU 서버로 데이터를 이동시킨다.

locality level은 프로세스>노드>랙>Any 순으로 속도가 빠르다.
- PROCESS_LOCAL: 데이터가 실행되고 있는 코드의 JVM 과 함께 위치해 있는 경우. 가장 실행 속도가 빠름
- NODE_LOCAL: 데이터가 같은 노드에 있는 경우. data 가 process 들 간에 이동해야하기 때문에 PROCESS_LOCAL 보다는 조금 느림
- RACK_LOCAL: 데이터가 같은 Rack 의 다른 서버에 존재하지만, 단순하게 Switch 쪽을 통한 Network 비용만이 발생함
- ANY: 데이터가 같은 Rack 이 아닌 다른 네트워크 상에 존재하는 경우. 가장 속도가 느림

locality를 맞추기 위한 대기시간은 다음 옵션으로 설정할 수 있다. 
해당 시간이 만료되면 locality를 희생하고 원격 서버에 job을 할당한다.
```
spark.locality.wait
```


---
### 10. What is the role of cache() and persist()?
Whenever you want to store a RDD into memory such that the <b>RDD will be used multiple times</b> 
or that RDD might have <b>created after lots of complex processing</b> in those situations, 
you can take the advantage of Cache or Persist.

- <b>persist()</b>: you can store the RDD on the <b>disk</b> or in the <b>memory</b> or both.
- <b>cache()</b>: it is like persist() function only, where the <b>storage level</b> is set to <b>memory only</b>.


---
### 11. What are Accumulators?
- <b>write only variables</b> 
- <b>initialized once and sent to the workers</b>.
- These workers will update based on the logic written and sent back to the driver which will aggregate or process based on the logic.
- Only driver can access the accumulator’s value. For tasks, Accumulators are write-only. 
- For example, it is used to <b>count the number errors</b> seen in RDD across workers.


---
### 12. What are Broadcast Variables?
- <b>read-only shared variables</b>. 
- For case of a set of data which may have to be <b>used multiple times</b> in the workers at <b>different phases</b>
- <b>shared to the workers</b> from the driver and every machine can read them.


---
### 13. What are the optimizations that developer can make while working with spark?
Spark is memory intensive, whatever you do it does in memory.
- <b>locality</b>: how long spark will wait before it times out on each of the phases of data locality (data local –> process local –> node local –> rack local –> Any).
- <b>shuffle</b>: Filter out data as early as possible. 
- <b>caching</b>: with cache() or persist(), choose wisely from various storage levels.
- <b>partition</b>: Tune the number of partitions in spark for parallelism.
- <b>broadcast and accumulator</b>: use read-only, write-only varables.


---
### 14. What is Spark SQL?
<b>Spark SQL</b> is a module for structured data processing where we take <b>advantage of SQL queries</b> running on the datasets.


---
### 15. What is a Data Frame?
A data frame is like a table, it got some named columns which organized into columns. 
You can create a data frame from a file or from tables in hive, external databases SQL or NoSQL or existing RDD’s. 
It is analogous to a table.


---
### 19. What is Spark Streaming?
Whenever there is <b>data flowing continuously</b> and you want to process the data as early as possible, 
in that case you can take the advantage of Spark Streaming. 
It is the <b>API for stream processing of live data</b>.

Data can flow for Kafka, Flume or from TCP sockets, Kenisis etc., and you can do complex processing on the data 
before you pushing them into their destinations. 
Destinations can be file systems or databases or any other dashboards.


---
### 20. What is Sliding Window?
Basically, any Spark window operation requires specifying two parameters.
- <b>Window length</b>: It defines the duration of the window.
- <b>Sliding interval</b>: It defines the interval at which the window operation is performed.


---
### Reference
- https://acadgild.com/blog/top-20-apache-spark-interview-questions-2019
