# Distributed Key-Value Pairs (Pair RDDs)

## 1. Distributed Key-Value Pairs


#### 1.1 빅데이터와 키-밸류 쌍

- single-node Scala에서 키-밸류 쌍은 <b>map</b>과 유사하다. Python에서 딕셔너리의 역할과도 비슷하다.
- map / dictionary는 대부분의 언어에서 지원하지만 single-node 프로그램에선 list / array만큼 범용적이진 않다.
- 빅데이터 프로세싱에선 데이터를 <b>키-밸류 쌍</b> 형태로 처리하는 것이 가장 보편적이다.
    - MapReduce의 핵심이 바로 이 키-밸류 쌍이다
- 헤아릴 수 없을 만큼 방대하고 복잡한 데이터를 처리하는 가장 바람직한 방법은 
데이터를 키-밸류 쌍의 형태로 project down시키는 것이다.    


#### 1.2 Spark의 Pair RDDs

- 정의: Spark에선 <b>"분산된 키-밸류 쌍"</b> 데이터를 <b>"Pair RDDs"</b>라고 부른다.
    - 분산된 데이터를 처리할 땐 데이터를 키-밸류 쌍으로 변환하는 것이 바람직하다.
- 장점: Pair RDDs는 네트워크에 걸쳐서 데이터를 <b>parallel</b>하게 처리할 수 있으며 
<b>regroup</b>시킬 수도 있다.
- Pari RDDs는 데이터를 키와 관련지어 처리하는데 특화된 메소드들을 제공한다.

Pair RDDs의 형태

    RDD[(K, V)]

Pair RDDs example

    case class Property(street: String, city: String, state: String)
    
    RDD[(String, Property)]


## 2. Pair RDDs (Key-Value Pairs)

Spark에서 키-밸류 쌍은 일반적으로 Pair RDDs를 의미한다.

#### 2.1 Pair RDDs 메소드

Pair RDDs(예: RDD\[(K, V)])를 위한 주요 메소드들은 아래와 같다.

    def groupByKey(): RDD[(K, Iterable[V])]
    def reduceByKey(func: (V, V) => V): RDD[(K, V)]
    def join[W](other: RDD[(K, W)]): RDD[()]

#### 2.2 Pair RDDs 만들기

Pair RDDs는 보통 이미 만들어진 non-pair RDDs로부터 만들어진다. 다음의 예시를 보자

    val rdd: RDD[WikipediaPage] = ...
    
    val pairRdd = rdd.map(page => (page.title, page.text)): RDD[(String, String)]

Pair RDDs를 생성했다면 reduceByKey, groupByKey, join 등 키-밸류 쌍에 특화된 transformations를 사용할 수 있다.
 