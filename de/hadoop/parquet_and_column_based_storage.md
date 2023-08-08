# Column-based Storage

## 로우 기반 vs 칼럼 기반

### 로우 기반 스토리지

데이터는 로우(row)나 칼럼(column) 기반으로 저장될 수 있다. 로우 기반은 로우의 모든 칼럼이나 필드가 함께 저장된다.
로우 기반 스토리지는 CRUD(Create, Read, Update, Delete)를 수행하는 어플리케이션에 최적화되어 있다.
이러한 애플리케이션은 한 번에 하나의 로우만 처리한다.

하지만 로우 기반 저장 방식은 분석 애플리케이션에서 효율적이지 않다.
데이터세트의 칼럼을 위주로 사용하며, 다수 로우의 일부 칼럼들만 읽고 분석하기 때문이다.
모든 칼럼들을 읽는 것은 메모리와 CPU, 디스크 IO를 불필요하게 소모한다.

또한, 로우 기반 저장 방식은 데이터를 효율적으로 압축할 수 없다.
레코드는 서로 다른 타입의 칼럼드로 구성될 수 있으므로 로우의 복잡성이 높다.
압축 알고리즘은 이종의 데이터에서 잘 동작하지 않기 때문에 칼럼 기반에 비해 파일이 클 수 밖에 없다.


### 칼럼 기반 스토리지

반면 칼럼 기반은 데이터를 칼럼으로 저장한다.
칼럼의 모든 셀은 디스크에 연속적을 저장된다.

칼럼 기반 스토리지는 분석 애플리케이션에서 보다 효과적이고 더 빠른 분석이 가능하며 더 적은 디스크 공간을 차지한다.


![file_format_rowbased_vs_columnbased](https://github.com/dhkdn9192/data_engineer_should_know/blob/master/de/hadoop/img/file_format_rowbased_vs_columnbased.png)


## RCFile
RCFile은 하이브 테이블을 저장하기 위해 HDFS에 구현한 첫 번째 칼럼 기반 저장 방식이다.
테이블을 로우 그룹들로 분할한 후 각 로우 그룹을 칼럼 형식으로 저장한다. 이 때, 로우 그룹들은 클러스터에 분산되어 저장된다.

RCFile은 하둡 맵리듀스와 잘 어울린다. 로우 그룹들이 클러스터에 분산 저장되기 때문에 병렬로 처리할 수 있으며,
노드의 각 로우들은 칼럼 기반으로 저장되어 있으므로 효과적인 압축과 빠른 분석이 가능하다.


## ORC (Optimized Row Columnar)
ORC는 구조화된 데이터를 저장하는 효율적인 방식의 칼럼 기반 파일 형식이다.
쿼리 수행 시 로우를 빠르게 검색할 수 있는 로우 인덱스를 제공하며,
데이터 타입에 기반한 블록모드 압축으로 보다 높은 압축 기능을 제공하는 등 RCFile 이상의 이점을 가지고 있다.
단 범용 스토리지 포맷인 Parquet와 달리 Hive에 특화되어 있어 Impala, Spark 등 다른 쿼리 엔진에서 사용하기엔 적절하지 않다.


## Parquet
하둡 에코시스템을 위해 설계된 칼럼 기반 저장 방식으로, 하둡 맵리듀스와 스파크를 비롯해 어떤 종류의 데이터 처리 프레임워크와도 호환된다.

복잡한 중첩 데이터 구조를 지원하도록 설계되어 있으며, 다양한 데이터 인코딩 방식과 압축 기술을 지원하고,
각 칼럼에 대해 특정 압축 스키마를 사용할 수도 있다.

### concept

- **Block** (hdfs block) : Parquet에서 말하는 블록은 HDFS의 블록을 의미한다. (file format은 HDFS에서 동작하기 위해 설계됨)
- **File** : HDFS 파일은 반드시 메타데이터를 포함한다. 단 실제 데이터는 반드시 가질 필요는 없다.
- **Row group** : 데이터의 row들을 논리적으로 수평 파티셔닝한 것. (물리적인 구조는 아님) row group은 각 칼럼의 column chunk들로 구성된다.
- **Column chunk** : 특정 칼럼의 데이터 청크를 의미한다. 특정 row group에 있으며 파일에서 연속적이다.
- **Page** : column chunk는 여러 페이지로 구성된다. 페이지는 개념상 더이상 나눠지지 않는 단위다.  

계층적으로 보면, file은 하나 이상의 row group들로 구성된다. 
row group에는 칼럼당 한 column chunk가 포함된다.
column chunk는 하나 이상의 page로 구성된다.

![parquet_architecture](https://github.com/dhkdn9192/data_engineer_should_know/blob/master/de/hadoop/img/parquet_architecture.png)



## Reference
- 도서 "스파크를 활용한 빅데이터 분석", 비제이퍼블릭, 모하마드 굴러
- https://www.dremio.com/resources/guides/intro-apache-parquet/
- https://parquet.apache.org/docs/concepts/
