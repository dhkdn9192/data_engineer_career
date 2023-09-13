# 쿠버네티스 개념 및 용어


## [인그레스(Ingress)](https://kubernetes.io/ko/docs/concepts/services-networking/ingress/)
* 클러스터 내의 서비스에 대한 외부 접근을 관리하는 API 오브젝트이며, 일반적으로 HTTP를 관리한다.
* 인그레스는 부하 분산, SSL 종료, 명칭 기반의 가상 호스팅을 제공할 수 있다.
* 웹 애플리케이션의 예시를 보면, 프록시 서버는 서버나 IP가 바뀌면 설정을 수정해야 한다. k8s에선 인그레스가 이러한 작업을 자동화해준다. 
* 인그레스는 클러스터 외부에서 클러스터 내부 서비스로 HTTP와 HTTPS 경로를 노출한다. 트래픽 라우팅은 인그레스 리소스에 정의된 규칙에 의해 컨트롤된다.
<img width="713" alt="image" src="https://github.com/dhkdn9192/data_engineer_career/assets/11307388/c522bb27-aa0d-4023-89d0-70d3061f48ff">


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

## [파드(Pod)](https://kubernetes.io/ko/docs/concepts/workloads/pods/)
<img width="814" alt="image" src="https://github.com/dhkdn9192/data_engineer_career/assets/11307388/41ae4db9-521f-4372-9fae-53f75850aa29">

* 파드(Pod) 는 쿠버네티스에서 생성하고 관리할 수 있는 배포 가능한 가장 작은 컴퓨팅 단위이다.
* 파드는 하나 이상의 컨테이너(일반적으로 Docker)를 가진다.
* 같은 파드의 컨테이너들은 같은 스토리지와 네트워크를 공유하며 서로 localhost로 접근 가능하다.
* 파드 예제
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


## [레플리카셋(ReplicaSet)](https://kubernetes.io/ko/docs/concepts/workloads/controllers/replicaset/)
* 레플리카셋은 파드가 항상 일정한 복제본 수를 유지하도록 관리하며, 파드를 생성하고 개수를 유지하기 위해 반드시 필요한 오브젝트이다.
* 파드의 복제본 개수, 생성할 파드의 템플릿 등의 설정값을 갖는다.
* 보통 디플로이먼트 등 다른 오브젝트에 의해서 레플리카셋이 사용된다.
<img width="814" alt="image" src="https://github.com/dhkdn9192/data_engineer_career/assets/11307388/b344e68f-b603-433c-9653-2d0d3ac0fff1">


## Reference
* https://subicura.com/2019/05/19/kubernetes-basic-1.html
