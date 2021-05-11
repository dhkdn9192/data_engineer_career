# How to access first n rows in Spark

Spark Dataset의 주요 함수 ```limit(n)```, ```head(n)```, ```first()```, ```take(n)``` 비교하기


### limit(n)
- 상위 n개 Row를 갖는 **새로운 Dataset을 반환**한다. (```org.apache.spark.sql.Dataset[...]```)
- 호출돼도 바로 연산이 실행되지 않는 **transformation 함수**
- 예시
  ```scala
  val df = sc.parallelize(Seq((1,"hello"), (2,"world"),(3, "haha"))).toDF("no", "word")
  
  df.limit(2)
  // res35: org.apache.spark.sql.Dataset[org.apache.spark.sql.Row] = [no: int, word: string]
  ```

### head(n)
- **상위 n개 Row를 반환**한다. (```Array[org.apache.spark.sql.Row]```)
- 입력값이 없을 경우엔 단일 Row를 반환한다. (```org.apache.spark.sql.Row```)
- 호출 즉시 연상이 수행되는 **action 함수**
- 실행하면 내부적으로 head가 호출되는 함수: first(), take()
- 예시
  ```scala
  val df = sc.parallelize(Seq((1,"hello"), (2,"world"),(3, "haha"))).toDF("no", "word")
  
  df.head(2)
  // res33: Array[org.apache.spark.sql.Row] = Array([1,hello], [2,world])
  
  df.head()
  // res34: org.apache.spark.sql.Row = [1,hello]
  ```

### first()
- 최상위 Row를 반환한다.
- **head()와 동일**하다.


### take(n: Int)
- 상위 n개 Row를 반환한다.
- **head(n)과 동일**하다.



### limit(n) vs head(n)
- head(n)는 action 함수로 실제 데이터 배열을 반환한다.
- limit(n)는 transformation 함수로 새로운 Dataset을 반환한다.
- head(n)는 n이 과도하게 클 경우 driver 프로세스에서 ```OutOfMemory```가 발생할 수 있다.


### summary

| method | description |
| --- | --- |
| limit(n) | return Dataset |
| head(n) | return Array of Row |
| first() | alias for head() |
| take(n) | alias for head(n) |


<br>

## Reference
- https://stackoverflow.com/questions/46832394/spark-access-first-n-rows-take-vs-limit
- https://stackoverflow.com/questions/35869884/more-than-one-hour-to-execute-pyspark-sql-dataframe-take4/35870245#35870245
- https://stackoverflow.com/questions/45138742/apache-spark-dataset-api-headnint-vs-takenint
- https://spark.apache.org/docs/latest/api/scala
