# HDFS Block Replication and Fault Tolerance

HDFS에서 block replication 개수를 3에서 5로 변경했을때, 몇 번의 장애까지 견딜 수 있을까?
<br>
By increasing the block replication factor of HDFS to 3->5, how many failures can it withstand?


## 1. Replication Mechanism
Before Hadoop 3, <b>fault tolerance</b> in Hadoop HDFS was achieved by creating <b>replicas</b>. 
HDFS creates a replica of the data block and stores them on multiple machines (DataNode).

The number of replicas created depends on the replication factor (by default 3).


## 2. Rack Awareness
The NameNode will take the policy into account for replica placement in addition to the rack awareness.

If replication factor = 3:
- one replica on the local machine
- another replica on a node in a different (remote) rack
- and the last on a different node in the same remote rack.

If replication factor > 3:
- The placement of the 4th and following replicas are determined randomly
- keeping the number of replicas per rack below the upper limit 
- basic upper limit: (replicas - 1) / racks + 2


## 3. Erasure Coding
In Hadoop 3, Erasure coding is a method used for fault tolerance 
that durably stores data with <b>significant space savings</b> compared to replication.

RAID (Redundant Array of Independent Disks) uses Erasure Coding. 
Erasure coding works by striping the file into small units and storing them on various disks.

For each strip of the original dataset, a certain number of <b>parity cells</b> are calculated and stored. 
If any of the machines fails, <b>the block can be recovered from the parity cell</b>. 
Erasure coding reduces the storage overhead to 50%.

- Repliaction과 Erasure coding 비교 (replica factor는 3, perity cell 수는 블록 수의 절반일 때)
  |                       |N-replication  |(N, M)Reed-solomon|
  |:---                   |:---:           |:---:              |
  |Fault-tolerance 보장    | <b>N-1</b>          | M                 |
  |1개 파일당 디스크 사용량 | x3            | x1.5              |


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
