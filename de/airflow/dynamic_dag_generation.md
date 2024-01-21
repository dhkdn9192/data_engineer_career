# Dynamic DAG Generation

> documentation : https://airflow.apache.org/docs/apache-airflow/stable/howto/dynamic-dag-generation.html


- Airflow는 동적으로 DAG를 생성할 수 있는 기능을 제공한다.
- 동적으로 생성된 DAG들은 **같은 수의 task**를 가진다.
  - 만약 동적으로 task 수가 변경되는 기능을 원한다면 [Dynamic Task Mapping](https://airflow.apache.org/docs/apache-airflow/stable/authoring-and-scheduling/dynamic-task-mapping.html)을 참고
- 동적으로 생성되는 DAG들은 **Task와 Task Group들이 모두 일관된 순서로 실행되도록** 해야 한다.


## Dynamic DAG와 환경변수
- Dynamic DAG를 사용할 때 [top-level 코드](https://airflow.apache.org/docs/apache-airflow/stable/best-practices.html#top-level-python-code)에서 변수를 써야한다면 [Airflow Variables](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/variables.html) 대신 **환경변수**를 사용해야 한다.
- Airflow Variables를 사용하면 메타데이터 DB로부터 값을 받아오기 위해 연결을 생성하면서 DB에 부하가 가고 파싱이 느려질 수 있다.
- 예를 들어, `DEPLOYMENT` 변수 값으로 프로덕션 환경에선 "PROD"를, 개발환경에선 "DEV"를 입력하려고 한다면 아래처럼 코드를 작성할 수 있다.
```python
deployment = os.environ.get("DEPLOYMENT", "PROD")
if deployment == "PROD":
  task = Operator(param="prod-param")
elif deployment == "DEV":
  task = Operator(param="dev-param")
```

## Dynamic DAG에 메타데이터 전달하기

### (방법 1) Python 코드에 embedded meta-data를 포함시키는 방법
* 별개의 python 코드에 meta-data를 작성하고 이를 import하여 사용하는 방법이 있다.
* 예를 들어, DAG folder에 `my_company_utils/common.py` 파일을 아래와 같이 작성하고
```python
# This file is generated automatically !
ALL_TASKS = ["task1", "task2", "task3"]
```
* 모든 DAG에서 각자 `ALL_TASKS` 상수를 import하여 사용할 수 있다.
```python
from my_company_utils.common import ALL_TASKS

with DAG(
    dag_id="my_dag",
    schedule=None,
    start_date=datetime(2021, 1, 1),
    catchup=False,
):
    for task in ALL_TASKS:
        # create your operators and relations here
        ...
```
* 위처럼 사용할 경우, 아래 두 사항을 지켜야 한다.
  * `my_company_utils` 폴더에 `__init__.py` 파일을 추가해야 한다.
  * (regexp ignore syntax를 사용하는 경우엔) `.airflowignore file` 파일에 `my_company_utils/.*` 라인을 추가해야 한다. -> scheduler가 DAG를 찾을 때 해당 폴더 전체를 무시하도록 하기 위함


### (방법 2) 외부 configuration 파일로부터 meta-data 가져오기
* meta-data가 복잡하여 python 파일이 아닌 구조화된 포맷으로 분리하고자 할 경우, DAG 폴더에 파일 형태로 저장하면 된다. (JSON, YAML 등)
* meta-data 파일을 쉽게 찾을 수 있도록 DAG 모듈이 저장된 패키지/폴더 경로에 함께 저장하는 편이 좋다.
  * DAG가 포함된 모듈의 `__file__` 애트리뷰트를 사용하여 읽을 파일의 위치를 알 수 있다.
```python
my_dir = os.path.dirname(os.path.abspath(__file__))
configuration_file_path = os.path.join(my_dir, "config.yaml")
with open(configuration_file_path) as yaml_file:
    configuration = yaml.safe_load(yaml_file)
# Configuration dict is available here
```

## dynamic DAG 등록하기
* `@dag` 데코레이터를 사용하거나 `with DAG(...)` 컨텍스트 매니저를 사용하여 DAG들을 동적으로 생성할 수 있다.
* 생성된 DAG는 Airflow가 자동으로 등록해준다.
```python
from datetime import datetime
from airflow.decorators import dag, task

configs = {
    "config1": {"message": "first DAG will receive this message"},
    "config2": {"message": "second DAG will receive this message"},
}

for config_name, config in configs.items():
    dag_id = f"dynamic_generated_dag_{config_name}"

    @dag(dag_id=dag_id, start_date=datetime(2022, 2, 1))
    def dynamic_generated_dag():
        @task
        def print_message(message):
            print(message)

        print_message(config["message"])

    dynamic_generated_dag()
```
* DAG가 자동으로 등록(auto-registered)되는걸 원치 않는다면 DAG에서 `auto_register=False`로 설정하여 비활성화할 수 있다.
* 2.4 버전부턴 `@dag` 데코레이터나 `with DAG(...)` 컨텍스트 매니저로 생성된 DAG는 자동으로 등록되므로 더이상 global variable에 저장할 필요가 없다.


## DAG 파싱 지연 최적화하기
* (주의) 단, 이 방법은 현재 실험단계이고 모든 케이스에 적용 가능하지 않으며 DAG에 일부 사이트 이펙트를 유발할 수 있으므로 많은 테스트와 주의가 필요하다.
* 한 DAG 파일에서 너무 많은 Dynamic DAG들이 생성될 경우, DAG 파일 파싱이 오래 걸릴 수 있다.
  * Airflow는 task 실행 전에 DAG를 정의한 Python 코드를 파싱함
* 최적화를 위한 아이디어
  * Airflow Scheduler(또는 DAG File Processor)는 모든 메타데이터를 처리하기 위해 완전한 DAG 파일을 로딩하는 반면, task 실행에는 DAG object 하나만 있으면 된다.
  * 이 점을 이용하여 task 실행 시 불필요한 DAG obejct 생성을 skip하여 파싱 시간을 줄일 수 있다.
* 2.4 버전부턴 `get_parsing_context()` 메소드를 사용하여 현재 컨텍스트를 반환받을 수 있다.
  * DAG 생성 코드에서 컨텍스트를 사용하여 *모든 DAG obejct* 를 생성할 것인지, 아니면 *단일 DAG object만* 생성할 것인지 결정할 수 있다.
  * (DAG File processor에서 파싱할 때) -> 모든 DAG obejct 생성
  * (task를 수행할 때) -> 단일 DAG object만 생성
* `get_parsing_context()` 메소드는 현재의 파싱 컨텍스트를 반환한다.
  * 단일 DAG/task가 필요한 경우, `dag_id`와 `task_id` 필드에 값이 설정된다.
  * DAG File Processor 동작과 같이 전체 파싱이 필요한 경우, `dag_id`와 `task_id` 필드가 `None`으로 설정된다.
```python
from airflow.models.dag import DAG
from airflow.utils.dag_parsing_context import get_parsing_context

current_dag_id = get_parsing_context().dag_id

for thing in list_of_things:
    dag_id = f"generated_dag_{thing}"
    if current_dag_id is not None and current_dag_id != dag_id:
        continue  # skip generation of non-selected DAG

    with DAG(dag_id=dag_id, ...):
        ...
```
* 요컨데, Dynamic DAG는 하나의 DAG(부모) 코드에서 여러 동적 DAG(자식)들이 생성되는 구조이고 모든 동적 DAG(자식)들이 동일한 dag 코드로 동작한다.
* 이 때, 각 동적 DAG(자식) 코드에선 전체 DAG obejct들을 다 생성할 필요가 없다. 자신을 위한 object만 생성하도록 하여 파싱 시간을 줄일 수 있는 것이다.
