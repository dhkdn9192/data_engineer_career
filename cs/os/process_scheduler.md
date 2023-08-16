# 프로세스 스케줄링 큐



## 프로세스의 상태

![process_status](https://github.com/dhkdn9192/data_engineer_career/blob/master/cs/os/img/process_status_changes.png)

- **New** : 프로세스가 메인 메모리에 할당된다.
- **Ready** : 할당된 프로세스가 실행되기 위한 모든 준비를 마친다.
- **Running** : CPU가 해당 프로세스를 실행한다.
- **Waiting** : I/O로 인해 프로세스가 중단된다. 다시 실행되려면 Ready 상태가 되어야 한다.
- **Terminated** : 프로세스가 완전히 종료된다.



## PCB (Process Control Block)

PCB는 프로세스의 모든 정보를 저장한다. PID, 프로세스 상태, PC(Program Counter), Register 값, CPU 점유시간 등을 포함한다.

CPU는 문맥교환을 위해서 수행 중인 프로세스에서 나갈 때, 해당 프로세스의 정보를 PCB에 기록함으로써 나중에 다시 이어서 프로세스를 수행할 수 있게 된다.

프로세스들이 할당을 위해 큐에 대기할 때, 큐에는 PCB가 저장된다.



## 프로세스 큐

![process_queues](https://github.com/dhkdn9192/data_engineer_career/blob/master/cs/os/img/process_queues.png)

#### Job Queue

디스크에서 메모리로의 할당 순서를 기다리는 프로세스들의 큐. 현재 시스템의 모든 프로세스 집합이다. Job scheduler (Long-term scheduler)에 의해 스케줄링된다.



#### Ready Queue

메모리에 있으면서 CPU 점유 순서를 기다리는 프로세스들의 큐. CPU scheduler (Short-term scheduler)에 의해 스케줄링된다.



#### Device Queue

I/O 장치 점유를 기다리는 프로세스들의 큐. I/O 장치 별로 큐가 존재한다. Device scheduler에 의해 스케줄링된다.







## 프로세스 스케줄러

#### Long-term Scheduler (장기 스케줄러)

- 디스크와 메모리 사이의 스케줄링을 담당한다.
- 프로세스에 메모리 및 자원을 할당해준다.
- Degree of Multiprogramming 을 제어한다. (실행 중인 프로세스 수 제어)
- 프로세스의 상태 : ```New``` -> ```Ready``` 



#### Short-term Scheduler (단기 스케줄러)

- 메모리와 CPU 사이의 스케줄링을 담당한다.
- Ready Queue의 프로세스 중 어떤 프로세스를 실행시킬지를 결정한다.
- 프로세스에 CPU를 할당해준다.
- 프로세스의 상태 : ```Ready``` -> ```Running``` -> ```Waiting``` -> ```Ready```



#### Medium-term scheduler (중기 스케줄러)

시부할 시스템 등의 운영체제는 medium-term scheduler를 도입하여 메모리의 프로세스를 제거한다. CPU 경쟁을 줄여 다중 프로그래밍의 정도를 완화한다. 제거된 프로세스는 나중에 다시 메모리로 불러와서 중단 지점부터 다시 수행한다. 이러한 기법을 **swapping**이라 한다.

- 여유 공간 마련을 위해 프로세스를 메모리에서 디스크로 쫓아냄
- Degree of Multiprogramming 을 제어 (실행 중인 프로세스 수 제어)
- 메모리에 너무 많은 프로세스가 올라가는 것을 조절하는 스케줄러
- 프로세스의 상태 : ```Ready``` -> ```Suspended```



## Reference

- https://velog.io/@codemcd/%EC%9A%B4%EC%98%81%EC%B2%B4%EC%A0%9COS-5.-%ED%94%84%EB%A1%9C%EC%84%B8%EC%8A%A4-%EA%B4%80%EB%A6%AC
- https://lazymankook.tistory.com/25
- https://github.com/JaeYeopHan/Interview_Question_for_Beginner/tree/master/OS#%EC%8A%A4%EC%BC%80%EC%A4%84%EB%9F%AC

