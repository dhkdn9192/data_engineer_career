# Week03 - Summary


### 1. 셔플링은 무엇이고 언제 발생하나요? 

네트워크를 통해 노드 간 데이터가 이동하는 것. groupByKey나 reduceByKey 등의 transformation 함수로 인해 발생할 수 있다.

### 2. 파티션은 무엇인가요? 파티션의 특징을 2가지 알려주세요. 

Pair RDD에서 키 조건이 맞는 데이터들을 모으는 단위를 파티션이라 한다.
파티션은 여러 노드에 걸쳐있지 않으며 한 노드는 최소 하나 이상의 파티션을 갖는다.
즉 같은 파티션에 존재하는 데이터는 같은 노드에 존재함을 보장한다.
파티션의 수는 조정 가능하며 기본적으론 클러스터 전체의 코어 수만큼으로 설정된다.

### 3. 스파크에서 제공하는 partitioning 의 종류 두가지를 각각 설명해주세요. *

Hash Partitioning은 키의 해쉬값에 파티션 수를 모듈러연산한 결과가 같도록 파티셔닝하는 방법이다.
Range Partitioning은 키 값의 범위가 맞는 것끼리 묶는 파티셔닝 방법이다.

### 4. 파티셔닝은 어떻게 퍼포먼스를 높여주나요?

키에 따라 각 데이터를 어느 파티션에 할당해야하는지 알 수 있다.
즉 shuffle이 발생하게 되는 경우, 데이터들이 이미 키에 따라 파티셔닝이 되어있다면 데이터가 지역적으로만 이동하여 shuffle의 발생을 줄일 수 있다.

### 5. rdd 의 toDebugString 의 결과값은 무엇을 보여주나요? 

RDD의 lineage를 시각화한 문자열을 보여준다.

### 6. 파티션 된 rdd에 map 을 실행하면 결과물의 파티션은 어떻게 될까요? mapValues의 경우는 어떤가요?

각 데이터의 키가 변경되어 기존 파티션 정보를 잃게된다.
mapValues는 키를 변경하지 않으므로 파티션이 유지된다.

### 7. Narrow Dependency 와 Wide Dependency를 설명해주세요. 각 Dependency를 만드는 operation은 무엇이 있을까요?

Narrow Dependency는 parent partition과 child partition의 관계가 1대1로 shuffle을 유발하지 않는다. map, union, pre-partitioned된 join 등의 연산이 해당한다.
Wide Dependency는 parent partition이 둘 이상의 child partition에 의존성을 가지며 shuffle을 유발한다. groupByKey, reduceByKey, pre-partitioned되지 않은 join 등이 해당한다.

### 8. Lineage 는 어떻게 Fault Tolerance를 가능하게 하나요?

RDD는 불변성을 지니며 RDD로 DAG를 구성하는 Lineage는 재사용이 가능하다. Lineage의 수행 결과는 반복되더라도 같은 출력이 나오는 것을 보장한다. 따라서 특정 파티션 지점에서 partial failure가 발생하더라도 해당 Lineage의 연산을 처음부터 다시 수행하면 partial failure가 발생한 지점으로 다시 연산된 데이터 결과가 전달된다.


