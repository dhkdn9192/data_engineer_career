# CPU Scheduling
스케줄링(scheduling)은 다중 프로그래밍을 가능하게 하는 운영 체제의 동작 기법이다. 
운영 체제는 프로세스들에게 CPU 등의 자원 배정을 적절히 함으로써 시스템의 성능을 개선할 수 있다.

## 스케줄링 알고리즘 평가 기준

| 항목 | 설명 |
| :---: | :---: |
| CPU 사용률(CPU Utilization) | 전체 시스템 시간 중 CPU가 작업을 처리하는 시간의 비율 |
| 처리량(Throughput) | CPU가 단위 시간당 처리하는 프로세스의 개수 |
| 응답 시간(Response Time) | 대화식 시스템에서 요청 후 응답이 오기 시작할 때까지의 시간 |
| 대기 시간(Waiting Time) | 프로세스가 준비 큐 내에서 대기하는 시간의 총합 |
| 반환 시간(Turnaround Time) | 프로세스가 시작해서 끝날 때까지 걸리는 시간 |


## 비선점형과 선점형

- <b>비선점형 스케줄링(Non-preemptive Scheduling)</b> : 
프로세스가 종료되거나 자발적으로 중지될 때까지 계속 실행되도록 보장한다.
순서대로 처리되고, 응답 시간을 예상할 수 있으며, 스케줄러 호출 빈도가 낮고, 문맥 교환 오버헤드가 적다. 
일괄 처리 시스템에 적합하다.
*CPU 사용 시간이 긴 하나의 프로세스에 의해 처리율이 떨어질 수 있다*는 단점이 있다.

- <b>선점형 스케줄링(Preemptive Scheduling)</b> : 
다른 프로세스가 실행 중인 프로세스를 중지하고 CPU를 강제로 점유할 수 있다. 
모든 프로세스에게 CPU 사용 시간을 동일하게 부여할 수 있다. 
빠른 응답시간에 적합하며 긴급한 프로세서를 제어할 수 있다. 


## 정적 스케줄링과 동적 스케줄링

- <b>정적 스케줄링(Static Scheduling)</b> : 
프로세스에 부여된 우선순위가 바뀌지 않는다. 고정우선순위 스케줄링이라고도 한다.

- <b>동적 스케줄링(Dynamic Scheduling)</b> :
스케줄링 과정에서 프로세스의 우선순위를 변동시킨다. 유동우선순위 스케줄링이라고도 한다.


## 스케줄링 알고리즘 종류
- 비선점 프로세스 스케줄링
  - FCFS 스케줄링(First Come First Served Scheduling)
  - SJF 스케줄링(Shortest Job First Scheduling)
  - HRRN 스케줄링(Highest Response Ratio Next Scheduling)
- 선점 프로세스 스케줄링
  - RR 스케줄링(Round Robin Scheduling)
  - SRTF 스케줄링(Shortest Remaining-Time First Scheduling)
  - 다단계 큐 스케줄링(Multilevel Queue Scheduling)
  - 다단계 피드백 큐 스케줄링(Multilevel Feedback Queue Scheduling)
  - RM 스케줄링(Rate Monotonic Scheduling)
  - EDF 스케줄링(Earliest Deadline First Scheduling)
  
  
