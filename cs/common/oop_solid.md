# SOLID

## SOLID란?
객체지향 프로그래밍과 설계를 위한 5가지 원칙. 시간이 지나도 유지보수와 확장이 쉬운 시스템을 만들기 위한 기본 원칙이기도 하다.
* **S**ingle responsibility principle (단일 책임 원칙)
* **O**pen/closed principle (폐쇄/개발 원칙)
* **L**iskov's substitution principle (리스코프 치환 원칙)
* **I**nterface segregation principle (인터페이스 분리 원칙)
* **D**ependency inversion principle (의존성 역전 원칙)

SOLID의 개념과 구체적인 적용 방법을 Python 예시와 함께 정리해본다.


## 1. 단일 책임 원칙 (SRP)
단일 책임 원칙이란, **클래스는 단 하나의 책임**을 져야한다는 원칙이다.

* 많은 책임을 지고 있는 클래스는 관련 없는 행동을 그룹화한 것이므로 유지보수가 어렵다.
* 많은 책임을 지는 클래스는 수정해야하는 이유가 많아진다.
* 하나의 클래스에 상호 배타적이고 서로 관련 없는 메서드들이 포함되어 있다면 더 작은 클래스로 분리하는 것이 좋다.
* (참고) 필요한 일 이상의 것을 하거나 너무 많은 것을 알고 있는 객체를 일컬어 **신(god) 객체**라 부른다.


### 너무 많은 책임을 가진 클래스
다음은 SRP를 준수하지 않는 클래스 디자인이다.
```Python
class SystemMonitor :
    def load_activity(self):
        """소스에서 처리할 이벤트를 가져오기"""
 
    def identify_events(self):
        """가져온 데이터 를 파싱하여 도메인 객체 이벤트로 변환"""
 
    def stream_events(self):
        """파싱한 이벤트를 외부 에이전트로 전송"""
```

이 클래스의 문제점은 다음과 같다.
* 독립적인 동작을 하는 메서드들을 하나의 인터페이스에 정의하고 있다.
* 각 메서드는 클래스의 책임을 대표하며, 메서드마다 다양한 변경의 필요성이 생길 수 있다.
* 즉, **클래스를 변경해야 하는 이유가 너무 많다**.


### 해결방법은 책임 분산
각 메서드를 다른 클래스로 분리하여 각 클래스가 단일 책임을 갖게 할 수 있다.
```Python
class ActivityWatcher :
    def load_activity(self):
        """소스에서 처리할 이벤트를 가져오기"""

class SystemMonitor :
    def identify_events(self):
        """가져온 데이터 를 파싱하여 도메인 객체 이벤트로 변환"""

...
```
클래스를 분리하는 것으로 아래 효과를 얻을 수 있다.
* 서로 분리된 3개 클래스 중 하나가 수정이 필요하더라도 나머지 객체까지 수정할 필요가 없다.
* 변경 사항이 각 클래스 로컬에만 적용되므로 각 클래스의 **유지보수**가 쉬워진다.
* 상속이 필요한 경우, 하위 클래스는 책임과 관련 없는 메서드를 상속받지 않게 되므로 클래스를 **재사용**하기도 쉬워진다.


## 2. 개방/폐쇄 원칙 (OCP)
개방/폐쇄 원칙은 모듈이 개방되어 있으면서도 폐쇄되어 있어야 한다는 원칙이다.
무슨 말이냐 하면, 클래스를 디자인할 때 **확장에는 개방**되고 **수정에는 폐쇄**되도록 해야 한다는 의미이다.

* 새로운 문제가 발생할 경우 새로운 것만 추가할 뿐 기존 코드는 그대로 유지해야 한다.
* 새로운 기능을 추가하다가 기존 코드를 수정했다면 이는 기존 로직이 잘못 디자인되었다는 것을 의미한다.


