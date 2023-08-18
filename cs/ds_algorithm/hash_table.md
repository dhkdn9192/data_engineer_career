# Hash Table


## Hashing

해시함수란 데이터의 효율적 관리를 목적으로 임의의 길이의 데이터를 고정된 길이의 데이터로 매핑하는 함수이다. 
이 때 매핑 전 원래 데이터의 값을 **키(key)**, 매핑 후 데이터의 값을 **해시값(hash value)**, 매핑하는 과정 자체를 **해싱(hashing)** 이라고 한다.

해시함수는 해쉬값의 개수보다 대개 많은 키값을 해쉬값으로 변환(many-to-one 대응)하기 때문에 
해시함수가 서로 다른 두 개의 키에 대해 동일한 해시값을 내는 **해시충돌(collision)** 이 발생하게 된다. 


## Hashing의 장점

해시충돌이 발생할 가능성이 있음에도 해시테이블을 쓰는 이유는 **적은 리소스로 많은 데이터를 효율적으로 관리**하기 위해서다. 
- 계산복잡도
  - 이진탐색트리: `O(log n)`
  - 해싱: `O(1)`
  

## Hash table

해시함수를 사용하여 키를 해시값으로 매핑하고, 이 해시값을 색인(index) 혹은 주소 삼아 
데이터의 값(value)을 키와 함께 저장하는 자료구조를 **해시테이블(hash table)** 이라고 한다. 
이 때 데이터가 저장되는 곳을 **버킷(bucket)** 또는 **슬롯(slot)** 이라고 한다. 
해시테이블의 기본 연산은 **삽입**, **삭제**, **탐색(search)** 이다.

보통의 경우 해시테이블 크기(m)가 실제 사용하는 키 개수(n)보다 적은 해시테이블을 운용한다.


## Collision

해시충돌 문제를 해결하기 위해 다양한 기법들이 고안되었다. 
chaining은 해시테이블의 크기를 유연하게 만들고, 
open addressing은 해시테이블 크기는 고정시키되 저장해 둘 위치를 잘 찾는 데 관심을 둔 구조이다. 


### chaining
한 버킷당 들어갈 수 있는 엔트리의 수에 제한을 두지 않음으로써 모든 자료를 해시테이블에 담는다. 
해당 버킷에 데이터가 이미 있다면 체인처럼 노드를 추가하여 다음 노드를 가리키는 방식으로 구현(연결리스트)한다. 
유연하다는 장점을 가지나 **메모리 문제** 를 일으킬 수 있다.


### open addressing
chaining과 달리 한 버킷당 들어갈 수 있는 엔트리가 하나뿐인 해시테이블이다. 
해시함수로 얻은 주소가 아닌, **다른 주소에 데이터를 저장** 할 수 있도록 허용한다. 
메모리 문제가 발생하지 않으나 해시충돌이 발생할 수 있다.

특정 해시값에 키가 몰리게 되면 open addressing의 효율성이 크게 떨어진다. 
해시충돌은 탐사(probing) 방식으로 해결할 수 있다. 
탐사란 삽입, 삭제, 탐색을 수행하기 위해 해시테이블 내 새로운 주소(해시값)를 찾는 과정이다.


### universal hasing
다수의 해시함수를 만들고, 이 해시함수의 집합 H에서 **무작위로 해시함수를 선택**해 해시값을 만드는 기법이다. 
H에서 무작위로 뽑은 해시함수가 주어졌을 때 임의의 키값을 임의의 해시값에 매핑할 확률을 1/m로 만드려는 것이 목적이다. 



## Reference
- https://ratsgo.github.io/data%20structure&algorithm/2017/10/25/hash/
- https://en.wikipedia.org/wiki/Hash_table