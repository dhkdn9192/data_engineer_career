# 데드락의 발생조건과 세마포어, 뮤텍스


## 데드락(Deadlock)

프로세스가 자원을 얻지 못해 다음 처리를 하지 못하는 상태. 
시스템적으로 한정된 자원을 여러 곳에서 사용하려고 할 때 발생한다.

![deadlock](img/deadlock.png)

<br>

## 데드락 발생 조건

#### 1. 상호배제 (Mutual Exclusion)
- 한 자원에 대해 동시에 한 프로세스만 접근 가능
#### 2. 점유와 대기 (Hold and Wait)
- 자원을 점유한 상태에서 다른 프로세스의 자원이 반납되기를 기다림
#### 3. 비선점(Non Preemptive)
- 프로세스들은 다른 프로세스의 자원을 강제로 뺏어올 수 없음
#### 4. 환형대기 (Circle Wait)
- 각 프로세스가 순환적으로 다음 프로세스가 요구하는 자원을 점유함

<br>

## 데드락 해결 방법

#### 1. 예방 (Prevention)
- 상기 데드락 발생 조건 중 하나를 부정하여 사전에 예방하는 방법
  - <b>상호배제 부정</b>: 동시에 여러 프로세스 접근 가능. 실제로는 적용하기 어렵다.
  - <b>점유와 대기 부정</b>: 프로세스 시작 시 필요한 모든 자원을 동시에 가져온다.
  - <b>비선점 부정</b>: 다른 프로세스의 자원을 강제로 뺏어올 수 있도록 허용
  - <b>환형대기 부정</b>: 자원에 우선순위를 메겨 할당

#### 2. 회피 (Avoidance)
- Dijkstra의 은행원 알고리즘과 같이 모든 프로세스의 요구가 충족되도록 설계.
- 프로세스가 자원을 요구할 때, 시스템은 자원 할당 후에도 안정 상태로 남을지를 사전에 검사
  
#### 3. 회복 (Recovery)
- 교착상태를 허용한다. 탐지될 경우, 이를 회복하는 방식
- 교착상태를 일으킨 프로세스를 종료하거나, 할당된 자원을 해제한다.

#### 4. 무시 (Ignore)
- 대부분의 시스템에서 교착상태는 잘 일어나지 않는다.
- 교착상태를 예방/회피/탐지/복구 하는 데에 비용이 많이 들기 때문에 이를 내버려둔다.

<br>

## Reference

- https://jwprogramming.tistory.com/12
- https://junsday.tistory.com/32