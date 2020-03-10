# Top 62 Data Engineer Interview Questions & Answers

---
### 4) Distinguish between structured and unstructured data

| Parameter | Structured Data | Unstructured Data|
| :--- | :--- | :--- |
| Storage | DBMS | Unmanaged file structures|
| Standard | ADO.net, ODBC, and SQL | STMP, XML, CSV, and SMS|
| Integration Tool | ELT (Extract, Transform, Load) | Manual data entry or batch processing that includes codes|
| scaling | Schema scaling is difficult | Scaling is very easy.|

---
### 5) Explain all components of a Hadoop application
- <b>Hadoop Common</b>: It is a common set of utilities and libraries that are utilized by Hadoop.
- <b>HDFS</b>: This Hadoop application relates to the file system in which the Hadoop data is stored. It is a distributed file system having high bandwidth.
- <b>Hadoop MapReduce</b>: It is based according to the algorithm for the provision of large-scale data processing.
- <b>Hadoop YARN</b>: It is used for resource management within the Hadoop cluster. It can also be used for task scheduling for users.

---
### 7) Define HadoopStreaming
자바 이외의 언어로 MapReduce 애플리케이션을 작성할 수 있도록 Hadoop에서 제공하는 프로그램 인터페이스다.
- HadoopStreaming으로 애플리케이션을 작성할 경우, map 함수와 reduce 함수 처리를 직접 구현
- Map/Reduce 처리를 위한 데이터 입출력은 <b>표준 입출력</b>을 사용
- 표준입출력을 사용하므로 어떤 언어로든 MapReduce 애플리케이션을 만들 수 있다. (파이썬 등)

---
### 10) What are the steps that occur when Block Scanner detects a corrupted data block?
The function of block scanner is to scan block data to detect possible corruptions. 

Since data corruption may happen at any time on any block on any DataNode, 
it is important to identify those errors in a timely manner. 
This way, the <b>NameNode can remove the corrupted blocks and re-replicate</b> accordingly, 
to maintain data integrity and reduce client errors.

---
### 11) Name two messages that NameNode gets from DataNode?
- <b>Block report</b>
- <b>Heartbeats</b>



### Reference
- https://www.guru99.com/data-engineer-interview-questions.html
