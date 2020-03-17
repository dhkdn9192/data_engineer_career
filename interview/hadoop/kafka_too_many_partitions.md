# Kafka의 partition은 많을 수록 좋을까?

## Kafka's Partition
Kafka에 메시지를 병렬 처리 방식으로 보내고 받을 수 있도록 하기 위해 Topic당 여러개의 partition을 할당할 수 있다.
메시지를 produce/consume하는 프로세스 수 만큼 partition을 생성한다면 보다 효율적으로 메시지를 주고받을 수 있다.
Kafka에 메시지를 read/write하는 작업도 엄연히 시간을 소요하는 I/O 작업이다.

## Too many Partitions
Topic의 partition 개수를 늘리면 빠른 전송이 가능하다.
그러나 무조건 partition 수가 많은 것이 좋은 것은 아니다.
과도하게 많은 partition 수는 Kafka의 성능에 악영향을 준다.

- <b>파일 핸들러 낭비</b>
  - 각 partition은 broker의 디렉토리와 매핑된다. 즉, <b>partition 수가 많을 수록 Kafka는 많은 파일 핸들</b>을 열게 되고, 이는 리소스 낭비를 유발한다.
- <b>장애 복구 시간 증가</b>
  - Kafka는 장애 복구를 위해 replication을 지원하며, 각 partition 별로 replica를 생성한다.
  - partition의 replica들은 leader와 follower로 구분되며 오직 leader만 읽기/쓰기를 담당한다.
  - 노드 장애 시 <b>broker controller</b>는 각 파티션별 leader를 새로 선출한다. partition 수가 많을 수록 선출 작업은 오래 걸린다.
  - <b>broker controller</b>가 다운될 경우, 
  남은 broker가 새로운 controller가 되고 초기화되는 동안 zookeeper는 <b>모든 partition의 데이터를 읽어야 한다</b>.

## Reference
- 도서 "카프카, 데이터 플랫폼의 최강자", 책만, 고승범 공용준 지음
