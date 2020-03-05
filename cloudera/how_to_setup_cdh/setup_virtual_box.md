# Set Up VirtualBox for CDH

Virtualbox를 이용하여 가상 linux 서버들을 구성하고 그 위에 CDH를 설치한다. 필요한 준비물은 다음과 같다

- Oracle Virtualbox 5.2.20
- CentOS-7-x86_64-DVD-1804.iso

## 1. Virtualbox 가상 os 구성

### 1.1 공통 네트워크 설정

Virtualbox에서 [설정] - [네트워크] - [NAT 네트워크] 항목에서 새 항목을 추가한다

- 네트워크 이름:﻿NatNetwork
- 네트워크 CIDR:﻿10.0.2.0/24
- 네트워크 옵션: 'DHCP 지원'에 체크

Virtualbox 관리자에서 [전역 도구] - [만들기] 메뉴를 통해 '호스트 전용 네트워크'를 추가한다. 
'수동으로 어댑서 설정'을 체크하여 다음과 같이 입력한다

- IPv4 주소: 192.168.56.1
- IPv4 서브넷마스크: 255.255.255.0

DHCP 서버 설정은 다음과 같이 설정한다

- 서버주소:﻿192.168.56.100
- 서버마스크: 255.255.255.0
- 최저주소한계: 192.168.56.101
- 최주소한계: 192.168.56.254

'적용'을 클릭하여 설정을 반영한다

### 1.2 메모리 및 스토리지 설정

Virtualbox를 실행 중인 본인의 Mac Book은 RAM 16G, Storage 100G 사용 가능하며, CDH 클러스터는 노드 3대로 구성할 예정이다.
따라서 다음과 같이 각 가상환경을 구성한다.

- 기본메모리: 3096 MB
- 저장장치: 32 G (동적 확장)

### 1.3 네트워크 어댑터 설정

각 가상환경은 2개의 네트워크 어댑터를 사용한다. 어댑터1은 'NAT', 어댑터2는 '호스트 전용 어댑터'로 지정한다. 
'호스트 전용 어댑터'의 경우, [고급] - [무작위 모드]를 '모두 허용'으로 설정한다

### 1.4 CentOS 7 설치

구성한 가상환경 1대 위에 CentOS 7을 설치한다. 위에서 준비한 iso 파일을 사용한다. 
설치시, 네트워크는 어댑터1,2로 설정한 네트워크 2개를 모두 On으로 설정한다

### 1.5 고정 IP 및 호스트명 할당

#### 고정 IP 할당

/etc/sysconfig/network-crtipts 경로엔 ifcfg-enp... 파일이 2개 존재할 것이다. 앞에서 사용하도록 설정한 네트워크 어댑터 1, 2이다.
(본인의 경우엔 ifcfg-enp0s3, ifcfg-enp0s8) 이 중 '호스트 전용 네트워크'에 해당하는 설정파일을 수정하여 고정 IP및 물리주소를 사용하도록 해야 한다.
(본인의 경우엔 enp0s8이 호스트 전용 네트워크)

기존 BOOTPROTO 설정을 주석처리하고 아래와 같이 설정들을 추가한다

    TYPE=Ethernet
    BOOTPROTO=static
    ONBOOT=yes
    IPADDR=192.168.56.101
    GATEWAY=192.168.56.1
    NETMASK=255.255.255.0
    NETWORK=192.168.56.0
    HWADDR=08:00:27:87:52:85

기존 라인에 동일한 설정이 있다면 주석처리한다. IPADDR에 고정 IP를 입력한다. (101~103으로 사용한다) HWADDR에는 본 가상환경의 
'호스트 전용 네트워크' 어댑터의 물리주소를 두 글자 단위로 ':' 구분하여 입력한다

#### 호스트명 할당

