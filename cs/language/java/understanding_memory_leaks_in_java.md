# Java의 메모리 누수 이해하기

Java의 핵심적인 장점은 내장된 Garbage Collector(GC)가 자동으로 메모리를 관리해준다는 점이다.
GC는 암묵적으로 메모리의 할당과 해제를 처리하기 때문에 메모리 누수 이슈의 대부분을 해결할 수 있다.

GC가 메모리 누수의 완벽한 해결책을 보장하지는 않는다.
메모리 누수는 때때로 발생할 수 있다.


## 메모리 누수란 무엇인가

메모리 누수란 힙에 존재하는 더 이상 사용되지 않는 오브젝트를 **garbage collector가 이를 제거할 수 없어서** 불필요하게 메모리가 낭비되는 상황을 뜻한다.

메모리 리소스가 block되고 시스템 성능이 시간이 지남에 따라 하락하므로 메모리 누수가 생기는 것은 좋지 않다.
만약 누수가 해결되지 않으면 애플리케이션은 리소스가 고갈되어 최종적으로 ```java.lang.OutOfMemoryError``` 에러와 함께 종료된다.

힙 메모리에 존재하는 오브젝트의 타입은 참조되는 것과 참조되지 않는 것 2가지로 구분한다.
- **referenced objects** : 애플리케이션에서 참조가 활성화된 오브젝트
- **unreferenced objects** : 참조가 활성화되지 않은 오브젝트

garbage collector는 참조되지 않는 오브젝트를 주기적으로 제거한다.
그러나 **여전히 참조되는 오브젝트는 수집하지 않는다**.
이것이 메모리 누수가 발생할 수 있는 경우이다.

![memory_leak_in_java_heap](https://github.com/dhkdn9192/data_engineer_career/blob/master/cs/language/java/img/memory_leak_in_java_heap.png)


## 메모리 누수의 증상
- 애플리케이션을 장시간 계속 수행하면 **심각한 성능 하락**이 발생
- 애플리케이션 내부에서 **OutOfMemoryError** 힙 에러가 발생
- 자발적이고 이상한 **애플리케이션 크래시** 현상
- 애플리케이션이 때떄로 **connection object가 고갈됨**


## JVM Memory Leak 해결하기
- 원인분석: heapdump 분석 (eclipse memory analyzer 등)
- memory 점유율이 높은 object부터 분석 (당연하지만 말처럼 쉽지 않음...)


## 힙 메모리(heap memory)
프로그램을 사용할 수 있는 자유 메모리이다. 
프로그램 실행 시에 함수로 보내는 자료 등을 일시적으로 보관해 두는 소량의 메모리인 '스택'과 필요할 때 언제나 사용할 수 있는 대량의 메모리인 '힙'이 있다. 
바로 이 '힙'이 없어지면 메모리가 부족해서 '이상 종료'하게 된다.



## Reference
- https://www.baeldung.com/java-memory-leaks
- https://www.scienceall.com/%ED%9E%99-%EB%A9%94%EB%AA%A8%EB%A6%ACheap-memory/
- https://woowabros.github.io/tools/2019/05/24/jvm_memory_leak.html
