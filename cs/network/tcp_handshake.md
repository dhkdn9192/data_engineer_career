# TCP의 연결세션 생성과 종료

## 3-way handshake

- TCP/IP프로토콜을 이용해서 통신을 하는 응용프로그램이 데이터를 전송하기 전에 정확한 전송을 보장하기 위해 상대방 컴퓨터와 사전에 세션을 수립하는 과정을 의미한다
- 양쪽 모두 데이타를 전송할 준비가 되었다는 것을 보장하고, 실제로 데이타 전달이 시작하기전에 한쪽이 다른 쪽이 준비되었다는 것을 알수 있도록 한다
- 양쪽 모두 상대편에 대한 초기 순차일련변호를 얻을 수 있도록 한다


![tcp_3way_handshake](https://github.com/dhkdn9192/data_engineer_career/blob/master/cs/network/img/tcp_3way_handshake.png)

#### step 1
- A클라이언트는 B서버에 접속을 요청하는 SYN 패킷을 보낸다
- 이때 A클라이언트는 SYN 을 보내고 SYN/ACK 응답을 기다리는 ```SYN_SENT``` 상태가 된다

#### step 2
- B서버는 SYN요청을 받고 A클라이언트에게 요청을 수락한다는 ACK 와 SYN flag 가 설정된 패킷을 발송하고 A가 다시 ACK으로 응답하기를 기다린다
- 이때 B서버는 ```SYN_RECEIVED``` 상태가 된다

#### step 3
- A클라이언트는 B서버에게 ACK을 보내고 이후로부터는 연결이 이루어지고 데이터가 오가게 되는것이다
- 이때의 B서버 상태가 ```ESTABLISHED``` 이다.



## 4-way handshake

- 3-Way handshake는 TCP의 연결을 초기화 할 때 사용한다면, 4-Way handshake는 세션을 종료하기 위해 수행되는 절차이다


![tcp_4way_handshake](https://github.com/dhkdn9192/data_engineer_career/blob/master/cs/network/img/tcp_4way_handshake.png)

#### step 1
- 클라이언트가 연결을 종료하겠다는 FIN플래그를 전송한다

#### step 2
- 서버는 일단 확인메시지를 보내고 자신의 통신이 끝날때까지 기다리는데 이 상태가 ```TIME_WAIT``` 상태다

#### step 3
- 서버가 통신이 끝났으면 연결이 종료되었다고 클라이언트에게 FIN플래그를 전송한다

#### step 4
- 클라이언트는 확인했다는 메시지를 보낸다


#### 연결 종료로 인한 패킷 유실 방지

- Server에서 FIN을 전송하기 전에 전송한 패킷이 (Routing 지연이나 패킷 유실로 인한 재전송 등으로 인해) FIN패킷보다 늦게 도착하는 경우
- Client에서 세션을 종료시킨 후 뒤늦게 도착하는 패킷이 있다면 이 패킷은 Drop되고 데이터는 유실될 것이다 
- 이러한 현상에 대비하여 Client는 Server로부터 FIN을 수신하더라도 일정시간(디폴트 240초) 동안 세션을 남겨놓고 잉여 패킷을 기다리는 과정을 거치게 되는데 이 과정을 ```TIME_WAIT``` 라고 한다



## Reference
- https://mindnet.tistory.com/entry/%EB%84%A4%ED%8A%B8%EC%9B%8C%ED%81%AC-%EC%89%BD%EA%B2%8C-%EC%9D%B4%ED%95%B4%ED%95%98%EA%B8%B0-22%ED%8E%B8-TCP-3-WayHandshake-4-WayHandshake
