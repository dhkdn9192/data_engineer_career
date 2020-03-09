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


---
### 12. What do you mean by meta data in HDFS? List the files associated with metadata.
- <b>FsImage</b>: It contains the complete state of the file system namespace since the start of the NameNode.
- <b>EditLogs</b>: It contains all the recent modifications made to the file system with respect to the recent FsImage.


---
### 13. What is the problem in having lots of small files in HDFS?
NameNode stores the metadata information regarding file system in the <b>RAM</b>. 
Therefore, the amount of memory produces a limit to the number of files in my HDFS file system. 
Too much of files will lead to the generation of too much meta data and <b>storing these meta data in the RAM will become a challenge</b>. 
As a thumb rule, metadata for a file, block or directory takes 150 bytes.  


---
### 14. What is a heartbeat in HDFS?
Heartbeats in HDFS are the signals that are sent by DataNodes to the NameNode to indicate that it is functioning properly (alive). 
By default, the heartbeat interval is 3 seconds, which can be configured using dfs.heartbeat.interval in hdfs-site.xml.


---
### 16. What is a block?
Blocks are the smallest continuous location on your hard drive where data is stored. 
HDFS stores each file as blocks, and distribute it across the Hadoop cluster. 
The default size of a block in HDFS is 128 MB (Hadoop 2.x) and 64 MB (Hadoop 1.x) 
which is much larger as compared to the Linux system where the block size is 4KB. 
<b>The reason of having this huge block size is to minimize the cost of seek and reduce the meta data information generated per block</b>.


---
### 17. Suppose there is file of size 514 MB stored in HDFS (Hadoop 2.x) using default block size configuration and default replication factor. Then, how many blocks will be created in total and what will be the size of each block?
Default block size in Hadoop 2.x is 128 MB. So, a file of size 514 MB will be divided into 5 blocks ( 514 MB/128 MB) where the first four blocks will be of 128 MB and the last block will be of 2 MB only. Since, we are using the default replication factor i.e. 3, each block will be replicated thrice. Therefore, we will have 15 blocks in total where 12 blocks will be of size 128 MB each and 3 blocks of size 2 MB each.


---
### 20. What is a block scanner in HDFS?
<b>Block scanner</b> runs periodically on every DataNode to verify whether the data blocks stored are correct or not. 
The following steps will occur when a corrupted data block is detected by the block scanner:

- First, the DataNode will report about the corrupted block to the NameNode.
- Then, NameNode will start the process of creating a new replica using the correct replica of the corrupted block present in other DataNodes.
- The corrupted data block will not be deleted until the replication count of the correct replicas matches with the replication factor (3 by default).

This whole process allows HDFS to maintain the integrity of the data when a client performs a read operation. 
One can check the block scanner report using the DataNode’s web interface- localhost:50075/blockScannerReport


---
### 23. Can we have different replication factor of the existing files in HDFS?
Yes, one can have different replication factor for the files existing in HDFS. 
Suppose, I have a file named test.xml stored within the sample directory in my HDFS with the replication factor set to 1. 
Now, the command for changing the replication factor of text.xml file to 3 is:
```
hadoop fs -setrwp -w 3 /sample/test.xml
```

Finally, I can check whether the replication factor has been changed or not by using following command:
```
hadoop fs -ls /sample
```
or 
```
hadoop fsck /sample/test.xml -files
```

---
### 24. What is a rack awareness algorithm and why is it used in Hadoop?
<b>Rack Awareness</b> algorithm in Hadoop ensures that all the block replicas are not stored on the same rack or a single rack. 
There are two reasons for using Rack Awareness:
- <b>To improve the network performance</b>: In general, you will find greater network bandwidth between machines in the same rack than the machines residing in different rack. So, the Rack Awareness helps to reduce write traffic in between different racks and thus provides a better write performance. 
- <b>To prevent loss of data</b>: I don't have to worry about the data even if an entire rack fails because of the switch failure or power failure. And if one thinks about it, it will make sense, as it is said that never put all your eggs in the same basket.


---
### 25. How data or a file is written into HDFS?
Suppose a client wants to write a file into HDFS. 
So, the following steps will be performed internally during the whole HDFS write process:
- the client will divide the files into blocks and will send a write request to the NameNode.
- For each block, the NameNode will provide the client a list containing the IP address of DataNodes (depending on replication factor, 3 by default) where the data block has to be copied eventually.
- The client will copy the first block into the first DataNode and then the other copies of the block will be replicated by the DataNodes themselves in a sequential manner.


---
### 30. Define Data Integrity? How does HDFS ensure data integrity of data blocks stored in HDFS?
- HDFS creates the <b>checksum</b> for all the data written to it and verifies the data with the checksum during read operation by default. 
- Also, each DataNode runs a <b>block scanner</b> periodically, which verifies the correctness of the data blocks stored in the HDFS.
- HDFS follows <b>Write Once Read Many</b> model


---
### 32. Define Hadoop Archives? What is the command for archiving a group of files in HDFS.
<b>Hadoop Archive</b> was introduced to cope up with the problem of increasing memory usage of the NameNode 
for storing the metadata information because of too many small files. 
Basically, it allows us to <b>pack a number of small HDFS files into a single archive file</b> 
and therefore, reducing the metadata information. 
The final archived file follows the .har extension and one can consider it as a layered file system on top of HDFS. 


---
### 33. How will you perform the inter cluster data copying work in HDFS?
클러스터 간의 데이터 복사는 다음 명령어로 수행할 수 있다.
```
hadoop distcp hdfs://<source NameNode> hdfs://<target NameNode>
```

---
### Reference
- https://www.edureka.co/blog/interview-questions/hadoop-interview-questions-hdfs-2/
