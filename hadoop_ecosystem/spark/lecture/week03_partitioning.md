# Partitioning


키-밸류 쌍들을 그룹화하면 같은 키의 데이터는 같은 노드로 모이게 된다.
이 때 Spark은 어느 키를 어느 노드로 이동시킬지 어떻게 결정할까? 
정답은 바로 Partition에 있다.

## 1. Properties of Partitions

RDD의 데이터들은 여러 Partition들에 분산되어 있다.

- 파티션은 여러 노드에 걸쳐 있지 아니한다. 즉, 같은 파티션에 존재하는 데이터는
같은 노드 안에 있다는 것이 보장된다.
- 각 노드는 최소한 하나 이상의 파티션을 갖느다.
- 기본적으로 파티션의 수는 클러스터의 총 코어수로 지정되며 원하는 수로 조정할 수도 있다.

Spark에서 Partitioning의 종류는 다음 2가지이다.

- Hash partitioning
- Range partitioning

(<b>중요</b>) <b>Partitioning의 커스터마이징은 오직 Pair RDD에서만 가능</b>하다 (키가 있어야 하므로!!)

## 2. Hash Partitioning

### 2.1 Basic Concept

예제와 함께 알아보자. 주어지는 Pair RDD는 반드시 그룹화되어 있어야한다.

    val purchasesPerCust = purchasesRdd
        .map(p => (p.customerid, p.price))      // Pair RDD
        .groupByKey()
        
groupByKey는 먼저 각 (k, v) 튜플들에 대한 파티션 p를 계산한다.

    p = k.hashCode() % numPartitions
    
즉 Hash Partitioning은 키를 기반으로 데이터를 파티션들에 골고루 분배한다.

### 2.2 example

Pair RDD의 키가 \[8, 96, 240, 400, 401, 800\]이고 파티션의 개수는 4개이다.
그리고 hashCode() 함수는 n.hashCode() == n이라 가정한다.
Pair RDD의 키는 아래와 같이 파티셔닝될 것이다.

    partition 0: [8, 96, 240, 400, 800]
    partition 1: [401]
    partition 2: []
    partition 3: [] 

## 3. Range Partitioning 

### 3.1 Basic Concept

Pair RDD의 키는 정렬 가능한 값을 가질 수 있다. (ex. Int, Char, String, ...)
이러한 경우엔 Range Partitioning이 효과적이다.

Range Partitioner를 사용하면 키는 다음에 따라 파티셔닝된다.

- an ordering for keys
- a set of sorted ranges of keys

Range Partitioning에선 키의 range가 같은 튜플들이 같은 노드에 모이게 된다.

### 3.2 example

Pair RDD의 키가 \[8, 96, 240, 400, 401, 800\]이고 파티션의 개수는 4개이다.
또한 다음과 같이 가정한다.

- 모든 키가 양수이다.
- 키의 최대값은 800이다.
- Set of Ranges: \[1 , 200], \[201 , 400], \[401 , 600], \[601 , 800]

Pair RDD의 키는 아래와 같이 파티셔닝될 것이다.

    partition 0: [8, 96]
    partition 1: [240, 400]
    partition 2: [401]
    partition 3: [800] 

## 4. Partitioning Data

### 4.1 How to Partitioning Data

특정한 파티셔너를 사용하여 RDD를 생성하는 방법은 2가지가 있다.

- 특정 Partitioner를 제공하여 RDD에 대해 <b>artitionBy</b>를 호출하는 방법
- 특정 Partitioner가 적용된 RDD를 반환하는 <b>transformation</b>을 사용하는 방법  

### 4.2 partitionBy

partitionBy는 사용할 파티셔너를 정하여 입력해주어야한다.
아래는 RangePartitioner를 지정하여 partitionBy를 사용하는 예시이다.
파티션의 개수는 8개이다. 
(파티셔닝을 수행하는 <b>partitionBy 직후에 persist가 호출되어야하는 점</b>을 잊지 말 것!)

    val pairs = purchasesRdd.map(p => (p.customerld, p.price))
    val tunedPartitioner = new RangePartitioner(8, pairs)
    val partitioned = pairs.partitionBy(tunedPartitioner).persist()

RangePartitioner를 생성하려면 아래 조건들을 갖추어야 한다.

- 할당할 파티션의 개수를 지정해야 한다.
- 정렬된 키를 갖는 Pair RDD를 제공해야 한다. 이 RDD를 샘플링하여 정렬된 범위 집합을 생성하게 된다.

(<b>중요</b>) <b>partitionBy의 결과는 반드시 persist</b>되어야 한다.
그러지 않으면 파티셔닝되는 RDD가 사용될 때마다 파티셔닝이 반복적으로 수행될 것이다.
즉, shuffling이 반복적으로 일어난다.

### 4.3 Partitioning Data Using Transformations

#### Partitioner from parent RDD:

이미 파티셔닝된 RDD에 transformation이 적용되어 만들어진 Pair RDD는 기본적으로
<b>hash partitioner</b>를 사용하도록 설정되어있다.

#### Automatically-set Partitioner:

RDD에 대한 일부 연산들은 자동으로 잘 알려진 파티셔너를 사용하여 RDD를 만든다.

예를들어 sortByKey는 RangePartitioner를 사용한다.
반면 groupByKey는 앞서 살펴본대로 HashPartitioner를 사용한다.

파티셔너를 유지/전파하는 Pair RDD 연산들은 다음과 같다.

    - cogroup                   - foldByKey
    - groupWith                 - combineByKey
    - join                      - partitionBy
    - leftOuterJoin             - sort
    - rightOuterJoin            - mapValues (if parent has partitioner)
    - groupByKey                - flatMapValues (if parent has partitioner)
    - reduceByKey               - filter (if parent has partitioner)
    
(<b>주의</b>) <b>위의 연산들 외 나머지 연산들은 파티셔너 없이 결과를 생성한다.</b>
왜일까?

### 4.4 mapValues

hash partitioner로 파티셔닝된 Pair RDD에 map을 적용한다고 가정해보자.
이 경우 파티셔너가 유실된다. 왜냐하면 <b>map에 의해 키가 바뀔 수 있기 때문</b>이다.

    rdd.map((k: String, v: Int)=> ("doh!", v))
    
따라서 파티셔닝된 Pair RDD에 대해 map 연산을 수행하고 싶다면 <b>mapValues</b>를 사용해야 한다.
mapValues는 키를 변경하지 않고 map transformation을 수행하며
따라서 파티셔너도 보존된다.
