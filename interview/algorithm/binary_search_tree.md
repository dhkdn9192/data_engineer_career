# 이진트리와 이진탐색트리


## 이진트리 (Binary Tree)

- 트리의 종류
    - <b>Full Binary Tree</b> (정 이진 트리) : 모든 트리의 자식은 0개 또는 2개다.
    - <b>Perfect Binary Tree</b> (포화 이진 트리) : 모든 리프노드의 높이가 같다.
    - <b>Complete Binary Tree</b> (완전 이진 트리) : 트리의 원소를 왼쪽에서 차례대로 채워넣은 형태.
        - 모든 리프노드의 높이는 최대 1 차이
        - 노드의 오른쪽 자식이 있으면 반드시 왼쪽 자식도 존재

- 완전이진트리의 표현
    - n개 원소로 이뤄진 완전이진트리는 n개 원소의 배열로 표현할 수 있다.
    - n번째 원소의 왼쪽 자식은 2n 번째, 오른쪽 자식은 2n+1 번째 원소이다.
    - n번째 원소의 부모 노드는 \[n/2\] 번째 원소이다.

- 트리 순회 방법
    - <b>In-order Traversal</b> (중위 순회) : 왼쪽 자식, 자신, 오른쪽 자식 순으로 순회
    - <b>Pre-order Traversal</b> (전위 순회) : 자신, 왼쪽 자식, 오른쪽 자식 순으로 순회
    - <b>Post-order Traversal</b> (후위 순회) : 왼쪽 자식, 오른쪽 자식, 자신 순으로 순회

이진탐색트리를 중위순회(in-order)하면 정렬된 값들을 얻을 수 있다.


## 이진탐색트리 (Binary Search Tree)

![BSTSearch](img/BSTSearch.png)

이진탐색트리는 아래의 속성을 갖는다.
- 각 노드에 값이 있다.
- 값들은 전순서가 있다.
- 노드의 왼쪽 서브트리에는 그 노드의 값보다 작은 값들을 지닌 노드들로 이루어져 있다.
- 노드의 오른쪽 서브트리에는 그 노드의 값과 같거나 큰 값들을 지닌 노드들로 이루어져 있다.
- 좌우 하위 트리는 각각이 다시 이진 탐색 트리여야 한다.


### 노드와 트리 클래스

이진 트리의 각 노드들에 대한 클래스
```Python
class Node(object):
    def __init__(self, data):
        self.data = data
        self.left = self.right = None
```

위의 Node 인스턴스들로 구현될 이진 트리 클래스. root 노드가 존재하며 insert, find, delete 메소드를 포함해야 한다.
```Python
class BinarySearchTree(object):
    def __init__(self):
        self.root = None
        
    def insert(self, data):
        ...
        
    def find(self, data):
        ...
        
    def delete(self, data):
        ...
```


### find
이진탐색트리의 탐색 시간은 트리의 높이 h만큼 소요된다. 즉 O(h)이다.
```Python
def find(self, data):
    return self.find_node(self.root, data)

def find_node(self, node, data):
    if node is None:  # 리프노드 도달
        return False
    elif node.data == data:  # 현재 노드값이 찾는 값이라면 True
        return True
    elif node.data > data:  # 왼쪽 자식으로 넘어가기
        return self.find_node(node.left, data)
    else:  # 오른쪽 자식으로 넘어가기
        return self.find_node(node.right, data)
```


### insert
트리를 탐색하여 마지막 리프노드에 값을 입력해주므로 시간복잡도는 find와 마찬가지로 O(h)이다.
insert로 리프노드가 추가되어도 트리의 속성이 깨지지 않는다.
트리의 맨 왼쪽과 맨 오른쪽 노드는 각각 최소값과 최대값을 갖는다.
```Python
def insert(self, data):
    if self.root is None:  # 루트가 없다면 본 데이터로 루트를 만들어준다.
        self.root = Node(data)
    else:   # 루트부터 탐색하여 데이터 입력
        self.insert_node(self.root, data)

def insert_node(self, node, data):            
    if node.data > data:
        if node.left is None:
            node.left = Node(data)
        else:
            self.insert_node(node.left, data)
    elif node.data < data:
        if node.right is None:
            node.right = Node(data)
        else:
            self.insert_node(node.right, data)
    # 현재 노드값이 data와 같을경우, 이미 트리에 값이 있으므로 아무것도 안 함
    #else:
    #    pass

```


### delete
제거 대상 노드의 양쪽 자식이 모두 존재할 경우, 오른쪽 서브트리의 가장 왼쪽 노드를 가져와서 대체해야 한다.




## AVL Tree

이진탐색트리의 단점 보완한 트리.

그 외 힙이 있음


<br>


## Reference
- https://www.geeksforgeeks.org/binary-search-tree-data-structure/
- https://geonlee.tistory.com/72
- https://ratsgo.github.io/data%20structure&algorithm/2017/10/22/bst/
