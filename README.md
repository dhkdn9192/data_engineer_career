# 데이터 엔지니어가 알아야 할 모든 것


데이터 엔지니어 기술면접 질문과 기본적인 개념들을 정리했습니다.
자료 출처는 각 문서의 하단을 참조하시기 바랍니다.


## Table of Contents
- [1. Interview](#1-interview)
  - [1-1. Hadoop Ecosystem](#1-1-hadoop-ecosystem)
  - [1-2. Top Bigdata Questions](#1-2-top-bigdata-questions)
  - [1-3. Computer Science](#1-3-computer-science)
  - [1-4. Algorithm](#1-4-algorithm)
  - [1-5. Database](#1-5-database)
- [2. Bigdata Components](#2-bigdata-components)
  - [2-1. Cloudera Hadoop](#2-1-cloudera-hadoop)
  - [2-2. Hadoop Ecosystem](#2-2-hadoop-ecosystem)
  - [2-3. Elastic Stack](#2-3-elastic-stack)
- [3. Fields of Study](#3-fields-of-study)

---

<br>

## 1. Interview
데이터 엔지니어가 알아야 할 기술 면접 질문

### 1-1. Hadoop Ecosystem
- [HDFS의 block replication factor를 3->5로 늘리면 몇 번의 장애까지 견딜 수 있는가?](interview/hadoop/hdfs_replication_and_fault_tolerance.md)
- [YARN이 도입된 이유](interview/hadoop/why_use_yarn.md)
- [HDFS의 HA 구성 컨센서스](interview/hadoop/hdfs_ha_and_consensus.md)
- [손상된 블록의 탐지와 처리과정](interview/hadoop/hdfs_block_scanner.md)
- [Major Compaction과 Minor Compaction](interview/hadoop/hbase_compaction.md)
- [RDD, DataFrame, Dataset의 차이점](interview/hadoop/rdd_df_ds.md)
- [SparkContext와 SparkSession의 차이점](interview/hadoop/sparkcontext_sparksession.md)
- [Parquet와 칼럼 기반 스토리지](interview/hadoop/parquet_and_column_based_storage.md)
- [Standby Namenode vs Secondary Namenode](interview/hadoop/standbynn_secondarynn.md)
- [Hive의 Partition, Bucket, Index의 차이점](interview/hadoop/hive_partition_bucket_index.md)
- MapReduce의 spilling이란?
- Hadoop ecosystem 구성요소별 partition의 의미
- [Kafka의 partition 수는 많을 수록 좋을까?](interview/hadoop/kafka_too_many_partitions.md)
- Scala의 map과 flatMap의 차이점
- Spark의 map과 mapPartitions의 차이점
- Spark의 ML 패키지와 MLlib 패키지의 차이점
- 과제: On-premise 하둡 아키텍처 설계하기

### 1-2. Top Bigdata Questions
- [Top 50 Hadoop Interview Questions You Must Prepare In 2020](interview/top_bigdata_questions/top_50_hadoop_interview_questions_in_2020.md)
- [Top Hadoop Interview Questions To Prepare In 2020 – HDFS](interview/top_bigdata_questions/top_hadoop_interview_questions_in_2020_hdfs.md)
- [Top 20 Apache Spark Interview Questions 2019](interview/top_bigdata_questions/top_20_apache_spark_interview_questions_2019.md)
- [Top 62 Data Engineer Interview Questions & Answers](interview/top_bigdata_questions/top_62_data_engineer_interview_questions.md)
- [Hadoop MapReduce Interview Questions In 2020](interview/top_bigdata_questions/hadoop_mapreduce_interview_questions_in_2020.md)
- Hadoop Interview Questions For 2020 – Setting Up Hadoop Cluster
- Hadoop Interview Questions On HBase In 2020
- [Top Hadoop Interview Questions To Prepare In 2020 – Apache Hive](interview/top_bigdata_questions/top_hadoop_interview_questions-hive.md)

### 1-3. Computer Science
- [파티셔닝과 샤딩의 차이](interview/computer_science/partitioning_vs_sharding.md)
- [해싱의 개념과 해싱 테이블](interview/computer_science/hash_table.md)
- 직렬화와 역직렬화
- 멀티스레드와 멀티프로세스
- Critical Section과 Deadlock
- 페이지 방식과 버퍼 방식의 차이
- [캐시 메모리와 버퍼 메모리](interview/computer_science/difference_between_cache_and_buffer.md)
- [자바 메모리 누수 현상의 원인](interview/computer_science/understanding_memory_leaks_in_java.md)
- [페이징과 세그먼테이션](interview/computer_science/paging_segmentation.md)
- 자바의 장점
- [Polling과 Interrupt](interview/computer_science/polling_and_interrupt.md)
- [데이터베이스 인덱스](interview/computer_science/database_index.md)
- 파이썬의 GIL
- TCP와 UDP
- [Big-endian, Little-endian](interview/computer_science/big_endian_little_endian.md)
- LRU 방식의 문제점
- Java의 Primitive type, Reference type, Wrapper class
- CPU 스케줄링 알고리즘
- 데드락의 조건과 세마포어, 뮤텍스
- (작성중)[Java 인터페이스와 추상클래스의 차이, 그리고 다형성](interview/computer_science/interface_vs_abstract_class.md)
- (작성중)[JVM](interview/computer_science/jvm.md)
- [Sync와 Async, Blocking과 Non-blocking](interview/computer_science/sync_async_block_nonblock.md)

### 1-4. Algorithm
- Array vs Linked List
- Stack and Queue
- Tree
  - Binary Tree
  - [Binary Search Tree](interview/algorithm/binary_search_tree.ipynb)
- Heap
- Hash Table
  - Hash Function
  - Resolve Collision
    - Open Addressing
    - Separate Chaining
  - Resize
- Graph
- [Sorting](interview/algorithm/sorting_algorithm.ipynb)
  - Bubble Sort
  - Selection Sort
  - Insertion Sort
  - Merge Sort
  - Heap Sort
  - Quick Sort
- Recursion
- Dynamic Programming and Memoization


### 1-5. Database
- [Top 50 SQL Interview Questions](interview/database/top_50_sql_interview_questions.md)
- (작성중)[Top 50+ Database Interview Questions](interview/database/top_50_database_interview_questions.md)

<br>

## 2. Bigdata Components
하둡, 엘라스틱 등 빅데이터 인프라 관련 컴포넌트 학습 정리

### 2-1. Cloudera Hadoop
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

- [Anomaly Detection](fields_of_study/anomaly_detection)
- Churn Prediction
- NLP
- Recommender System

<br>

---

### Reference
- https://www.edureka.co/blog/interview-questions/hadoop-interview-questions-hdfs-2/
- https://acadgild.com/blog/top-20-apache-spark-interview-questions-2019
- https://github.com/JaeYeopHan/Interview_Question_for_Beginner
- https://wikidocs.net/23683
