# Kerberos

많은 구성요소들로 구성된 네트워크에선 안전하게 인증을 수행하기 위해 커버로스 인증을 사용할 수 있다.
하둡 클러스터처럼 많은 프로세스들과 클라이언트들이 혼재된 환경에서 커버로스 인증을 사용하여 사용자를 식별하고 인증 제어를 구현할 수 있다.


## Kerberos 주요 구성요소

* KDC (Key Distribution Center)
  * AS, TGS, Kerberos DB로 구성됨
  * 유저와 서버 등 커버로스 네트워크 구성요소들의 인증을 관리하고 티켓을 발급하고 인증 정보를 DB로 관리하는 주체
* AS (Authentication Server)
  * 사용자로부터 인증 요청을 받아 TGT를 발행하는 서버
* TGS (Ticket Granting Server)
  * TGT를 보유한 사용자에게 티켓을 발급하는 서버
* Principal
  * 커버로스 네트워크의 식별자로서 KDC는 principal에 대해서 인증 티켓을 발급


## Principal
커버로스에서 principal은 유니크한 식별자다. 클라이언트 혹은 프로세스 간에 통신을 하려면 이 principal에 대해서 티켓을 발급받아야 한다.

principal은 다음과 같이 primary, instance, realm으로 구성된다. `primary/instance@REALM`.

* primary
  * principal의 첫번째 구성요소. 유저의 경우에는 username이 호스트의 경우엔 hostname이 primary가 된다.
  * 예시) admin
* instance
  * instance는 부가적인 문자열로 principal의 인스턴스 주소라 할 수 있다. 유저의 경우엔 instance 없이 principal을 구성할 수도 있다. 호스트의 경우 호스트의 fqdn을 사용한다.
  * 예시) daffodil.mit.edu
* realm
  * realm은 대문자로 구성된 커버로스 도메인 이름이다.
  * 예시) EXAMPLE.COM
 

## Kerberos 인증 절차
1. 사용자는 KDC의 AS(Authentication Server)에게 인증을 요청
2. AS는 ID,PW를 확인하여 인증을 수행, 인증될 경우 사용자에게 TGT(Ticket Granting Ticket)를 발행
3. 사용자는 TGT와 인증정보를 KDC의 TGS(Ticket Granting Server)에 전송하여 티켓을 요청
4. TGS는 TGT와 인증정보를 복호화하여 ID를 검증, 검증될 경우 SGT(Session Granting Ticket)를 발행
5. 사용자는 통신하고자 하는 서버에 SGT와 인증정보를 전송, 서버측에선 SGT와 인증정보를 복호화하여 ID를 검증하는 것으로 인증을 확인하고 통신 수행


## 참고자료
* https://blogger.pe.kr/920
* https://web.mit.edu/kerberos/krb5-1.5/krb5-1.5.4/doc/krb5-user/What-is-a-Kerberos-Principal_003f.html
* https://www.devkuma.com/docs/kerberos/
* https://docs.oracle.com/cd/E26925_01/html/E25888/intro-25.html
