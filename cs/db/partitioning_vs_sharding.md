# Sharding과 Partitioning의 차이점
샤딩과 파티셔닝은 데이터를 여러 머신으로 분산시키고 **scale-out** 데이터베이스 아키텍처를 구성하는데 사용되는 방식이다.


## Partitioning
레코드들로 구성된 데이터셋이 있다고 가정해보자. 각 레코드에는 키가 있다.
이 키는 레코드들을 서로 다른 단위로 분산(partitioning)시키는데 사용된다.

오라클 RDBMS에선 테이블 파티셔닝이 오랫동안 사용되어왔다.
파티션키로 테이블의 레코드들을 둘 이상의 파티션들로 세분화한다.
**이렇게 세분화된 파티션들은 여전히 동일한 DB 인스턴스에 의해 컨트롤된다.**
즉, 같은 CPU, 메모리, I/O, 스토리지 리소스를 피어 파티션 및 파티셔닝되지 않은 테이블과 공유한다.


오라클은 Hash, Range, List 기반의 파티셔닝을 지원한다.
이러한 파티셔닝 알고리즘이나 다른 분산 스키마의 목적은 간단하다.
레코드의 키가 주어졌을 때, 파티션이 어디에 속할지를 결정하는 것이다.


## Sharding
**샤딩은 서로 다른 물리장비/노드 간에 이뤄지는 파티셔닝**이다.
각 파티션은 **완전히 서로 다른 물리 머신**에 존재하며, 따라서 **서로 다른 스키마**를 가지며, **분리된 DB 인스턴스**에 의해 컨트롤된다.
MongoDB가 이와 같은 방식을 취한다.

데이터를 여러 머신에 분산시키는 방법으론 hash와 range가 사용된다.

```
"Sharding is a method to distribute data across multiple different servers.
We achieve horizontal scalability through sharding."

- MongoDB’s online manual
```

## 차이점
샤딩은 데이터를 서로 다른 머신에 분산시키는 반면, 파티셔닝은 데이터를 같은 머신 안에서 분산시킨다.


## Reference
- https://www.quora.com/Whats-the-difference-between-sharding-DB-tables-and-partitioning-them
- https://ko.wikipedia.org/wiki/%EB%8D%B0%EC%9D%B4%ED%84%B0%EB%B2%A0%EC%9D%B4%EC%8A%A4_%EB%B6%84%ED%95%A0
- https://gmlwjd9405.github.io/2018/09/24/db-partitioning.html
