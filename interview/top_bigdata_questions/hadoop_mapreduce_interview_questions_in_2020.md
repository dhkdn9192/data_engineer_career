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




## Reference
- https://www.edureka.co/blog/interview-questions/hadoop-interview-questions-mapreduce/
