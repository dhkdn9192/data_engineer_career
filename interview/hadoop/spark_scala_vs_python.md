# Spark : Python vs Scala

<br>

## Structured API : DataFrame, SQL

```
"JVM execution with Python limited to the driver"
```

- Spark의 구조적 API는 모든 언어에서 일관된 속도와 안정성을 제공한다.
- 즉, 모든 언어에서 DataFrame, SQL의 속도, 성능은 거의 동일하다.
- 단, 파이썬이나 R로 **UDF를 정의할 경우엔 성능 저하**가 발생할 수 있다.
  - 각 Executor에서 UDF를 처리하기 위해 JVM 외부의 Python/R 프로세스와 통신하면서  I/O 및 직렬화/역직렬화 비용이 들기 때문
  - 따라서 UDF 대신 DataFrame/SQL을 사용하는 것이 좋으며
  - UDF가 필요하다면 Scala로 작성 후 jar를 별도로 등록해 사용하는 것이 좋다.
- **모든 DataFrame, Dataset, SQL은 RDD로 컴파일** 되며 **Python/R 언어로 수행되는 JVM 연산은 driver로 제한**된다.


<br>


## RDD API

```
"pure Python structures with JVM based orchestration"
```

- Python으로 RDD를 다룰 경우, 순수 Python 프로세스와 JVM이 통신을 하게 된다.
- 이 경우엔 다음과 같은 요소들이 성능에 영향을 미치게 된다.
  - **Overhead of JVM communication**. Python 프로세스와 JVM 사이의 통신비용
  - **Python은 process-based executor**로, 각 프로세스마다 broadcast의 복사본을 요구하므로 **Scala의 thread-based executor**에 비해 효율이 상대적으로 떨어진다.
  - Python은 **reference counting** 기반의 메모리 관리를 수행하므로 **JVM GC**에 의한 장시간 pause의 위험을 낮출 수 있다.
- 따라서 RDD를 사용하려면 Scala나 Java를 사용해야 해야 하고, Python/R로 RDD를 다뤄야 한다면 사용 영역을 최소화해야 한다.
- 예를 들어, Python에서 RDD 코드를 실행하면 Python 프로세스를 오가는 많은 데이터를 직렬화해야 하고, 매우 큰 데이터를 직렬화하면 많은 비용이 발생하며 안전성까지 떨어지게 된다.


<br>


## Reference
- https://stackoverflow.com/questions/32464122/spark-performance-for-scala-vs-python
- 도서 "스파크 완벽 가이드", 한빛미디어, 빌 체임버스, 마테이 자하리아 지음
