# Set up Scala and SBT

Scala의 설치는 Spark 프레임워크 사용을 염두에 두고 진행한다.
Scala와 Spark, SBT의 버전 호환성을 맞춰야 하므로 maven repository의 버전 테이블을 참고하여 설치를 진행한다.

https://mvnrepository.com/artifact/org.apache.spark/spark-core

### Installation
JDK 1.8 이상이라면 SBT version은 at least 0.13.13 이어야 한다.

설치 버전
| package | version |
| :--- | :--- |
| JDK | 1.8 |
| Scala | 2.11.12 |
| Spark | 2.4.5 |
| SBT | 1.3.2 |


\* scala 2.12를 썼으나, spark-streaming-kafka가 2.12에서 호환성 문제가 있어서 downgrade함


### Dependencies

- Spark Streaming
  - Spark 2.4.5에서 Spark Streaming을 사용할 경우
  
    | Source | Artifact |
    | :--- | :--- |
    | Kafka | spark-streaming-kafka-0-10_2.11-2.4.5|

  - 참조 : https://spark.apache.org/docs/latest/streaming-programming-guide.html#linking
