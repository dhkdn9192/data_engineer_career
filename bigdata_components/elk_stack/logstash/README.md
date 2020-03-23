# Logstash

logstash 개념과 설치, 실무 프로젝트 코드 정리

- consumer : kafka-consumer logstash 소스코드
- producer : kafka-producer logstash 소스코드

## Basic Concept

오픈소스 서버의 데이터 처리 파이프라인인 Logstash는 다양한 소스에서 
동시에 데이터를 수집하여 변환한 후 자주 사용하는 저장소로 전달한다 (https://www.elastic.co/kr/products/logstash)

## Pipeline 구조

logstash pipeline의 데이터 흐름은 크게 3가지로 구분된다.

<img src="img/basic_logstash_pipeline.png" alt="basic_logstash_pipeline" style="width: 400px;" align="middle"/>

- inputs
    - file, beats(Elastic Beats), kafka, elasticsearch 등 다양한 소스로부터 데이터를 
    logstash로 가져온다
- filter
    - 입력된 각각의 로그데이터에 대해 필터링, 파싱 등을 적용
    - grok: 비정형 이벤트 데이터로부터 필드별 데이터값을 추출, 파싱
    - mutate: 이벤트 데이터에 대해 일반적인 데이터 변환을 수행
    - ruby: ruby 프로그래밍을 이용하여 데이터 처리
    - date: 날짜, 시간 정보를 파싱
    - etc...
- outputs
    - 파이프라인의 최종단계로, 이벤트 데이터를 목적지로 전달한다
    - elasticsearch
    - file
    - kafka
    - mongodb
    - webhdfs
    - etc...


config file format




    input {
        kafka {
            ...데이터 입력...
        }
    }
    
    filter {
        mutate {
            ...데이터 가공...
        }
    }
    
    output {
        elasticsearch {
            ...결과 저장...
        }    
    }



## Reference

- [grok 패턴 정의](https://streamsets.com/documentation/datacollector/latest/help/datacollector/UserGuide/Apx-GrokPatterns/GrokPatterns_title.html#concept_chv_vmj_wr)
- [grok 패턴 테스트 사이트](https://grokconstructor.appspot.com/do/match#result)
- [config 조건문](https://www.elastic.co/guide/en/logstash/current/event-dependent-configuration.html)
- [Logstash 실행하면 모든 각각의 Log 데이터에 @version과 @timestamp 필드가 기본으로 추가됨](https://lge920904.tistory.com/143)


