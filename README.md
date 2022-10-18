
<p align="center">
  <img src="img/banner.png" alt="banner" width="90%">
</p>

데이터 엔지니어가 알아야 할 모든 것들을 정리합니다.
자료 출처는 각 문서의 하단을 참조하시기 바랍니다.

본 레포 문서는 기술블로그(https://dhkdn9192.github.io) 에서도 보실 수 있습니다.


## Table of Contents
- [1. Data Engineering](#1-data-engineering)
  - [1-1. Hadoop Ecosystem](#1-1-hadoop-ecosystem)
  - [1-2. ELK Stack](#1-2-elk-stack)
  - [1-3. Kubernetes and Docker](#1-3-kubernetes-and-docker)
  - [1-4. AWS](#1-4-aws)
- [2. Computer Science](#2-computer-science)
  - [2-1. Operation System](#2-1-operation-system)
  - [2-2. Database](#2-2-database)
  - [2-3. Network](#2-3-network)
  - [2-4. Programming Language](#2-4-programming-language)
  - [2-5. Data Structure and Algorithm](#2-5-data-structure-and-algorithm)
  - [2-6. common sense](#2-6-common-sense)
- [3. GoF Design Pattern and Architecture Pattern](#3-gof-design-pattern-and-architecture-pattern)
- [4. Designing Data-Intensive Application](#4-designing-data-intensive-application)
- [5. Fields of Study](#5-fields-of-study)


<br>


## 1. Data Engineering
데이터 엔지니어가 알아야 할 기술 질문

### 1-1. Hadoop Ecosystem
- Apache Hadoop
  - [HDFS의 replication-factor를 3->5로 변경하면 최대 몇 번의 장애까지 견딜 수 있는가?](interview/hadoop/hdfs_replication_and_fault_tolerance.md)
  - JournalNode의 장애 허용 개수
  - Hadoop 3.x의 Erasure Coding
  - [YARN이 도입된 이유](interview/hadoop/why_use_yarn.md)
  - [HA consensus of HDFS](interview/hadoop/hdfs_ha_and_consensus.md)
  - [손상된 블록을 탐지하고 처리하는 프로세스](interview/hadoop/hdfs_block_scanner.md)
  - [Parquet와 칼럼 기반 스토리지](interview/hadoop/parquet_and_column_based_storage.md)
  - Parquet의 압축 알고리즘
  - [Standby Namenode vs Secondary Namenode](interview/hadoop/standbynn_secondarynn.md)
  - [YARN scheduler](interview/hadoop/yarn_scheduler.md)
  - [HDFS의 read/write/replication 절차](interview/hadoop/hdfs_read_write_replication.md)
  - RDBMS의 SQL과 Hadoop MapReduce의 차이점
  - MapReduce spilling
  - Hadoop 서버의 vm.swappiness 설정
  - 클라이언트에서 hdfs write를 위한 옵션을 설정하려면 어떤 xml 설정파일을 수정해야될까?
  - [클러스터로 구성된 서비스를 무중단으로 업데이트하려면?(Rolling Restart)](https://docs.cloudera.com/documentation/enterprise/5-16-x/topics/cm_mc_rolling_restart.html)
- [Apache Spark](bigdata_components/hadoop_ecosystem/spark)
  - [RDD, DataFrame, Dataset](interview/hadoop/rdd_df_ds.md)
  - [SparkContext and SparkSession](interview/hadoop/sparkcontext_sparksession.md)
  - [Spark Executor의 메모리 구조](interview/hadoop/spark_executor_memory_structure.md)
  - [PySpark에서 Scala UDF / Python UDF 성능 비교](interview/hadoop/pyspark_udf.md)
  - [언어별 Spark API 성능 차이](interview/hadoop/spark_scala_vs_python.md)
  - [RDD 커스텀 파티셔닝](interview/hadoop/rdd_custom_partitioning.md)
  - [RDD Aggregation: groupByKey vs reduceByKey](interview/hadoop/rdd_groupbykey_reducebykey.md)
  - [repartition과 coalesce의 차이점](interview/hadoop/difference_between_repartition_and_coalesce_in_spark.md)
  - [Spark access first n rows: take() vs limit()](interview/hadoop/spark_access_first_n_rows.md)
  - [효율적인 DataFrame Join 전략](interview/hadoop/spark_join_strategy.md)
  - Spark의 memoryOverhead 설정과 OutOfMemoryError
  - memoryOverhead만 높여주면 해결 가능한 exceeding memory limits 문제 (parquet )
  - spark.executor.memoryOverhead와 spark.memory.offHeap.size 설정은 어떻게 다른가?
  - Project Tungsten의 주요 Spark 성능 개선 사항은 무엇인가?
  - Java 직렬화 vs Kryo 직렬화
  - ORC, Parquet 등 Spark에서 사용할 수 있는 데이터 소스 포맷과 압축 알고리즘
  - k8s에서 Spark Job을 수행한다면 종료 후 로그는 어떻게 확인해야될까? (Spark History Server? AWS S3 logging?)
  - Spark Job에 과도하게 많은 Memory/CPU를 할당해주면 무슨 일이 일어날까?
  - Spark bucketing이란?
- Apache Flink
  - 배치처리와 스트림처리
- Apache Druid
  - Druid의 주요 특징
  - Druid의 아키텍처
- Apache HBase
  - [Major Compaction vs Minor Compaction](interview/hadoop/hbase_compaction.md)
  - Region Server architecture
  - Time series Row key design: Salting, Empty region
  - Region's locality
- Apache Hive
  - [Partition, Bucket, Index](interview/hadoop/hive_partition_bucket_index.md)
  - Why isn't the metastore in hdfs?
  - Which is faster, SORT BY or ORDER BY in HiveQL?
  - What is HCatalog?
  - Hive UDF란?
- Apache Impala
  - Impala with parquet에서 스키마 변경을 위한 PARQUET_FALLBACK_SCHEMA_RESOLUTION 옵션
- Apache Kafka
  - [Kafka의 partition은 많을 수록 좋을까?](interview/hadoop/kafka_too_many_partitions.md)
  - [Kafka Streams Topology](interview/hadoop/kafka_streams_topology.md)
  - [Kafka에서 Zookeeper의 역할](interview/hadoop/zookeeper_role_in_kafka.md)
  - [Kafka + Spark Streaming : 2가지 Integration 방법 비교](interview/hadoop/kafka_sparkstreaming_integration.md)
  - [Kafka + Spark Streaming : 파티션 수와 컨슈머 수 정하기](interview/hadoop/kafka_partitions_and_consumers.md)
  - [Kafka의 exactly-once delivery](interview/hadoop/kafka_exactly_once.md)
  - [Burrow와 Telegraf로 Kafka Lag 모니터링하기](https://blog.voidmainvoid.net/279)
  - ISR (In Sync Replica)
  - Kafka의 Controller Broker(KafkaController)란 무엇인가?
  - [dead letter queue](https://devidea.tistory.com/111)
- Apache Oozie
  - Oozie를 사용하면서 불편했던 점들
- Apache Airflow
  - Executor Types: Local vs Remote ([link](https://airflow.apache.org/docs/apache-airflow/stable/executor/index.html))
  - Celery 개념과 Celery Excutor
- CDH setup
  - [~~Set up Virtual Box~~](bigdata_components/cloudera/setup_virtual_box.md)
  - [~~Install Cloudera Manager~~](bigdata_components/cloudera/install_cloudera_manager.md)
- Common Questions
  - [Top 50 Hadoop Interview Questions You Must Prepare In 2020](interview/top_bigdata_questions/top_50_hadoop_interview_questions_in_2020.md)
  - [Top Hadoop Interview Questions To Prepare In 2020 – HDFS](interview/top_bigdata_questions/top_hadoop_interview_questions_in_2020_hdfs.md)
  - [Top 20 Apache Spark Interview Questions 2019](interview/top_bigdata_questions/top_20_apache_spark_interview_questions_2019.md)
  - [Top 62 Data Engineer Interview Questions & Answers](interview/top_bigdata_questions/top_62_data_engineer_interview_questions.md)
  - [Hadoop MapReduce Interview Questions In 2020](interview/top_bigdata_questions/hadoop_mapreduce_interview_questions_in_2020.md)
  - [Top Hadoop Interview Questions To Prepare In 2020 – Apache Hive](interview/top_bigdata_questions/top_hadoop_interview_questions-hive.md)
  - [Lambda architecture](https://gyrfalcon.tistory.com/entry/%EB%9E%8C%EB%8B%A4-%EC%95%84%ED%82%A4%ED%85%8D%EC%B2%98-Lambda-Architecture)


### 1-2. ELK Stack
- [Elasticsearch](bigdata_components/elk_stack/elasticsearch)
  - [성능 튜닝하기 : Shard, Replica의 개수와 사이즈 등](https://www.slideshare.net/deview/2d1elasticsearch)
- [Logstash](bigdata_components/elk_stack/logstash)
- [es의 ingest pipeline을 이용한 전처리](https://danawalab.github.io/elastic/2020/09/04/ElasticSearch-IngestPipeLine.html)


### 1-3. Kubernetes and Docker
- Docker
  - [Container vs VM](interview/k8s_docker/container_vs_vm.md)
  - Difference between Docker and process
- Kubernetes Cluster
  - Pod
  - Replica Set
  - Deployment
  - Service
  - Namespace


### 1-4. AWS
- Amazon EC2
  - [VPC, Subnet, Network ACL, NAT Gateway](https://medium.com/harrythegreat/aws-%EA%B0%80%EC%9E%A5%EC%89%BD%EA%B2%8C-vpc-%EA%B0%9C%EB%85%90%EC%9E%A1%EA%B8%B0-71eef95a7098)
  - [AMI](https://docs.aws.amazon.com/ko_kr/AWSEC2/latest/UserGuide/AMIs.html)
  - [Load Balancer](https://medium.com/harrythegreat/aws-%EB%A1%9C%EB%93%9C%EB%B0%B8%EB%9F%B0%EC%8B%B1-%EC%95%8C%EC%95%84%EB%B3%B4%EA%B8%B0-9fd0955f859e)
- Amazon S3
  - [S3 vs EFS vs EBS](https://seohyun0120.tistory.com/entry/AWS-EBS-vs-EFS-vs-S3-%EC%B0%A8%EC%9D%B4%EC%A0%90-%EC%96%B4%EB%8A%90-%EC%8A%A4%ED%86%A0%EB%A6%AC%EC%A7%80%EB%A5%BC-%EC%8D%A8%EC%95%BC%ED%95%A0%EA%B9%8C)
  - [s3, s3n, s3a 차이점](https://swalloow.github.io/aws-emr-s3-spark/)
- Amazon Redshift
  - [Amazon Redshift가 지원하지 않는 것들](interview/aws/redshift_does_not_support.md)
- Amazon EMR
  - [Node Types: Master, Core, Task Nodes](https://docs.aws.amazon.com/ko_kr/emr/latest/ManagementGuide/emr-master-core-task-nodes.html)


<br>


## 2. Computer Science

### 2-1. Operation System
  - [멀티스레드와 멀티프로세스](interview/computer_science/multithread_multiprocess.md)
  - [교착상태(deadlock)의 발생조건](interview/computer_science/deadlock.md)
  - [다익스트라의 은행원 알고리즘](interview/computer_science/banker_algorithm.md)
  - [세마포어와 뮤텍스](interview/computer_science/semaphore_and_mutex.md)
  - [프로세스 스케줄러](interview/computer_science/process_scheduler.md)
  - [CPU 스케줄링 알고리즘](interview/computer_science/cpu_scheduling.md)
  - [페이지 교체 알고리즘](interview/computer_science/page_replacement_algorithm.md)
  - [페이징과 세그먼테이션, 그리도 단편화](interview/computer_science/paging_segmentation.md)
  - [Big-endian, Little-endian](interview/computer_science/big_endian_little_endian.md)
  - [캐시 메모리와 버퍼 메모리](interview/computer_science/difference_between_cache_and_buffer.md)
  - [페이지 캐시와 버퍼 캐시](interview/computer_science/page_cache_and_buffer_cache.md)
  - [Polling과 Interrupt](interview/computer_science/polling_and_interrupt.md)  
  - [Sync와 Async, Blocking과 Non-blocking](interview/computer_science/sync_async_block_nonblock.md)
  - [Context Switching이 진행되는 단계](interview/computer_science/context_switching.md)
  - 하이퍼스레딩과 코어 수

### 2-2. Database
  - [데이터 무결성 (Data Integrity)](interview/database/data_integrity.md)
  - [데이터베이스 인덱스](interview/database/database_index.md)
  - [데이터베이스 정규화](interview/database/normalization.md)
  - [파티셔닝과 샤딩의 차이](interview/database/partitioning_vs_sharding.md)
  - [트랜잭션과 ACID](interview/database/transaction_acid.md)
  - [DDL / DML / DCL / TCL](interview/database/ddl_dml_dcl_tcl.md)
  - [DELETE / TRUNCATE / DROP](interview/database/delete_truncate_drop.md)
  - [Top 50 SQL Interview Questions](interview/database/top_50_sql_interview_questions.md)
  - PostgreSQL vs MariaDB
  - MongoDB 고가용성 아키텍처

### 2-3. Network
  - [TCP and UDP](interview/computer_science/tcp_udp.md)
  - [TCP's 3-way handshake, 4-way handshake](interview/computer_science/tcp_handshake.md)
  - [HTTP 요청 메소드: GET과 POST의 차이](interview/computer_science/http_request_method.md)
  - [웹 브라우저가 웹 페이지의 이미지를 보여주기까지의 과정](https://goodgid.github.io/HTTP-Communicate-Process/)

### 2-4. Programming Language
  - Java
    - [인터페이스와 추상클래스의 차이, 그리고 다형성](interview/computer_science/interface_vs_abstract_class.md)
    - [JVM, JIT Compiler, GC](interview/computer_science/jvm.md)
    - [GC 정리](interview/computer_science/gc.md)
    - [Java 메모리 누수](interview/computer_science/understanding_memory_leaks_in_java.md)
    - [On-heap과 Off-heap](interview/computer_science/java_onheap_offheap.md)
    - [String 대신 StringBuffer, StringBuilder를 쓰는 이유](interview/computer_science/java_string_stringbuffer_stringbuilder.md)
    - static 선언과 GC
    - Primitive type, Reference type, Wrapper class
  - Scala
    - [Scala의 함수형 프로그래밍 성질](interview/computer_science/scala_functional_programming.md)
    - [Scala의 pass-by-name](https://stackoverflow.com/questions/9508051/function-parameter-types-and)
    - 동반 객체 (Companion Object)
    - 케이스 클래스 (case class)
  - Python
    - [GIL(Global Interpreter Lock)](interview/computer_science/python_gil.md)

### 2-5. Data Structure and Algorithm
  - Array vs Linked List
  - Stack and Queue
    - Stack으로 Queue 구현하기
  - [Tree](interview/algorithm/tree.md)
    - [Binary Search Tree (BST)](interview/algorithm/binary_search_tree.md)
    - AVL Tree
    - Heap
  - [Hash Table](interview/computer_science/hash_table.md)
  - Graph
    - [Dijkstra algorithm](interview/algorithm/dijkstra_shortest_path.md)
  - [Sorting](interview/algorithm/sorting_algorithm.md)
  - Recursion
  - Dynamic Programming

### 2-6. common sense
  - [MVC Pattern](interview/computer_science/mvc_pattern.md)
  - 객체지향의 DTO, DAO, VO 개념 용어
  - Idempotence(멱등성)
  - 테스트 도구와 절차
  - 트래픽/트랜잭션량 측정
  - Singleton 패턴을 사용하는 이유

<br>

## 3. GoF Design Pattern and Architecture Pattern
GoF란 1995년에 출간된 "Design Patterns of Reusable Object-Oriented Software"라는 책의 저자들(Erich Gamma, Richard Helm, Ralph Johnson, John Vlissdes)를 의미한다.

<br>

## 4. Designing Data-Intensive Application
데이터 중심 애플리케이션 설계
  - OLTP와 OLAP

<br>


## 5. Fields of Study
머신러닝, 데이터분석 등 관심있는 연구 분야와 수행 프로젝트 정리

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
