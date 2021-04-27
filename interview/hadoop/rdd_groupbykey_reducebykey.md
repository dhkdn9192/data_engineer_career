# RDD Aggregation : groupByKey vs reduceByKey



key-value 형태를 갖는 PairRDD는 키를 기준으로 데이터를 집계할 수 있다. PairRDD의 집계 함수 중 groupByKey와 reduceByKey는 기능은 유사하지만 성능에 있어서 매우 큰 차이를 갖는다.

비교를 위해 아래와 같이 key-value 형태의 PairRDD(KVcharacters)를 만든다.

```scala
val myCollection = "Spark The Definitive Guide : Big Data Processing Made Simple".split(" ")
val words = spark.sparkContext.parallelize(myCollection, 2)

// myCollection: Array[String] = Array(Spark, The, Definitive, Guide, :, Big, Data, Processing, Made, Simple)
// words: org.apache.spark.rdd.RDD[String] = ParallelCollectionRDD[10] at parallelize at <console>:26
```

```scala
val chars = words.flatMap(word => word.toLowerCase.toSeq)
val KVcharacters = chars.map(letter => (letter, 1))

def maxFunc(left: Int, right: Int) = math.max(left, right)
def addFunc(left: Int, right: Int) = left + right

val nums = sc.parallelize(1 to 30, 5)

// chars: org.apache.spark.rdd.RDD[Char] = MapPartitionsRDD[13] at flatMap at <console>:29
// KVcharacters: org.apache.spark.rdd.RDD[(Char, Int)] = MapPartitionsRDD[14] at map at <console>:30
// maxFunc: (left: Int, right: Int)Int
// addFunc: (left: Int, right: Int)Int
// nums: org.apache.spark.rdd.RDD[Int] = ParallelCollectionRDD[15] at parallelize at <console>:35
```

```scala
KVcharacters.collect()

// res11: Array[(Char, Int)] = Array((s,1), (p,1), (a,1), (r,1), (k,1), (t,1), (h,1), (e,1), (d,1), (e,1), (f,1), (i,1), (n,1), (i,1), (t,1), (i,1), (v,1), (e,1), (g,1), (u,1), (i,1), (d,1), (e,1), (:,1), (b,1), (i,1), (g,1), (d,1), (a,1), (t,1), (a,1), (p,1), (r,1), (o,1), (c,1), (e,1), (s,1), (s,1), (i,1), (n,1), (g,1), (m,1), (a,1), (d,1), (e,1), (s,1), (i,1), (m,1), (p,1), (l,1), (e,1))
```





<br>



## groupByKey

```scala
KVcharacters.groupByKey().map(row => (row._1, row._2.reduce(addFunc))).collect()

// res8: Array[(Char, Int)] = Array((d,4), (p,3), (t,3), (b,1), (h,1), (n,2), (f,1), (v,1), (:,1), (r,2), (l,1), (s,4), (e,7), (a,4), (k,1), (i,7), (u,1), (o,1), (g,3), (m,2), (c,1))
```

- groupByKey를 사용하면 모든 executor에서 함수를 적용하기 전에 **키와 관련된 모든 값을 메모리로 읽어들여야** 한다. 
- 이 경우, 크게 치우쳐진 키가 있다면(skewness) **일부 파티션에 값이 몰려서 OutOfMemory**가 발생할 수 있다.
- 따라서 groupByKey는 각 키에 대한 값의 크기가 일정하고 executor 메모리에서 처리 가능한 수준일 경우에만 사용해야 한다.
- 보통 groupByKey의 대안으로 reduceByKey를 사용한다.



<br>



## reduceByKey

```scala
KVcharacters.reduceByKey(addFunc).collect()

// res13: Array[(Char, Int)] = Array((d,4), (p,3), (t,3), (b,1), (h,1), (n,2), (f,1), (v,1), (:,1), (r,2), (l,1), (s,4), (e,7), (a,4), (i,7), (k,1), (u,1), (o,1), (g,3), (m,2), (c,1))
```

- **노드 간 shuffle 전에 로컬에서 값들을 먼저 병합**하여 최종 리듀스에서 shuffle되는 데이터의 양을 줄인다. (MR의 combiner와 유사)
- 로컬에서의 병합은 파티션 수준에서의 리듀스 작업이다.
- 각 executor는 해당 키의 모든 값들을 메모리로 가져올 필요가 없으므로 연산이 안정적이고 빠르다.
- reduceByKey의 반환 RDD는 개별 요소들이 정렬되어 있지 않다.
- reduceByKey는 작업 부하를 줄이는데 적합하며, 결과의 순서가 중요한 작업에는 적합하지 않다.





<br>



## Reference

- 도서 "스파크 완벽 가이드", 한빛미디어, 빌 체임버스, 마테이 자하리아 지음
