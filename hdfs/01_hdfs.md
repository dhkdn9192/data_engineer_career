# HDFS


## webhdfs

curl, wget 등으로 hdfs에 접근할 수 있게 해주는 rest api 기능

- 설정
    - Cloudera Manager 웹 화면에서 [HDFS] - [구성] - [WebHDFS 설정] (dfs.webhdfs.enabled)에서 HDFS(서비스전체)를 체크해준다
- 포트
    - NameNode 웹 UI 포트
        - Cloudera Manager 웹 화면에서 [HDFS] - [구성] - [NameNode 웹 UI 포트] (dfs.namenode.http-address)의 설정 포트값을 확인한다.
        - 설치 시 디폴트값 50070이며 해당 포트가 listening 중인지 확인한다
        <br>
        $ netstat -tnlp | grep 50070
    - DataNode 웹 UI 포트
        - 디폴트 설정값은 50075이다
- 사용법
    - 디렉토리 만들기
    <br>
    $ curl -XPUT "http://cloudera-node1:50070/webhdfs/v1/user/hdfs/test_dir?op=MKDIRS&user.name=hdfs" -v
    - 파일 목록 보기
    <br>
    $ curl -XGET "http://cloudera-node1:50070/webhdfs/v1/user?op=LISTSTATUS"