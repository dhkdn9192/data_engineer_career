# Read Kafka : Partitions and Consumers



컨슈머는 Kafka로부터 메시지를 subscribe하고 처리하여 원하는 저장소에 전달한다. 만약 프로듀서가 토픽에 메시지를 입력하는 속도가 컨슈머의 처리 속도를 초과한다면 어떻게 해야할까? 이 경우엔 여러 컨슈머가 같은 토픽을 subscribe할 수 있도록 컨슈머 그룹를 확장해야 한다.

모든 컨슈머는 특정 컨슈머 그룹에 소속된다. 만약 같은 그룹의 컨슈머들이 같은 토픽을 subscribe한다면 각 컨슈머는 서로 겹치지 않게 파티션의 데이터를 읽게 된다.



<br>



## 1. N Partitions and One Consumer

![data_engineer_should_know/kafka_one_consumer_with_multiple_partitions.png at master · dhkdn9192/data_engineer_should_know (github.com)](https://github.com/dhkdn9192/data_engineer_should_know/blob/master/interview/hadoop/img/kafka_one_consumer_with_multiple_partitions.png)

컨슈머 그룹 내에 컨슈머가 하나 뿐일 경우, 혼자서 토픽의 모든 파티션을 subscribe한다.



<br>



## 2. Partitions > Consumers

![data_engineer_should_know/kafka_two_consumers_with_multiple_partitions.png at master · dhkdn9192/data_engineer_should_know (github.com)](https://github.com/dhkdn9192/data_engineer_should_know/blob/master/interview/hadoop/img/kafka_two_consumers_with_multiple_partitions.png)

컨슈머가 2개 일 경우, 각자 파티션 2개씩 subscribe하여 겹치지 않게 메시지를 읽어온다.



<br>



## 3. Partitions = Consumers

![data_engineer_should_know/kafka_n_consumers_n_partitions.png at master · dhkdn9192/data_engineer_should_know (github.com)](https://github.com/dhkdn9192/data_engineer_should_know/blob/master/interview/hadoop/img/kafka_n_consumers_n_partitions.png)

파티션 수와 컨슈머 수가 동일할 경우, 일대일 연결로 메시지를 읽어온다.



<br>



## 4. Partitions < Consumers

![data_engineer_should_know/kafka_more_consumers.png at master · dhkdn9192/data_engineer_should_know (github.com)](https://github.com/dhkdn9192/data_engineer_should_know/blob/master/interview/hadoop/img/kafka_more_consumers.png)

만약 컨슈머 수가 파티션 수보다 많다면, 일대일 연결이 되지 못한 컨슈머는 메시지를 읽지 못하고 idle 상태가 된다.





<br>



## 5. Another Consumer Group

![data_engineer_should_know/kafka_multiple_consumer_groups.png at master · dhkdn9192/data_engineer_should_know (github.com)](https://github.com/dhkdn9192/data_engineer_should_know/blob/master/interview/hadoop/img/kafka_multiple_consumer_groups.png)

같은 토픽을 subscribe하더라도 컨슈머 그룹이 서로 다르다면 서로의 subscribe 정보에 상관 없이 메시지를 처음부터 읽어오게 된다.





<br>



## Reference

- https://oreilly.com/library/view/kafka-the-definitive/9781491936153/ch04.html

