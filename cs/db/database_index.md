# 데이터베이스 인덱스


## 인덱스의 개념

특정 칼럼 값을 갖는 레코드를 검색할 경우 테이블에 대한 Full table scan을 수행한다. 테이블의 레코드가 많을 수록 검색 속도는 더욱 느려지게 된다.

인덱스(Index)는 데이터베이스 테이블에 대한 동작의 속도를 높여주는 자료구조다. 인덱스는 테이블 내의 1개의 컬럼, 혹은 여러 개의 컬럼을 이용하여 생성될 수 있다. 고속의 검색 동작뿐만 아니라 레코드 접근과 관련 효율적인 순서 매김 동작에 대한 기초를 제공한다. 인덱스로 지정된 칼럼에 대해 (*칼럼의 값*, *레코드가 저장된 주소*)의 키-값 쌍으로 인덱스를 생성한다.

읿반적으로 인덱스는 B-Tree와 같이 정렬된 상태를 유지하기 때문에 탐색은 빠르지만 삽입/삭제/수정 등의 쿼리에는 성능이 떨어진다. 즉, 데이터 저장 성능을 희생한 대신 탐색 속도를 향상시킨 것이다. 과도하게 많은 칼럼에 대해 인덱스를 생성하면 인덱스가 비대해지고 데이터 저장 성능이 크게 감소하므로 역효과가 발생할 수 있다.



## Clustered Index / Nonclustered Index

### 클러스터화된 인덱스

- 테이블당 1개씩만 허용된다.
- PK설정 시 그 칼럼은 자동으로 클러스터드 인덱스가 만들어진다.
- 물리적으로 행을 재배열한다.
- 인덱스 자체의 리프 페이지가 곧 데이터이다. 즉 테이블 자체가 인덱스이다. (따로 인덱스 페이지를 만들지 않는다.)
- 데이터 입력, 수정, 삭제 시 항상 정렬 상태를 유지한다.
- 비 클러스형 인덱스보다 검색 속도는 더 빠르다. 하지만 데이터의 입력. 수정, 삭제는 느리다.

![clustered_index](https://github.com/dhkdn9192/data_engineer_career/blob/master/cs/db/img/clustered_index.png)



### 비클러스터화된 인덱스

- 테이블당 여러개의 인덱스를 만들 수 있다.
- 인덱스 페이지는 로그파일에 저장된다.
- 레코드의 원본은 정렬되지 않고, 인덱스 페이지만 정렬된다.
- 인덱스 자체의 리프 페이지는 데이터가 아니라 데이터가 위치하는 포인터(RID)이기 때문에 클러스터형보다 검색 속도는 더 느리지만 데이터의 입력, 수정, 삭제는 더 빠르다.
- 인덱스를 생성할 때 데이터 페이지는 그냥 둔 상태에서 별도의 인덱스 페이지를 따로 만들기 때문에 용량을 더 차지한다

![nonclustered_index](https://github.com/dhkdn9192/data_engineer_career/blob/master/cs/db/img/nonclustered_index.png)



## 인덱스 알고리즘

### Hash 인덱스 알고리즘

- 칼럼 값에 대한 해시 값으로 인덱싱을 하면 O(1)의 빠른 검색이 가능하다.
- 하지만 해시 함수로 칼럼 값이 변형되므로, 문장의 pre-fix 혹은 부분 문자열과 같이 값의 일부분으로 검색하기가 어렵다.
- 또한 검색 조건이 등호(```=```)가 아닌 부등호(```<```, ```>```)일 경우엔 사용하기가 어렵다.



### Binary Search Tree

- 이진검색트리로 인덱스를 생성하면 O(log n)의 시간복잡도로 검색이 가능하다.
- 하지만 데이터가 삽입/수정/삭제 연산이 반복될 수록 특정 서브트리에 데이터가 몰리게 된다.
- 결국 트리의 구조가 점점 불균형해져서 성능이 떨이진다.



### B-tree

- B-tree는 이진트리를 확장한 구조로, 각 노드가 가질 수 있는 자식 노드의 최대 수가 2보다 큰 트리구조다.
- B-tree의 구조는 최상단의 Root Node와 중간 노드인 Branch Node, 가장 아래의 Leaf Node로 구성된다.

![b_tree_architecture](https://github.com/dhkdn9192/data_engineer_career/blob/master/cs/db/img/b_tree_architecture.png)

- 검색할 값을 데이터와 일일이 비교하는 것은 비효율적이므로, B-tree는 데이터를 항상 정렬된 상태로 보관한다.

![sorted_data_in_btree](https://github.com/dhkdn9192/data_engineer_career/blob/master/cd/db/img/sorted_data_in_btree.png)

- B-tree의 내부 노드는 자식 노드의 수를 정해진 범위 안에서 변경할 수 있다. 즉, 삽입/삭제가 발생하면 해당 범위의 자식 노드 수를 만족시키기 위해 노드끼리 합쳐지거나 분리되며 재균형 과정을 이룬다.

![balanced_tree](https://github.com/dhkdn9192/data_engineer_career/blob/master/cs/db/img/balanced_tree.png)

- 균형 상태를 항상 유지하므로 B-tree는 어느 데이터에 대해서든 O(log n)의 동일한 속도로 균일하게 빠른 탐색을 할 수 있다.
- 반면 재균형 과정으로 인해 삽입/삭제 연산에 대해서는 성능이 떨어진다.



### B+ tree

- B+tree는 B-tree를 확장한 개념이다.
- B-tree가 internal 또는 브랜치 노드에 key와 data를 담을 수 있는 반면, B+tree는 브랜치 노드에 key만 담아두고, data는 담지 않는다. 오직 리프 노드에만 key와 data를 저장하고, 리프 노드끼리 Linked list로 연결되어 있다. 

![bplus_tree](https://github.com/dhkdn9192/data_engineer_career/blob/master/cs/db/img/bplus_tree.png)

- 리프 노드를 제외하고 데이터를 담아두지 않기 때문에 메모리를 더 확보함으로써 더 많은 key들을 수용할 수 있다. 
- 하나의 노드에 더 많은 key들을 담을 수 있기에 트리의 높이는 더 낮아진다.(cache hit를 높일 수 있음)
- 풀 스캔 시, B+tree는 리프 노드에 데이터가 모두 있기 때문에 한 번의 선형탐색만 하면 되기 때문에 B-tree에 비해 빠르다. (B-tree의 경우에는 모든 노드를 확인해야 한다.)





## Reference

- https://ko.wikipedia.org/wiki/%EC%9D%B8%EB%8D%B1%EC%8A%A4_(%EB%8D%B0%EC%9D%B4%ED%84%B0%EB%B2%A0%EC%9D%B4%EC%8A%A4)
- https://junghn.tistory.com/entry/DB-%ED%81%B4%EB%9F%AC%EC%8A%A4%ED%84%B0-%EC%9D%B8%EB%8D%B1%EC%8A%A4%EC%99%80-%EB%84%8C%ED%81%B4%EB%9F%AC%EC%8A%A4%ED%84%B0-%EC%9D%B8%EB%8D%B1%EC%8A%A4-%EA%B0%9C%EB%85%90-%EC%B4%9D%EC%A0%95%EB%A6%AC
- https://beelee.tistory.com/37
- https://zorba91.tistory.com/293
