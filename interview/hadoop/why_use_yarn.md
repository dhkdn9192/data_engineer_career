# What is Apache Hadoop YARN?

YARN(Yet Another Resources Negotiator)은 MapReduce 등 다양한 분산 처리 프레임워크에 클러스터 리소스 관리 기능을 제공하는 미들웨어다.
Hadoop 1.x 까지는 Hadoop/MapReduce 자체에 내장되어 있었지만 
Hadoop 2.x부턴 클러스터 리소스를 다른 분산 처리 프레임워크와 공유하기 위해 YARN이란 이름으로 분리되었다.


## YARN 도입 배경
YARN이 도입되기 전 Hadoop/MapReduce에서 JobTracker, TaskTracker의 역할은 다음과 같았다.
- <b>JobTrcker</b>
  - 리소스 관리 : job 우선순위, user별 리소스 할당, Map슬롯/Reduce슬롯에 task 할당 등
  - job 관리 : job 실행 중 계산 스케줄링 실시, task 진척 관리, 장애 시 재실행, Mapper/Reducer 처리 시작 등
  - job 이력관리
- <b>TaskTracker</b>
  - 노드의 리소스를 Map슬롯/Reduce슬롯이라는 형태로 분할해서 처리

위와 같은 리소스 관리 모델을 다음 문제들을 야기했다.
1. 태스크 슬롯 수가 <b>다른 분산 처리 프레임워크와 공유되지 않아</b> 리소스 이용 효율이 나쁨 : 클러스터 전체 리소스의 이용 효율이 파악 안 됨
2. <b>슬롯을 TaskTracker 시작 시에 정적으로 결정</b>하여 리소스 이용 효율이 나쁨 : MapReduce는 초반에는 Map슬롯, 후반에는 Reduce슬롯이 많이 요구됨
3. 클러스터를 업데이트 시, <b>모든 JobTacker/TaskTracker를 정지한 후에 일제히 업데이트</b>해야 함
4. task 수가 많은 환경에서는 <b>JobTacker에 부하가 집중</b>되어, CPU 병목현상을 야기할 수 있음


## YARN 아키텍처

기존 MapReduce에 대응되는 YARN의 기능들을 표로 나타내면 다음과 같다.

| 기존 Hadoop/MapReduce | MapReduce/YARN                                         |
| :---                 | :---                                                   |
| JobTracker           | ResourceManager / ApplicationMaster / JobHistoryServer |
| TaskTracker          | NodeManager                                            |

- JobTracker의 리소스 관리 : <b>ResourceManager</b>로 분리. RM이 클러스터 리소스를 일괄 관리하므로 이용 효율이 높다.
- JobTracker의 스케줄 관리 : <b>ApplicationMaster</b>로 분리. AM이 job 단위로 실행되므로 업데이트 없이 버그 수정 가능하고, task 증가에 의한 병목을 막을 수 있다.
- JobTracker의 이력 관리 : <b>JobHistoryServer</b>로 분리. AM으로부터 job 진행 상황을 보고받으며, job 이력 정보를 대시보드로 시각화해준다.
- TaskTracker : <b>NodeManager</b >로 분리. NM은 슬롯이 아닌 컨테이너 단위로 해당 서버의 리소스를 관리한다. NM은 RM에 서버 리소스를 보고한다.


YARN의 ResourceManager로 인해 클러스터 리소스가 일괄관리 되므로 모든 분산 처리 프레임워크들은 RM에게 리소스를 할당받아야 한다.
![yarn_before_after](img/yarn_before_after.png)

YARN에서 job이 실행되는 흐름을 구조적으로 보여주면 다음과 같다.
![yarn_job_flow](img/yarn_job_flow.png)

1. 클라이언트가 job을 실행하기 위해 ResourceManager에 요청한다.
2. ResourceManager는 ApplicationMaster를 실행하기 위해, NodeManager에 요청하여 컨테이너를 할당한다.
3. ResourceManager가 컨테이너 상에서 ApplicationMaster를 실행한다.
4. ApplicationMaster가 ResourceManager에 요청하여, 계산에 사용할 컨테이너를 할당한다.
5. ApplicationMaster가 할당받은 컨테이너 상에서 스케줄링을 실시하여 계산을 수행한다.

