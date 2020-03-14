# HDFS HA and Consensus

- 핵심키워드: ```Active-Standby NameNode```, ```JournalNode```, ```QuorumJournalManager```, ```ZKFC```, ```Failover```

(작성 예정)

Zookeeper를 이용한 분산시스템 consensus 구현

분산시스템의 consensus


## 1. HA(High Availability) 기본

### 1.1. HA를 보장하는 구조

HA의 개념
3가지 조건

### 1.2. Active-Standby 구조와 Failover 처리

### 1.3. Zookeeper
zookeeper가 데이터 합의를 이루는 과정. 컨센서스



## 2. HDFS HA

### 2.1. DataNode HA


### 2.2. NameNode HA



## Reference
- https://hadoopabcd.wordpress.com/2015/02/19/hdfs-cluster-high-availability/
- 도서 "빅데이터 시대의 하둡 완벽 입문", 제이펍, 오오타 카스기 외 다수

그외 읽을거리
- (HDFS Paper) https://storageconference.us/2010/Papers/MSST/Shvachko.pdf
- https://henning.kropponline.de/2016/12/04/sunday-read-distributed-consensus/
- https://www.slideshare.net/iFunFactory/apache-zookeeper-55966566
