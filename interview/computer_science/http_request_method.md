# HTTP Request Method



## HTTP와 HTTPS

http는 텍스트를 전송하며 암호화를 거치지 않기 때문에 패킷을 가로채거나 수정할 수 있다. 즉 보안에 취약하다.

https는 http에 암호화 계층을 추가한 것이다. **제3자인증**, **공개키암호화**, **비밀키암호화**를 사용하며 패킷이 암호화되어 전송된다.



## HTTP Request Method

- **GET**: 서버로부터 데이터를 취득한다
- **HEAD**: GET 방식과 동일하지만 응답에 BODY가 없고 응답코드와 HEAD만 받는다
- **POST**: 요청된 자원을 생성(CREATE)한다. 서버에 데이터를 추가/작성한다.
- **PUT**: 요청된 자원을 수정(UPDATE)한다. 서버의 데이터를 갱신/작성한다.
- **PATCH**: PUT과 유사하게 요청된 자원을 수정(UPDATE)한다. 해당 자원의 전체가 아니라 일부를 교체할 때 사용한다.
- **DELETE**: 요청된 자원을 삭제할 것을 요청한다.
- **OPTIONS**: 웹서버에서 지원되는 메소드의 종류를 확인할 때 사용
- **CONNECT**: 동적으로 터널 모드를 교환, 프락시 기능을 요청할 때 사용



## CRUD 비교

| CRUD   | HTTP Request Method |
| ------ | ------------------- |
| Create | POST/PUT            |
| Read   | GET                 |
| Update | PUT                 |
| Delete | DELETE              |



## GET과 POST의 차이

#### GET

- GET 방식은 Http Message 중 **Header 부분의 url에 요청할 데이터가 포함**되어 전송된다. (url 뒤에 물음표로 시작하는 request 부분을 포함)
- 요청할 데이터를 url 공간에 포함되어 보내지므로 **보낼 수 있는 데이터의 크기가 제한적**인다. 
- 데이터가 url에서 그대로 노출되므로 **보안에 취약**하다 (비밀번호 등)
- GET은 기본적으로 서버로부터 특정 데이터를 가져오는 용도로, 서버의 데이터를 변경하지 않는다.
- GET 요청은 **브라우저에서 caching** 할 수 있다. 때문에 기존의 caching된 데이터가 응답될 가능성이 있다.

#### POST

- POST 방식은 Http Message 중 **Body 부분에 요청할 데이터가 포함**되어 전송된다. (때문에 보안 측면에서 GET에 비해 데이터 전달 방법이 상대적으로 나음)
- POST는 서버의 데이터를 변경하거나 추가하기 위해 사용된다.
- POST 요청은 GET과는 달리 브라우저에 caching되지 않는다.
- POST는 서버의 상태를 변경시키므로 멱등성이 유지되지 않는다.



## RESTfull API

RESTfull API란 http uri로 자원을 표시하고 http request method로 자원에 대한 처리를 표현한다. 별도의 인프라 구축이 필요 없고 사람이 읽기 쉬운 API라는 점이 장점이다.

단, 명확한 표준이 존재하지 않고 완전하게 RESTfull한 API를 만들기 어렵다는 문제가 있다.



## URI와 URL

#### URI

통합 자원 식별자(Uniform Resource Identifier, URI)는 인터넷에 있는 **자원을 나타내는 유일한 식별자 주소**이다. URI의 존재는 인터넷에서 요구되는 기본조건으로서 인터넷 프로토콜에 항상 붙어 다닌다. URL을 포함하는 상위개념이다.

#### URL

URL(Uniform Resource Locator, 문화어: 파일식별자, 유일자원지시기)은 네트워크 상에서 **자원이 어디 있는지 위치를 알려주기 위한 규약**이다. 즉, 컴퓨터 네트워크와 검색 메커니즘에서의 위치를 지정하는, 웹 리소스에 대한 참조이다. 흔히 웹 사이트 주소로 알고 있지만, URL은 웹 사이트 주소뿐만 아니라 컴퓨터 네트워크상의 자원을 모두 나타낼 수 있다. URI의 하위개념이다. 

https://example.com:3000/main?id=foo&name=poo 라는 주소에 대해서

- https://example.com:3000/main 까지가 자원의 위치로 URL에 해당한다. (동시에 URI)
- https://example.com:3000/main?id=foo&name=poo 의 request를 포함한 부분은 고유한 식별자로 URI에 해당한다. (URL은 아님)



## Reference

- https://velog.io/@josworks27/HTTP-Request-%EC%A0%95%EB%A6%AC
- https://github.com/JaeYeopHan/Interview_Question_for_Beginner/tree/master/Network
- https://velog.io/@jch9537/URI-URL