### OCP를 따르지 않아 유지보수가 어려워지는 케이스
아래는 OCP를 따르지 않는 디자인 예시이다.
각 이벤트에 대해 정의한 클래스들이 있고, SystemMonitor에선 입력받은 이벤트에 따라 조건에 맞는 클래스를 반환한다.
```Python
class Event:
    def __init__(self, raw_data):
        self.raw_data = raw_data
 
class UnknownEvent(Event):
    """데이터만으로 식별할 수 없는 이벤트"""
 
class LoginEvent(Event):
    """로그인 사용자에 의한 이벤트"""
 
class LogoutEvent(Event):
    """로그아웃 사용자에 의한 이벤트"""
 
class SystemMonitor:
    """시스템에서 발생한 이벤트 분류"""
 
    def __init__(self, event_data):
        self.event_data = event_data
 
    def identify_event(self):
        if (
            self.event_data["before"]["session"] == 0
            and self.event_data["after"]["session"]  == 1
        ):
            return LoginEvent(self.event_data)
        elif (
            self.event_data["before"]["session"] == 1
            and self.event_data["after"]["session"] == 0
        ):
            return LogoutEvent(self.event_data)
 
        return UnknownEvent(self.event_data)
```
위 디자인은 아래와 같은 문제점을 갖는다.
* 이벤트 유형을 결정하는 로직이 SystemMonitor의 identify_event 단일 메서드에 중앙 집중화된다. 지원해야 할 이벤트 종류가 늘어날 수록 메서드도 커지게 된다.
* identify_event 메서드가 수정을 위해 닫히지 않았다. 즉, 새로운 이벤트 유형이 추가될 때마다 이 메서드도 수정해야 한다. (줄줄이 이어지는 elif 문장....)

문제 해결을 위해 필요한 것은?
* identify_event 메서드를 변경하지 않고 새로운 유형의 이벤트를 추가하고 싶다. (**폐쇄 원칙**)
* 새로운 이벤트가 추가될 때 기존 코드를 변경하지 않고 코드를 확장하여 새로운 유형의 이벤트를 지원하고 싶다. (**개방 원칙**)


### 확장성을 가진 이벤트 시스템으로 리팩토링하기
OCP를 준수하도록 아래와 같이 디자인을 변경할 수 있다.
```Python
class Event:
    def __init__(self, raw_data):
        self.raw_data = raw_data
         
    @staticmethod
    def meets_condition(event_data: dict):
        return False
 
class UnknownEvent(Event):
    """데이터만으로 식별할 수 없는 이벤트"""
 
class LoginEvent(Event):
    @staticmethod
    def meets_condition(event_data: dict):
        return (
            event_data["before"]["session"] == 0
            and event_data["after"]["session"] == 1
        )
 
class LogoutEvent(Event):
    @staticmethod
    def meets_condition(event_data: dict):
        return (
            event_data["before"]["session"] == 1
            and event_data["after"]["session"] == 0
        )
 
class SystemMonitor:
    """시스템에서 발생한 이벤트 분류"""
 
    def __init__(self, event_data):
        self.event_data = event_data
 
    def identify_event(self):
        for event_cls in Event.__subclasses__():
            try:
                if event_cls.meets_condition(self.event_data):
                    return event_cls(self.event_data)
            except KeyError:
                continue
 
        return UnknownEvent(self.event_data)
```
리팩토링으로 아래와 같은 효과를 얻을 수 있다.
* 기존 identify_event 메서드가 닫히게 되어 새로운 유형의 이벤트가 추가되더라도 수정할 필요가 없어졌다.
* 반대로, 이벤트 계층은 확장을 위해 열려있어 인터페이스에 맞춰 새로운 클래스를 추가할 수 있다



## 3. 리스코프 치환 원칙 (LSP)
리스코프 치환 원칙이란 **부모 클래스를 하위 클래스로 치환하여 그대로 사용할 수 있어야 한다**는 것을 의미한다.
* 만약 S가 T의 하위 타입이라면 프로그램을 변경하지 않고 T 타입의 객체를 S 타입의 객체로 치환 가능해야 한다.
* 이것이 가능하려면 하위 클래스는 상위 클래스에서 정의한 계약을 따르도록 디자인되어야 한다.
  * 하위 클래스는 부모 클래스에서 정의된 것보다 사전조건을 엄격하게 만들면 안 된다.
  * 하위 클래스는 부모 클래스에서 정의된 것보다 약한 사후조건을 만들면 안 된다.


