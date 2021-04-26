# PySpark에서 UDF를 효율적으로 사용하려면



<br>



## Spark User-Defined Functions (UDFs)

Scala, Python, Java 언어로 커스텀 함수를 만들어 사용할 수 있다. Spark SQL은 원하는 프로그래밍 언어로 만든 함수를 입력함으로써 UDF를 등록할 수 있도록 지원한다. 

Scala와 Python은 네이티브 함수와 람다식을 사용할 수 있다. Java는 UDF 클래스를 상속받아야 한다.

UDF는 다양한 데이터 타입을 사용할 수 있고 반환값 역시 다양한 타입으로 지정할 수 있다. Python과 Java에선 반환값의 타입을 반드시 명시해야 한다.

```scala
def time1000(field):
	return field * 1000.00

spark.udf.register("UDF_NAME", time1000, returnType())
```



<br>



## UDF with Distributed mode

분산환경에서 Spark은 master/slave 구조로 동작하며 driver가 분산된 다수의 executor와 상호작용한다. driver와 executor는 각자 자신의 Java 프로세스(JVM)를 동작시킨다.

driver는 main() 함수를 실행하고 SparkContext, RDD를 생성하여 transformation/action 연산을 수행한다. executor는 각자 주어진 task를 실제로 수행한다.

PySpark Job이 동작할 때 UDF를 호출할 경우, UDF가 어떤 언어로 작성되었느냐에 따라 Spark job의 성능이 달라진다.

- **Spark Scala UDF** : Scala는 Spark의 네이티브 언어이므로, JVM에서 동작 가능하도록 컴파일된다. 따라서 빠르게 프로세싱된다.
- **PySpark UDF** : 컴파일 과정은 Scala->Python->Scala 에 좌우된다. JVM은 UDF를 사용할 수 있도록 변환하기 위해 Serialization/Deserialization 과정을 거쳐 JVM 외부의 Python 프로세스와 통신해야 한다. 따라서 UDF 사용에 많은 비용이 든다.

![data_engineer_should_know/spark_udf_architecture.png at master · dhkdn9192/data_engineer_should_know (github.com)](https://github.com/dhkdn9192/data_engineer_should_know/blob/master/interview/hadoop/img/spark_udf_architecture.png)


<br>


## PySpark에서 Scala UDF 사용하기

1. Spark SQL에서 사용하기 위해 아래와 같은 Scala UDF를 작성한다.

   ```scala
   import org.apache.spark.sql.SparkSession
   import org.apache.spark.ml.linalg.{Vector, Vectors}
   import org.apache.spark.sql.functions.udf
   import org.apache.spark.sql.expressions.UserDefinedFunction
   import math.log
   
   object FeatureUDFs {
   
   	def logFeatures(a: Vector): Vector = {
   	    Vectors.dense(a.toArray.map(x => log(x + 1.0))).toSparse
   	  }
   	  
     	def logFeaturesUDF: UserDefinedFunction = udf(logFeatures _ )
   	  
     	def registerUdf: UserDefinedFunction = {
     		val spark = SparkSession.builder().getOrCreate()
     		spark.udf.register("logFeatures", (a: Vector) => logFeatures(a))
     }
   	  
   }
   ```

2. 작성한 Scala 코드를 sbt, gradle 등으로 컴파일하여 .jar 파일을 생성한다.

3. 생성한 .jar 파일을 ```$SPARK_HOME/jars``` 경로에 복사한다.

4. PySpark 코드에서 위의 Scala UDF를 등록하면 Spark SQL에서 사용할 수 있다.

   ```python
   from pyspark.sql import SparkSession
   spark = SparkSession.builder.getOrCreate()
   
   # calling our registerUdf function from PySpark 
   spark.sparkContext._jvm.FeatureUDFs.registerUdf()
   
   # then access via SparkSQL
   df = spark.sql("""
   SELECT
       logFeatures(features) AS log_features
   FROM
       df
   """)
   df.show(2)
   
   +----------------------------------------------+
   | log_features                                 |
   +----------------------------------------------+
   |[5.0, 2.57, 3.67, 3.18, 4.09, 4.07, 3.67, 5.5]|
   |[4.29, 4.65, 5.07, 5.21, 3.5, 4.42, 2.4, 4.14]|
   +----------------------------------------------+
   ```

5. 또는 아래와 같이 PySpark API를 통해 UDF를 사용할 수도 있다.

   ```python
   from pyspark.sql import SparkSession
   from pyspark.sql.column import Column, _to_java_column, _to_seq 
   
   spark = SparkSession.builder.getOrCreate()
   
   def log_features_scala_udf(feature_vector): 
       logFeaturesUDF = spark._jvm.FeatureUDF.logFeaturesUDF() 
       return Column(logFeaturesUDF.apply(_to_seq(spark.sparkContext, [feature_vector], _to_java_column)))
   
   df = df.select(log_features_scala_udf("features").alias("log_features"))
   df.show(2)
   
   +----------------------------------------------+
   | log_features                                 |
   +----------------------------------------------+
   |[5.0, 2.57, 3.67, 3.18, 4.09, 4.07, 3.67, 5.5]|
   |[4.29, 4.65, 5.07, 5.21, 3.5, 4.42, 2.4, 4.14]|
   +----------------------------------------------+
   ```

   

<br>



## Reference

- https://medium.com/quantumblack/spark-udf-deep-insights-in-performance-f0a95a4d8c62
- http://grahamflemingthomson.com/scala_udfs

