
<p align="center">
  <img src="img/banner.png" alt="banner" width="90%">
</p>

데이터 엔지니어 직무와 관련된 지식, 기술질문 등을 정리합니다.


## Table of Contents
- [1. Data Engineering](#1-data-engineering)
  - [1-1. Hadoop](#1-1-hadoop)
  - [1-2. Spark](#1-2-spark)
  - [1-3. Kafka](#1-3-kafka)
  - [1-4. ELK Stack](#1-4-elk-stack)
  - [1-5. Airflow](#1-5-airflow)
  - [1-6. Hive](#1-6-hive)
  - [1-7. Trino](#1-7-trino)
  - [1-8. DataHub](#1-8-datahub)
  - [1-9. others](#1-9-others)
- [2. Cloud Computing](#2-cloud-computing)
  - [2-1. Docker and k8s](#2-1-docker-and-k8s)
  - [2-2. AWS](#2-2-aws)
- [3. Computer Science](#3-computer-science)
  - [3-1. Operation System](#3-1-operation-system)
  - [3-2. Database](#3-2-database)
  - [3-3. Network](#3-3-network)
  - [3-4. Data Structure and Algorithm](#3-4-data-structure-and-algorithm)
  - [3-5. Programming Language](#3-5-programming-language)
  - [3-6. common](#3-6-common)
- [4. Back-end](#4-back-end)
- [5. Fields of study](#5-fields-of-study)


<br>


## 1. Data Engineering

### 1-1. Hadoop
- [HDFS의 replication-factor를 3->5로 변경하면 최대 몇 번의 장애까지 견딜 수 있는가? + Erasure Coding](de/hadoop/hdfs_replication_and_fault_tolerance.md)
- [YARN이 도입된 이유](de/hadoop/why_use_yarn.md)
- [HA consensus of HDFS](de/hadoop/hdfs_ha_and_consensus.md)
- [손상된 블록을 탐지하고 처리하는 프로세스](de/hadoop/hdfs_block_scanner.md)
- [HDFS의 read/write/replication 절차](de/hadoop/hdfs_read_write_replication.md)
- [Parquet와 칼럼 기반 스토리지](de/hadoop/parquet_and_column_based_storage.md)
- [Standby Namenode vs Secondary Namenode](de/hadoop/standbynn_secondarynn.md)
- [YARN scheduler](de/hadoop/yarn_scheduler.md)
- [Secured Hadoop - Kerberos](de/hadoop/kerberos.md)
- 클러스터로 구성된 서비스를 무중단으로 업데이트하려면?(Rolling Restart) ([link](https://docs.cloudera.com/documentation/enterprise/5-16-x/topics/cm_mc_rolling_restart.html))
- WebHDFS와 HttpFS의 차이점 ([link](https://stackoverflow.com/questions/31580832/hdfs-put-vs-webhdfs))
- HDFS Federation - Namespace, Block storage, Block pools 개념의 도입 ([link](https://xlos.tistory.com/1555))
- [~~How to set up Cloudera Hadoop~~](de/hadoop/cloudera_hadoop/README.md)


### 1-2. Spark
- [Coursera 강좌 "Big Data Analysis with Scala and Spark"](de/spark/coursera_spark_lecture)
- [RDD, DataFrame, Dataset](de/spark/rdd_df_ds.md)
- [SparkContext and SparkSession](de/spark/sparkcontext_sparksession.md)
- [Spark Executor의 메모리 구조](de/spark/spark_executor_memory_structure.md)
- [언어에 따른 Spark 성능 차이(Spark API, UDF 등)](de/spark/spark_performance_with_language.md)
- [RDD 커스텀 파티셔닝](de/spark/rdd_custom_partitioning.md)
- [RDD Aggregation: groupByKey vs reduceByKey](de/spark/rdd_groupbykey_reducebykey.md)
- [repartition과 coalesce의 차이점](de/spark/difference_between_repartition_and_coalesce_in_spark.md)
- [Spark access first n rows: take() vs limit()](de/spark/spark_access_first_n_rows.md)
- [효율적인 DataFrame Join 전략](de/spark/spark_join_strategy.md)
- [Kafka + Spark Streaming : 2가지 Integration 방법 비교](de/spark/kafka_sparkstreaming_integration.md)
- spark.executor.memoryOverhead와 spark.memory.offHeap.size 설정은 어떻게 다른가?
- Project Tungsten의 주요 Spark 성능 개선 사항은 무엇인가?
- Spark bucketing이란?
 
### 1-3. Kafka
- [Kafka의 partition은 많을 수록 좋을까?](de/kafka/kafka_too_many_partitions.md)
- [Kafka Streams Topology](de/kafka/kafka_streams_topology.md)
- [Zookeeper가 Kafka에서 수행하는 역할](de/kafka/zookeeper_role_in_kafka.md)
- [효율적인 Kafka consume 방법 (파티션 수와 컨슈머 수의 관계)](de/kafka/kafka_partitions_and_consumers.md)
- [exactly-once delivery](de/kafka/kafka_exactly_once.md)
- Burrow와 Telegraf로 Kafka Lag 모니터링하기 ([link](https://blog.voidmainvoid.net/279))
- ISR (In Sync Replica)
- Kafka의 Controller Broker(KafkaController)란 무엇인가? ([link](https://devidea.tistory.com/71))
- dead letter queue ([link](https://devidea.tistory.com/111))
- [Kafka Connect overview](de/kafka/kafka_connect_overview.md)
- Schema Registry
- Debezium CDC

### 1-4. ELK Stack
- Elasticsearch
  - [기본 개념과 구조](de/elk/elasticsearch_basic.md)
  - [How to Set up](de/elk/es01_setup.md)
  - [REST API](de/elk/es02_rest_api.md)
  - ES 성능 튜닝하기 : Shard, Replica의 개수와 사이즈 등 ([link](https://www.slideshare.net/deview/2d1elasticsearch))
  - es의 ingest pipeline을 이용한 전처리 ([link](https://danawalab.github.io/elastic/2020/09/04/ElasticSearch-IngestPipeLine.html))
- Logstash
  - [기본 개념과 구조](de/elk/logstash_basic.md)

### 1-5. Airflow
- Executor Types: Local vs Remote ([link](https://airflow.apache.org/docs/apache-airflow/stable/executor/index.html))
- Celery 개념과 Celery Excutor
- schedule_interval과 execution_date 의 난해함 ([link](https://blog.bsk.im/2021/03/21/apache-airflow-aip-39/))
- catchup 설정과 주의사항 ([link](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html#catchup))
- Airflow dataset과 Data-aware scheduling ([link](https://airflow.apache.org/docs/apache-airflow/stable/authoring-and-scheduling/datasets.html))
- Airflow의 Trigger와 Sensor, ExternalTaskSensor 의 기능

### 1-6. Hive
- HiveServer2 ([link](https://cwiki.apache.org/confluence/display/Hive/HiveServer2+Overview))
- Hive Design and Architecture ([link](https://cwiki.apache.org/confluence/display/hive/design))
- Hive ACID ([link](https://cwiki.apache.org/confluence/display/hive/hive+transactions))
- Hive Replication ([link](https://cwiki.apache.org/confluence/display/Hive/Replication))
- Hive Query Planner and Optimizer ([link](https://cwiki.apache.org/confluence/display/Hive/Cost-based+optimization+in+Hive))
- [Partition, Bucket, Index](de/hive/hive_partition_bucket_index.md)
- Which is faster, SORT BY or ORDER BY in HiveQL?
- What is HCatalog?
- Hive UDF란?
- Hive의 View와 Table
- HiveQL Merge Into

### 1-7. Trino
- [Trino The Definitive Guide](de/trino/trino-definitive-guide)

### 1-8. DataHub
- 데이터 거버넌스란 무엇이고 왜 필요한가? ([link](https://datahubproject.io/docs/quickstart))

### 1-9. others
- Apache HBase
  - [Major Compaction vs Minor Compaction](de/hbase/hbase_compaction.md)
- Apache Flink
- Apache Druid
  - Query granularities와 쿼리 부하 사이의 관계 ([link](https://druid.apache.org/docs/latest/querying/granularities/))
  - HLL(HyperLogLog) Sketch와 유니크 원소 갯수 (cardinality) 추정 ([link1](https://d2.naver.com/helloworld/711301), [link2](https://druid.apache.org/docs/latest/development/extensions-core/datasketches-hll/))
- Apache SeaTunnel ([link](https://seatunnel.apache.org/))
  - Sqoop, Logstash, Fluentd, Kafka Connect를 모두 대체할 수 있을까?
- Apache Doris ([link](https://doris.apache.org/))
  - Apache Doris is a new-generation open-source real-time data warehouse based on MPP architecture, with easier use and higher performance for big data analytics.
- Apache StreamPark ([link](https://streampark.apache.org/))
  - Make stream processing easier! easy-to-use streaming application development framework and operation platform
- Apache Airbyte ([link](https://airbyte.com/))
  - The only tool you need to move data
- dbt ([link](https://www.getdbt.com/))
- 데이터 엔지니어 면접 질문 모음
  - [Top 50 Hadoop Interview Questions You Must Prepare In 2020](de/top_bigdata_questions/top_50_hadoop_interview_questions_in_2020.md)
  - [Top Hadoop Interview Questions To Prepare In 2020 – HDFS](de/top_bigdata_questions/top_hadoop_interview_questions_in_2020_hdfs.md)
  - [Top 20 Apache Spark Interview Questions 2019](de/top_bigdata_questions/top_20_apache_spark_interview_questions_2019.md)
  - [Top 62 Data Engineer Interview Questions & Answers](de/top_bigdata_questions/top_62_data_engineer_interview_questions.md)
  - [Hadoop MapReduce Interview Questions In 2020](de/top_bigdata_questions/hadoop_mapreduce_interview_questions_in_2020.md)
  - [Top Hadoop Interview Questions To Prepare In 2020 – Apache Hive](de/top_bigdata_questions/top_hadoop_interview_questions-hive.md)


<br>


## 2. Cloud Computing

### 2-1. Docker and k8s
- Docker
  - [Container vs VM](cloud/docker/container_vs_vm.md)
- Kubernetes ([link](https://subicura.com/2019/05/19/kubernetes-basic-1.html))
  - [기본개념과 용어](cloud/k8s/k8s_basic.md)
  - PV/PVC ([link](https://kimjingo.tistory.com/153))
  - HPA ([link](https://medium.com/dtevangelist/k8s-kubernetes%EC%9D%98-hpa%EB%A5%BC-%ED%99%9C%EC%9A%A9%ED%95%9C-%EC%98%A4%ED%86%A0%EC%8A%A4%EC%BC%80%EC%9D%BC%EB%A7%81-auto-scaling-2fc6aca61c26))

### 2-2. AWS
- Amazon EC2
  - VPC, Subnet, Network ACL, NAT Gateway ([link](https://medium.com/harrythegreat/aws-%EA%B0%80%EC%9E%A5%EC%89%BD%EA%B2%8C-vpc-%EA%B0%9C%EB%85%90%EC%9E%A1%EA%B8%B0-71eef95a7098))
  - AMI ([link](https://docs.aws.amazon.com/ko_kr/AWSEC2/latest/UserGuide/AMIs.html))
  - Load Balancer ([link](https://medium.com/harrythegreat/aws-%EB%A1%9C%EB%93%9C%EB%B0%B8%EB%9F%B0%EC%8B%B1-%EC%95%8C%EC%95%84%EB%B3%B4%EA%B8%B0-9fd0955f859e))
- Amazon S3
  - S3 vs EFS vs EBS ([link](https://seohyun0120.tistory.com/entry/AWS-EBS-vs-EFS-vs-S3-%EC%B0%A8%EC%9D%B4%EC%A0%90-%EC%96%B4%EB%8A%90-%EC%8A%A4%ED%86%A0%EB%A6%AC%EC%A7%80%EB%A5%BC-%EC%8D%A8%EC%95%BC%ED%95%A0%EA%B9%8C))
  - s3, s3n, s3a 차이점 ([link](https://swalloow.github.io/aws-emr-s3-spark/))
  - MinIO와 S3 호환 ([link1](https://city-man.tistory.com/36), [link2](https://shuu.tistory.com/145))
- Amazon Redshift
  - [Amazon Redshift가 지원하지 않는 것들](cloud/aws/redshift_does_not_support.md)
- Amazon EMR
  - Node Types: Master, Core, Task Nodes ([link](https://docs.aws.amazon.com/ko_kr/emr/latest/ManagementGuide/emr-master-core-task-nodes.html))



<br>


## 3. Computer Science

### 3-1. Operation System
- [멀티스레드와 멀티프로세스](cs/os/multithread_multiprocess.md)
- [교착상태(deadlock)의 발생조건](cs/os/deadlock.md)
- [다익스트라의 은행원 알고리즘](cs/os/banker_algorithm.md)
- [세마포어와 뮤텍스](cs/os/semaphore_and_mutex.md)
- [프로세스 스케줄러](cs/os/process_scheduler.md)
- [CPU 스케줄링 알고리즘](cs/os/cpu_scheduling.md)
- [페이지 교체 알고리즘](cs/os/page_replacement_algorithm.md)
- [페이징과 세그먼테이션, 그리도 단편화](cs/os/paging_segmentation.md)
- [Big-endian, Little-endian](cs/os/big_endian_little_endian.md)
- [캐시 메모리와 버퍼 메모리](cs/os/difference_between_cache_and_buffer.md)
- [페이지 캐시와 버퍼 캐시](cs/os/page_cache_and_buffer_cache.md)
- [Polling과 Interrupt](cs/os/polling_and_interrupt.md)  
- [Sync와 Async, Blocking과 Non-blocking](cs/os/sync_async_block_nonblock.md)
- [Context Switching이 진행되는 단계](cs/os/context_switching.md)

### 3-2. Database
- [데이터 무결성 (Data Integrity)](cs/db/data_integrity.md)
- [데이터베이스 인덱스](cs/db/database_index.md)
- [데이터베이스 정규화](cs/db/normalization.md)
- [파티셔닝과 샤딩의 차이](cs/db/partitioning_vs_sharding.md)
- [트랜잭션과 ACID](cs/db/transaction_acid.md)
- [DDL / DML / DCL / TCL](cs/db/ddl_dml_dcl_tcl.md)
- [DELETE / TRUNCATE / DROP](cs/db/delete_truncate_drop.md)
- [Top 50 SQL Interview Questions](cs/db/top_50_sql_interview_questions.md)

### 3-3. Network
- [TCP and UDP](cs/network/tcp_udp.md)
- [TCP's 3-way handshake, 4-way handshake](cs/network/tcp_handshake.md)
- [HTTP 요청 메소드: GET과 POST의 차이](cs/network/http_request_method.md)
- 웹 브라우저가 웹 페이지의 이미지를 보여주기까지의 과정 ([link](https://goodgid.github.io/HTTP-Communicate-Process/))

### 3-4. Data Structure and Algorithm
- Array vs Linked List
- Stack and Queue
  - Stack으로 Queue 구현하기
- [Tree](cs/ds_algorithm/tree.md)
  - [Binary Search Tree (BST)](cs/ds_algorithm/binary_search_tree.md), ([notebook](cs/ds_algorithm/binary_search_tree.ipynb))
  - AVL Tree
  - Heap
- [Hash Table](cs/ds_algorithm/hash_table.md)
- Graph
  - [Dijkstra algorithm](cs/ds_algorithm/dijkstra_shortest_path.md)
- [Sorting](cs/ds_algorithm/sorting_algorithm.md), ([notebook](cs/ds_algorithm/sorting_algorithm.ipynb))
- Recursion
- Dynamic Programming


### 3-5. Programming Language
- Java
  - [JVM, JIT Compiler, GC](cs/language/java/jvm.md)
  - [GC 정리](cs/language/java/gc.md)
  - ZGC란
  - [Java 메모리 누수](cs/language/java/understanding_memory_leaks_in_java.md)
  - [On-heap과 Off-heap](cs/language/java/java_onheap_offheap.md)
  - [String 대신 StringBuffer, StringBuilder를 쓰는 이유](cs/language/java/java_string_stringbuffer_stringbuilder.md)
  - [인터페이스 vs 추상클래스](cs/language/java/interface_vs_abstract_class.md)
  - 싱글톤 패턴
  - static 선언과 GC
  - Primitive type, Reference type, Wrapper class
- Scala
  - [Scala의 함수형 프로그래밍 성질](cs/language/scala/scala_functional_programming.md)
  - Scala의 pass-by-name ([link](https://stackoverflow.com/questions/9508051/function-parameter-types-and))
  - 동반 객체 (Companion Object)
  - 케이스 클래스 (case class)
- Python
  - [GIL(Global Interpreter Lock)](cs/language/python/python_gil.md)
- Kotlin
  - [Kotlin in acion 스터디](https://github.com/dhkdn9192/kotlin-in-action)


### 3-6. common
객체지향프로그래밍, 디자인패턴, 아키텍처패턴, 개발방법론, 소프트웨어공학 등
- OOP
  - 캡슐화
  - 상속
    - 메소드 오버라이딩
  - 다형성
    - 메소드 오버로딩
  - [객체지향 5원칙: SOLID](cs/common/oop_solid.md)
  - 객체-관계 매핑 (Object Relational Mapping, ORM) ([link](https://gmlwjd9405.github.io/2019/02/01/orm.html))
- Idempotence(멱등성)
- 테스트 도구와 절차
- 트래픽/트랜잭션량 측정
- Lambda architecture ([link](https://gyrfalcon.tistory.com/entry/%EB%9E%8C%EB%8B%A4-%EC%95%84%ED%82%A4%ED%85%8D%EC%B2%98-Lambda-Architecture))
- ETL과 ELT


<br>


## 4. Back-end
- [Java Spring 스터디](https://github.com/dhkdn9192/hello-spring/tree/main)
- DAO, DTO, VO, BO, Entity, Service


<br>


## 5. Fields of study

기타 읽을거리 및 관심있는 연구주제, 토이 프로젝트 등

- 읽을거리
  - [The future of the data engineer (part 1)](fields_of_study/articles/the-future-of-the-data-engineer-part-i.md)
  - 쿠팡 빅데이터 플랫폼의 진화, 그리고 향후 발전 방향 ([link](https://medium.com/coupang-engineering/big-data-platform-evolving-from-start-up-to-big-tech-company-26f9fcb9c13))
- 도서학습
  - [데이터 중심 애플리케이션 설계](fields_of_study/books/designing_data_intensive_applications)
  - [Trino The Definitive Guide](de/trino/trino-definitive-guide)
- 연구주제
  - [Anomaly Detection](fields_of_study/anomaly_detection)

<br>



## Reference
- https://www.edureka.co/blog/interview-questions/hadoop-interview-questions-hdfs-2/
- https://acadgild.com/blog/top-20-apache-spark-interview-questions-2019
- https://github.com/JaeYeopHan/Interview_Question_for_Beginner
- https://wikidocs.net/23683
