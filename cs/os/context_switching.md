# Context Switching의 단계


## Context Switching이란
CPU가 어떤 하나의 프로세스를 실행하고 있는 상태에서 인터럽트 요청에 의해 다음 우선 순위의 프로세스가 실행되어야 할 때 수행된다.
기존의 프로세스의 상태 또는 레지스터 값(Context)을 저장하고 CPU가 다음 프로세스를 수행하도록 
새로운 프로세스의 상태 또는 레지스터 값(Context)를 교체하는 작업을 Context Switch(Context Switching)라고 한다.

#### Context의 내용
CPU가 해당 프로세스를 실행하기 위한 해당 프로세스의 정보들이다.
이 Context는 프로세스의 PCB(Process Control Block)에 저장된다.

#### PCB의 저장정보
- 프로세스 번호: PID
- 프로세스 상태 : 생성(Created), 준비(Ready), 수행(Running), 대기(Waiting), 완료(Terminated)
- 프로그램 카운터 : 프로세스가 다음에 실행할 명령어 주소
- 레지스터 : 누산기, 스택, 색인 레지스터


## Context Switching 수행 단계
1. <b>인터럽트/시스템 호출</b> : 운영체제에서 프로세스 스케쥴러에 의해 인터럽트 발생
2. <b>커널 모드 전환</b> : 프로세스가 실행되는 사용자모드에서 커널 모드로 전환
3. <b>현재 프로세스 상태 PCB 저장</b> : 기존 실행되는 프로세스 정보를PCB에 저장
4. <b>다음 실행 프로세스 로드</b> : PCB에 있는 다음 실행 프로세스 상태 정보 복구
5. <b>사용자 모드 전환</b> : 커널 모드에서 사용자 모드로 전환하여 프로세스 실행


## 인터럽트에 의한 Context Switching
인터럽트는 실행중인 프로그램 밖에서 예외 상황이 발생하여 처리가 필요한 경우, 
CPU에게 알려 예외 상황을 처리할 수 있도록 하는 것을 말한다.

#### Context Switching이 발생하는 인터럽트 요청
- I/O request (입출력 요청할 때)
- time slice expired (CPU 사용시간이 만료 되었을 때)
- fork a child (자식 프로세스를 만들 때)
- wait for an interrupt (인터럽트 처리를 기다릴 때)



## Context Switching의 오버헤드
Context Switching 때 해당 CPU는 아무런 일을 하지 못한다. 
따라서 컨텍스트 스위칭이 잦아지면 오히려 오버헤드가 발생해 효율(성능)이 떨어진다.


#### 오버헤드 해결 방안
- 프로그램 다중화 수준 낮춤 : 다중 프로그래밍 수준을 낮추어 문맥 교환 발생 빈도 감소
- 스레드 이용 : Light Weight 프로세스인 스레드를 이용하여 문맥 교환 부하 최소화
- 스택포인터 활용 : 스택 이용 프로그램의 경우 스택 포인터를 이용하여 문맥 교환 부하 최소화


## Reference
- https://jeong-pro.tistory.com/93
- http://blog.skby.net/%EB%AC%B8%EB%A7%A5%EA%B5%90%ED%99%98-context-switching/
