# HDFS의 Read/Write/Replication



<br>



## Read Operation

![hdfs_read_process](https://github.com/dhkdn9192/data_engineer_should_know/blob/master/interview/hadoop/img/hdfs_read_process.PNG)

1. 클라이언트가 **DistributeFileSystem**의 인스턴스인 **FileSystem** 객체의 open() 메소드를 호출하여 원하는 파일을 연다.
2. **DistributeFileSystem**는 파일의 첫 번째 블록 위치를 파악하기 위해 RPC를 사용하여 NameNode를 호출한다. NameNode는 블록의 복제본을 가진 DataNode들의 주소 리스트를 반환한다.
3. 클라이언트는 DataNode 주소 리스트를 가진 **DFSInputStream**의 read() 메소드를 호출하여 첫 번째 블록을 가진 가장 가까운 DataNode와 연결한다.
4. 스트림에 read() 메소드를 반복적으로 호출하며 데이터 블록을 클라이언트로 가져온다.
5. 블록을 받으면 **DFSInputStream**은 DataNode와의 연결을 종료하고, 다음 블록을 가진 가까운 DataNode와 연결한다.
6. 읽기가 모두 끝나면 close() 메소드를 호출한다.



<br>



## Write Operation

![hdfs_write_process](https://github.com/dhkdn9192/data_engineer_should_know/blob/master/interview/hadoop/img/hdfs_write_process.PNG)

1. 클라이언트는 **DistributedFileSystem**의 create() 메소드를 호출하여 파일을 생성한다.
2. **DistributedFileSystem**은 RPC를 사용하여 NameNode를 호출하여 파일시스템의 네임스페이스에 새로운 파일을 생성하도록 한다. 이떄 블록에 대한 정보는 보내지 않는다.
3. 클라이언트가 데이터를 작성하면 **DFSOutputStream**은 이를 패킷으로 나누어 **data queue**라 불리는 내부 큐에 입력한다. 이 큐는 **DataStreamer**에 의해 처리된다. 먼저 NameNode에 복제본을 저장할 DataNode 리스트를 요청한다. 리스트의 DataNode들은 파이프라인을 형성하며 **DataStreamer**는 첫 번째 DataNode로 패킷을 전송한다. (replication-factor가 3일 경우) 첫 번째 DataNode는 패킷을 저장하고 파이프라인의 두 번째 DataNode로 패킷을 전달한다.
4. 두 번째 DataNode는 패킷을 저장하고 파이프라인의 세 번째 DataNode로 패킷을 전달한다.
5. **DFSOutputStream**은 파이프라인의 모든 노드에서 ack를 받으면 **ack queue**에서 write 완료된 패킷을 제거한다.
6. 데이터 쓰기를 완료할 때 클라이언트는 스트림에 close() 메소드를 호출한다.
7. 이 메소드는 파이프라인에 남아있는 모든 패킷을 flush하고 승인을 기다린다. 모든 패킷이 전송 완료되면 NameNode에 "file is complete" 신호를 보낸다.



<br>



## Replication

![hdfs_replication_process](https://github.com/dhkdn9192/data_engineer_should_know/blob/master/interview/hadoop/img/hdfs_replication_process.PNG)

하둡의 복제폰 배치 전략

- 첫 번째 복제본은 클라이언트가 DataNode 중 하나라면 해당 노드에 저장한다. 클라이언트가 DataNode가 아니라면 무작위로 노드를 선택해 저장한다.
- 두 번째 복제본은 첫 번째 노드와 다른 Rack에 있는 무작위 노드에 저장한다.
- 세 번째 복제본은 두 번째 노드와 같은 Rack의 서로 다른 노드에 저장한다.



<br>



## Reference

- http://www.bigdataplanet.info/2013/10/Hadoop-Tutorial-Part-3-Replication-and-Read-Operations-in-HDFS.html
- http://www.bigdataplanet.info/2013/10/Hadoop-Tutorial-Part-4-Write-Operations-in-HDFS.html
