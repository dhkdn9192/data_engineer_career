# Trouble Shooting

## Setup 관련 이슈

### max file descriptors

- 에러 로그

    
    ERROR. max file descriptors [4096] for elasticsearch process is too low, increase to at least [65536]
    
    
- 해결 방안

다음 명령어로 limits 설정 파일을 연다
    
    vim /etc/security/limits.conf
    
아래 라인들을 추가한다. (bigdata 대신 elasticsearch를 실행할 유저 이름을 입력한다)

    bigdata soft memlock unlimited
    bigdata hard memlock unlimited
    bigdata soft nofile 65536
    bigdata hard nofile 65536
    bigdata soft nproc 32768
    bigdata soft nproc 32768
    
    
### max virtual memory

- 에러 로그

    
    ERROR. max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]
    
- 해결 방안

아래 명령어로 프로세스당 메모리 맵 최대 수를 설정한다. root 권한으로 실행한다

    sysctl -w vm.max_map_count=262144
    
재부팅 후에도 적용 가능하도록 /etc/sysctl.conf에도 위 명령러를 추가한다