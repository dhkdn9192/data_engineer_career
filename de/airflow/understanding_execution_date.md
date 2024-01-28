# Airflow execution_date와 스케줄링 이해하기


Airflow를 사용할 때 이해하기 어렵고 실수하기 쉬운 부분 중 하나가 `execution_date` 이다.
현재는 `logical_date`로 대체되었으나 호환성을 위해 여전히 Airflow에서 사용되고 있다.
`execution_date`와 DAG 스케줄링에 대한 개념을 정리해본다.



## DAG 생성 시 첫 번째로 DAG가 실행되는 날짜는?
Airflow를 사용할 때 가장 흔한 실수 중 하나를 살펴보자.
DAG를 생성하면서 `start_date`를 `2024-01-01`로, `schedule_interval`을 `@daily` (혹은 `0 0 * * *`) 로 설정했다.
```python
 with DAG(
     dag_id="my_dag_name",
     start_date=datetime.datetime(2024, 1, 1),
     schedule="@daily",
 ):
     EmptyOperator(task_id="task")
```

이제 2024-01-01 00시가 되면 DAG가 첫 실행될 것 같지만 실제로는 그렇지 않다.
DAG가 처음 실행되는 날짜는 하루가 지난 2024-01-02 00시이다.
이유를 이해하려면 Airflow의 execution_date와 time window(data interval) 개념을 알아야 한다.


## 스케줄링 개념 이해하기

### schedule_interval

DAG가 실행되는 주기로 cron 설정 또는 아래와 같이 프리셋을 사용할 수 있다.
여기까진 이해하기 쉽다.

preset | meaning | cron
-------| ------- | -----
None   | Don’t schedule, use for exclusively “externally triggered” DAGs | 
@once  | Schedule once and only once | 
@continuous | Run as soon as the previous run finishes | 
@hourly | Run once an hour at the end of the hour | 0 * * * *
@daily | Run once a day at midnight (24:00) | 0 0 * * *
@weekly | Run once a week at midnight (24:00) on Sunday | 0 0 * * 0
@monthly | Run once a month at midnight (24:00) of the first day of the month | 0 0 1 * *
@quarterly | Run once a quarter at midnight (24:00) on the first day | 0 0 1 */3 *
@yearly | Run once a year at midnight (24:00) of January 1 | 0 0 1 1 *


### Data Interval

data interval은 각 DAG가 갖는 데이터 시간 범위(time range)를 의미한다.
예를 들어, `@daily` 스케줄링된 DAG는 00:00분이 시작이고 24:00이 끝인 data interval을 갖는다.

DAG run은 data interval이 끝나는 시점에서 수행된다.
Airflow의 개념 상 각 DAG가 처리해야 할 데이터의 범위(data interval)가 존재하며 그 기간이 지나야 실제로 DAG가 실행될 수 있다.
이 부분에서 처음 Airflow를 접하는 사람들이 혼란을 많이 겪는다.

중요한 점은, **data interval의 시작점은 DAG가 실제로 실행되는 시점이 아니라는 것**이다.


### start_date

`start_date`는 **DAG의 첫 번째 data interval의 시작일**을 의미한다.
용어 때문에 오해할 수 있지만 start(시작점)이 가리키는 대상은 DAG run이 아니라 data interval인 것이다.
때문에 DAG run이 처음 수행되는 시점은 `start_date`로부터 interval이 한 번 지난 data interval 끝 시점이 된다.

즉, `start_date`는 **DAG가 실제로 실행되는 날짜를 의미하는 것이 아니다**.


### execution date와 logical date

`execution_date`는 data interval의 시작일을 의미한다.
이름 때문에 혼동이 올 수 있으나 **DAG가 실제로 실행되는 날짜를 의미하지 않는다**.

위와 같은 혼동이 오는 근본적인 이유는, DAG run 스케줄링과 time window(data interval) 개념이 `execution_date`에 혼재되어 있기 때문이다.
현재 Airflow에선 `execution_date`가 `logical_date`로 대체되었다. (다만 과거 호환성을 위해 `execution_date`은 계속 사용되고 있다.)


### DAG run

DAG가 실제로 실행되는 시간은 `logical_date` + `scheduled_interval` 로 계산할 수 있다.
만약 처음 등록된 DAG라면 `start_date`에서 `scheduled_interval`가 한 번 지난 시점에서 실행되는 것이다.

`schedule_interval`이 `@daily`이고 `2024-01-05`에 실행되는 DAG의 스케줄링을 이미지로 나타내보면 다음과 같다.
<img width="885" alt="image" src="https://github.com/dhkdn9192/data_engineer_career/assets/11307388/5846bfbe-ce66-4050-96b4-690ee5a3acdb">




## 참고자료
* https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dags.html
* https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/dag-run.html
* https://airflow.apache.org/docs/apache-airflow/stable/faq.html#faq-what-does-execution-date-mean
* https://blog.bsk.im/2021/03/21/apache-airflow-aip-39/
* https://gpalektzja.medium.com/airflow-%EC%8A%A4%EC%BC%80%EC%A4%84%EB%A7%81%EA%B3%BC-execution-date-%EB%BD%80%EA%B0%9C%EA%B8%B0-2549e711a4b6
