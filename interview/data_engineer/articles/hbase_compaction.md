# HBase Minor Compaction and Major Compaction

## Minor Compaction
Minor compaction is the process of combining the configurable number of smaller HFiles into one Large HFile. 
Minor compaction is very important because without it, reading particular rows requires many disk reads 
and can reduce overall performance.

HBase는 자동적으로 어떤 작은양의(주로 최근에 생성된) HFile을 집어와서, 약간 더 큰 HFile안에 다시 쓴다. 
이 과정을 Minor Compaction이라고 한다.
Minor Compaction은 Storage File 숫자를 줄이고 작은 HFile을 좀 더 큰 HFile로 쓴다.


## Major Compaction
Major compaction is a process of combining the StoreFiles of regions into a single StoreFile. 
It also deletes remove and expired versions. 
By default, major compaction runs every 24 hours and merges all StoreFiles into single StoreFile. 
After compaction, if the new larger StoreFile is greater than a certain size (defined by property), 
the region will split into new regions.

Major Compaction은 한 Region안에 있는 모든 Hfile을 하나의 Column Family마다의 HFile로 머지하고 다시 쓰는 작업이다. 
그리고 이 과정에서, 셀을 drop, 삭제하거나 expire한다.

이 작업이 이뤄지면, 읽기 성능을 향상시킨다. 
그러나 Major Compaction이 모든 파일을 새로 쓰기 때문에 Disk I/O와 Network Traffic이 많이 발생한다. 
이 작업을 write amplification이라고 한다.

Major Compaction은 자동적으로 실행되도록 스케줄되어 있다. 
write amplification 때문에 Major Compaction은 보통 주말 또는 오후에 일어난다. 
(Note that MapR-DB has made improvements and does not need to do compactions)


## StoreFile and HFile
synonyms. HBase는 데이터가 입력(PUT)되면 memStore 메모리에 쌓다가 일정량이 되면 flush하여 HFile(storeFile)로 저장한다.
(그 전에 WAL 로그 파일 작성하여 복구 대비)
이렇게 쌓이는 HFile들은 compaction으로 줄여줘야 IO및 트래픽이 줄어든다.


## Reference
- https://dzone.com/articles/hbase-compaction-and-data-locality-with-hadoop
- https://joswlv.github.io/2018/07/07/HBase_basics/
