# How to set up Apache Zeppelin

서버에 Apache Zeppelin을 설치하여 Scala-Spark 프로그래밍 환경을 구성해보자.

## 설치환경

| 항목 | 버전 |
|-|-|
| OS | centos 7.6|
| Oracle JDK | 1.8 |
| Apahce Spark | 2.4.5 |
| Apache Zeppelin | 0.8.2|

* zeppelin 0.8.0은 spark 2.2 버전대 + JDK 1.8에서만 호환된다고 한다. 
zeppelin 0.8.2 또한 호환 버전 이슈가 있을 것으로 보이며 위와 같은 환경에선 호환되는 것을 확인함.

## 환경변수 설정
```~/.bash_profile```에 다음 변수들을 export 설정
|||
|-|-|
| JAVA_HOME | /usr/lib/jvm/java-1.8.0-openjdk |
| SPARK_HOME | /usr/local/spark|


## Zeppelin 설치 과정

### 1. zeppelin 설치 파일 다운로드
- 공식 다운로드 페이지(http://zeppelin.apache.org/download.html)에서 zeppelin-0.8.2-bin-all.tgz 파일 다운로드
- 서버의 지정 경로에서 tar -zxvf 명령어로 tgz 파일을 압축 해제 (ex. ```/data/zeppelin```)

### 2. configuration
- config 디렉토리 내의 ```zeppelin-env.sh.template``` 파일을 ```zeppelin-env.sh```로 변경하고 권한을 777로 변경
- ```zeppelin-env.sh``` 파일 내에 "ZEPPELIN_ADDR", "ZEPPELIN_PORT", "SPARK_HOME" 변수들을 설정해준다.

```bash
export ZEPPELIN_ADDR=0.0.0.0
export ZEPPELIN_PORT=8080
export SPARK_HOME=/usr/local/spark 
```

### 3. zeppelin start and stop
zeppelin 시작 명령어
```
bin/zeppelin-daemon.sh start
```

zeppelin 종료 명령어
```
bin/zeppelin-daemon.sh stop
```

