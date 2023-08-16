# Container vs VM

- 핵심키워드 :  ```hypervisor```, ```docker```, ```virtual box```



## Container Architecture


![container_architecture_diagram](https://github.com/dhkdn9192/data_engineer_career/blob/master/cloud/docker/img/container_architecture_diagram.png)


- 컨테이너는 호스트 OS의 커널 위에 빌드되어 **호스트 OS와 커널을 공유**한다.
- VM과 달리 게스트 OS 이미지가 통째로 올라가지 않아 용량이 작고 I/O가 빠르다.
- 커널이 공유되는 등 VM에 비해 격리 수준이 약하다.
- 컨테이너 이미지의 생성/배포가 용이하고 k8s를 이용한 오케스트레이션이 가능하다.


## Virtual Machine Artchitecture

![vm_architecture_diagram](https://github.com/dhkdn9192/data_engineer_career/blob/master/cloud/docker/img/vm_architecture_diagram.png)


- 컨테이너와 달리, VM은 커널을 포함하는 완전한 게스트 OS가 실행된다.
- 호스트 OS 위에서 **hypervisor가 하드웨어를 가상화**하여 강력한 수준으로 격리가 이뤄진다.
- 완전한 게스트 OS 이미지가 올라가므로 용량을 많이 차지하고 무겁고 느리다.


## Docker vs VM

![docker_vs_vm](https://github.com/dhkdn9192/data_engineer_career/blob/master/cloud/docker/img/docker_vs_vm.png)



## Reference

- https://docs.microsoft.com/ko-kr/virtualization/windowscontainers/about/containers-vs-vm
- https://medium.com/@darkrasid/docker와-vm-d95d60e56fdd



