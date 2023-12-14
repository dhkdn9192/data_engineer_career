# 쿠버네티스 개념 및 용어

## [Kubernetes Object](https://kubernetes.io/ko/docs/concepts/overview/working-with-objects/kubernetes-objects/)
* 쿠버네티스 오브젝트는 쿠버네티스 시스템에서 영속성을 가지는 구성요소이다.
* 쿠버네티스는 클러스터의 상태를 나타내기 위해 이 오브젝트를 이용한다.
* 대부분의 경우 정보를 .yaml 파일로 kubectl에 제공한다.
* 쿠버네티스의 기본 단위인 Pod 등이 오브젝트에 해당한다.
  * Pod, ReplicaSet, Deployment, Service, Ingress, StatefulSet, ConfigMap, Secret 등


### 1) [Pod](https://kubernetes.io/ko/docs/concepts/workloads/pods/)
<img width="814" alt="image" src="https://github.com/dhkdn9192/data_engineer_career/assets/11307388/41ae4db9-521f-4372-9fae-53f75850aa29">

* Pod는 쿠버네티스에서 생성하고 관리할 수 있는 배포 가능한 가장 작은 컴퓨팅 단위이다.
* Pod는 하나 이상의 컨테이너(일반적으로 Docker)를 가진다.
* 같은 Pod의 컨테이너들은 같은 스토리지와 네트워크를 공유하며 서로 localhost로 접근 가능하다.
* Pod 예제
  * nginx:1.14.2 이미지를 실행하는 컨테이너로 구성된 파드
  ```yaml
  apiVersion: v1
  kind: Pod
  metadata:
    name: nginx
  spec:
    containers:
    - name: nginx
      image: nginx:1.14.2
      ports:
      - containerPort: 80
  ```
  * 위의 정의된 파드를 실행하려면
  ```bash
  kubectl apply -f https://k8s.io/examples/pods/simple-pod.yaml
  ```


### 2) [ReplicaSet](https://kubernetes.io/ko/docs/concepts/workloads/controllers/replicaset/)
* ReplicaSet은 Pod가 항상 일정한 복제본 수를 유지하도록 관리하며, Pod를 생성하고 개수를 유지하기 위해 반드시 필요한 오브젝트이다.
* Pod의 복제본 개수, 생성할 Pod의 템플릿 등의 설정값을 갖는다.
* 보통 Deploymebnt 등 다른 오브젝트에 의해서 ReplicaSet이 사용된다.
<img width="814" alt="image" src="https://github.com/dhkdn9192/data_engineer_career/assets/11307388/b344e68f-b603-433c-9653-2d0d3ac0fff1">


### 3) [Deployment](https://kubernetes.io/ko/docs/concepts/workloads/controllers/deployment/)
* Deployment는 Pod와 ReplicaSet에 대한 선언적 업데이트를 제공한다.
* 일반적으로 Pod와 ReplicaSet을 직접 생성하지 않고 Deployment를 통해 관리한다.
* Deployment 예제
  * 3개의 nginx Pod를 불러오기 위한 ReplicaSet을 생성
  ```yaml
  apiVersion: apps/v1
  kind: Deployment
  metadata:
    name: nginx-deployment
    labels:
      app: nginx
  spec:
    replicas: 3
    selector:
      matchLabels:
        app: nginx
    template:
      metadata:
        labels:
          app: nginx
      spec:
        containers:
        - name: nginx
          image: nginx:1.14.2
          ports:
          - containerPort: 80
  ```

### 4) [Service](https://kubernetes.io/ko/docs/concepts/services-networking/service/)
* Pod 집합에서 실행중인 애플리케이션을 네트워크 서비스로 노출하는 추상화 방법
* 쿠버네티스에서 Pod는 언제든 새로 만들어지고 제거될 수 있으므로 본질적으로 고정된 IP와 포트를 가질 수 없다.
* 따라서 쿠버네티스는 Service 오브젝트를 이용하여 Pod에게 고유한 IP 주소와 Pod 집합에 대한 단일 DNS 명을 부여한다.
* 또한 Service는 Pod들 간의 Load Balance를 수행할 수 있다.
* Service 예제
```yaml
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  selector:
    app.kubernetes.io/name: MyApp
  ports:
    - protocol: TCP
      port: 80
      targetPort: 9376
```


### 5) [Ingress](https://kubernetes.io/ko/docs/concepts/services-networking/ingress/)
* 클러스터 내의 서비스에 대한 외부 접근을 관리하는 API 오브젝트이며, 일반적으로 HTTP를 관리한다.
* 인그레스는 부하 분산, SSL 종료, 명칭 기반의 가상 호스팅을 제공할 수 있다.
* 웹 애플리케이션의 예시를 보면, 프록시 서버는 서버나 IP가 바뀌면 설정을 수정해야 한다. k8s에선 인그레스가 이러한 작업을 자동화해준다. 
* 인그레스는 클러스터 외부에서 클러스터 내부 서비스로 HTTP와 HTTPS 경로를 노출한다. 트래픽 라우팅은 인그레스 리소스에 정의된 규칙에 의해 컨트롤된다.
<img width="713" alt="image" src="https://github.com/dhkdn9192/data_engineer_career/assets/11307388/c522bb27-aa0d-4023-89d0-70d3061f48ff">


