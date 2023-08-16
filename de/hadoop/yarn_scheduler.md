# YARN Scheduler

Hadoop YARN의 Resource Manager는 Application Master의 요청에 따라 자원을 할당해준다.
자원을 할당해주기 위한 스케줄링 정책으로 3가지 스케줄러(FIFO, Fair, Capacity)를 사용할 수 있다.

YARN의 ```yarn-site.xml``` 설정파일에서 ```yarn.resourcemanager.scheduler.class``` 옵션에 원하는 스케줄러의 클래스명을 설정해줄 수 있다.

| scheduler | class name |
| --- | --- |
| FIFO Scheduler | org.apache.hadoop.yarn.server.resourcemanager.scheduler.fifo.FifoScheduler |
| Fair Scheduler | org.apache.hadoop.yarn.server.resourcemanager.scheduler.fair.FairScheduler |
| Capacity Scheduler | org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.CapacityScheduler |



![yarn_schedulers](https://github.com/dhkdn9192/data_engineer_career/blob/master/de/hadoop/img/yarn_schedulers.png)


## FIFO Scheduler
- 먼저 들어온 작업이 먼저 처리되는 선입선출 방식의 스케줄러
- 작업이 제출 순서대로 처리되고, 각 작업은 앞의 작업이 종료될 때까지 대기해야 한다.
- FIFO 방식은 효율적으로 자원을 사용하기 어려우며, 일반적으로 테스트 용도로 사용된다.


## Capacity Scheduler
- 디폴트로 사용되는 스케줄러
- 트래 형태로 큐를 선언하고, 각 큐 별로 자원의 용량을 지정
- 각 큐는 지정된 용량에 맞게 자원을 할당받는다.


## Fair Scheduler
- 제출된 작업들이 동등하게 자원을 점유하는 방식의 스케줄러
- 클러스터는 작업 큐에 작업이 제출되면 자원을 조절하여 각 작업에 균등하게 할당해준다.
 

<br>

## Reference
- https://wikidocs.net/22936
