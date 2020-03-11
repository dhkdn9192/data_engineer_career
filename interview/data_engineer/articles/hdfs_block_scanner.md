# How does HDFS detect and handle corrupted blocks?

## Block Scanner
Block scanner runs <b>periodically</b> on every DataNode to verify whether the data blocks stored are correct or not. 
The following steps will occur when a corrupted data block is detected by the block scanner:

1. DataNode will <b>report to the NameNode</b> about the corrupted block.
2. NameNode will start the process of <b>creating a new replica using</b> the correct replica of the corrupted block present in other DataNodes.
3. The corrupted data block will not be deleted <b>until the replication count of the correct replicas matches with the replication factor</b> (3 by default).

This whole process allows HDFS to maintain the <b>integrity</b> of the data when a client performs a read operation.

## Reference
- https://www.edureka.co/community/12658/block-scanner-hdfs
