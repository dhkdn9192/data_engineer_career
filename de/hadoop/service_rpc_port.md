# NameNode Service RPC port


네임노드 `dfs.namenode.servicerpc-address` 설정으로 Service RPC port를 지정해줄 수 있다.
설정값에 대한 설명은 아래와 같다.

> RPC address for HDFS Services communication. BackupNode, Datanodes and all other services should be connecting to this address if it is configured

규모가 큰 하둡 클러스터에선 네임노드 RPC 큐가 가득차서 네임노드가 주요 컴포넌트와 원활하게 RPC 통신이 어려워지는 경우가 생길 수 있다.

예를 들어 네임노드 RPC 포트 busy 상태로 인해 ZKFC가 timeout 내에 응답을 받지 못 해 SERVICE_NOT_RESPONDING 상태로 간주하고 네임노드를 강제로 shutdown 및 failover 시키는 경우가 있을 수 있다.(해당 네임노드가 멀쩡한데도!)

이러한 사태를 방지하기 위해 네임노드가 ZKFC나 데이터노드들과 통신하기 위한 전용 RPC 통신 채널을 지정할 수 있다.

그 외에도 하둡에 적재된 데이터 증가에 따라 fsimage가 커지면서 image transfer timeout이 나는 경우 또한 의심해볼 수 있다.
`dfs.image.transfer.timeout` 설정은 기본값이 60000 (ms)인데 이를 두세배 늘려볼 수도 있다. (혹은 `dfs.image.transfer.bandwidthPerSec` 설정을 살펴볼 수도 있다.)

두 가지 모두 작은 규모의 하둡 클러스터에선 필수적인 고려사항은 아니다.


## 참고링크
* https://community.cloudera.com/t5/Community-Articles/How-do-you-enable-Namenode-service-RPC-port-without-HDFS/ta-p/249006
* https://hadoop.apache.org/docs/r3.0.0/hadoop-project-dist/hadoop-hdfs/hdfs-default.xml

