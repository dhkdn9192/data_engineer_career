# Sort Algorithm

## Merge Sort

merge sort의 과정은 배열을 매 재귀마다 둘로 나누므로 이진 트리를 형성하게 된다. 
merge sort의 계산복잡도는 ```이진 트리의 높이```와 각 ```단계의 원소 수```의 곱으로 나타낼 수 있다.
즉, O(n $\log n$)

```python
def merge_sort(ary):
    
    if len(ary) <= 1:
        return ary
    
    pivot = len(ary) // 2
    left_ary = ary[:pivot]
    right_ary = ary[pivot:]
    
    l_list = merge_sort(left_ary)
    r_list = merge_sort(right_ary)
    
    merged = []
    
    while len(l_list) > 0 and len(r_list) > 0:
        if l_list[0] < r_list[0]:
            merged.append(l_list[0])
            l_list = l_list[1:]
        else:
            merged.append(r_list[0])
            r_list = r_list[1:]

    merged += r_list
    merged += l_list
    
    return merged
```



## Reference
- https://ratsgo.github.io/data%20structure&algorithm/2017/10/03/mergesort/
- https://ratsgo.github.io/data%20structure&algorithm/2017/09/28/quicksort/
