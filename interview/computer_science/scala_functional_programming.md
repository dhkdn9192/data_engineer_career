# Scala: 함수형 프로그래밍의 특징

Scala는 Java와 같은 JVM 언어지만 함수형 프로그래밍 패러다임이라는 점에서 다른 성질을 갖는다.

- Pure functions
- Stateless and Immutability
- Expression only
- First-class and Higher-order functions



<br>



## 1. Pure Functions

- 함수에서 외부의 상태값을 참조가거나 외부의 값을 변경하는 것은 순수한 함수라 할 수 없다.

  ```scala
  val a = 1
  def func(b:Int) = {
    b + a
  }
  ```

- 순수한 함수는 **외부에 영향을 미치지 않는다**.

- 여러 함수가 외부의 동일 변수에 접근하지 않으므로 **Thread-safe**하다.

- 여러 스레드가 thread-safe하게 동작할 수 있으므로 **병렬계산**이 가능하다.

  ```scala
  def func(a:Int, b:Int) = {
    a + b
  }
  ```

  



<br>



## 2. Stateless, Immutability

- 연산을 할 때 이전의 상태정보나 트랜잭션을 참조하는 경우(예: 온라인뱅킹)를 Stateful하다고 표현한다.

- Stateless란 과거의 상태정보나 트랜잭션에 대한 정보가 저장되지 않고, 각 연산/트랜잭션은 모두 처음부터 시작된다. 

- 즉, 각 연산이 격리되었다고 할 수 있다.

- Statefule한 코드와 Stateless한 코드 예시

  ```scala
  /* Stateful */
  val myMap = Map("a" -> 10, "b" -> 20)
  
  def func(someMap: Map[String, Int]) = {
    someMap + ("b" -> (someMap("b")+10))
  }
  
  func(myMap)
  // res7: scala.collection.immutable.Map[String,Int] = Map(a -> 10, b -> 30)
  ```

  ```scala
  /* Stateless */
  val myMap = Map("a" -> 10, "b" -> 20)
  
  def func(someMap: Map[String, Int]) = {
    Map("c" -> (someMap("b")+10))
  }
  
  func(myMap)
  // res10: scala.collection.immutable.Map[String,Int] = Map(c -> 30)
  ```

- 함수형 프로그래밍은 데이터를 변환한 결과를 기존의 변수에 저장하지 않고 새로운 변수를 생성하여 저장함으로써 멱등성을 보장할 수 있어야 한다.

- Scala는 mutable/immutable 타입으로 변수를 지정할 수 있다.

  ```scala
  var a = 10
  a += 5 // ok
  
  val b = 10
  b += 5 // error!
  ```

  



<br>



## 3. Expression Only

- expression이란 실행 결과로 어떤 값을 넘겨주는 코드를 말한다. 

- value나 variable을 정의할 때 다음처럼 expression으로 표현할 수 있다.

  ```scala
  val <identifier>[: <type>] = <expression>
  ```

- 둘 이상의 expression 코드 라인이 모이면 ```{}```로 묶고 이를 expression block이라 한다.

- immutable 성질은 연산의 결과를 기존 변수에 저장하는 것이 아니라 새로운 값에 저장하는 것이며 expression은 새로운 결과값을 다음 expression에 계층적으로 반환함으로써 각각의 결과값들을 immutable하게 다룰 수 있다.

- for loop나 if 조건문은 함수형 표현이라 할 수 없다.

  ```scala
  for (i <- 10 to 15) {
    println(i*10)
  }
  ```

- 함수형 expression만으로 아래처럼 표현할 수 있다.

  ```scala
  val a = (10 to 15)
  val b = a.map(n => n*10)
  ```

  



<br>



## 4. First-class and Higher-order Functions

- First-class functions란 함수를 마치 값, 변수, 데이터 구조처럼 저장할 수 있는 것을 의미한다.

- Higher-order functions란 함수를 매개변수로 입력받거나 함수를 반환값으로 사용하는 것을 의미한다.

  ```scala
  def double(a:Int) = a * 2
  val myDouble: (Int => Int) = double
  myDouble(6)  // 12
  ```




<br>



## Reference

- https://www.youtube.com/watch?v=4ezXhCuT2mw
- https://has3ong.github.io/scala-firstclassfunction

