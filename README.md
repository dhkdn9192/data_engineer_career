
<p align="center">
  <img src="img/banner.png" alt="banner" width="90%">
</p>

데이터 엔지니어가 알아야 할 모든 것들을 정리합니다.
자료 출처는 각 문서의 하단을 참조하시기 바랍니다.
<br>
It organizes everything a data engineer needs to know. Please refer to the bottom of each document for the source of the content.


## Table of Contents
- [1. Interview](#1-interview)
  - [1-1. Hadoop Ecosystem](#1-1-hadoop-ecosystem)
  - [1-2. Computer Science](#1-2-computer-science)
  - [1-3. Algorithm & Data Structure](#1-3-algorithm-and-data-structure)
- [2. Bigdata Components](#2-bigdata-components)
  - [2-1. Set up with Cloudera](#2-1-set-up-with-cloudera)
  - [2-2. Hadoop Ecosystem](#2-2-hadoop-ecosystem)
  - [2-3. Elastic Stack](#2-3-elastic-stack)
- [3. Fields of Study](#3-fields-of-study)



<br>

## 1. Interview
데이터 엔지니어가 알아야 할 기술 질문
<br>
Technical questions data engineers need to know

### 1-1. Hadoop Ecosystem
- Apache Hadoop
  - [By increasing the block replication factor of HDFS to 3->5, how many failures can it withstand?](interview/hadoop/hdfs_replication_and_fault_tolerance.md)
  - [Why YARN is introduced?](interview/hadoop/why_use_yarn.md)
  - [HA consensus of HDFS](interview/hadoop/hdfs_ha_and_consensus.md)
  - [The process of detecting and handling damaged blocks](interview/hadoop/hdfs_block_scanner.md)
  - [Parquet and column-based strage](interview/hadoop/parquet_and_column_based_storage.md)
  - [Standby Namenode vs Secondary Namenode](interview/hadoop/standbynn_secondarynn.md)
  - Hadoop ecosystem 구성요소별 partition의 의미
    - What is "partition" in Hadoop ecosystem?
  - What is MapReduce spilling?
  - vm.swappiness와 하둡 데몬의 실행 시간 초과 문제
    - vm.swappiness and Hadoop daemon run timeout issue
- Apache Spark
  - [RDD, DataFrame, Dataset](interview/hadoop/rdd_df_ds.md)
  - [SparkContext and SparkSession](interview/hadoop/sparkcontext_sparksession.md)
  - Difference between "map" and "flatMap" in Scala
  - Difference between "map" and "mapPartitions" in Scala
  - Difference between "ML" package and "MLlib" package in Spark
  - Which of the RDD functions is faster, "groupByKey" or "reduceByKey"?
- Apache HBase
  - [Major Compaction and Minor Compaction](interview/hadoop/hbase_compaction.md)
  - Region Server architecture
  - Time series Row key design: Salting, Empty region
  - Region's locality
- Apache Hive
  - [Partition, Bucket, Index](interview/hadoop/hive_partition_bucket_index.md)
  - Why isn't the metastore in hdfs?
  - Which is faster, SORT BY or ORDER BY in HiveQL?
  - What is HCatalog?
- Apache Kafka
  - [Is it better to have more partitions in Kafka?](interview/hadoop/kafka_too_many_partitions.md)
  - zookeeper's role in Kafka
  - ISR (In Sync Replica)
  - At least once delivery, Exactly once delivery
  - Lambda architecture with Kafka
- Top Bigdata Questions
  - [Top 50 Hadoop Interview Questions You Must Prepare In 2020](interview/top_bigdata_questions/top_50_hadoop_interview_questions_in_2020.md)
  - [Top Hadoop Interview Questions To Prepare In 2020 – HDFS](interview/top_bigdata_questions/top_hadoop_interview_questions_in_2020_hdfs.md)
  - [Top 20 Apache Spark Interview Questions 2019](interview/top_bigdata_questions/top_20_apache_spark_interview_questions_2019.md)
  - [Top 62 Data Engineer Interview Questions & Answers](interview/top_bigdata_questions/top_62_data_engineer_interview_questions.md)
  - [Hadoop MapReduce Interview Questions In 2020](interview/top_bigdata_questions/hadoop_mapreduce_interview_questions_in_2020.md)
  - Hadoop Interview Questions For 2020 – Setting Up Hadoop Cluster
  - Hadoop Interview Questions On HBase In 2020
  - [Top Hadoop Interview Questions To Prepare In 2020 – Apache Hive](interview/top_bigdata_questions/top_hadoop_interview_questions-hive.md)
- 과제: On-premise 하둡 아키텍처 설계하기 (Challenge: designing an on-premise Hadoop architecture)


### 1-2. Computer Science
- Operation System
  - [데드락의 발생조건](interview/computer_science/deadlock.md)
  - [다익스트라의 은행원 알고리즘](interview/computer_science/banker_algorithm.md)
  - (작성중)[세마포어와 뮤텍스](interview/computer_science/semaphore_and_mutex.md)
  - Critical Section과 Deadlock
  - [CPU 스케줄링 알고리즘](interview/computer_science/cpu_scheduling.md)
  - [페이지 교체 알고리즘](interview/computer_science/page_replacement_algorithm.md)
  - [페이징과 세그먼테이션, 그리도 단편화](interview/computer_science/paging_segmentation.md)
  - [Big-endian, Little-endian](interview/computer_science/big_endian_little_endian.md)
  - [캐시 메모리와 버퍼 메모리](interview/computer_science/difference_between_cache_and_buffer.md)
  - 페이지 방식과 버퍼 방식의 차이
  - [Polling과 Interrupt](interview/computer_science/polling_and_interrupt.md)  
  - 멀티스레드와 멀티프로세스
  - [Sync와 Async, Blocking과 Non-blocking](interview/computer_science/sync_async_block_nonblock.md)
  - [Context Switching이 진행되는 단계](interview/computer_science/context_switching.md)
- Database
  - (작성중)[데이터베이스 인덱스](interview/database/database_index.md)
  - [파티셔닝과 샤딩의 차이](interview/database/partitioning_vs_sharding.md)
  - [CRUD와 ACID](interview/database/crud_acid.md)
  - [DDL / DML / DCL / TCL](interview/database/ddl_dml_dcl_tcl.md)
  - [DELETE / TRUNCATE / DROP](interview/database/delete_truncate_drop.md)
  - [Top 50 SQL Interview Questions](interview/database/top_50_sql_interview_questions.md)
- Programming Language
  - (작성중)[(Java) 인터페이스와 추상클래스의 차이, 그리고 다형성](interview/computer_science/interface_vs_abstract_class.md)
  - (작성중)[(Java) JVM](interview/computer_science/jvm.md)
  - (Java) Primitive type, Reference type, Wrapper class
  - (Java) thread-safe와 synchronized
  - Singleton pattern을 사용하는 이유와 단점
  - [(Java) Cause of Java memory leak](interview/computer_science/understanding_memory_leaks_in_java.md)  
  - Benefit of Java
  - Serialization and Deserialization
  - (Python) GIL
- Network
  - TCP and UDP
- Etc
  - idempotence(멱등성)
  - [Lambda architecture](https://ko.wikipedia.org/wiki/%EB%9E%8C%EB%8B%A4_%EC%95%84%ED%82%A4%ED%85%8D%EC%B2%98)
  
  
### 1-3. Algorithm and Data Structure
- Array vs Linked List
- Stack and Queue
- Tree
  - (작성중)[Binary Search Tree](interview/algorithm/binary_search_tree.md)
  - Heap Tree
- [Hash Table](interview/computer_science/hash_table.md)
- Graph
- (작성중)[Sorting](interview/algorithm/sorting_algorithm.ipynb)
- Recursion
- Dynamic Programming


<br>

## 2. Bigdata Components
하둡, 엘라스틱 등 빅데이터 인프라 관련 컴포넌트 학습 정리
<br>
About big data components such as Hadoop and Elastic

### 2-1. Set up with Cloudera
- [Set up Virtual Box](bigdata_components/cloudera/setup_virtual_box.md)
- [Install Cloudera Manager](bigdata_components/cloudera/install_cloudera_manager.md)

### 2-2. Hadoop Ecosystem
- [Spark](bigdata_components/hadoop_ecosystem/spark)
- Hadoop
- HBase
- Kafka
- Hive

### 2-3. Elastic Stack
- [Elasticsearch](bigdata_components/elk_stack/elasticsearch)
- [Logstash](bigdata_components/elk_stack/logstash)
- Kibana

<br>

## 3. Fields of Study
머신러닝, 데이터분석 등 관심있는 연구 분야와 수행 프로젝트 정리
<br>
Research fields and projects of interest such as machine learning and data analysis

- [Anomaly Detection](fields_of_study/anomaly_detection)
- Churn Prediction
- NLP
- Recommender System
- ideas
  - PySpark 클러스터 환경에서 각 노드별 python package 일괄 관리 툴
  - Apache Nutch의 streaming 버전, Spark 기반의 웹 크롤러

<br>



## Reference
- https://www.edureka.co/blog/interview-questions/hadoop-interview-questions-hdfs-2/
- https://acadgild.com/blog/top-20-apache-spark-interview-questions-2019
- https://github.com/JaeYeopHan/Interview_Question_for_Beginner
- https://wikidocs.net/23683