### 6) [StatefulSet](https://kubernetes.io/ko/docs/concepts/workloads/controllers/statefulset/)
* StatefulSet은 애플리케이션의 스테이트풀을 관리하는데 사용하는 워크로드 API 오브젝트이다.
* Pod 집합의 배포와 스케일링을 관리하며, Pod들의 순서 및 고유성을 보장한다 .
* Deployment 오브젝트와 유사하게, StatefulSet은 동일한 컨테이너 스펙을 기반으로 둔 파드들을 관리한다.
* Deployment 오브젝트와는 다르게, StatefulSet은 각 Pod의 독자성을 유지한다.
  * Deployment에서 Pod들은 서로 식별이 불가능한 반면, StatefulSet의 Pod들은 고유한 식별자를 가지며 서로 구분이 가능하다.


### 7) [ConfigMap](https://kubernetes.io/ko/docs/concepts/configuration/configmap/)
* ConfigMap은 key-value 쌍으로 환경변수와 같은 설정 데이터를 저장하는 데 사용하는 API 오브젝트이다.
* Pod는 볼륨에서 환경변수, 커맨드-라인 인수 또는 설정파일로 ConfigMap을 사용할 수 있다.
* ConfigMap을 사용하면 애플리케이션과 환경 구성을 분리할 수 있다.


### 8) [Secret](https://kubernetes.io/ko/docs/concepts/configuration/secret/)
* Secret은 암호, 토큰 또는 키와 같은 소량의 중요한 데이터를 포함하는 오브젝트이다.
* ConfigMap과 유사하지만 민감한 정보나 기밀 데이터를 보관하는 용도로 사용한다.




## [커스텀 리소스(CR/CRD)](https://kubernetes.io/ko/docs/concepts/extend-kubernetes/api-extension/custom-resources/#%EC%BB%A4%EC%8A%A4%ED%85%80%EB%A6%AC%EC%86%8C%EC%8A%A4%EB%8D%B0%ED%94%BC%EB%8B%88%EC%85%98)
* k8s는 API를 통해 다양한 내장 리소스(Pod 등)을 제공한다.
* 사용자가 필요한 리소스(CR; Custom Resource)를 직접 정의해 사용할 수 있으며 k8s는 모든 기능을 기본으로 제공하기보단 이러한 확장성을 제공하는데 중점을 둔다.
* k8s에선 CR을 생성하기 위해 CRD 혹은 API 애그리게이션 총 2가지 방법을 제공한다.
* CRD (Custom Resource Definitnion)
  * CRD 오브젝트를 정의하면 지정한 이름과 스키마를 사용하여 새 커스텀 리소스가 만들어진다.
  * CRD는 API 애그리게이션과 달리 프로그래밍이 필요하지 않다. 사용자는 CRD 컨트롤러에 대한 모든 언어를 선택할 수 있다.
* CRD 예제
  * 다음과 같이 yaml 파일로 CRD를 작성한다.
  ```yaml
  # 파일명 : resourcedefinition.yaml
  
  apiVersion: apiextensions.k8s.io/v1
  kind: CustomResourceDefinition
  metadata:
    # name must match the spec fields below, and be in the form: <plural>.<group>
    name: crontabs.stable.example.com
  spec:
    # group name to use for REST API: /apis/<group>/<version>
    group: stable.example.com
    # list of versions supported by this CustomResourceDefinition
    versions:
      - name: v1
        # Each version can be enabled/disabled by Served flag.
        served: true
        # One and only one version must be marked as the storage version.
        storage: true
        schema:
          openAPIV3Schema:
            type: object
            properties:
              spec:
                type: object
                properties:
                  cronSpec:
                    type: string
                  image:
                    type: string
                  replicas:
                    type: integer
    # either Namespaced or Cluster
    scope: Namespaced
    names:
      # plural name to be used in the URL: /apis/<group>/<version>/<plural>
      plural: crontabs
      # singular name to be used as an alias on the CLI and for display
      singular: crontab
      # kind is normally the CamelCased singular type. Your resource manifests use this.
      kind: CronTab
      # shortNames allow shorter string to match your resource on the CLI
      shortNames:
      - ct
  ```
  * 다음 명령어로 CR을 생성한다.
  ```bash
  kubectl apply -f resourcedefinition.yaml
  ```





## Reference
* https://subicura.com/2019/05/19/kubernetes-basic-1.html
