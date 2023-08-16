# repartition과 coalesce의 차이점


## repartition
- repartition은 **무조건 전체 데이터에 대한 shuffle을 유발한다**.
- 때문에 파티션 수를 현재보다 늘리거나, 칼럼을 기준으로 파티션을 만드는 경우에만 사용해야 한다.
```scala
// 파티션 수를 지정
df.repartition(5)

// 특정 칼럼 기준으로
df.repartition(col("NAME"))

// 특정 칼럼 기준으로 파티션 수 지정
df.repartition(5, col("NAME"))
```


## coalesce
- coalesce는 전체 데이터를 shuffle하지 않고 파티션을 병합하는 경우에 사용한다.
```scala
df.repartition(5, col("NAME")).coalesce(2)
```
- repartition 메소드는 shuffle 옵션이 true로 설정된 coalesce 메소드를 호출한다.
```scala
  // https://github.com/apache/spark/blob/master/core/src/main/scala/org/apache/spark/rdd/RDD.scala (482 line)
  def repartition(numPartitions: Int)(implicit ord: Ordering[T] = null): RDD[T] = withScope {
    coalesce(numPartitions, shuffle = true)
  }
```



## Reference
- 도서 "스파크 완벽 가이드", 한빛미디어, 빌 체임버스, 마테이 자하리아 지음


