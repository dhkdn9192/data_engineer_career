# Top 50 Hadoop Interview Questions In 2020

follow this [link](https://www.edureka.co/blog/interview-questions/top-50-hadoop-interview-questions-2016/) for details.


### 1. What are the basic differences between relational database and HDFS?

|                         | RDBMS   | Hadoop  |
| :---                    | :---    | :---    |
|Data Types               |RDBMS relies on the structured data and the schema of the data is always known.|Any kind of data can be stored into Hadoop i.e. Be it structured, unstructured or semi-structured.|
|Processing               |RDBMS provides limited or no processing capabilities.|Hadoop allows us to process the data which is distributed across the cluster in a parallel fashion.|
|Schema on Read Vs. Write |RDBMS is based on ‘schema on write’ where schema validation is done before loading the data.|On the contrary, Hadoop follows the schema on read policy.|
|Read/Write Speed         |In RDBMS, reads are fast because the schema of the data is already known.|The writes are fast in HDFS because no schema validation happens during HDFS write.|


### 3. What is Hadoop and its components. 
- Storage unit : <b>HDFS</b> (NameNode, DataNode)
- Processing framework : <b>YARN</b> (ResourceManager, NodeManager)


### 4. What are HDFS and YARN?

<b>HDFS</b> (Hadoop Distributed File System) is the storage unit of Hadoop. 
It is responsible for storing different kinds of data as blocks in a distributed environment. 
It follows <b>master and slave topology</b>.

- <b>NameNode</b>: NameNode is the master node in the distributed environment and it maintains the metadata information for the blocks of data stored in HDFS like block location, replication factors etc.
- <b>DataNode</b>: DataNodes are the slave nodes, which are responsible for storing data in the HDFS. NameNode manages all the DataNodes.

<b>YARN</b> (Yet Another Resource Negotiator) is the processing framework in Hadoop, 
which manages resources and provides an execution environment to the processes.

- <b>ResourceManager</b>: It receives the processing requests, and then passes the parts of requests to corresponding NodeManagers accordingly, where the actual processing takes place. It allocates resources to applications based on the needs.
- <b>NodeManager</b>: NodeManager is installed on every DataNode and it is responsible for the execution of the task on every single DataNode.


### 5. Tell me about the various Hadoop daemons and their roles in a Hadoop cluster.
- <b>NameNode</b>: It is the master node which is responsible for storing the metadata of all the files and directories. It has information about blocks, that make a file, and where those blocks are located in the cluster.
- <b>Datanode</b>: It is the slave node that contains the actual data.
- <b>Secondary NameNode</b>: It periodically merges the changes (edit log) with the FsImage (Filesystem Image), present in the NameNode. It stores the modified FsImage into persistent storage, which can be used in case of failure of NameNode.
- <b>ResourceManager</b>: It is the central authority that manages resources and schedule applications running on top of YARN.
- <b>NodeManager</b>: It runs on slave machines, and is responsible for launching the application's containers (where applications execute their part), monitoring their resource usage (CPU, memory, disk, network) and reporting these to the ResourceManager.
- <b>JobHistoryServer</b>: It maintains information about MapReduce jobs after the Application Master terminates.


### 7. List the difference between Hadoop 1 and Hadoop 2.

|                   | Hadoop 1.x                                  | Hadoop 2.x                                      |
| :---              | :---                                        | :---                                            |
| Passive NameNode  |NameNode is a <b>Single Point of Failure</b> |Active & Passive NameNode                        |
| Processing        |MRV1 (Job Tracker & Task Tracker)            |MRV2/<b>YARN</b> (ResourceManager & NodeManager) |


### 9. Why does one remove or add nodes in a Hadoop cluster frequently?

Attractive features of the Hadoop framework <b>leads to frequent DataNode crashes</b> in a Hadoop cluster.
- <b>utilization of commodity hardware</b>: 상용 제품 활용성이 높음
- <b>ease of scale in accordance with the rapid growth in data volume</b>: 데이터양 급증에 따른 스케일 조정이 용이함

Because of these two reasons, one of the most common task of a Hadoop administrator is 
to <b>commission (Add)</b> and <b>decommission (Remove)</b> "Data Nodes" in a Hadoop Cluster.


### 10. What happens when two clients try to access the same file in the HDFS?

HDFS supports <b>exclusive writes only</b>.

When the first client contacts the "NameNode" to open the file for writing, 
the "NameNode" grants a lease to the client to create this file. 
When the second client tries to open the same file for writing, 
the "NameNode" will notice that the lease for the file is already granted to another client, 
and will reject the open request for the second client.


### 11. How does NameNode tackle DataNode failures?
NameNode periodically receives a <b>Heartbeat</b> (signal) from each of the DataNode in the cluster, 
which implies DataNode is functioning properly.

A block report contains a list of all the blocks on a DataNode. 
If a DataNode fails to send a heartbeat message, after a specific period of time it is marked dead.

The NameNode replicates the blocks of dead node to another DataNode using the replicas created earlier.



