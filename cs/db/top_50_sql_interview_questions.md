# Top 50 SQL Interview Questions

- reference: https://www.guru99.com/sql-interview-questions-answers.html


### 8. What is a foreign key?
A foreign key is one table which can be related to the primary key of another table. 
Relationship needs to be created between two tables by referencing foreign key with the primary key of another table.


### 10. What are the types of join and explain each?
- Inner Join
- Right Join
- Left Join
- Full Join


### 11. What is normalization?
Normalization is the process of minimizing redundancy and dependency by organizing fields and table of a database. 
The main aim of Normalization is to add, delete or modify field that can be made in a single table.


### 12. What is Denormalization.
DeNormalization is a technique used to access the data from higher to lower normal forms of database. 
It is also process of introducing redundancy into a table by incorporating data from the related tables.


### 14. What is a View?
1. 뷰는 사용자에게 접근이 허용된 자료만을 제한적으로 보여주기 위해 하나 이상의 기본 테이블로부터 유도된, 이름을 가지는 가상 테이블이다.
2. 뷰는 저장장치 내에 물리적으로 존재하지 않지만 사용자에게 있는 것처럼 간주된다.
3. 뷰는 데이터 보정작업, 처리과정 시험 등 임시적인 작업을 위한 용도로 활용된다.
4. 뷰는 조인문의 사용 최소화로 사용상의 편의성을 최대화 한다.


### 15. What is an Index?
An index is performance tuning method of allowing faster retrieval of records from the table. 
An index creates an entry for each value and it will be faster to retrieve data.


### 22. What is a stored procedure?
Stored Procedure is a function consists of many SQL statement to access the database system. 
Several SQL statements are consolidated into a stored procedure and execute them whenever and wherever required.


### 23. What is a trigger?
A DB trigger is a code or programs that automatically execute with response to some event on a table or view in a database. 
Mainly, trigger helps to maintain the integrity of the database.

Example: When a new student is added to the student database, 
new records should be created in the related tables like Exam, Score and Attendance tables.


### 24. What is the difference between DELETE and TRUNCATE commands?

<b>DELETE</b> command is used to remove rows from the table, 
and WHERE clause can be used for conditional set of parameters. 
Commit and *Rollback can be performed*after delete statement.

<b>TRUNCATE</b> removes all rows from the table. 
Truncate operation *cannot be rolled back*.


### 26. What is a constraint?
Constraint can be used to specify the limit on the data type of table. 
Constraint can be specified while creating or altering the table statement. 
Sample of constraint are.
- NOT NULL
- CHECK
- DEFAULT
- UNIQUE
- PRIMARY KEY
- FOREIGN KEY



### 27. What is data integrity?

데이터의 무결성은 데이터의 정확성, 일관성, 유효성이 유지되는 것을 말한다. 
데이터의 무결성을 유지하는 것은 데이터베이스 관리시스템 (DBMS)의 중요한 기능이며, 
주로 데이터에 적용되는 연산에 제한을 두어 데이터의 무결성을 유지한다. 
데이터베이스에서 말하는 무결성에는 다음과 같은 4가지 종류가 있다.

- 개체 무결성 (Entity integrity)
  - 모든 테이블이 기본 키 (primary key)로 선택된 필드 (column)를 가져야 한다. 
  - 기본 키로 선택된 필드는 고유한 값을 가져야 하며, 빈 값은 허용하지 않는다.

- 참조 무결성 (Referential integrity)
  - 참조 관계에 있는 두 테이블의 데이터가 항상 일관된 값을 갖도록 유지되는 것을 말한다.
  
- 도메인 무결성 (Domain integrity)
  - 필드의 무결성을 보장하기 위한 것으로 필드의 타입, NULL값의 허용 등에 대한 사항을 정의하고, 
  올바른 데이터의 입력 되었는지를 확인하는 것이다.
 
- 무결성 규칙 (Integrity rule)

- reference: https://untitledtblog.tistory.com/123


### 38. What is Online Transaction Processing (OLTP)?

Online Transaction Processing (OLTP) manages transaction based applications which can be used for data entry, 
data retrieval and data processing. 
OLTP makes data management simple and efficient. 
Unlike OLAP systems, *goal of OLTP systems is serving real-time transactions*.

Example – Bank Transactions on a daily basis.





