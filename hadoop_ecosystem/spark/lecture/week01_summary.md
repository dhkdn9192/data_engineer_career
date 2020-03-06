# Week02 - Summary

1. Shared Memory Data Parallelism (SDP)와 Distributed Data Parallelism (DDP)의 공통점과 차이점은 무엇인가?

```
데이터를 병렬적으로 처리한다는 점은 동일하나, SDP의 경우 단일 머신의 메모리 안에서(멀티코어/멀티프로세서) 병렬 처리가 이루어지고, 
DDP의 경우 여러 노드/머신에 나눠서 처리함. DDP의 경우 네트워크 비용이 발생하게 되며, latency를 해결해야 함
```

2. 분산처리 프레임워크 Hadoop의 Fault Tolerance는 DDP의 어떤 문제를 해결했나요?

  Hadoop의 Fault Tolerance는 DDP의 문제 중 Partial Failure를 해결했음. 
  여러 노드 중 한 노드에 이상이 생겨도, 다른 노드로 같은 데이터를 전달시킨 후 작업시켜서 성공할때까지 시도함으로써, 작업의 안정성을 보장함
  - Partial Failure : crash failures of a subset of the machines involved in a distributed computation

### 3. Spark가 하둡과 달리 데이터를 메모리에 저장하면서 개선한 것 무엇이고, 왜 메모리에 저장하면 그것이 개선이 되나요?

Hadoop에서는 발생 가능한 failure로부터 복구할 목적으로 모든 map, reduce 과정에서 데이터를 disk에 쓴다. 
반면 Spark에서는 disk 대신 in-memory를 이용, disk 쓰기 속도보다 in-memory가 100x 정도 빠르다

### 4. val ramyons = List("신라면", "틈새라면", "너구리")val kkodulRamyons = ramyons.map(ramyon => "꼬들꼬들 " + ramyon)kkodulRamyonsList.map()을 사용하여 ramyons 리스트에서 kkodulRamyon List를 새로 만들었습니다. kkodulRamyons랑 똑같이 생긴 List를 만드는 Scala 코드를 써주세요

val res = List("꼬들꼬들 신라면", "꼬들꼬들 틈새라면", "꼬들꼬들 너구리")

### 5. val noodles = List(List("신라면", "틈새라면", "너구리"), List("짜파게티", "짜왕", "진짜장"))val flatNoodles = noodles.flatMap(list => list)flatNoodlesList.flatmap()을 사용하여 noodles 리스트에서 flatNoodles List를 새로 만들었습니다. flatNoodles랑 똑같이 생긴 List를 만드는 Scala 코드를 써주세요

val res = List("신라면", "틈새라면", "너구리", "짜파게티", "짜왕", "진짜장")

### 6. val jajangs = flatNoodles.filter(noodle => noodle.contains("짜"))jajangsList.filter()를 사용하여 flatNoodles 리스트에서 jajangs List를 새로 만들었습니다.jajangs랑 똑같이 생긴 List를 만드는 Scala 코드를 써주세요

val res = List("짜파게티", "짜왕", "진짜장")

### 7. val jajangMenu = jajangs.reduce((first, second) => first +"," + second)jajangMenuList.reduce()를 사용하여 jajangs 리스트에서 jajangMenu String을 만들었습니다.jajangMenu랑 똑같이 생긴 String을 만드는 Scala 코드를 써주세요

val res = "짜파게티,짜왕,진짜장"

### 8. Eager execution와 Lazy execution의 차이점은 무엇인가요?

Lazy execution은 결과가 바로 계산되지 않음. 
Eager execution은 결과가 바로 계산됨. 
Spark 의 Transformation 는 lazy execution으로, RDD의 reference만 만들고, Action이 있을 경우에 실제로 수행함

- Eager execution : Spark Actions. Compute a result based on an RDD 
(result is immediately computed)
- Lazy execution : Spark Transformations. Return new RDDs as results
(result RDD is not immediately computed)
- ** Laziness / Eagerness is how we can limit network communication using the programming model!

### 9. Transformation과 Action의 결과물 (Return Type)은 어떻게 다를까요?

Transformation의 return type은 RDD, Action의 return type은 RDD가 아님.
연산에 대한 결과물 혹은 파일(e.g. HDFS)

### 10. RDD.cache()는 어떤 작동을 하고, 언제 쓰는 것이 좋은가?

evaluate된 RDD를 메모리에 저장하여 이후에 다시 사용할 수 있음. 
한 RDD를 여러 action의 input으로 쓸 때 이렇게 하면 중복 계산 작업을 막을 수 있다. 
특히 iteration 에서 반복적으로 사용되는 경우 메모리에 올려놓고 사용하는게 유리함.

### 11. Lazy Execution이 Eager Execution 보다 더 빠를 수 있는 예를 얘기해주세요.

Eager execution은 여러 단계의 연산을 수행 할 때, 한 단계씩 차례차례 진행하는 반면, lazy execution은 한번에 진행한다. 
Lazy execution 과정에서는 모든 단계를 고려한 최적화 작업이 자동으로 이루어지는데, 
그 과정에서 필요없는 연산은 생략 되는 등의 효과가 있기 때문에 각 단계를 무조건 수행하는 eager execution 보다 빠를 수 있다.
