# Java : String vs StringBuffer, StringBuilder

- 핵심 키워드 : ```StringBuffer```, ```StringBuilder```



## Java의 String

문자열 연산을 수행하기 위해 아래와 같은 쿼리를 수행한다고 가정해보자

```java
String myQuery = "";
myQuery += "select * ";
myQuery += "from atable ";
myQuery += "limit 100; ";
```

최종적으로 myQuery 문자열에 저장되는 값은 "select * from atable limit 100;" 이라는 sql 쿼리문이다. 그러나 각 라인을 수행하면서 각각의 부분 문자열 객체들을 생성해야하고 이는 연산 후에 곧바로 사용되지 않는 garbage가 된다. **garbage가 많이 생성될 수록 메모리 사용량도 늘어나고, GC 또한 빈번하게 발생하므로 속도도 느려지게된다**.

다음처럼 매번 다른 메모리 주소 상에 새로운 객체가 저장된다. 즉, 직전까지의 객체는 garbage가 된다.

| 메모리 주소 | 값                                |
| ----------- | --------------------------------- |
| 100         | "select * "                       |
| **150**     | "select * from atable"            |
| **200**     | "select * from atable limit 100;" |





## String 대신 StringBuffer, StringBuilder

위의 예시를 Java의 StringBuffer 또는 StringBuilder를 사용할 경우 아래처럼 작성할 수 있다.

```java
StringBuffer strBuff = new StringBuffer();
strBuff.append("select * ");
strBuff.append("from atable ");
strBuff.append("limit 100; ");
String myQuery = strBuff.toString();
```

StringBuffer나 StringBuilder는 String과는 달리 **새로운 객체를 생성하지 않는다**. append() 연산을 통해 기존 객체에 데이터를 추가한다. 매 연산마다 garbage가 생성되지 않으므로 GC 또한 빈번하게 발생하지 않는다.

메모리 상에 데이터가 저장될 때에는 다음처럼 동일한 주소의 객체에 추가된다.

| 메모리 주소 | 값                                |
| ----------- | --------------------------------- |
| 100         | "select * "                       |
| 100         | "select * from atable"            |
| 100         | "select * from atable limit 100;" |




## StringBuffer vs StringBuilder

- StringBuffer는 thread-safe하게 설계되어 여러개의 thread가 접근하는 환경에서도 사용할 수 있다.
- StringBuilder는 단일 thread에서의 안전성만 보전하므로 여러개의 thread가 접근하면 문제가 발생할 수 있다.





## 결론

- String은 가급적이면 문자열 연산이 없는 경우에 사용한다.
- StringBuffer는 thread-safe한 프로그래밍이 필요한 경우(static 선언된 문자열을 변경하는 등)에 사용한다.
- StringBuilder는 thread-safe 여부와 관계 없이 프로그래밍할 경우(메소드 내에서 선언된 문자열을 변경한는 등)에 사용한다.




## Reference

- 도서 "자바 성능 튜닝 이야기", 인사이트, 이상민 지음
