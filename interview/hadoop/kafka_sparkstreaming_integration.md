# Kafka + Spark Streaming Integration

Spark Streaming과 Kafka를 연동하는 방법에는 크게 2가지가 있다.

- Receiver-based Approach
- Direct Approach (No Receivers)


<br>


## 1. Receiver-based Approach

이 통합 방식에서는 데이터 전달 과정에서 더 나은 **Fault-tolerance 수준을 보장**하기 위해 Spark 1.2부터 도입된 **Write Ahead Log** (**WAL**)를 사용한다. 

1. Spark Executor에 존재하는 Receiver가 Kafka로부터 데이터를 consume한다. Kafka의 high-level consumer API를 사용한다.
2. 수신된 데이터는 WAL에 저장된다(HDFS)
3. WAL에 기록이 완료되면, Receiver는 Zookeeper 상의 Kafka offsetㅇ르 업데이트한다.
4. 장애가 발생할 경우, WAL의 기록을 읽어 데이터가 손실되지 않도록 복구한다.



![kafka_sparkstreaming_receiver_approach](https://github.com/dhkdn9192/data_engineer_should_know/blob/master/interview/hadoop/img/kafka_sparkstreaming_receiver_approach.png)



<br>

Receiver-based Approach는 데이터의 손실은 막을 수 있지만 장애가 발생하면 데이터가 두 번 이상 중복으로 처리될 수 있다는 문제가 있다. 즉, **at-least-once** 방식이다.

1. Receiver가 WAL에 기록을 완료한 뒤 Zookeeper의 offset을 업데이트하기 전에 장애가 발생
2. Receiver는 다시 Kafka를 consume 할 때 Zookeeper의 업데이트되지 않은 offset을 참조
3. 이렇게 읽어온 데이터는 이미 WAL에 기록되어 있으므로 같은 데이터를 두 번 처리하게 됨




<br>


## 2. Direct Approach (No Receivers)

위와 같은 문제 때문에 Spark 1.3부터 Direct approach가 도입되었다. Receiver와 WAL을 사용하지 않으며, offset을 Zookeeper에 갱신하지 않고 직접 checkpoint로 관리한다. Receiver approach와 비교하여 아래와 같은 이점을 갖는다.

- **Simplified Prallelism** : ```directStream``` 은 Kafka partition 수만큼 RDD partition을 생성해준다. 따라서 여러개의 input Kafka stream을 생성하여 ```union``` 해줄 필요가 없다. 덕분에 사용하기 쉽고 설정하기도 용이하다.
- **Efficiency** : Receiver approach에선 WAL 사용으로 인해 데이터가 중복 처리되는 비효율 문제가 있었다. Direct approach에선 Receiver가 없으므로 WAL 또한 사용하지 않는다. 장애가 생길 경우엔 Kafka로부터 손실된 메시지를 가져온다.
- **Exactly-once semantics** : offset을 Spark Streaming이 직접 **checkpoint**를 통해 관리하며 Zookeeper를 사용하지 않는다. 이로 인해 장애가 발생하더라도 Spark Streaming과 Zookeeper/Kafka 사이의 inconsistency가 생기지 않는다. 즉, **exactly-once** 가 보장된다.



![kafka_sparkstreaming_direct_approach](https://github.com/dhkdn9192/data_engineer_should_know/blob/master/interview/hadoop/img/kafka_sparkstreaming_direct_approach.png)



반면, Zookeeper를 통해 offset이 관리되지 않으므로 다음과 같은 단점을 가진다.

- 전통적으로 Zookeeper를 사용하는 Kafka 모니터링 도구에서 Spark Streaming이 consume하고 있는 offset을 볼 수 없다. offset을 Zookeeper에 기록하지 않고 checkpoint를 통해 자체적으로 관리하기 때문이다.





<br>



## Reference

- https://tommypagy.tistory.com/155
- https://spark.apache.org/docs/2.4.6/streaming-kafka-0-8-integration.html
- https://databricks.com/blog/2015/03/30/improvements-to-kafka-integration-of-spark-streaming.html
