# Elasticsearch REST API

## CRUD of Elasticsearch

Elasticsearch | RDBMS | CRUD
------------- | ----- | ----
GET | Select | Read
PUT | Update | Update
POST | Insert | Create
DELETE | Delete | Delete


## Basic REST API examples

'classes'란 이름의 인덱스 조회하기

    curl -XGET http://localhost:9200/classes?pretty

'classes'란 이름의 인덱스 추가하기
    
    curl -XPUT http://localhost:9200/classes
    
'classes'란 이름의 인덱스 삭제하기
    
    curl -XDELETE http://localhost:9200/classes
    
'classes' 인덱스에 document 추가하기
    
    curl -XPOST http://localhost:9200/classes/class/1/ -d '{"name":"dhkim","phone":"010-1234-5678"}' -H 'Content-Type: application/json'
    # 'classes'란 이름의 인덱스(데이터베이스)의 'class'란 이름의 타입(테이블)에서 _id를 1로 하여 doc을 입력한다
    
json 파일 형태의 document를 추가하기

    # es_sample.json의 내용 : {"name":"wow","phone":"111-222-333"}
    curl -XPOST http://localhost:9200/classes/class/2/ -d @es_sample.json -H 'Content-Type: application/json'
     
데이터 update하기

    curl -XPOST http://localhost:9200/classes/class/2/_update -d '{"doc":{"age":"29"}}' -H 'Content-Type: application/json'
    # rest api 상으론 POST를 써도 update가 가능하다

## Bulk

대량의 데이터를 한꺼번에 입력하기

    curl -XPOST http://localhost:9200/_bulk?pretty --data-binary @bulk_sample.json
    
## Mapping

### Create Index

'myclasses'란 이름의 인덱스를 새로 생성한다

    curl -XPUT http://localhost:9200/myclasses

위 명령어를 실행하면 mapping이 비어있는 새로운 인덱스가 생성된다

    {
      "myclasses" : {
        "aliases" : { },
        "mappings" : { },
        "settings" : {
          "index" : {
            "creation_date" : "1556349459214",
            "number_of_shards" : "1",
            "number_of_replicas" : "1",
            "uuid" : "M1wr2TosQMmXtSXPb3R-dg",
            "version" : {
              "created" : "7000099"
            },
            "provided_name" : "myclasses"
          }
        }
      }
    }

### Create Mapping

매핑 내용이 기록된 json 파일을 사용하여 매핑을 생성한다

    curl -XPUT http://localhost:9200/myclasses/mytype/_mapping -d @mymapping.json  
