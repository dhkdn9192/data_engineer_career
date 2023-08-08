# HDFS Block Replication and Fault Tolerance

HDFS에서 block replication 개수를 3에서 5로 변경했을때, 몇 번의 장애까지 견딜 수 있을까?


## 1. Replication Mechanism
Hadoop 3.x 이전까지 HDFS는 replica들을 생성하는 것으로 fault tolerance를 보장해왔다.
데이터 블록의 복제본을 만들어 여러 데이터노드에 저장하는 것이다.
복제본의 개수는 replication factor(기본값은 3)로 정한다.


## 2. Rack Awareness
네임노드는 복제본들을 저장할 때 rack awareness까지 고려한 정책을 따른다.

- If replication factor = 3:
  - 첫 번째 복제본은 어느 머신에 저장되어 있다
  - 두 번째 복제본은 그 머신과 다른 (remote) rack에 있는 머신에 저장한다.
  - 세 번째 복제본은 두 번째와 같은 rack의 다른 머신에 저장한다.

- If replication factor > 3:
  - 네 번째 복제본부터는 저장되는 머신을 랜던하게 지정한다.
  - 단 rack 별로 저장되는 복제본의 수는 limit을 초과해선 안 된다.
  - 기본적인 limit 값 : `(replicas - 1) / racks + 2`


## 3. Erasure Coding
Hadoop 3.x부터는 fault tolerance를 위한 메소드로 replication 대비 저장 공간을 크게 절약할 수 있는 Erasure coding을 제공한다.
(HDFS 뿐만 아니라 RAID에서도 Erasure coding을 지원한다.)

Erasure coding은 다음 과정으로 이뤄진다. (Reed-solomon 알고리즘을 사용하는 예)
- 원본 데이터를 n개의 데이터셀로 분할
- 분할된 데이터를 인코딩하여 k개의 패리티셀을 생성
- 데이터셀 또는 패리티셀이 손상될 경우 n+k개의 데이터셀, 패리티셀을 디코딩하여 유실된 셀을 복구

여기서 Erasure coding은 **최대 k개의 셀까지는 유실을 허용**한다.
즉, n개 이상의 셀만 남아있다면 복구가 가능하다.

Repliaction과 Erasure coding 비교 (replica factor는 3, 패리티셀 수 k가 데이터셀 n의 절반일 때)
|                       |N-replication  |(N, K)Reed-solomon|
|:---                   |:---:           |:---:              |
|Fault-tolerance가 보장되는 유실량 | <b>N-1</b>          | K                 |
|파일 1개의 디스크 사용량 | x3            | x1.5              |


## (Tip) 파일 혹은 디렉토리별 Replication 설정

HDFS의 특정 디렉토리나 파일을 지정하여 replication 수를 지정할 수 있다.


You can change the replication factor of a file using command:
```
hdfs dfs –setrep –w 3 /user/hdfs/file.txt 
```

You can also change the replication factor of a directory using command:
```
hdfs dfs -setrep -R 2 /user/hdfs/test
```

## Reference
- https://data-flair.training/blogs/learn-hadoop-hdfs-fault-tolerance/
- https://gerardnico.com/db/hadoop/hdfs/replication#replication_factor_31
- https://www.samsungsds.com/global/ko/support/insights/Hadoop3-coding.html
- https://stackoverflow.com/questions/30558217/to-change-replication-factor-of-a-directory-in-hadoop/30558916
