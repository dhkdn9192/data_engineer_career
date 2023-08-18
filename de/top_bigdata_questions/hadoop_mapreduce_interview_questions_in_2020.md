# Hadoop MapReduce Interview Questions In 2020

## 0. MapReduce Basic

#### Definition:
MapReduce is a programming framework that allows us to perform distributed and parallel processing on large data sets 
in a distributed environment.

#### MR2.0 with YARN:
- <b>Master/Slave Topology</b> : the master node (Resource Manager) manages and tracks various MapReduce jobs being executed on the slave nodes (Node Mangers).
- Resource Manager consists of two main components:
  - <b>Application Manager</b>: It accepts job-submissions, negotiates the container for <b>ApplicationMaster</b> and handles failures while executing MapReduce jobs.
  - <b>Scheduler</b>: Scheduler allocates resources that is required by various MapReduce application running on the Hadoop cluster.

#### How MapReduce job works:
1. Reducer phase takes place after the mapper phase has been completed.
2. The first is the map job, where a block of data is read and processed to produce key-value pairs as intermediate outputs.
3. The reducer receives the key-value pair from multiple map jobs.
4. Then, the reducer aggregates those intermediate data tuples (intermediate key-value pair) into a smaller set of tuples or key-value pairs which is the final output.


---
### 1. What are the advantages of using MapReduce with Hadoop?

| Advantage | Description|
| :--- | :--- |
| Flexible | Hadoop MapReduce programming can access and operate on different types of structured and unstructured|
| Parallel Processing | MapReduce programming divides tasks for execution in parallel|
| Resilient | Is fault tolerant that quickly recognizes the faults & then apply a quick recovery solution implicitly|
| Scalable | Hadoop is a highly scalable platform that can store as well as distribute large data sets across plenty of servers|
| Cost-effective | High scalability of Hadoop also makes it a cost-effective solution for ever-growing data storage needs|
| Simple | It is based on a simple programming model |
| Secure | Hadoop MapReduce aligns with HDFS and HBase security for security measures|
| Speed | It uses the distributed file system for storage that processes even the large sets of unstructured data in minutes|


---
### 2. What do you mean by data locality?
- <b>Data locality</b> talks about moving computation unit to data rather data to the computation unit.
- MapReduce framework achieves data locality by processing data locally
- Which means processing of the data happens in the very node by Node Manager where data blocks are present. 


---
### 3. Is it mandatory to set input and output type/format in MapReduce?
No, it is not mandatory to set the input and output type/format in MapReduce. 
<b>By default, the cluster takes the input and the output type as 'text'</b>.


---
### 4. Can we rename the output file?
Yes, we can rename the output file by implementing <b>multiple format output class</b>.


---
### 5. What do you mean by shuffling and sorting in MapReduce?
Shuffling and sorting takes place <b>after the completion of map task</b> 
where the input to the every reducer is sorted according to the keys. 

#### Shuffle:
- the system sorts the key-value output of the map tasks
- then transfer it to the reducer


---
### 6. Explain the process of spilling in MapReduce?
The output of a map task is written into a circular memory buffer (RAM). 
The default size of buffer is set to 100 MB  which can be tuned by using ```mapreduce.task.io.sort.mb``` property. 
Now, spilling is a process of copying the data from memory buffer to disc 
when the content of the buffer reaches a certain threshold size. 

By default, a background thread starts spilling the contents from memory to disc after <b>80% of the buffer size</b> is filled. 
Therefore, for a 100 MB size buffer the spilling will start after the content of the buffer reach a size of 80 MB.

#### Spilling:
a process of copying the data from memory buffer to disc when the content of the buffer reaches a certain threshold size


---
### 7. What is a distributed cache in MapReduce Framework?
Distributed Cache is a facility provided by the MapReduce framework to cache files needed by applications.
Once you have cached a file for your job, Hadoop framework will make it available on each and every data nodes 
where you map/reduce tasks are running. 
Therefore, one can access the cache file as a local file in your Mapper or Reducer job.


---
### 8. What is a combiner and where you should use it?
Combiner is like a mini reducer function that allow us to perform a local aggregation of map output 
before it is transferred to reducer phase. 
Basically, it is used to optimize the network bandwidth usage during a MapReduce task 
by cutting down the amount of data that is transferred from a mapper to the reducer.


---
### 9. Why the output of map tasks are stored (spilled ) into local disc and not in HDFS?
The outputs of map task are the intermediate key-value pairs 
which is then processed by reducer to produce the final aggregated result. 
<b>Once a MapReduce job is completed, there is no need of the intermediate output produced by map tasks</b>. 
Therefore, storing these intermediate output into HDFS and replicate it will create unnecessary overhead.


---
### 10. What happens when the node running the map task fails before the map output has been sent to the reducer?
In this case, <b>map task will be assigned a new node</b> and whole task will be <b>run again</b> to re-create the map output.  

---
### 11. What is the role of a MapReduce Partitioner?
A partitioner divides the intermediate key-value pairs produced by map tasks into partition. 
<b>The total number of partition is equal to the number of reducers</b> 
where each partition is processed by the corresponding reducer. 
The partitioning is done using the hash function based on a single key or group of keys. 
The default partitioner available in Hadoop is ```HashPartitioner```.


---
### 12. How can we assure that the values regarding a particular key goes to the same reducer?
<b>By using a partitioner</b> we can control that a particular key – value goes to the same reducer for processing. 


---
### 17. What are the various configuration parameters required to run a MapReduce job?
- Job's input locations in the distributed file system
- Job's output location in the distributed file system
- Input format of data (default: String)
- Output format of data
- Class containing the map function
- Class containing the reduce function
- JAR file containing the mapper, reducer and driver classes


---
### 20. What is a map side join?
Map side join is a process where <b>two data sets are joined by the mapper</b>.


---
### 21. What are the advantages of using map side join in MapReduce?
- Map-side join helps in minimizing the cost that is incurred for <b>sorting and merging in the shuffle and reduce stages</b>.
- Map-side join also helps in improving the performance of the task by <b>decreasing the time to finish the task</b>.


---
### 24. Is it legal to set the number of reducer task to zero? Where the output will be stored in this case?
Yes, It is legal to set the number of reduce-tasks to zero if there is no need for a reducer. 
In this case the outputs of the map task is directly stored into the HDFS which is specified in the setOutputPath(Path). 


---
### 27. How will you submit extra files or data ( like jars, static files, etc. ) for a MapReduce job during runtime?
The <b>distributed cache</b> is used to distribute large read-only files that are needed by map/reduce jobs to the cluster. 
The framework will copy the necessary files from a URL on to the slave node 
before any tasks for the job are executed on that node. 
The files are only copied once per job and so should not be modified by the application.


---
### 29. How do reducers communicate with each other?
This is a tricky question. 
The "MapReduce" programming model does not allow "reducers" to communicate with each other. 
"Reducers" run in isolation.


---
### 30. Define Speculative Execution
If a node appears to be executing a task slower than expected, 
the master node can redundantly execute another instance of the same task on another node. 
Then, the task which finishes first will be accepted whereas other tasks will be killed. 
This process is called <b>speculative execution</b>.


## Reference
- https://www.edureka.co/blog/interview-questions/hadoop-interview-questions-mapreduce/
