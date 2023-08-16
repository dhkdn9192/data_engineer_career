# RDD Custom Partitioning


## Custom Partitioning

- 사용자 정의 파티셔닝(custom partitioning)은 RDD를 사용하는 가장 큰 이유 중 하나이다.
- 사용자 정의 파티셔닝의 유일한 목표는 **데이터 치우침(skew)** 문제를 피하기 위해 클러스터 전체에 데이터를 균등하게 분배하는 것이다.
- 사용자 정의 파티셔닝을 사용하려면 DataFrame 또는 Dataset을 RDD로 변환한 다음, 파티셔닝을 적용한 후에 다시 DataFrame 또는 Dataset으로 변환해야 한다.



## Sample Code



HashPartitioner 또는 RangePartitioner와 같은 내장형 파티셔너를 사용하는 예제

```scala
import org.apache.spark.HashPartitioner

val df = spark.read.option("header", "true").option("inferSchema", "true").csv("...")
val rdd = df.coalesce(10).rdd

rdd.map(r => r(6)).take(5).foreach(println)
val keyedRDD = rdd.keyBy(row => row(6).asInstanceOf[Int].toDouble)

keyedRDD.partitionBy(new HashPartitioner(10)).take(10)
```



## Reference

- 도서 "스파크 완벽 가이드", 한빛미디어, 빌 체임버스, 마테이 자하리아 지음