여러 하위 타입을 가진 객체를 사용하는 클라이언트의 예시를 생각해보자.
* LSP가 지켜진다면 하위 클래스들은 부모 클래스가 정의한 계약을 따를 것이다.
* 즉, 클라이언트 클래스는 주의를 기울이지 않고도 모든 하위 클래스의 인스턴스로도 작업할 수 있어야 한다. 
![solid_lsp](https://github.com/dhkdn9192/data_engineer_career/blob/master/cs/common/img/solid_lsp.png)



## 4. 인터페이스 분리 원칙 (ISP)
인터페이스 분리 원칙이란, 클라이언트가 꼭 필요한 메소드들만 사용하도록 작고 구체적인 단위의 인터페이스로 분리해야 한다는 것을 의미한다.

### 인터페이스란?
* 객체 지향적인 용어로 객체가 노출하는 메서드의 집합이다.
* 객체가 수신하거나 해석할 수 있는 모든 메시지가 인터페이스를 구성하며, 클라이언트는 이것을 호출할 수 있다.
* 인터페이스는 클래스의 정의와 구현을 분리한다.
* 파이썬의 경우, 자바와는 달리 interface 키워드가 없으며 추상 기본 클래스(abstract base class; abc)를 사용해서 인터페이스를 구현한다.

### 덕 타이핑(duck typing)이란?
* "어떤 새가 오리처럼 걷고 오리처럼 꽥꽥 소리낸다면 오리여야 한다."
* 객체가 어떤 타입에 걸맞는 변수 혹은 메소드를 지니면 객체를 그 타입으로 간주하는 동적 타이핑 원리
* 파이썬은 덕 타이핑의 원리를 따르는 언어이다.
* 추상 기본 클래스 도입 전까지는 덕 타이핑은 파이썬에서 인터페이스를 정의하는 유일한 방법이었다.


## 5. 의존성 역전 원칙 (DIP)
의존성을 역전시킨다는 것은 코드가 구체적인 구현에 적응하도록 하지 않고, 추상화된 객체에 적응하도록 하는 것을 의미한다.

상호교류하는 객체 A, B에 대해서 A가 B의 인스턴스를 사용할 경우, B에 크게 의존하므로 B가 변경되면 A의 코드는 쉽게 꺠지게 된다.
B에 대한 추상 컴포넌트 C를 만들어서 A → B로 향하는 의존성을 A → C로 향하도록 의존성을 거꾸로 뒤집어서 역전시켜야 한다.



### 강한 의존성을 가진 예시
이벤트 처리기인 EventStreamer가 이 Syslog를 사용해야한다고 가정해보자.
가장 단순한 구현 방법은 EventStreamer에서 필요한 객체를 직접 생성하는 것이다.
```Python
class EventStreamer:
    def __init__(self):
        self._target = Syslog()
         
    def stream(self, events: list[Event]) -> None:
        for event in events:
            self._target.send(event.serialise())  
```
위 디자인은 다음과 같은 문제점이 있다.
* Syslog로 데이터를 보내는 방식이 변경되면 EventStreamer 또한 수정되어야 한다. (즉 의존성이 강해진다)
* 디자인이 유연하지 않으며 인터페이스를 활용하지도 않는다.
* 단위 테스트를 수행하려면 Syslog의 생성 로직을 수정하거나, 생성한 뒤 정보를 업데이트해야 하는 등 테스트하기가 어렵다.
* (참고) `__init__` 메서드에서 의존성이 있는 컴포넌트를 직접 생성하지 않도록 하는 것이 좋다. 필요하다면 의존성을 `__init__` 메서드에 파라미터로 전달하는 것이 보다 유연하게 대응할 수 있는 방식이다.


## 의존성을 거꾸로
이러한 문제를 해결하려면 EventStreamer가 구체 클래스가 아닌 인터페이스와 대화하도록 해야 한다.
* DataTargetClient 인터페이스를 만들어 Syslog가 이를 구현하도록 한다.
* EventStreamer는 Syslog가 아닌 DataTargetClient 인터페이스하고만 의존성을 갖도록 한다.

```Python
class EventStreamer:
    def __init__(self, target: DataTargetClient):
        self._target = target
         
    def stream(self, events: list[Event]) -> None:
        for event in events:
            self._target.send(event.serialise()) 
```
다음과 같은 점이 개선되었다.
* 구체 클래스 Syslog가 변경되더라도 EventStreamer를 수정할 필요가 없다.
* 인터페이스를 구현하고 변화를 수용하는 것은 각 구현체가 담당한다.
* 이전과 달리 테스트도 간편하여 Syslog를 사용하고 싶지 않으면 알맞은 테스트 더블을 제공하기만 하면 된다.


## 참고자료
* (도서) 파이썬 클린 코드
