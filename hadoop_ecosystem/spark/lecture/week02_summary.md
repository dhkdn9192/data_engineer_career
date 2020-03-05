# Week02 - Summary

### 1. foldLeft 와 aggregate 둘다 inputType과 outputType이 다른데 왜 aggregate 만 병렬 처리가 가능한지 설명해주세요

aggregate는 foldLeft와 달리 seqop와 combop 연산을 지정할 수 있다. 
즉 chunk 내에서 연산뿐만 아니라 각 chunk들의 출력들을 합치는 연산도 정의한다.
chunk 내에서의 순차적인 연산은 inputType과 outputType이 달라지지만 각 chunk들의 결과를 합치는 연산은
inputType과 outputType이 동일하도록 지정할 수 있다.
따라서 aggregate는 leftFold와 달리 paralleliable하다

### 2. pairRDD는 어떤 데이터 구조에 적합한지 설명해주세요. 또 pairRDD는 어떻게 만드나요? 

pair RDD는 같은 키로 묶어지는 데이터를 효율적으로 처리할 수 있다.
pair RDD는 이미 생성된 non-pair RDD에 map을 적용하여 각 row를 Tuple로 만들어주면
자동으로 RDD의 타입이 PairRDD로 전환된다.

### 3. groupByKey()와 mapValues()를 통해 나온 결과를 reduce()를 사용해서도 똑같이 만들 수 있습니다. 그렇지만 reduceByKey를 쓴는 것이 더 효율적인 이유는 무엇일까요?

#### groupByKey와 reduce를 사용하는 경우

groupByKey는 같은 키를 갖는 데이터들을 한 노드로 이동시키는 Shuffling이 일어난다.
그리고 reduce는 결과값이 하나의 단일값이므로 모든 데이터를 한 노드로 이동시킨다.

즉 <b>같은 키의 데이터들을 같은 노드로 이동</b>시키는 비용과
<b>모든 데이터를 한 노드로 이동</b>시키는 비용이 발생한다.

#### reduceByKey를 사용하는 경우

반면 reduceByKey는 groupByKey를 따로 사용하지 않는다.
그리고 reduceByKey의 결과는 각각의 키별로 하나의 값이 나와야 하므로(RDD\[(K, V)])
같은 키를 갖는 데이터가 같은 노드로 이동하기만 하면 된다.

따라서 위의 경우와 달리, reduceByKey는 <b>같은 키의 데이터들을 같은 노드로 이동</b>시키는 비용만 발생한다.

### 4. join 과 leftOuterJoin, rightOuterJoin이 어떻게 다른지 설명하세요

join은 database의 inner join에 해당한다. 양쪽 RDD 모두에 동일한 키가 존재하는 값들만 join되며 그렇지 않은 값들은 버려진다.
leftOuterJoin은 양쪽 RDD 중 연산의 왼쪽에 오는 RDD의 키를 보존한다. (오른쪽 RDD에 같은 키가 없으면 대응 값을 None으로 채운다)
rightOuterJoin은 양쪽 RDD 중 연산의 로은쪽에 오는 RDD의 키를 보존한다. (왼쪽 RDD에 같은 키가 없으면 대응 값을 None으로 채운다)

### 5. Shuffling은 무엇인가요? 이것은 어떤 distributed data paraellism의 성능에 어떤 영향을 가져오나요?

RDD가 어떠한 연산을 통해 재구성될 때, 네트워크를 통해 다른 노드로 데이터가 이동하는 것.
Shuffling 연산 자체가 네트워크 비용을 발생시키므로 Shuffling 연산이 많으면 
분산 처리 작업의 전체적인 속도가 느려질 수 있다.
