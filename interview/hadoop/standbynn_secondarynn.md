# What is the difference between a standby NameNodes and a secondary NameNode?

## Secondary Namenode
In Hadoop 1.x and 2.x, the secondary namenode means the same. 
It does CPU intensive tasks for Namenode. 
In more details, it combines the Edit log and fs_image and returns the consolidated file to Namenode. 
Namenode then loads that file into RAM. 
But, <b>secondary namenode doesn't provide failover capabilities</b>.
So, in case of Namenode failure, Hadoop admins have to manually recover the data from Secondary Namenode.


## Standby Namenode
In Hadoop 2.0, with the introduction of HA, the Standby Namenode came into picture. 
The standby namenode is the node that removes the problem of SPOF (Single Point Of Failure) that was there in Hadoop 1.x. 
The <b>standby namenode provides automatic failover</b> in case Active Namenode 
(can be simply called 'Namenode' if HA is not enabled) fails.

Moreover, enabling HA is not mandatory. 
But, <b>when it is enabled, you can't use Secondary Namenode</b>. 
So, either Secondary Namenode is enabled OR Standby Namenode is enabled.


## Reference
- https://www.quora.com/What-is-the-difference-between-a-standby-NameNodes-and-a-secondary-NameNode-Does-the-new-Hadoop-with-YARN-have-a-secondary-NameNode
