# GC의 종류



## 1. GC란

Java에선 메모리 관리를 Garbage Collector가 수행한다. 메모리 상의 불필요한 객체를 찾아 해제하는 역할을 수행한다.

GC가 발생하는 예시로, Java의 String 연산을 빈번하게 수행하면 불필요한 객체가 많이 생성되므로 잦은 GC를 유발하게 되고 성능이 저하될 수 있다.



<br>



## 2. JVM의 Runtime Data Area

JVM의 Runtime Data Area는 다음과 같이 크게 5가지 요소로 구성된다.

- method area
- heap
- Java stacks
- PC registers
- Native method stacks



{image}



### 2-1. Heap memory



### 2-2. Non-heap memory



#### method area

#### Java stacks

#### native method stacks

#### PR registers



{image}



### 2-3. StackOverflowError / OutOfMemoryError







<br>



## 3. Java Heap Memory

{image} - eden, s1, s2, old (perm은 JDK8부터 사라짐)





<br>



## 4. GC의 종류



Minor GC

Major GC



<br>



## 5. GC 알고리즘

- Serial Collector (시리얼 콜렉터)
- Parallel Collector (병렬 콜렉터)
- Parallel Compacting Collector (병렬 콤팩팅 콜렉터)
- Concurrent Mark-Sweep Collector (CMS 콜렉터)
- Garbage First Collector (G1 콜렉터)







<br>





## Reference

- 도서 "자바 성능 튜닝 이야기", 인사이트, 이상민 지음
- https://commons.wikimedia.org/wiki/File:Bdb.gif
