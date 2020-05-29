# Database Index

## Index basic
- A database index is a data structure that <b>improves the speed of data retrieval operations</b> on a database table. 
- Indexes are used to <b>quickly locate data without having to search every row</b> in a database table. 
- Indexes can be created using one or more columns of a database table, 
providing the basis for both <b>rapid random lookups</b> and <b>efficient access of ordered records</b>.


## Application and limitation
- Consider the following SQL statement: ```SELECT first_name FROM people WHERE last_name = 'Smith';```. 
- Without an index, software must look at the ```last_name``` column on every row in the table. => <b>Full Table Scan</b>. 
- With an index the database simply follows the <b>B-tree</b> data structure until the Smith entry has been found; 
this is much less computationally expensive than a full table scan.

## Reference
- https://en.wikipedia.org/wiki/Database_index
