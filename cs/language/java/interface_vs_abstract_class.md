# Java에서 인터페이스와 추상클래스의 차이점

## Java의 Interface

```Java
public class Animal {
    String name;

    public void setName(String name) {
        this.name = name;
    }
}

public interface Predator {

}

public class Tiger extends Animal implements Predator {

}
```


## Java의 Abstract Class
```Java
public abstract class Predator extends Animal {
    public abstract String getFood();
}

public interface Barkable {
    public void bark();
}

public class Tiger extends Predator implements Barkable {
    public String getFood() {
        return "apple";
    }

    public void bark() {
        System.out.println("어흥");
    }
}
```



## Abstraction?
기능의 내부적인 구현은 감추고 사용자에게 보여주기만 하는 것.

"i.e. what it works (showing), how it works (hiding)."

추상클래스와 인터페이스는 추상화를 위해 사용된다.


## 추상클래스와 인터페이스 비교
- **메소드의 타입** : 인터페이스는 오직 추상메소드만 가질 수 있다. 반면, 추상클래스는 non-abstract 메소드도 가질 수 있다.
- **Final Variables** : Java 인터페이스에서 선언된 변수는 디폴트로 final이다. 반면, 추상클래스는 non-final 변수를 포함할 수 있다.
- **변수의 타입** : 추상클래스는 final, non-final, static, non-static 변수를 가질 수 있다. 반면, 인터페이스는 오직 static과 final 변수만 가질 수 있다.
- **Implementation** : 추상클래스는 인터페이스의 implementation을 제공한다. 반면, 인터페이스는 추상클래스의 implementation을 제공할 수 없다.
- **Inheritance vs Abstraction** : Java 인터페이스는 `implements` 키워드로 구현된다. 추상클래스는 `extends` 키워드로 상속된다.
- **Multiple implementation** : 인터페이스는 다른 Java 인터페이스만 상속받을 수 있다. 반면, 추상클래스는 다른 Java 클래스를 상속받을 수 있고 여러 Java 인터페이스를 구현할 수 있다.
- **Accessibility of Data Members** : Java 인터페이스의 멤버는 디폴트로 public이다. 반면, Java 추상클래스는 private, protected 등의 클래스 멤버를 가질 수 있다.


## 공통점/차이점 정리
- 공통점
    - 추상클래스와 인터페이스는 선언만 존재하고 구현 내용이 없다
    - 인스턴스화할 수 없다
    - 추상클래스의 경우 extends로 상속, 인터페이스의 경우 implements로 구현한 자식 클래스만이 객체를 인스턴스화할 수 있다.
- 차이점
    - 추상클래스는 일반메소드와 추상메소드를 모두 가질 수 있지만 인터페이스는 추상메소드만 가질 수 있다
    - 인터페이스는 다중상속(한 클래스가 여러 인터페이스를 동시에 implements) 가능하지만 추상클래스는 단일상속만 가능하다
    - 추상클래스의 목적은 상속을 받아서 기능을 확장시키는 것이다 (동일한 부모를 갖는 클래스들을 묶어서 상속받도록 함)
    - 인터페이스의 목적은 구현하는 클래스에 대해 특정 메소드가 반드시 존재하도록 강제하는 역할을 하는 것이다


## When to use?

### Abstract Class
- 자식 클래스들이 동일한 메소드, 동일한 코드 라인들을 가져야하는 경우 (즉, 부모 추상클래스의 공통 기능들을 자식들이 오버라이드하여 공유하도록 강제할 때)
- non-static, non-final 변수 타입이 필요한 경우
- public 이외에 private, protected 타입이 필요한 경우


### Interface
- 클래스들의 기능은 정의하되 구체적인 구현 방식은 신경쓰지 않는 경우
- 다중 상속이 필요한 경우
- 연관없는 클래스들을 공통 인터페이스로 묶어주고 싶은 경우



## Reference
- https://wikidocs.net/217
- https://www.geeksforgeeks.org/difference-between-abstract-class-and-interface-in-java/
- https://m.blog.naver.com/PostView.nhn?blogId=heartflow89&logNo=220979244668&proxyReferer=https%3A%2F%2Fwww.google.com%2F
- https://cbw1030.tistory.com/47
- https://inpa.tistory.com/entry/JAVA-%E2%98%95-%EC%9D%B8%ED%84%B0%ED%8E%98%EC%9D%B4%EC%8A%A4-vs-%EC%B6%94%EC%83%81%ED%81%B4%EB%9E%98%EC%8A%A4-%EC%B0%A8%EC%9D%B4%EC%A0%90-%EC%99%84%EB%B2%BD-%EC%9D%B4%ED%95%B4%ED%95%98%EA%B8%B0
