# Top Hadoop Interview Questions In 2020 – HDFS

follow [link](https://www.edureka.co/blog/interview-questions/hadoop-interview-questions-hdfs-2/) for details

---
### 1. What are the core components of Hadoop?


|Component|Description|
|:---|:---|
|HDFS|Hadoop Distributed file system or HDFS is a Java-based distributed file system that allows us to store Big data across multiple nodes in a Hadoop cluster.|
|YARN|YARN is the processing framework in Hadoop that allows multiple data processing engines to manage data stored on a single platform and provide Resource management.|


---
### 2. What are the key features of HDFS?
- <b>Cost effective and Scalable</b>: HDFS, in general, is deployed on a commodity hardware. So, it is very economical in terms of the cost of ownership of the project. Also, one can scale the cluster by adding more nodes.
- <b>Variety and Volume of Data</b>: HDFS is all about storing huge data i.e. Terabytes & Petabytes of data and different kinds of data. So, I can store any type of data into HDFS, be it structured, unstructured or semi structured.
- <b>Reliability and Fault Tolerance</b>: HDFS divides the given data into data blocks, replicates it and stores it in a distributed fashion across the Hadoop cluster. This makes HDFS very reliable and fault tolerant. 
- <b>High Throughput</b>: Throughput is the amount of work done in a unit time. HDFS provides high throughput access to application data.


---
### 3. Explain the HDFS Architecture and list the various HDFS daemons in HDFS cluster?
- <b>NameNode</b>: It is the master daemon that maintains and manages the data block present in the DataNodes. 
- <b>DataNode</b>: DataNodes are the slave nodes in HDFS. Unlike NameNode, DataNode is a commodity hardware, that is responsible of storing the data as blocks.
- <b>Secondary NameNode</b>: The Secondary NameNode works concurrently with the primary NameNode as a helper daemon. It performs checkpointing. 


---
### 4. What is checkpointing in Hadoop?
Checkpointing is the process of <b>combining the Edit Logs</b> with the <b>FsImage</b> (File system Image). 
It is performed by the <b>Secondary NameNode</b>.


---
### 5. What is a NameNode in Hadoop?
The NameNode is the master node that manages all the DataNodes (slave nodes). 
It records the metadata information regarding all the files stored in the cluster (on the DataNodes), 
e.g. The location of blocks stored, the size of the files, permissions, hierarchy, etc.


---
### 6. What is a DataNode?
DataNodes are the slave nodes in HDFS. 
It is a commodity hardware that provides storage for the data. 
It serves the read and write request of the HDFS client. 


---
### 7. Is Namenode machine same as DataNode machine as in terms of hardware?
Unlike the DataNodes, a NameNode is a highly available server 
that manages the File System Namespace and maintains the metadata information. 
Therefore, <b>NameNode requires higher RAM for storing the metadata information</b> 
corresponding to the millions of HDFS files in the memory, 
whereas the DataNode needs to have a higher disk capacity for storing huge data sets. 


---
### 10. What is throughput? How does HDFS provides good throughput?
Throughput is the amount of <b>work done in a unit time</b>. HDFS provides good throughput because:
- <b>Write Once and Read Many Model</b>: it simplifies the data coherency(일관성) issues as the data written once can’t be modified and therefore, provides high throughput data access.
- <b>The computation part is moved towards the data</b>: it reduces the network congestion and therefore, enhances the overall system throughput.


---
### 11. What is Secondary NameNode? Is it a substitute or back up node for the NameNode?
A Secondary NameNode is a helper daemon that performs <b>checkpointing</b> in HDFS. 
- It is not a backup or a substitute node for the NameNode. 
- It periodically, takes the <b>edit logs</b> (meta data file) from NameNode and merges it with the <b>FsImage</b> to produce an updated FsImage
- It prevent the Edit Logs from becoming too large.





