# Difference between Interface and Abstrac Class in JAVA

## Interface

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


## Abstract Class
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
Hiding the internal implementation of the feature and only showing the functionality to the users. 
i.e. what it works (showing), how it works (hiding). 
Both abstract class and interface are used for abstraction.



## Abstract class vs Interface
- <b>Type of methods</b>: Interface can have only abstract methods. Abstract class can have abstract and non-abstract methods. From Java 8, it can have default and static methods also.
- <b>Final Variables</b>: Variables declared in a Java interface are by default final. An abstract class may contain non-final variables.
- <b>Type of variables</b>: Abstract class can have final, non-final, static and non-static variables. Interface has only static and final variables.
- <b>Implementation</b>: Abstract class can provide the implementation of interface. Interface can’t provide the implementation of abstract class.
- <b>Inheritance vs Abstraction</b>: A Java interface can be implemented using keyword “implements” and abstract class can be extended using keyword “extends”.
- <b>Multiple implementation</b>: An interface can extend another Java interface only, an abstract class can extend another Java class and implement multiple Java interfaces.
- <b>Accessibility of Data Members</b>: Members of a Java interface are public by default. A Java abstract class can have class members like private, protected, etc.


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
- In java application, there are some <b>related classes</b> that need to share some lines of code 
then you can put these lines of code within abstract class 
and this abstract class should be extended by all these related classes.
- You can define non-static or non-final field(s) in abstract class, 
so that via a method you can access and modify the state of Object to which they belong.
- You can expect that the classes that extend an abstract class have <b>many common methods or fields</b>, 
or require access modifiers other than public (such as protected and private).

### Interface
- It is total abstraction, All methods declared within an interface must be implemented by the class(es) that implements this interface.
- A class can implement more than one interface. It is called <b>multiple inheritance</b>.
- You want to specify the behavior of a particular data type, but not concerned about who implements its behavior.


## 다형성 (Polymorphism)
다형성이란 같은 자료형에 여러 가지 객체를 대입하여 다양한 결과를 얻어내는 성질을 의미한다. 
대표적으로 오버로딩이 있다.


## Reference
- https://wikidocs.net/217
- https://www.geeksforgeeks.org/difference-between-abstract-class-and-interface-in-java/
- https://m.blog.naver.com/PostView.nhn?blogId=heartflow89&logNo=220979244668&proxyReferer=https%3A%2F%2Fwww.google.com%2F
- https://cbw1030.tistory.com/47
