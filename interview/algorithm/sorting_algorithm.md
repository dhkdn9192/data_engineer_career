# Sorting Algorithm

## Merge Sort

merge sort의 과정은 배열을 매 재귀마다 둘로 나누므로 이진 트리를 형성하게 된다. 
merge sort의 계산복잡도는 ```이진 트리의 높이```와 ```각 단계의 원소 수```의 곱으로 나타낼 수 있다.
즉, O(n log n)이 된다.

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


## Quick Sort
quick sort는 배열 원소 중 하나를 pivot으로 정하고 pivot보다 큰 값들의 배열, 작은 값들의 배열을 만든다.
생성된 두 배열에 대해 재귀적으로 quick sort를 수행하고 각 수행 단계에서 정렬된 두 배열과 pivot을 순서대로 정렬한다.

quick sort 역시 정렬 과정에서 이진 트리를 형성하므로 계산복잡도는 ```트리의 높이```와 ```각 단계의 원소 수```의 곱이므로 평균 O(n log n)이 된다.

그러나 매 반복에서 pivot이 항상 최댓값 또는 최솟값일 경우 이진 트리의 높이가 n이 되므로 
최악의 경우엔 계산복잡도가 O(n<sup>2</sup>)가 된다.

```python
def quick_sort(ary):
    
    if len(ary) <= 1:
        return ary
    
    pivot = ary[0]
    lesser = [a for a in ary[1:] if a < pivot]
    greater = [a for a in ary[1:] if a >= pivot]  # >가 아니라 >=인건, 이미 ary[1:]에서 pivot이 빠져있기 때문
    
    return quick_sort(lesser) + [pivot] + quick_sort(greater)
```


## Reference
- https://ratsgo.github.io/data%20structure&algorithm/2017/10/03/mergesort/
- https://ratsgo.github.io/data%20structure&algorithm/2017/09/28/quicksort/
