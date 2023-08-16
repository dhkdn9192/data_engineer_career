# Transformations and Actions on Pair RDDs

## 1. Pair RDDs의 주요 연산들

아래는 Pair RDDs의 중요한 연산들이다. non-pair RDDs에선 사용할 수 없다.

#### Transformations

- groupByKey
- reduceByKey
- mapValues
- keys
- joins
- leftOuterJoin / rightOuterJoin

#### Actions

- countByKey

## 2. Pair RDDs Transformation: groupByKey

#### 2.1 Scala's groupBy

먼저 Scala의 groupBy를 떠올려보자.
Scala의 groupBy는 주어진 discriminator function에 따라 입력 collection을 collection들의 map으로
partitioning하는 것이다. 정의는 아래와 같다.

    def groupBy[K](f: A => K): Map[K, Traversable[A]]
    
쉬운 이해를 위해 아래의 예시를 살펴보자

    // 나이들의 리스트를 연령대별로 그룹지어보자
    val ages = List(2, 52, 44, 23, 17, 14, 12, 82, 51, 64)
    
    val grouped = ages.groupBy{age => 
        if (age >= 18 && age < 65) "adult"
        else if (age < 18) "child"
        else "senior"
    }
    
    // grouped: scala.collection.immutable.Map[String, List[Int]] =
    // Map(senior -> List(82), adult -> List(52, 44, 23, 51, 64), 
    //     child -> List(2, 17, 14, 12))
    
    
#### 2.2 Spark's groupByKey

groupByKey는 Pair RDDs에 대한 groupBy라고 볼 수 있다.
즉, 같은 키를 갖는 값들끼리 그룹화하는 것이다.
따라서, groupByKey는 <b>argument를 갖지 않는다</b>

    def groupByKey(): RDD[(K, Iterable[V])]

example

    // organizer별로 budget 값들을 그룹화해보자
    case class Event(organizer: String, name: String, budget: Int)
    
    val eventsRdd = sc.parallelize( ... )
                      .map(event => (event.organizer, event.budget))
                      
    val groupedRdd = eventsRdd.groupByKey()
    
위 예시에서 키는 organizer이다. 여기서 groupByKey 호출은 무엇을 수행하는가?

!!!! <b>FAKE QUESTION</b> !!! transformation 연산이므로 아무것도 하지 않는다.
그저 unevaluated RDD를 반환할 뿐이다. (action이 아니면 아무것도 하지 않는다는 점에 늘 주의!!)

    groupedRdd.collect().foreach(println)
    // (Prime Sound, CompactBuffer(4200, 3000, 2000))
    // (Sportorg, CompactBuffer(123, 456, 789))
    // ...
    

## 3. Pair RDDs Transformation: reduceByKey

reduceByKey는 groupByKey와 reduce의 조합이라고 할 수 있다.

(중요) reduceByKey는 <b>두 연산을 각각 사용하는 것보다 reduceByKey를 사용하는 것이 보다 효율적</b>이다.

    def reduceByKey(func: (V, V) => V): RDD[(K, V)]

example

    // organizer별로 budget의 총합을 집계해보자
    case class Event(organizer: String, name: String, budget: Int)
    
    val eventsRdd = sc.parallelize( ... )
                      .map(event => (event.organizer, event.budget))
    
    val budgetsRdd = evnetsRdd.reduceByKey(_+_)
    
예시에서 보듯 reduceByKey는 단 한번의 호출로 groupByKey와 reduce를 모두 사용한 것과 같은 효과를 갖는다.
reduceByKey 연산이 적용되는 RDD는 Pair RDDs이며, 자동으로 같은 키를 갖는 값들에 대해 reduce를 수행한다.

    reducedRdd.collect().foreach(println)
    // (Prime Sound, 42000)
    // (Sportorg, 36400)
    // (Innotech, 320000)
    // (Association Bal€lec, 50000) 
    // ...

마찬가지로 transformation 연산이므로 호출된 시점에선 아무것도 수행하지 않는다는 점에 주의하라.

    
    
    