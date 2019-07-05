# Install Cloudera Manager

- info: CDH 6.2.x 설치에 대한 문서. cloudera manager 역할을 수행할 서버에 Cloudera Manager Server를 설치한 뒤, Cloudera Manager를 통해 각 노드들에 cloudera 및 밀요한 component들을 설치한다.
- reference: https://www.cloudera.com/documentation/enterprise/latest/topics/installation.html
 

## Before You Install
- 링크를 참조하여 설치 전 준비작업을 수행한다 (네트워크, 방화벽, 포트, ssh, SELinux, hostname 등에 대한 설정)
- 현재 cloudera, cloudera-node1~4까지의 서버들은 위 설정들이 완료되어 있으므로 별도의 수정된 서버 or 신규 서버가 아니라면 이 과정을 패스한다

## Cloudera Manager Server 설치
- cloudera(172.22.1.149) 서버에 ssh 접속 후 cloudera-manager-installer.bin 파일을 실행 (/opt 경로에 존재. 없으면 cloudera에서 다운로드 가능)



    $ wget https://archive.cloudera.com/cm6/6.2.0/cloudera-manager-installer.bin
    $ chmod u+x cloudera-manager-installer.bin
    $ sudo ./cloudera-manager-installer.bin

   
    
- 라이센스 동의 및 설치를 진행

![img01](imgs/cm_img01.png)

- 설치 완료 후 cloudera manager 웹(http://172.22.1.149:7180) 접속 (접속이 안 될 경우 서비스가 진행될 때까지 대기)

![img02](imgs/cm_img02.png)

- 로그인 후 cloudera 설치 시작


## Cloudera Cluster 설치

- Select Edition: Cloudera Express 선택

![img03](imgs/cm_img03.png)

- Specify Hosts: 클러스터에 등록할 각 노드의 hostname들을 입력하고 "검색"을 눌러 위와 같은 화면이 출력되는 걸 확인

![img04](imgs/cm_img04.png)

- 레포지토리 선택: default 옵션을 선택하되, CDH 버전은 6.2.0이어야한다
- JDK 설치 옵션: "Oracle Java SE Development Kit(JDK) 설치", "Java Unlimited Strength 암호화 정책 파일 설치" 모두 체크
- SSH 로그인 정보 제공: 암호는 각 서버들의 ssh 접속 비밀번호를 입력한다. root로 접속할 때의 비밀번호이다. port는 기본 22를 사용한다
- Install Agents: 앞에서 명시한 각 호스트에 cloudera agent를 설치한다

![img05](imgs/cm_img05.png)

- Install Parcels: 각 호스트에 앞서 명시한 설치할 parcel들을 설치한다.
- Inspect Cluster: "I understand the risks, let me continue with cluster creation" 선택

![img06](imgs/cm_img06.png)


## 클러스터 설정

- Select Services: "사용자 지정 서비스" 선택 후 설치할 서비스들을 선택
    - HBase, HDFS, Hive, Hue, Kafka, Oozie, Spark, YARN, ZooKeeper
- 역할 할당 사용자 지정: 아래와 같은 예시로 할당할 수 있다

![img07](imgs/cm_img07.png)

- 데이터베이스 설정: "내장된 데이터베이스 사용" 선택. 암호를 미리 복사하여 보관해두어야 한다

![img08](imgs/cm_img08.png)

- 변경 내용 검토: 각 디렉토리 설정에서 모든 경로를 /opt/cdm 아래에 두면 삭제할 때 편하게 지울 수 있다
- 명령 세부 정보: 설치된 서비스들이 정상적인지 확인

![img09](imgs/cm_img09.png)

- 요약: 모든 설치가 정상적으로 끝나면 다음과 같은 화면이 출력된다

![img10](imgs/cm_img10.png)
