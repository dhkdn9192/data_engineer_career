# HDFS HA and Consensus

- 핵심키워드: ```Active NameNode```, ```Standby NameNode```, ```JournalNode```, ```QuorumJournalManager```, ```ZKFC```, ```Failover```


## 1. HA(High Availability) 기본

### 1.1. HA를 보장하는 구조

#### 가용성 (Availability)
Hadoop과 같이 다수의 노드로 클러스터를 형성하는 시스템은 서버 수가 많아질 수록 장애 가능성이 높아진다.
장애 상황으로 인해 일부 노드가 정상적으로 동작하지 않더라도 전체적인 처리는 계속될 수 있어야 하는데 이러한 성질을 <b>가용성</b>(Availability)라 한다.

#### 단일 장애 지점 (Single point of failure)
HDFS와 MapReduce의 슬레이브 노드는 다수 존재하여 데이터 블록의 이중화하거나 실패한 task를 재실행하는 것으로 가용성을 보장할 수 있다.
그러나 HDFS의 NameNode와 같은 마스터 노드는 클러스터에 한 대만 존재하여 <b>단일 장애 지점</b>(Single Point of Failure)이 생기게 된다.
따라서 마스터 노드를 어떻게 이중화하는지가 중요하다.

#### HA를 위해 필요한 기능들
HDFS의 NameNode는 파일 시스템 메타데이터를, MapReduce의 JobTracker는 잡 할당과 실행 상태를 각각 보유하고 있다.
그래서 마스터 노드의 가용성을 향상시키려면 다음과 같은 기능이 필요하다.
- 마스터 노드가 가진 정보를 <b>일관성있게 이중화</b>하여 저장하는 기능
- 가동 중인 마스터 노드가 고장나면 스탠바이 노드가 그것을 인식해서 <b>마스터 노드로서 처리를 인계</b>하는 기능
- <b>마스터 노드가 서비스 가능한지를 감시</b>하여 문제가 생기면 머스터 노드를 변경하는 기능

Hadoop 1.x(CDH 3)까지는 Hadoop과 독립된 클러스터링 소프트웨어로 HA를 구성했으나,
Failover 시간이 길다는 문제가 있어서 Hadoop 2.x(CDH 4)부터는 내장 HA 기능이 추가되었다.



### 1.2. Active-Standby 구조와 Failover 처리

#### Active-Standby 구성
평상시 가동 중인 노드는 한 대뿐이며 이 노드에 문제가 생길 경우에 사용할 대기용 노드룰 둔다.

#### Failover 처리
ㅇㄴㄹㅇㄴㅎㅁㅎㄷ

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
