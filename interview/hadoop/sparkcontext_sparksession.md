# SparkContext vs SparkSession

What is the difference between SparkSession and SparkContext in Apache Spark?
Where should we use SparkSession / SparkContext?

## Spark Context
Prior to Spark 2.0.0 sparkContext was used as a channel to access all spark functionality.
The spark driver program <b>uses spark context to connect to the cluster</b> through a resource manager (YARN orMesos..).
sparkConf is required to create the spark context object, which stores configuration parameter like appName 
(to identify your spark driver), application, number of core and memory size of executor running on worker node.

In order to use APIs of SQL, HIVE, and Streaming, <b>separate contexts need to be created</b>.

#### Example
```scala
// creation of SparkConf:
val conf = new SparkConf().setAppName(“RetailDataAnalysis”).setMaster(“spark://master:7077”).set(“spark.executor.memory”, “2g”)

// creation of sparkContext:
val sc = new SparkContext(conf)
```



## Spark Session
SPARK 2.0.0 onwards, SparkSession provides a single point of entry to interact with underlying Spark functionality 
and allows programming Spark with DataFrame and Dataset APIs. 
All the functionality available with sparkContext are also available in sparkSession.

In order to use APIs of SQL, HIVE, and Streaming, <b>no need to create separate contexts</b> as sparkSession includes all the APIs.
Once the SparkSession is instantiated, we can <b>configure Spark's run-time config properties</b>.

#### Example
```scala
// Creating Spark session:
val spark = SparkSession
  .builder
  .appName("WorldBankIndex")
  .getOrCreate()

// Configuring properties:
spark.conf.set("spark.sql.shuffle.partitions", 6)
spark.conf.set("spark.executor.memory", "2g")
```


## Reference
- https://data-flair.training/forums/topic/sparksession-vs-sparkcontext-in-apache-spark/

