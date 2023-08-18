# On-heap과 Off-heap


## On-heap
- Java는 new 연산으로 생성된 객체를 JVM의 heap 메모리에 저장하는데 이 때 저장되는 heap 영역을 on-heap store라 한다.
- heap 메모리의 객체들은 Garbage Collector에 의해 자동으로 해제되므로 사용자가 명시적으로 메모리를 관리할 필요가 없다.
- on-heap store에 저장된 객체가 많거나 매우 큰 사이즈의 데이터를 다룬다면 GC(특히 Full GC)로 인한 성능저하가 커질 수 있다. (stop-the-world)
- 특히 실시간 서비스의 경우 Full GC로 인한 stop-the-world가 실시간성을 저해할 수 있다.
- 이러한 문제를 해결하기 위해 GC 알고리즘을 개선하는 방법도 있지만 아예 애플리케이션 단에서 불필요한 GC를 발생시키지 않도록 하는 방법도 있다.


## Off-heap
- heap 영역의 밖 즉, off-heap store에 객체를 저장하여 **GC의 대상으로 삼지 않는** 방법이 있다.
- Java에선 nio를 통한 off-heap store 사용이 가능하며, Direct ByteBuffer를 사용해 GC 대상 밖인 버퍼 공간에 데이터를 저장한다. (단, 직접 메모리를 관리하므로 번거롭고 위험)
  - EHCache, Terrcotta BigMemory 등의 off-heap store를 사용하는 캐시 라이브러리로 비교적 안전하게 메모리를 관리할 수 있다.
- Off-heap store에 저장되는 객체는 **직렬화(Serialize)하여 저장해야** 한다.
- Off-heap store 사용은 Allocation/Deallocation 비용이 일반 버퍼에 비해 높다.
- 따라서, Off-heap store에 저장할 객체는 **사이즈가 크고(large)**, 메모리에 **오래 잔존하는(long-lived)** 객체이면서, **시스템 네이티브 I/O 연산의 대상이 되는** 객체를 대상으로 하는 것이 좋다.


## 결론
**Full GC로 인한 성능저하를 줄이기 위해 Off-heap에 객체를 저장하여 On-heap 사이즈를 줄이는** 방법이 있으며, 
이를 위한 Off-heap 객체는 성능향상이 보장되는 경우에만 사용하는 것이 좋다



## Reference
- https://soft.plusblog.co.kr/163
