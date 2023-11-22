# Kafka Connect

Kafka Connect는 Apache Kafka의 오픈소스 컴포넌트로, Kafka와 다른 데이터소스 사이의 데이터 전송을 위한 도구다.

## Concept
| 용어 | 설명 |
| --- | --- |
| Connectors | task를 관리하며 데이터 스트리밍을 담당하는 추상화 |
| Tasks | Kafka에서 데이터가 어떻게 입출력되는지에 대한 구현체 |
| Workers | connector와 Task를 실행하는 실제 프로세스 |
| Converters | Connect와 시스템이 주고받는 데이터를 번역하는 코드 |
| Transforms | connector가 전송하거나 전송받는 각 메시지를 수정하기 위한 간단한 로직 |
| Dead Letter Queue | Connect가 connector 에러를 처리하는 방법 |


## Connectors
Connector instance는 논리적인 잡으로, Kafka와 다른 시스템 사이의 데이터 복사를 책임진다. Kafka Connect는 2 종류의 connector를 갖는다.
* **Source connector**: 데이터베이스 전체, 스트림 테이블 변경사항을 Kafka 토픽으로 ingest한다. 
* **Sink connector**: Kafka 토픽으로부터 데이터를 ES, Hadoop 등의 저장소로 전달한다.


## Tasks
* 각 connector instance는 task들의 데이터 복사 과정을 관리한다.
* 수행할 작업을 여러 task들로 나눔으로써 병렬처리와 확장성을 가질 수 있다.
* task들의 상태정보는 Kafka의 특정 토픽에 저장된다.
* **Task Rebalancing**: Kafka Connect 클러스터에 connector가 제출되면 worker들에 connector와 task가 균등하게 분배된다. 만약 어느 worker가 유실될 경우, task들은 자동으로 다른 worker들에 재분배된다.

## Workers
connector와 task는 논리적인 단위로, 프로세스 내에서 실행된다. 이 프로세스를 worker라 부르며 두 가지 타입이 존재한다.
* **Standalone workers**: 단일 프로세스로 모든 connector와 task를 실행한다.
* **Distributed workers**: 확장성과 자동화된 fault tolerance를 제공한다. 한 클러스터의 worker 프로세스들은 같은 `group.id` 값을 갖는다. connector와 task들이 여러 worker들에 스케줄링되어 수행된다.

## Converters
converter는 Kafka Connect가 Kafka에서 데이터를 읽거나 Kafka에 데이터를 쓸 때 특정 데이터 포맷을 지원하기 위해 필요하다. task에선 converter를 사용하여 데이터의 포맷을 byte에서 Connect 내부 데이터 포맷으로, 혹은 그 반대로 변경한다.

Confluent Platform에서 기본적으로 제공하는 converter는 아래와 같다.
* AvroConverter: Schema Registry와 함께 사용
* ProtobufConverter: Schema Registry와 함께 사용
* JsonSchemaConverter: Schema Registry와 함께 사용.
* JsonConverter
* StringConverter
* ByteArrayConverter


## Transforms
connector는 각 메시지에 대한 간단한 수정을 할 수 있는 transformation을 설정할 수 있다. 메시지 변환에 대한 자세한 설정은 [링크](https://docs.confluent.io/platform/current/connect/transforms/overview.html#connect-transforms-supported)를 참조


## Reference
* https://docs.confluent.io/platform/current/connect/index.html
