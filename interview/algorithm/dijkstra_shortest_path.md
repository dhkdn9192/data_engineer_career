# Dijkstra 최단경로



## 기본 개념

Dijkstra 최단경로 알고리즘은 그래프 상에서 노드 A로부터 각 노드까지의 최단경로를 구하는 알고리즘이다. 



## 동작 방식

1. 출발노드와 도착노드를 설정한다.
2. 모든 노드들에 대해 두 노드 사이의 edge 가중치를 부여한다. (weights 딕셔너리 생성)
3. 출발노드부터 시작하여 BFS 방식으로 인접한 노드들을 방문하고 출발노드로부터의 거리를 계산한다.
4. 계산한 거리가 기존 거리보다 짧은 경우에만 갱신한다.
5. BFS 큐가 빌 때까지 탐색을 반복한다.



## Python 구현하기

- BFS 탐색 시 큐에서 "출발노드~각노드 거리"가 짧은 순으로 추출하기 위해 heap 자료구조를 사용한다.

  ```python
  import heapq
  ```

  

- 샘플 데이터: 노드 A,B,C,D,F,G,H로 구성된 graph의 각 edge 가중치가 아래와 같다.

  ```python
  weights = {
      'A': {'B':3, 'C':7, 'D':10},
      'B': {'A':3, 'C':2, 'F':5},
      'C': {'A':7, 'B':2, 'D':6, 'G':4, 'H':10},
      'D': {'A':10, 'C':6, 'H':9},
      'F': {'B':5, 'H':4},
      'G': {'C':4, 'H':2},
      'H': {'F':4, 'G':2, 'C':10, 'D':9}
  }
  ```

  

- 출발노드로부터 각 노드까지의 최단거리를 기록할 distances 딕셔너리와 BFS 탐색용 queue를 생성/초기화한다.

  ```python
  distances = dict()
  queue = []
  
  distances['A'] = (0, ['A'])
  heapq.heappush(queue, (0, 'A'))
  ```

  

- queue가 빌 때까지 BFS 탐색을 수행하며 각 노드에 대해 출발노드로부터의 최단경로를 계산/갱신한다.

  ```python
  while queue:
      
      current_dist, current_node = heapq.heappop(queue)
      
      for tmp_node, tmp_weight in weights[current_node].items():
          new_dist = current_dist + tmp_weight
          
          # 새로 계산한 거리가 기존 최단경로보다 길다면 패스
          if tmp_node in distances and distances[tmp_node][0] <= new_dist:
              continue
          
          distances[tmp_node] = (new_dist, distances[current_node][1] + [tmp_node])
          print(f">> distance to {tmp_node} updated: {new_dist}")
          
          heapq.heappush(queue, (new_dist, tmp_node))
  ```

  

- 수행 시, 출발노드로부터 각 노드까지의 최단경로 distances 결과값은 아래와 같다.

  ```
  {'A': (0, ['A']),
   'B': (3, ['A', 'B']),
   'C': (5, ['A', 'B', 'C']),
   'D': (10, ['A', 'D']),
   'F': (8, ['A', 'B', 'F']),
   'G': (9, ['A', 'B', 'C', 'G']),
   'H': (11, ['A', 'B', 'C', 'G', 'H'])}
  ```

  







## Reference

- https://mattlee.tistory.com/50
- https://justkode.kr/algorithm/python-dijkstra
