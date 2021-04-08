# Python GIL (Global Interpreter Lock)

## GIL이란?
CPython에서의 GIL은 여러개의 thread로 Python 코드(bytecode)를 실행할 결우, 단 하나의 thread만이 Python Object에 접근할 수 있도록 제한하는 mutex이다.
이 lock이 필요한 이유는 CPython의 메모리 관리가 thread-safe하지 않기 때문이다.

- 핵심 키워드: ```mutex```, ```thread-safe```, ```synchronized```, ```race-condition```



## CPython의 메모리 관리: Reference Counting
CPython은 각 object별로 reference count를 기록하는 방식으로 메모리를 관리한다.
reference count가 0이되는 object는 메모리 할당이 해제된다.

```Python
# Python object의 reference count를 확인하는 예제
import sys
a = []
b = a
print(sys.getrefcount(a)  # 출력결과는 3
```
- ```a```가 최초 생성되었을 때 reference 개수는 1이 됨
- ```b```가 ```a```를 참조하여 reference 개수는 2가 됨
- ```sys.getrefcount()``` 자체가 ```a```를 참조하므로 출력되는 값은 3


## CPython의 thread-safe 여부
- thread-safe란 멀티스레드 프로그래밍에서 여러 thread가 객체, 변수 등에 접근하더라도 프로그램의 실행에 문제가 없는 경우를 뜻한다.
- thread-safe한 코드를 만들기 위해선 mutex 등으로 객체에 lock을 걸어 동시 접근을 막아야 한다.
- CPython은 C로 만들어졌으며 C에서 thread를 사용할 때의 race condition 문제를 제어하는 것은 온전히 사용자의 몫이다.
- 때문에 CPython은 thead 레벨에서의 메모리 관리가 기본적으로 thread-safe하지 않다.


## Python에서의 임계영역과 동기화 문제
- thread들은 한 process 내에서 같은 힙 메모리 영역을 공유하며 같은 python object들에 접근할 수 있다.
- 즉, thread들에 대해 **각 python object들은 critical section에 해당**한다.
- 각 python object들의 reference count 값을 여러 thread들이 동시에 접근하여 동기화 문제가 발생할 경우, **메모리 할당이 해제되지 않아 메모리 누수가 발생**할 수 있다.

```
object "foo"를 서로 다른 두 thread가 상호배제 없이 동시에 접근하는 경우
1. thread A가 foo를 참조 => A가 읽은 reference count는 2
2. thread B가 foo를 참조 => B가 읽은 reference count는 3
3. thread A가 foo 참조를 해제 => A는 foo의 reference count 2에서 1을 제거한 값인 1을 저장
4. thread B가 foo 참조를 해제 => B는 foo의 reference count 3에서 1을 제거한 값인 2를 저장
5. 최종적으로 foo는 참조하는 thread가 없음에도 reference count 2값을 지니게 되어 메모리 할당이 해제되지 않음 
```

## mutex로 임계영역 문제 해결하기
- 위와 같은 문제를 해결하려면 mutex로 상호배제를 적용해야 한다.
- 그러나 각 python object에 mutex로 lock을 거는 것은 매우 비효율적이다.
- 여러개의 mutex를 사용하는 것은 성능적으로도 손해가 많을 뿐만 아니라, deadlock이 발생할 위험이 있다.
- 따라서 Python은 interpreter에 대해 mutex를 걸어 동시에 한 thread만이 python object에 접근할 수 있도록 lock을 거는 방식을 선택했다.


<br>

## Reference
- https://dgkim5360.tistory.com/entry/understanding-the-global-interpreter-lock-of-cpython
