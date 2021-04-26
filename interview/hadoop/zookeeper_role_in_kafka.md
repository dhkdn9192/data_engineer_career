# Kafka에서 Zookeeper의 역할



<br>



## Zookeeper in Kafka

Kafka는 2.8.0 이전 버전까지는 공통적으로 Zookeeper를 코디네이트 도구로 사용한다. Zookeeper가 Kafka에서 수행하는 역할은 크게 5가지이다.

1. **Controller Election** : controller는 각 파티션에 대해 leader/follower 관계를 관리하는 broker이다. Zookeeper는 만약 어느 broker 노드가 shut down될 경우, shut down된 노드의 leader 파티션을 다른 노드의 replica가 대체할 것을 보장해준다.

2. **Cluster Membership** : Zookeeper는 클러스터 상의 정상적인 broker 리스트를 관리한다.

3. **Topic Configuration** : Zookeeper는 모든 토픽의 configuration을 관리한다. 현재 유효한 토픽들 리스트, 각 토픽의 파티션 수, replica들의 위치, 토픽별 configuration override 등의 정보를 관리한다.

4. **Access Control Lists (ACLs)** : Zookeeper는 모든 토픽에 대해 접근제어목록(ACL)을 관리한다. 토픽 별 read/write 허용 사용자 리스트, consumer group 리스트, 그룹별 멤버 리스트, consumer group별 각 파티션에 대한 최신 offset 정보 등을 관리한다.
5. **Quotas (허용량)** : Zookeeper는 각 클라이언트가 데이터를 얼마나 read/write 할 수 있는지에 대한 허용량을 관리한다.



<br>



## Zookeeper 최적화

- 대부분의 경우, 8GB RAM이면 Zookeeper를 구동하기에 충분하다.
- Zookeeper를 위한 CPU 코어를 할당함으로써 Context Switching 이슈가 발생하지 않도록 한다.
- SSD를 사용하여 Disk write latency를 낮춘다.



<br>



## Reference

- https://dattell.com/data-architecture-blog/what-is-zookeeper-how-does-it-support-kafka/

