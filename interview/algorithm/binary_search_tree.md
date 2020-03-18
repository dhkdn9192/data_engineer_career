# Binary Search Tree 
It is a node-based binary tree data structure which has the following properties:
- The left subtree of a node contains only nodes with keys lesser than the node’s key.
- The right subtree of a node contains only nodes with keys greater than the node’s key.
- The left and right subtree each must also be a binary search tree.

![BSTSearch](img/BSTSearch.png)

## Coding

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

insert 메소드 구현
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

find 메소드 구현
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
            
            if child.data == data:
                return True
            elif child is None:
                return False
            else:
                parent = child
                
        return False
```

delete 메소드 구현. 제거 대상 노드의 양쪽 자식이 모두 존재할 경우, 오른쪽 서브트리의 가장 왼쪽 노드를 가져와서 대체해야 한다.
```Python
class BinarySearchTree(object):
    ...
    def delete(self, data):
        (생략)
```

이하 [노트북](bst.ipynb) 참조

## Reference
- https://www.geeksforgeeks.org/binary-search-tree-data-structure/
- https://geonlee.tistory.com/72
