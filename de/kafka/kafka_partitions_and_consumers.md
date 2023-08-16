# Kafka 메시지를 효율적으로 읽으려면



## Read Kafka : Partitions and Consumers

컨슈머는 Kafka로부터 메시지를 subscribe하고 처리하여 원하는 저장소에 전달한다. 만약 프로듀서가 토픽에 메시지를 입력하는 속도가 컨슈머의 처리 속도를 초과한다면 어떻게 해야할까? 이 경우엔 여러 컨슈머가 같은 토픽을 subscribe할 수 있도록 컨슈머 그룹를 확장해야 한다.

모든 컨슈머는 특정 컨슈머 그룹에 소속된다. 만약 같은 그룹의 컨슈머들이 같은 토픽을 subscribe한다면 각 컨슈머는 서로 겹치지 않게 파티션의 데이터를 읽게 된다.




### Case 1) N Partitions and One Consumer
컨슈머 그룹 내에 컨슈머가 하나 뿐일 경우, 혼자서 토픽의 모든 파티션을 subscribe한다.
![kafka_one_consumer_with_multiple_partitions](https://github.com/dhkdn9192/data_engineer_should_know/blob/master/de/kafka/img/kafka_one_consumer_with_multiple_partitions.png)





### Case 2) Partitions > Consumers
컨슈머가 2개 일 경우, 각자 파티션 2개씩 subscribe하여 겹치지 않게 메시지를 읽어온다.
![kafka_two_consumers_with_multiple_partitions](https://github.com/dhkdn9192/data_engineer_should_know/blob/master/de/kafka/img/kafka_two_consumers_with_multiple_partitions.png)





### Case 3) Partitions = Consumers
파티션 수와 컨슈머 수가 동일할 경우, 일대일 연결로 메시지를 읽어온다.
![kafka_n_consumers_n_partitions](https://github.com/dhkdn9192/data_engineer_should_know/blob/master/de/kafka/img/kafka_n_consumers_n_partitions.png)





### Case 4) Partitions < Consumers
만약 컨슈머 수가 파티션 수보다 많다면, 일대일 연결이 되지 못한 컨슈머는 메시지를 읽지 못하고 idle 상태가 된다.
![kafka_more_consumers](https://github.com/dhkdn9192/data_engineer_should_know/blob/master/de/kafka/img/kafka_more_consumers.png)







### 1-5. Another Consumer Group
같은 토픽을 subscribe하더라도 컨슈머 그룹이 서로 다르다면 서로의 subscribe 정보에 상관 없이 메시지를 처음부터 읽어오게 된다.
![kafka_multiple_consumer_groups](https://github.com/dhkdn9192/data_engineer_should_know/blob/master/de/kafka/img/kafka_multiple_consumer_groups.png)






## (예제) Spark Streaming에서 Kafka 메시지 읽기

Spark Streaming 애플리케이션이 서로 다른 Kafka 토픽 4개로부터 메시지를 읽어야 한다. 각 토픽은 모두 파티션 수가 3개 이다. 어떻게 해야 Kafka 파티션 수와 컨슈머 수가 일대일 매핑이 될 수 있을까? (Executor의 core 수는 Kafka 파티션을 읽기 위한 것만 고려)

- **Kafka의 각 파티션은 Spark Streaming Job의 각 core와 매핑된다**. (Executor와 매핑되는게 아니다!)
- 토픽별 파티션 수가 3개, 토픽의 수는 4개 이므로 읽어야 할 파티션의 수는 총 12개이다.
- 따라서 전체 코어수는 12개여야 한다.
- 코어 수 12개를 구성하는 방법은 다음과 같이 2가지 방법이 있다.
  - (1) Executor 1개에 core를 12개 할당 : ```spark.executor.instances=1``` and ```spark.executor.cores=12```
  - (2) Executor 12개에 core를 1개씩 할당 : ```spark.executor.instances=12``` and ```spark.executor.cores=1```




## Reference

- https://oreilly.com/library/view/kafka-the-definitive/9781491936153/ch04.html
- https://stackoverflow.com/questions/55474645/how-to-optimize-number-of-executor-instances-in-spark-structured-streaming-app
- https://community.cloudera.com/t5/Support-Questions/What-s-the-right-number-of-cores-and-executors-for-a-spark/m-p/61943

