# 5 Logstash Filter Plugins You Need to Know About

- 참조: https://logz.io/blog/5-logstash-filter-plugins/

ELK에서 Logstash는 로그의 집계와 처리 등 리소스를 많이 요구하는 작업을 처리한다. 
Elasticsearch는 Logstash가 파싱 및 구조화한 로그 메시지를 인덱싱하여 분석 및 시각화한다. 


구체적으로 어떤 프로세싱이 이뤄지는지는 Logstash configuraion 파일의 filter 섹션에서 정해진다.
로그를 가공하는데 사용될 수 있는 매우 다양한 filter plugins들이 제공된다.
가장 보편적으로 사용되는 filter plugin은 <b>grok</b>이며 그 외에도 유용한 plugin들이 많다.


어떤 plugin들을 쓸지는 로그에 따라 달라지겠지만, 여기선 일반적으로 가장 유용한 5가지를 알아보고자 한다.


## 1. grok

