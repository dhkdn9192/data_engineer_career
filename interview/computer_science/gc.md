# Garbage Collection



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



![jvm_runtime_data_area](https://github.com/dhkdn9192/data_engineer_should_know/blob/master/interview/computer_science/img/jvm_runtime_data_area_simple.png)



### 2-1. Heap memory

클래스의 인스턴스, 변수 등의 객체가 저장되는 메모리 영역이다. 여러 thread들이 공유하기 때문에 shared memory라고도 불린다. Heap 메모리의 객체들은 GC의 대상이 된다.



### 2-2. Non-heap memory

Runtime Data Area는 크게 Heap과 Non-heap으로 구분할 수 있다. Non-heap은 Heap 이외의 메모리 영역들을 뜻한다.

- method area : 메소드 영역은 모든 JVM thread에서 공유한다. 런타임 상수 풀, 메소드, 생성자 코드 등을 포함한다. Java에선 클래스 파일이 constant_pool이라는 정보를 포함하는데 이 constant_pool에 대한 정보를 메소드 영역에서 참조한다.
- Java stacks (JVM stacks) : thread가 시작할 때 JVM 상에 스택이 생성된다. 스택에는 메소드 호출 정보인 frame, 지역 변수, 임시 결과, 메소드 리턴 관련 정보 등이 저장된다.
- pc registers : thread들은 각자의 Program Counter 레지스터를 갖는다. thread 들은 Java 코드를 수행할 때 JVM 인스트럭션 주소를 pc 레지스터에 저장한다.
- native method stacks : Java 코드가 아닌 다른 언어로 된 코드를 실행할 때의 스택 정보를 관리한다. (주로 C언어 등)



JVM의 Runtime Data Area를 좀 더 구체화하면 아래 이미지와 같다.

![jvm_runatime_data_area_each_thread](https://github.com/dhkdn9192/data_engineer_should_know/blob/master/interview/computer_science/img/jvm_runtime_data_area_each_thread.png)



<br>



## 3. Heap memory 구조

JVM Heap 메모리 구조는 크게 Young 영역(eden, survivor1, survivor2)과 Old 영역으로 구분된다. (Perm 영역은 JDK8부터는 사라진다)

![heap_memory_structure](https://github.com/dhkdn9192/data_engineer_should_know/blob/master/interview/computer_science/img/JVM-memory-structure2.png)



Heap 메모리에 객체가 저장되는 방식은 다음과 같다.

- 새로 생성된 객체는 제일 먼저 eden에 저장된다. 
- eden이 가득 차게 되면 두 survivor 영역 중 비어있는 곳에 옮겨진다. 
- survivor 두 곳 중 하나는 반드시 비어있어야 하며, GC를 수행할 때마다 객체는 두 survivor 사이를 이동하게 된다. 
- 이 과정에서 오래 생존한 객체는 Old 영역으로 옮겨진다. (객체의 크기가 survivor보다 클 경우엔 바로 Old 영역으로 이동할 수 있다.)



GC 작업은 Heap 메모리 상에서 사용하지 않는 메모리를 인식하여 자원을 반환하는 일을 수행한다. 만약 GC를 해도 더 이상 사용 가능한 메모리 영역이 없는데 애플리케이션이 계속 메모리를 할당하려고 하면 ```OutOfMemoryError``` 가 발생하여 JVM이 다운될 수 있다.



<br>



## 4. GC의 종류

- Minor GC : Young 영역에서 발생하는 GC
- Major GC : Old 영역에서 발생하는 GC
- Full GC : 전체 영역에서 발생하는 GC



<br>



## 5. GC 알고리즘

JDK에선 아래와 같은 5가지 GC 방식을 지원한다.

- Serial Collector (시리얼 콜렉터)
- Parallel Collector (병렬 콜렉터)
- Parallel Compacting Collector (병렬 콤팩팅 콜렉터)
- Concurrent Mark-Sweep Collector (CMS 콜렉터)
- Garbage First Collector (G1 콜렉터)



### 5-1. Serial Collector

- Young 영역에 대한 GC와 Old 영역에 대한 GC가 연속적으로 처리된다.
- 하나의 CPU를 사용한다.
- Minor GC가 이뤄지는 절차는 다음과 같다
    1. eden이 가득 차게 될 경우, eden의 살아있는 객체과 (from) survivor의 살아있는 객체를 비어있는 (to) survivor로 이동한다.
    2. eden과 (from) survivor를 비운다.
    3. (to) survivor가 가득 차게 되는 경우, eden과 (from) survivor의 남은 객체는 Old 영역으로 이동한다.
- Old 영역에 대한 GC는 **Mark-Sweep-Compaction** 콜렉션 알고리즘을 따른다.
    1. Old 영역의 살아있는 객체를 식별한다. (Mark)
    2. Old 영역의 garbage 객체를 식별한다. (Sweep)
    3. Garbage 객체를 지우고 살아있는 객체들을 한 곳으로 모아 컴팩팅한다. (Compaction)
- 시리얼 콜렉터는 클라이언트단의 장비 등 대기 시간이 길어도 문제되지 않는 시스템에서 사용된다. 
- 사용하려면 ```-XX:+UseSerialGC``` 옵션을 사용한다.



### 5-2. Parallel Collector

- Throughput Collector로도 불린다.
- 시리얼 콜렉터와 달리, Young 영역에서의 GC를 parallel로 처리한다.
- 많은 CPU를 사용하므로 처리량이 많고 GC로 인한 부하를 줄일 수 있다.
- Old 영역의 GC는 시리얼 콜렉터와 마찬가지로 **Mark-Sweep-Compaction** 콜렉션 알고리즘을 사용한다.
- 사용하려면 ```-XX:+UseParallelGC``` 옵션을 사용한다.



![serial_gc_and_parallel_gc](https://github.com/dhkdn9192/data_engineer_should_know/blob/master/interview/computer_science/img/serial_gc_and_parallel_gc.png)



### 5-3. Parallel Compacting Collector

- Young 영역에 대한 GC는 병렬 콜렉터와 동일하다. (parallel로 처리)
- Old 영역에 대한 GC는 병렬 콜렉터와 달리 **Mark-Summary-Compaction** 방식으로 이뤄진다.
    1. Mark (표시 단계) : 살아있는 객체를 식별하는 단계
    2. Summary (종합 단계) : 이전 GC에서 컴팩션된 영역의 살아있는 객체를 조사하는 단계
    3. Compaction (컴팩션 단계 ) : 컴팩션을 수행하는 단계
- 시리얼 콜렉터, 병렬 콜렉터의 Mark-Sweep-Compaction과 병렬 컴팩팅 콜렉터의 Mark-Summary-Compaction 차이점은 스윕(Sweep)과 종합(Summary) 단계의 차이로 볼 수 있다.
    - Sweep 단계 : 단일 스레드가 Old 영역 전체를 훑는다.
    - Summary 단계 : **여러개의 스레드가 Old 영역을 분리하여 훑는다**. 또한 수행한 GC에서 컴팩팅된 영역을 별도로 훑는다.
- 사용하려면 ```-XX:+UseParallelOldGC``` 옵션을 사용하며 스레드 개수는 ```-XX:ParallelGCThreads=n``` 옵션으로 조정할 수 있다.



### 5-4. CMS Collector

- Low-latency Collector로도 알려져 있다.
- Heap 메모리의 크기가 큰 경우에 적합하다.
- Young 영역에 대한 GC는 병렬 콜렉터와 동일하다.
- Old 영역에 대한 GC는 다음 단계로 수행된다.
    1. Initial Mark : 짧은 대기 시간으로 살아있는 객체를 찾는 단계
    2. Concurrent Mark : stop-the-world 없이 애플리케이션과 병렬로 동작하면서 살아있는 객체를 표시하는 단계
    3. Remark : Concurrent Mark 수행 동안 변경사항이 발생한 객체에 대해서 다시 표시하는 단계
    4. Concurrent Sweep : 표시된 garbage들을 정리하는 단계
- CMS의 일부 단계들은 concurrent로 수행되며 stop-the-world로 인한 일시정이 없이 애플리케이션과 동시에 동작한다. 즉, 기존 GC의 Mark-Sweep-Compaction 절차에서 발생하던 **stop-the-world 일시정지가 여러 단계로 쪼개져서 각 일시정지의 latency가 짧아지게 되었다**.
- CMS는 기본적으로 **컴팩션 단계를 거치지 않으므로 단편화가 발생**할 수 있다.
- 사용하려면 ```-XX:+UseConcMarkSweepGC``` 옵션으로 사용할 수 있으며 ```-XX:CMSInitiatingOccupancyFraction=n``` 옵션으로 동시병렬을 시작할 시점을 조절할 수 있다.
    - **동시병렬 모드 실패로 인한 Full GC**가 발생할 확률을 줄이려면 위 옵션으로 동시병렬 모드 시작 시점을 앞당기거나 Heap 메로리 또는 Old 영역 비율을 늘리는 방법이 있다.



![cms_collector_process](https://github.com/dhkdn9192/data_engineer_should_know/blob/master/interview/computer_science/img/cms_collector_process.png)



### 5-5 G1GC







<br>





## Reference

- 도서 "자바 성능 튜닝 이야기", 인사이트, 이상민 지음
- https://commons.wikimedia.org/wiki/File:Bdb.gif
- https://d2.naver.com/helloworld/1329
- https://d2.naver.com/helloworld/37111
- https://www.oracle.com/webfolder/technetwork/tutorials/obe/java/G1GettingStarted/index.html

