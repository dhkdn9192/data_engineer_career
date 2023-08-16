
# Set up Elasticsearch

## Install

- 참조1: https://www.elastic.co/guide/en/elasticsearch/reference/current/targz.html

### Download and install archive for MacOS

The MacOS archive for Elasticsearch v7.0.0 can be downloaded and installed as follows:

(MacOS에서 Elasticsearch 설치 경로 : /Users/dhkdn9192/elasticsearch-7.0.0)

    wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.0.0-darwin-x86_64.tar.gz
    wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.0.0-darwin-x86_64.tar.gz.sha512
    shasum -a 512 -c elasticsearch-7.0.0-darwin-x86_64.tar.gz.sha512 
    tar -xzf elasticsearch-7.0.0-darwin-x86_64.tar.gz
    cd elasticsearch-7.0.0/
    
Home directory의 .bash_profile 파일에 아래와 같이 ES_HOME을 설정한다

    # Elasticsearch
    export ES_HOME=/Users/dhkdn9192/elasticsearch-7.0.0
    
### Installation for Linux

The Linux archive for Elasticsearch v7.0.0 can be downloaded and installed as follows:

    curl -L -O https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.0.0-linux-x86_64.tar.gz
    tar -xvf elasticsearch-7.0.0-linux-x86_64.tar.gz
    cd elasticsearch-7.0.0/bin


실행 시에는 아래와 같이 bin 안의 파일을 실행시킨다

    ./elasticsearch

백그라운드로 실행시키기 위해 다음과 같이 start.sh 스크립트를 만들어 사용하면 편리하다

    #! /bin/bash
    nohup /opt/elasticsearch-7.0.0/bin/elasticsearch > nohup_elasticsearch.out &
    
서비스 종료 시에는 해당 프로헤스를 kill하면 된다


    
### Enale automatic creation of X-Pack indices

X-Pack will try to automatically create a number of indices within Elasticsearch. By default, Elasticsearch is configured to allow automatic index creation, and no additional steps are required

$ES_HOME/config/elasticsearch.yml 파일에 다음과 같은 설정을 추가한다

    action.auto_create_index: .monitoring*,.watches,.triggered_watches,.watcher-history*,.ml*


### External network config

외부에서 Elasticsearch에 접근 가능하도록 하려면 $ES_HOME/config/elasticsearch.yml에 다음 설정을 추가한다. 단, 외부접근 가능한 공인 IP가 있어야 한다

    network.bind_host: 0.0.0.0 
    
당연히 포트가 열려있는지, 방화벽을 내렸는지 확인해야 한다

    netstat -tnlp
    systemctl status firewalld

### Important configuration

다음 설정들이 필요하다 (싱글노드를 상정함)

    cluster.name: my-application
    node.name: node-1
    path.data: /opt/elasticsearch-7.0.0/var/lib/elasticsearch
    path.logs: /opt/elasticsearch-7.0.0/var/log/elasticsearch
    bootstrap.memory_lock: true
    http.port: 9200
    discovery.seed_hosts: ["localhost"]
    cluster.initial_master_nodes: ["localhost"]



### Run from command line

    ./bin/elasticsearch
    

### Check that Elasticsearch is running

You can test that your Elasticsearch node is running by sending an HTTP request to port 9200 on localhost:


command line에서 아래와 같이 curl을 입력한다

    curl -X GET "localhost:9200/"
    
아래와 같은 응답을 받아야 정상이다

    {
      "name" : "gimdonghyeog-ui-MacBook-Pro.local",
      "cluster_name" : "elasticsearch",
      "cluster_uuid" : "RKUE3gwASMGDpp9PnOpZTA",
      "version" : {
        "number" : "7.0.0",
        "build_flavor" : "default",
        "build_type" : "tar",
        "build_hash" : "b7e28a7",
        "build_date" : "2019-04-05T22:55:32.697037Z",
        "build_snapshot" : false,
        "lucene_version" : "8.0.0",
        "minimum_wire_compatibility_version" : "6.7.0",
        "minimum_index_compatibility_version" : "6.0.0-beta1"
      },
      "tagline" : "You Know, for Search"
    }
    

### Running as a daemon

run as a daemon by -d option, and record the process ID in a file by -p option

    ./bin/elasticsearch -d -p pid    
    
Log messages can be found in the $ES_HOME/logs/ directory.


### Shutdown Elasticsearch

To shut down Elasticsearch, kill the process ID recorded in the pid file:

    pkill -F pid



## Setup 관련 트러블슈팅

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
