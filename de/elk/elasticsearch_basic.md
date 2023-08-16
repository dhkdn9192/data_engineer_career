# Elasticsearch

## 1. What is Elasticsearch?

### 1.1 Basic Concept

- 시간에 따라 증가하는 문제를 해결하는 분산형 RESTful 검색 및 분석 엔진
- Elastic Stack의 핵심 구성요소
- 데이터를 중앙에 저장하여 예상 가능한 항목 탐색 및 예상치 못한 항목 분석 등에 사용한다
- Apache Lucene(Java) 기반

### 1.2 Properties

- Distibuted, Scalable
- High-availability
- Multi-tenancy (사용자별 개인화 서비스)
- Developer Friendly
- Real-time, Full-text Search
- Aggregation

## 2. Architecture

### 2.1 Elasticsearch 클러스터링 과정

#### 2.1.1 Shard and Node

대용량 검색을 위해선 클러스터링이 필요하다. ES는 데이터를 샤드라는 단위로 분리하여 저장한다
- Shard: 루씬 검색 쓰레드. ES의 데이터 저장 단위
- Node: ES가 실행되는 하나의 프로세스를 노드라 부른다

![es_img01_shard](https://github.com/dhkdn9192/data_engineer_career/blob/master/de/elk/img/es_img01_shard.png)



#### 2.1.2 Clustering

ES는 여러개의 노드를 실행시키면 같은 클러스터로 묶는다. 그리고 샤드들은 각각의 노드들에 분배되어 저장된다.
    
![es_img02_clustering](https://github.com/dhkdn9192/data_engineer_career/blob/master/de/elk/img/es_img02_clustering.png)

    
#### 2.1.3 Replication

무결성과 가용성을 위해 샤드의 복제본을 만든다. Primary Shard와 Replica는 같은 내용을 갖되 서로 다른 노드에 저장된다.

![es_img03_replication](https://github.com/dhkdn9192/data_engineer_career/blob/master/de/elk/img/es_img03_replication.png)

    
#### 2.1.4 Fault Tolerance

아래처럼 시스템 다운이나 네트워크 단절 등으로 노드가 유실될 경우, 

![es_img04_fault_tolerance1](https://github.com/dhkdn9192/data_engineer_career/blob/master/de/elk/img/es_img04_fault_tolerance1.png)


복제본이 없는 샤드들은 다른 살아있는 노드로 복제를 수행한다.

![es_img05_fault_tolerance2](https://github.com/dhkdn9192/data_engineer_career/blob/master/de/elk/img/es_img05_fault_tolerance2.png)


따라서 ES는 노드의 수가 줄어들어도 <b>샤드의 수는 변함이 없으며 무결성을 유지</b>한다.


### 2.2 Elasticsearch 검색 과정

### 2.2.1 Query Phase

처음 쿼리 수행 명령을 받은 노드는 모든 샤드에 쿼리를 전달한다. 1차적으로 모든 샤드 및 복제본에서 검색을 수행한다.

![es_img06_query_phase](https://github.com/dhkdn9192/data_engineer_career/blob/master/de/elk/img/es_img06_query_phase.png)


각 샤드들은 요청된 크기만큼의 검색 결과 큐를 노드로 리턴한다. 리턴값은 전체 결과가 아니라 
루씬 doc id와 랭킹 점수(얼마나 정답에 가까운가)만 포함한다. 

![es_img07_query_return](https://github.com/dhkdn9192/data_engineer_career/blob/master/de/elk/img/es_img07_query_return.png)


### 2.2.2 Fetch Phase

노드는 리턴된 결과들을 랭킹점수로 정렬한다. 그리고 유효한 샤드들에 최종 결과를 다시 요청한다.

![es_img08_ask_final](https://github.com/dhkdn9192/data_engineer_career/blob/master/de/elk/img/es_img08_ask_final.png)


각 샤드는 전체 문서 내용(_source) 등의 정보를 리턴하며 최종적으로 클라이언트에 전달된다.

![es_img09_return_to_client](https://github.com/dhkdn9192/data_engineer_career/blob/master/de/elk/img/es_img09_return_to_client.png)


따라서 데이터의 입력과 검색은 서로 다른 노드에서 이뤄지더라도 항상 샤드 레벨로 분배되므로 전혀 문제 없다.



## 3. vs RDBMS

RDBMS | Elasticsearch
----- | -----
Database | Index
Table | Type
Row | Document
Column | Field
Schema | Mapping

