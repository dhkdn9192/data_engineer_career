# DDL / DML / DCL / TCL


## DML (Data Manipulation Language)
데이터 조작어
- <b>SELECT</b> : DB에 들어있는 데이터를 조회/검색하기 위한 명령어. RETRIEVE라고도 함
- <b>INSERT</b> : DB 테이블에 들어있는 데이터에 변형을 가하는 명령어 (삽입)
- <b>UPDATE</b> : DB 테이블에 들어있는 데이터에 변형을 가하는 명령어 (수정)
- <b>DELETE</b> : DB 테이블에 들어있는 데이터에 변형을 가하는 명령어 (삭제)


## DDL (Data Definition Language)
데이터 정의어
- <b>CREATE</b> : 테이블과 같은 데이터 구조를 정의하는데 사용되는 명령어 (생성)
- <b>ALTER</b> : 테이블과 같은 데이터 구조를 정의하는데 사용되는 명령어 (변경)
- <b>DROP</b> : 테이블과 같은 데이터 구조를 정의하는데 사용되는 명령어 (삭제)
- <b>RENAME</b> : 테이블과 같은 데이터 구조를 정의하는데 사용되는 명령어 (이름변경)
- <b>TRUNCATE</b> : 테이블과 같은 데이터 구조를 정의하는데 사용되는 명령어 (삭제)


## DCL (Data Control Language)
데이터 제어어
- <b>CRANT</b> : DB에 접근하고 객체들을 사용하도록 권한을 주는 명령어
- <b>REVOKE</b> : 권한을 회수하는 명령어


## TCL (Transaction Control Language)
트랜잭션 제어어
- <b>COMMIT</b> : 하나의 트랜잭션인 여러 DML 명령어를 데이터베이스에 반영하겠다는 의미의 명령어 (하나의 트랜잭션 과정이 정상적으로 종료)
- <b>ROLLBACK</b> : ROLLBACK은 잘못된 명령이나 잘못된 데이터를 입력하는 등 문제가 발생하였을 때 하나의 트랜잭션을 취소하는 명령어
- <b>SAVEPOINT</b> : 하나의 트랜잭션을 작게 분할하여 저장하기 위한 명령어


<br>

## Reference
- https://brownbears.tistory.com/180
- https://m.blog.naver.com/PostView.nhn?blogId=heartflow89&logNo=220981917783&proxyReferer=https:%2F%2Fwww.google.com%2F
