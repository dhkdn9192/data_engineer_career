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



## Reference
- https://wikidocs.net/217
- https://www.geeksforgeeks.org/difference-between-abstract-class-and-interface-in-java/
