# DELETE / TRUNCATE / DROP


## DELETE
- 구분 : DML
- 기능 :
  - 데이터만 지워지며 테이블과 디스크 상의 공간은 그대로 유지된다.
  - 테이블 용량은 줄어들지 않는다.
  - WHERE 절로 원하는 데이터만 삭제할 수 있다.
  - 삭제된 데이터는 되돌릴 수 있다. (ROLLBACK)
- 사용 : ```DELETE FROM my_table;```


## TRUNCATE
- 구분 : DDL
- 기능 : 
  - 테이블은 삭제하지 않고 데이터와 인덱스를 삭제한다. (한꺼번에 삭제)
  - 사용하던 공간을 반납하며 용량이 줄어든다.
  - 모든 행을 삭제하는 효율적인 방법
  - 삭제된 데이터는 *되돌릴 수 없다.*
- 사용 : ```TRUNCATE TABLE my_table;```


## DROP
- 구분 : DDL
- 기능 : 
  - 테이블 자체가 삭제되며, 해당 테이블에 생성되어 있던 인덱스도 모두 다 삭제된다. (데이터, 공간, 객체 자체를 삭제)
  - 삭제된 데이터는 *되돌릴 수 없다.*
- 사용 : ```DROP TABLE my_table;```


<br>

## Reference
- https://kjk3071.tistory.com/entry/DB-MySQL-Truncate%EA%B3%BC-Delete
- https://lee-mandu.tistory.com/476
