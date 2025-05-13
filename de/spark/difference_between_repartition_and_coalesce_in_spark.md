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


## Spark SQL에서 repartition vs coalesce 선택하기
- Spark SQL에서 small file write 수를 줄이기 위해 `/*+ REPARTITION(n) */` 또는 `/*+ COALESCE(n) */` 힌트를 사용할 때 repartition이 더 나은 성능을 보이기도 한다.

### Coalesce가 느릴 수 있는 이유
- **불균형 처리**
  - Coalesce는 기존 파티션을 줄이는 것만 목표로 하기 때문에 데이터가 한쪽 파티션으로 편향될 가능성이 큽니다.
  - Coalesce로 1개의 파티션으로 만들면, 기존 여러 Executor가 처리하던 것을 1개의 Task가 독점하게 됩니다.
  - 병렬성이 완전히 사라지고 하나의 CPU 코어에서 처리하니 속도가 매우 느려질 수 있음.
- **원래 데이터 레이아웃에 의존**
  - Coalesce는 데이터를 최소한으로 이동시키려고 해서 기존 물리적 데이터 배치에 따라 성능이 달라집니다.
  - 만약 데이터가 처음부터 균등하지 않은 상태라면, Coalesce는 불균형을 더 악화시킬 수 있습니다.
- **Task 수가 줄어 I/O 병목 발생**
  - 하나의 Task만 결과를 쓴다면, 네트워크, 디스크 I/O가 직렬화되어 전체 처리시간이 급격히 증가합니다.
  - 특히 HDFS는 다수의 Block을 동시에 쓰는 게 빠른데, 단일 Task는 이를 활용 못 함.

### Repartition이 더 빠를 수 있는 이유
- **균등 분산 및 병렬성 유지**
  - Repartition은 데이터를 전체적으로 섞어서 분산시켜 균등한 파티션을 생성합니다.
  - 1개로 줄이더라도 1개의 파티션을 만드는 작업은 여러 Executor가 병렬로 수행할 수 있어 처리 속도가 빠릅니다.
    - 예) 100개의 Executor가 1개의 파티션을 만드는 작업을 병렬로 나눠 수행한 뒤 최종적으로 하나로 합치는 식.
- **셔플 오버헤드 vs 직렬화 오버헤드**
  - 셔플이 비싸긴 해도, 직렬화된 Task 하나가 모든 데이터를 처리하는 비효율보단 나을 수 있습니다.
  - 특히 데이터량이 크다면 셔플의 비용 < 단일 Task의 병목 이 되는 경우가 자주 발생합니다.



## Reference
- 도서 "스파크 완벽 가이드", 한빛미디어, 빌 체임버스, 마테이 자하리아 지음