/etc/hosts 파일을 열어 기존 내용을 삭제하고 아래와 같이 입력한다. (본 설정은 Virtualbox를 실행 중인 os의 /etc/hosts에도 동일하게 추가한다)

    127.0.0.1       node1
    192.168.56.101  node1
    192.168.56.102  node2
    192.168.56.103  node3
    
첫 번째 라인은 각 서버별로 node1~3으로 호스트명을 맞게 입력한다.

#### network 파일 설정

다음으로, /etc/sysconfig/network 파일을 열러 다음과 같이 입력한다. 

    # Created by anaconda
    NETWORKING=yes
    NETWORKING_IPV6=no
    
#### network 재시작

다음 명령어로 네트워크를 재시작한다.

    $ service network restart
    
에러 없이 재시작되어야 한다.

### 1.6 ssh 관련 패키지 설치

다음 명령어로 ssh 접속에 필요한 패키지를 설치한 후 reboot한다

    $ yum install openssh*
    $ service sshd restart
    $ chkconfig sshd on
    $ reboot
    
reboot된 후에 다시 네트워크 설정을 재시작한다

    $ service network restart
    
### 1.7 CDH을 위한 추가 설정들

아래 명령어들을 차례로 실행

- vim /etc/selinux/config     # SELINUX=disabled 변경
- sysctl -w vm.swappiness=100
- vim /etc/sysctl.conf        # vm.swappiness=100 추가
- vim /etc/rc.local           # 아래 두 라인 추가
    
    
    echo never > /sys/kernel/mm/transparent_hugepage/enabled
    echo never > /sys/kernel/mm/transparent_hugepage/defrag    
    
- vim /etc/security/limits.conf # 아래 설정들을 추가


    root soft nofile 65536
    root hard nofile 65536
    * soft nofile 65536
    * hard nofile 65536
    root soft nproc 32768
    root hard nproc 32768
    * soft nproc 32768
    * hard nproc 32768    

- systemctl stop firewalld  # 방화벽 정지
- systemctl disable firewalld   # reboot 되더라도 방화벽 올리지 않
- reboot


### 1.8 가상환경 복제

위까지 만든 가상환경을 복제한다. 'MAC주소 초기화' 옵션을 선택해야 하면 '완전한 복제'를 선택한다.
이 방법으로 node2, node3 두 개의 가상환경을 생성한다

각 가상환경에서 수정해야할 부분들이 있다.

- 고정 IP: 101 -> 102, 103
- 호스트명: node1 -> node2, node3
- 물리주소: 각 서버의 '호스트 전용 네트워크'의 MAC 주소를 입력

위 사항들을 변경해주었다면 아래의 명령어들을 수행한다

    $ service network restart
    $ reboot
    
리부트 후 아래의 명령어로 수정이 제대로 이뤄졌는지 확인한다

    $ ifconfig -> 고정IP 반영 여부 확인
    $ hostname -> 호스트명 변경 여부 확인
    
### 1.9 기타

각 가상환경에 대한 작업은 ssh로 접속하여 진행한다. 비밀번호 없이 편하게 접속하려면 Virtualbox를 실행 중인 os에서 
ssh 키를 생성하여 공개키 (id_rsa.pub) 내용을 각 가상환경의 authorized_keys에 입력한다
    


## 2. Cloudera-Manager 설치
    
node1에서 cloudera-manager-insatller 파일을 다운로드한다. /opt 경로에 다운로드 받는다.

    $ wget https://archive.cloudera.com/cm6/6.2.0/cloudera-manager-installer.bin
    
실행 가능하도록 권한을 수정한다.

    $ chmod +777 cloudera-manager-installer.bin
    
installer 실행한다.

    $ ./cloudera-manager-installer.bin
    
node1에 cloudera-manager를 설치했다면 웹 화면(192.168.56.101:7180)에 접속하여 CDH 설치를 진행한다


## 3. CDH 설치

cloudera-manager 화면에 접속하여 admin/admin으로 로그인한다. 이후로는 node1~3 서버에 CDH을 원하는 설정대로 설치한다
