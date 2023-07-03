# Spark RDD vs DataFrame vs DataSet

## Basic concept

#### RDD
- Resilient Distributed Datasets
- It is Read-only partition collection of records. 
- in-memory computations on large clusters in a fault-tolerant manner. (speed up)

#### DataFrame
- Unlike an RDD, data organized into named columns. (For example a table in a relational database.)
- an immutable distributed collection of data. 
- impose a structure onto a distributed collection of data, allowing higher-level abstraction.

#### Dataset
- extension of DataFrame API 
- provides **type-safe**, **object-oriented** programming interface. 
- takes advantage of Spark’s Catalyst optimizer by exposing expressions and data fields to a query planner.


## Spark Release
| - | release |
| :--- | :---: |
| RDD | 1.0 |
| DataFrame | 1.3 |
| Dataset | 1.6 |

*Dataset does not support Python and R*


## DataFrame vs Dataset 비교

#### DataFrame
- DataFrame은 Dataset과 비교하여 "비타입형"에 속한다.
- 스키마에 명시된 데이터 타입 일치 여부를 **런타임**에 확인한다.
  - 만약 DataFrame에 존재하지 않는 칼럼에 접근하는 코드가 있다면 에러는 Runtime에 감지된다. DataFrame은 각 레코드가 Row 객체인 `Dataset[Row]` 제네릭 객체이기 때문.
- DataFrame은 각 레코드가 Row 타입으로 구성된 Dataset 즉 `Dataset[Row]` 제네릭 객체이다.
- Row 타입을 사용하면 JVM 데이터 타입이 아닌 자체 데이터 포맷을 사용하므로 GC, 객체 초기화에 더 효율적이다.


#### Dataset
- Dataset은 DataFrame과 비교하여 "타입형"에 속한다. (**type-safe**)
- 스키마에 명시된 데이터 타입 일치 여부를 **컴파일타임**에 확인한다.
  - 만약 Dataset에 존재하지 않는 칼럼에 접근하는 코드가 있다면 에러는 컴파일 시점에서 감지된다. 각 레코드에 대한 스키마가 case class로 정의되어 있으므로.
- Dataset의 데이터타입을 정의하려면 Scala에선 ```case class```를, Java에선 ```JavaBean```을 사용해야 한다.
- 따라서 Dataset은 JVM 기반 언어인 Scala와 Java에서만 사용 가능하다. (Python, R에선 사용 불가)


<br>


## Reference
- https://data-flair.training/blogs/apache-spark-rdd-vs-dataframe-vs-dataset/
- https://medium.com/@gignac.cha/rdd-dataset-dataframe-%EC%9D%98-%EC%B0%A8%EC%9D%B4%EA%B0%80-%EB%AD%94%EA%B0%80-149594d359a2
- 도서 "스파크 완벽 가이드", 한빛미디어, 빌체임버스, 메테이 자하리아 지음
