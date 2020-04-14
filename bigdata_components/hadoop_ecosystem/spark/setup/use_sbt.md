# How to use SBT

SBT(Simple Build Tool)는 scala를 빌드하기 위한 도구다. 

- 참조 url
  - [Scala 홈페이지의 SBT 튜토리얼](https://docs.scala-lang.org/getting-started/sbt-track/getting-started-with-scala-and-sbt-on-the-command-line.html)
  - [Scala school의 SBT 튜토리얼](https://twitter.github.io/scala_school/ko/sbt.html)
  - [howtousesbt](https://joswlv.github.io/2017/08/06/howtousesbt/)
  - [명령어 보기](https://webcache.googleusercontent.com/search?q=cache:FaC-GDaQXLoJ:https://www.scala-sbt.org/1.x/docs/Command-Line-Reference.html+&cd=3&hl=ko&ct=clnk&gl=kr)



## SBT 프로젝트 구조
- src/
  - main/
    - resources/
    - scala/
    - java/
  - test/
    - resources/
    - scala/
    - java/
- project/
  - build.properties
  - assembly.sbt
- target/
  - scala-2.XX
    - classes/
    - XXX.jar
- build.sbt





## Dependency 추가

build.sbt에 다음과 같이 libraryDependencies를 추가할 수 있다.
추가할 라이브러리는 scala와 버전 호환되어야 한다.
버전 호환은 maven repository에서 참조한다.

```scala
libraryDependencies += "org.scala-lang.modules" %% "scala-parser-combinators" % "1.1.2"
```




## SBT Commands

| commands | desc |
| :--- | :--- |
| clean | 타겟 디렉토리에 생성된 모든 파일을 삭제한다.|
| compile | 메인 리소스에 있는 모든 소스를 컴파일 한다.|
| test | 컴파일을 하고 모든 테스트케이스를 수행한다.|
| package | src/main 하위의 자바와 스칼라의 컴파일된 클래스와 리소스를 패키징한다.|
| reload  | 빌드 설정을 리로드한다.|


### ```sbt package```

src/main 하위의 자바와 스칼라의 컴파일된 클래스와 리소스를 패키징하여 jar 파일을 생성한다. 
"src/main/resources" 의 파일과 "src/main/scala", "src/main/java" 의 컴파일된 클래스 파일들을 사용한다.

```sbt assembly```와 달리, fat jar 파일을 만들지 않는다.


### ```sbt assembly```
fat jar 파일을 생성한다. 본 명령어를 사용하려면 published plugin을 사용해야 한다.

- Set up
  - "project/plugins.sbt" 파일을 생성하고 다음 라인을 입력해야 한다.
    ```scala
    addSbtPlugin("com.eed3si9n" % "sbt-assembly" % "x.y.z")
    ```
  - x.y.z는 아래 링크에서 sbt-assembly 프로젝트의 최신 release 버전을 입력한다.
    - https://github.com/sbt/sbt-assembly

- Trouble shooting
  - ```[error] deduplicate: different file contents found in the following:``` 오류 발생 시
    - build.sbt에서 libraryDependencies에 추가되는 라이브러리들을 "provided"로 설정해준다.
    - ```libraryDependencies += "org.apache.spark" %% "spark-core" % "2.4.5" % "provided" ```


### ```sbt update```
Resolves and retrieves external dependencies as described in library dependencies.


### ```sbt clean```
Deletes all generated files (in the "target" directory).




## Basic Operations

- ```:=``` : you can assign a value to a setting and a computation to a task. For a setting, the value will be computed once at project load time. For a task, the computation will be re-run each time the task is executed.
  ```scala
  name := "scala-Learning-spark"
  ```
- ```+=``` : will append a single element to the sequence.
  ```scala
  sourceDirectories in Compile += new File("source")
  ```
- ```++=``` : will concatenate another sequence.
  ```scala
  sourceDirectories in Compile ++= Seq(file("sources1"), file("sources2"))
  ```






