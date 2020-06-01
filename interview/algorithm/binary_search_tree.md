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


### insert

```Python
class BinarySearchTree(object):
    ...
    def insert(self, data):        
        # root가 None일 경우 data를 root로
        if self.root is None:
            self.root = Node(data)
            return True
        
        # 트리를 탐색하다 leaf 노드에 도달하면 자식을 추가하고 True 반환
        parent = self.root
        child = -1
        while child is not None:
            child = parent.left if data <= parent.data else parent.right
            
            if child is None:
                if data <= parent.data:
                    parent.left = Node(data)
                else:
                    parent.right = Node(data)
            else:
                parent = child
                
        return True
```


### find

```Python
class BinarySearchTree(object):
    ...
    def find(self, data):
        # root가 None일 경우
        if self.root is None:
            return False
        
        # root가 찾는 노드일 경우
        if self.root.data == data:
            return True
        
        # 트리를 탐색하다 찾으면 True, 없으면 False 반환
        parent = self.root
        child = -1
        while child is not None:
            child = parent.left if data <= parent.data else parent.right
            
            if child is None:
                return False
            elif child.data == data:
                return True
            else:
                parent = child
                
        return False
```


### delete
제거 대상 노드의 양쪽 자식이 모두 존재할 경우, 오른쪽 서브트리의 가장 왼쪽 노드를 가져와서 대체해야 한다.

```Python
class BinarySearchTree(object):
    ...
    def delete(self, data):
        (생략)
```



## AVL Tree

이진탐색트리의 단점 보완

그 외 힙이 있음


<br>


## Reference
- https://www.geeksforgeeks.org/binary-search-tree-data-structure/
- https://geonlee.tistory.com/72
