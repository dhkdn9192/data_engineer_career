# Spark Join Strategy

Spark에서 join을 수행하는 경우는 크게 두 가지로 나눌 수 있다. (1) *큰 테이블과 작은 테이블을 조인* 또는 (2) *큰 테이블과 큰 테이블을 조인*. Spark은 join을 수행하기 위해 Sort Merge Join, Broadcast Join, Shuffle Hash Join 등의 방법을 제공한다. 

- 핵심 키워드 : ```sort merge join```, ```shuffle hash join```, ```broadcast join```, ```straggler``` 



<br>



## 1. Sort Merge Join



![data_engineer_should_know/sort_merge_join.png at master · dhkdn9192/data_engineer_should_know (github.com)](https://github.com/dhkdn9192/data_engineer_should_know/blob/master/interview/hadoop/img/sort_merge_join.png)



### 1-1. 개요

- 모든 노드 간의 **all-to-all communication** 방식이다.
- 다음과 같이 두 단계로 수행된다.
  - (1) 먼저 실제 join 작업을 수행하기 전에 파티션들을 정렬한다. (이 작업만으로도 비용이 크다)
  - (2) 정렬된 데이터들을 병합하면서 join key가 같은 row들을 join한다.
- Sort Merge Join은 Shuffle Hash Join과 비교할 때, 클러스터 내 데이터 이동이 더 적은 경향이 있다.

- Spark 2.3부터 디폴트 join 알고리즘으로 사용되고 있다. (```spark.sql.join.perferSortMergeJoin=true```)



### 1-2. 이상적인 성능을 발휘하려면

- Join될 파티션들이 최대한 같은 곳에 위치해야 한다. 그렇지 않으면 파티션들을 이동시키기 위해 대량의 shuffle이 발생한다.
- DataFrame의 데이터가 클러스터에 균등하게 분배되어 있어야 한다. 그렇지 않으면 특정 노드에 부하가 집중되고 연산 속도가 느려진다.
- 병렬처리가 이뤄지려면 일정한 수의 고유키가 존재해야 한다.



<br>



## 2. Broadcast Join



![data_engineer_should_know/broadcast_join.png at master · dhkdn9192/data_engineer_should_know (github.com)](https://github.com/dhkdn9192/data_engineer_should_know/blob/master/interview/hadoop/img/broadcast_join.png)



### 2-1. 개요

- join할 두 테이블 중 작은 것을 모든 executor에 복사(broadcast)한다.

- 따라서 all-to-all communication 방법으로 shuffle할 필요가 없다.

- 각 executor에선 보유하고 있는 큰 테이블의 일부와 broadcast된 테이블을 join한다.

- 코드 샘플

  ```scala
  import org.apache.spark.sql.functions.broadcast
  
  val joinDF = bigDF.join(broadcast(smallDF), "joinKey")
  ```



<br>



## 3. Shuffle Hash Join



### 3-1. 개요

- map-reduce에 기반한 join 방식이다.
- 맵 단계에선 join 칼럼을 기준으로 DataFrame을 매핑하고, 리듀스 단계에서 DataFrame을 shuffle하여 join key가 같은 것끼리 join을 수행한다.
- Spark은 디폴트로 Sort Merge Join을 사용하므로 Shuffle Hash Join을 사용하려면 ```spark.sql.join.perferSortMergeJoin``` 옵션을 false로 변경해야 한다.



<br>



## 효율적인 Join을 방해하는 것들



- **Data Skewness** : join key가 클러스터에 균일하게 분포해 있지 않으면 특정 파티션이 매우 커질 수 있다. 이는 Spark이 parallel하게 연산을 수행하는 것을 방해한다.
- **All-to-all communication** : broadcast join이 아닐 경우, 두 DF의 데이터 모두에서 대규모 shuffle이 발생한다.
- **Limited executor memory** 



<br>



## Data Skewness를 해결하려면?

- **Repartitioning** : 단순히 repartition을 수행하는 것으로 데이터를 파티션들에 더 골고루 분배할 수 있다.
- **Key Salting** : 근본적으로 파티셔닝되는 칼럼 키값에 salting을 적용하여 키가 고르게 분배될 수 있도록 할 수 있다.



<br>



## Reference

- https://towardsdatascience.com/the-art-of-joining-in-spark-dcbd33d693c
- https://medium.com/datakaresolutions/optimize-spark-sql-joins-c81b4e3ed7da

