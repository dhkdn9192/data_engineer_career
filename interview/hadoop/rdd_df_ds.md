# Spark RDD vs DataFrame vs DataSet

## Basic concept

- <b>RDD APIs</b>
  - Resilient Distributed Datasets
  - It is Read-only partition collection of records. 
  - in-memory computations on large clusters in a fault-tolerant manner. (speed up)
- <b>Dataframe APIs</b>
  - Unlike an RDD, data organized into named columns. (For example a table in a relational database.)
  - an immutable distributed collection of data. 
  - impose a structure onto a distributed collection of data, allowing higher-level abstraction.
- <b>Dataset APIs</b>
  - extension of DataFrame API 
  - provides <b>type-safe</b>, <b>object-oriented</b> programming interface. 
  - takes advantage of Spark’s Catalyst optimizer by exposing expressions and data fields to a query planner.


## Spark Release
- RDD: 1.0 release.
- DataFrames: 1.3 release.
- DataSet: 1.6 release. (Spark version 2.1.1 does not support Python and R)


## Data Representation
- RDD: a distributed collection of data elements spread across many machines in the cluster. RDDs are a set of Java or Scala objects representing data.
- DataFrame: a distributed collection of data organized into named columns. It is conceptually equal to a table in a relational database.
- DataSet: an extension of DataFrame API that provides the functionality of <b>type-safe</b>, <b>object-oriented</b> programming interface of the RDD API and performance benefits of the <b>Catalyst query optimizer</b> and <b>off heap storage mechanism</b> of a DataFrame API.

## Summary
DataFrame이 Spark 1.3에서 등장한 이후, 1.6에서 이를 더욱 확장한 Dataset이 나오게 되었다.
둘 다 schema를 갖는 구조화/반구조화된 데이터를 다룰 수 있으며 catalyst를 통한 최적화가 가능하다.
데이터를 표현하는 방법에서 Dataset이 Row로 데이터들을 감싼다는 점에서 차이가 있으며 Spark 2.0에선 이 둘이 통합되어
DataFrame = Dataset\[Row\] 로 나타낼 수 있다.
다만 Dataset의 api들은 최근까지도 Python, R 등의 언어로는 제공이 되지 않는다.

## Reference
- https://data-flair.training/blogs/apache-spark-rdd-vs-dataframe-vs-dataset/
- https://medium.com/@gignac.cha/rdd-dataset-dataframe-%EC%9D%98-%EC%B0%A8%EC%9D%B4%EA%B0%80-%EB%AD%94%EA%B0%80-149594d359a2
