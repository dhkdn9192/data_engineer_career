# Spark Executor 메모리 구조

Spark 1.6 이상부턴 메모리 관리가 ```UnifiedMemoryManager``` class에 의해 이뤄진다.

![executor_memory_distribution](https://github.com/dhkdn9192/data_engineer_should_know/blob/master/interview/hadoop/img/spark_executor_memory_distribution.png)

- 위 이미지에선 spark.memory.fraction이 0.75로 표기되나, 현재 Spark 2.x 및 3.x에선 0.6이 default 값이다.
  - https://spark.apache.org/docs/latest/configuration.html#memory-management 

## 1. Reserved Memory
- 시스템에 의해 관리되는 메모리 영역으로 크기가 300MB로 고정되어 있다.
- Spark의 internal object들이 저장된다.
- Executor에 할당해준 메모리가 Reserved Memory 크기의 1.5배 미만이면 "*please use larger heap size*"라는 문구와 함께 에러가 발생한다.
- 메모리 사이즈 : ```300 MB (고정)```

## 2. User Memory
- 사용자가 정의한 데이터구조, UDF가 저장되는 공간이다.
- Spark에 의해 관리되지 않으며 Spark은 User Memory 공간을 인지하지 않는다.
- Java Heap 메모리에서 Reserved Memory를 제외한 공간 중에서 Spark Memory 가 아닌 나머지 부분이다.
- 메모리 사이즈 : ```(Java Heap Memory - Reserved Memory) * (1 - spark.memory.fraction)```

## 3. Spark Memory
- Spark에 의해 관리되는 메모리 영역이다.
- join과 같은 연산들이 실행되는 동안의 내부 상태가 저장되거나 broadcast 변수 등이 저장되는 영역이다.
- cache/persist에 의해 캐싱된 데이터가 저장되는 영역이다.
- Storage Memory 영역과 Execution Memory의 두 영역으로 나뉜다.
- 메모리 사이즈 : ```(Java Heap Memory - Reserved Memory) * spark.memory.fraction```

### 3-1. Storage Memory
- cache된 데이터, broadcast 변수가 저장된다.
- persist 옵션이 ```MEMORY```이면 이 영역에 데이터가 캐싱된다.
- 캐싱할 공간이 부족하여 오래된 캐시 데이터를 지울 경우엔 **LRU(Least Recently Used) 방식으로 제거**한다. (즉, 블록이 디스크로 강제 추방될 수 있다.)
- 캐싱된 데이터가 메모리에서 벗어날 경우에는 디스크에 저장되거나 새로 계산되어야 한다.
- 메모리 사이즈 : ```(Java Heap Memory - Reserved Memory) * spark.memory.fraction * spark.memory.storageFraction```

### 3-2. Execution Memory
- Spark이 task를 실행(execute)하는 동안 생성되는 object 들이 저장된다.
- 예시) Hash aggregation step에서 해쉬 테이블을 저장하거나, Map 수행 시 Shuffle intermediate buffer를 저장한다.
- 메모리가 충분하지 않을 경우, 디스크로의 spilling을 지원한다.
- 단, 이 영역의 블록은 다른 task에 의해 강제로 추방될 수는 없다. (Storage Memory와 다른 점)
- 메모리 사이즈 : ```(Java Heap Memory - Reserved Memory) * spark.memory.fraction * (1 - spark.memory.storageFraction)```

### Storage Memory vs Execution Memory 비교
1. Storage Memory는 Execution Memory가 사용되지 않는 경우에만 Execution Memory 영역을 빌릴 수 있다.
2. Execution Memory 역시 Storage Memory가 사용되지 않을 경우 Storage Memory 영역을 빌릴 수 있다.
3. Storage Memory가 점유한 Execution Memory 블록은 Execution이 요청할 경우, **강제로 추방될 수 있다**.
4. Execution Memory가 점유한 Storage Memory 블록은 Storage가 요청하더라도, **강제로 추방될 수 없다**. (Spark이 Execution의 블록을 release할 때까지 기다려야 한다.)


*즉, 블록 추방 우선도는 Storage Memory < Execution Memory라 할 수 있다.*



## Executor 메모리 할당 예시

Executor 메모리 설정이 다음 표와 같을 경우, 각 메모리 영역에 할당되는 실제 사이즈 계산

| conf | value |
| --- | --- |
| spark.executor.memory | 4g |
| spark.memory.fraction | 0.6 |
| spark.memory.storageFraction | 0.5 |


- Reserved Memory : **300MB**
- User Memory : (4096MB - 300MB) * (1 - 0.6) = **1518MB**
- Spark Memory : (4096MB - 300MB) * 0.6 = **2278MB**
- Storage Memory : (4096MB - 300MB) * 0.6 * 0.5 = **1139MB**
- Execution Memory : (4096MB - 300MB) * 0.75 * (1 - 0.5) = **1139MB**


## memoryOverhead 옵션
- `spark.executor.memory` 옵션으로 executor에 할당한 메모리와는 별개로 executor에 추가적으로 할당되는 메모리이다.
- `spark.executor.memoryOverhead` 옵션으로 설정 가능하며 최소값이 384 MiB이다. (즉, 384 MiB보다 적게 설정한 경우 강제로 384 MiB로 설정됨)
- 즉, `spark.executor.memory` 값을 1g로 설정했다면 실제로 executor에 할당되는 메모리는 1g + 384MiB 이다.
- VM overheads, interned strings, other native overheads 등을 위해 사용되는 메모리로 non heap에 해당한다. (즉, gc 대상이 아님, off-heap을 포함함)
- parquet 등 서드파티 라이브러리에서 off-heap 영역을 사용하는 경우 off-heap이 부족하여 OOM이 발생, memoryOverhead를 늘리라는 에러로그가 남는 경우가 있다. 이 경우엔 상기 옵션으로 memoryOverhead를 늘려주는 것으로 조치 가능하다.
- 관련 Configuration 설정
  - https://spark.apache.org/docs/latest/configuration.html#application-properties



<br>

## Reference
- https://medium.com/analytics-vidhya/apache-spark-memory-management-49682ded3d42
- http://jason-heo.github.io/bigdata/2020/10/24/understanding-spark-memoryoverhead-conf.html
