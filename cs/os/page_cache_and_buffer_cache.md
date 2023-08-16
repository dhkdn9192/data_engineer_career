# Page cache와 Buffer cache

page cache와 buffer cache는 리눅스 메모리의 캐시 영역의 일부이다. 캐시는 디스크 접근을 최소화하고 I/O 성능을 향상시켜준다. 리눅스 명령어 ```free```를 사용하면 시스템의 메모리 여유공간 및 사용량을 확인할 수 있는데 여기서 buffer/cache 항목이 각각 buffer cache, page cache를 의미한다.

```
[user@server ~]$ free -h
              total        used        free      shared  buff/cache   available
Mem:           251G        110G         70G        863M         70G        138G
Swap:           31G          0B         31G

```



- **Page cache** : 파일의 내용을 저장하고 있는 캐시. 한 번 읽은 파일의 내용을 페이지 캐시에 저장하여 다음번 접근에선 디스크가 아닌 캐시에서 읽는다.
- **Buffer cache** : 파일시스템의 메타데이터와 관련된 블록들을 저장하는 캐시. 블록 디바이스가 가지고 있는 블록 자체에 대한 캐시이다.
- **Buffer cache in Page cache** : 과거에는 버퍼 캐시와 페이지 캐시에서 데이터가 이중 캐시되는 문제가 있었다. 리눅스 2.4버전부터 버퍼 캐시가 페이지 캐시 안에 포함됨으로써 문제를 해결하였다.


## Reference

- https://dhkoo.github.io/2019/03/08/cache
- https://boxfoxs.tistory.com/288

