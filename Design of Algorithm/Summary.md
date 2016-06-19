Author: Xiao Liang Yu

Design of Algorithm
=====

Divide and Conquer
=====

Divide a big problem into smaller sub-problems. When the problem size is small enough, solve them, then merge them in order to solve the original big problem.

Asymptotic Notation
=====

Use math notation to show the rate of growth of functions

"$=$" is interchangeable with $\in$ 
Means the $=$ here is a one way equality

the multiplicative constants are omitted

rate of growth of functions
$$n! >> a^{n} >> n^{a} >> log(n), a \in R$$

Big-O $O$
-----

The upper bound growth rate 
Normally determine by the terms in $f$ with highest growth rate

We write $f(n) = O(g(n))$ if there exist constants $c > 0, n_0 > 0$ such that $0 \le f(n) \le cg(n)$ for all $n \ge n_0$

$O(g(n))$ is actually a set of functions with upper bound growth rate same as g(n)

Big-Omega $\Omega$
-----

The lower bound growth rate

$\Omega(g(n)) =$ {$f(n)$ : there exist constants $c > 0, n_0 > 0$ such that $0 \le cg(n) \le f(n)$ for all $n \ge n_0$}


Big-Theta $\Theta$
-----

$g \in \Theta(f)$ if $g \in \Omega(f)$ and $g \in O(f)$


Recurrence Relation
=====

Master Theorem
-----

If the recurrence equation has form $T(n) = aT(\frac{n}{b}) + O(n^{d})$, Then

\\[
T(n) =
\begin{cases}
O(n^{d}),  & \text{if $d > \log_b a$} \\\\\\\\
O(n^{d}\log ({n})), & \text{if $d = \log_b a$} \\\\\\\\
O(n^{\log_b a}), & \text{if $d < \log_b a$} \\\\\\\\
\end{cases}
\\]


General Method of solving it
-----

1. We substitute the equation for about three times to get an idea of the final equation. 
2. we get an equation with $k$, $k$ is the ($\text{number of time we substitute the equation} + 1$) (or something similar)  
3. We let $k$ to be $n + c$, $c$ is the number for which making the $f(n, k) = \text{the base case $n$ value}$ 

Good to try

- Prove that Quicksort has worst case $O(n^{2})$


Quick Sort
=====

The main step is "partition"

Complexity
-----

- best case - $O(nlog(n))$

$$T(n) = 2T(\frac{n}{2}) + O(n)$$

- average case - $O(nlog(n))$
- worst case - $O(n^{2})$

$$T(n) = T(n-1) + O(n)$$

Three way partition
```
function quick_sort(arr, start, end)

    if start >= end
        return

    pivot_start, pivot_end = partition(arr, start, end) //three-way partition

    quick_sort(arr, start, pivot_start-1)
    quick_sort(arr, pivot_end+1, end)

    return

function partition(arr, start, end)
    idx_pivot = a random index between start and end(inclusive)

    pivot = arr[idx_pivot]

    arr[idx_pivot] swap with arr[end]

    pivot_start = end
    greater_start = end + 1
    
    idx = start

    while idx < pivot_start

        if arr[idx] > pivot
            greater_start--
            pivot_start--
            arr[greater_start], arr[pivot_start], arr[idx] = arr[idx], arr[greater_start], arr[pivot_start]

        else if arr[idx] == pivot
            pivot_start--
            arr[idx] swap with arr[pivot_start]
            
        else // arr[idx] < pivot
            idx++

    return pivot_start, greater_start - 1

```


Merge Sort
=====

$T(n) = 2T(\frac{n}{2}) + O(n)$

```
arr - the array

function merge_sort(arr, start, end)

    if start >= end
        return

    mid = start + (end-start) / 2 // integer division
    merge_sort(arr, start, mid)
    merge_sort(arr, mid+1, end)

    merge(arr, arr[start to mid], arr[mid+1 to end], start)

function merge(arr, A, B, start)
    
    while A not empty or B not empty
        
        if B is empty or (A not empty and A[0] < B[0])
            arr[start] = A[0]
            delete A[0]
            start++
        else
            arr[start] = B[0]
            delete B[0]
            start++

```


Knapsack (TODO:come back)
=====

Two variant:

- amount of items is **infinite** (in this course, means **with repetition**) 
- amount of items is **finite** (in this course, means **without repetition**)


naive way is recursive. But we can use dynamic programming to speed it up.

Time complexity: 

- Naive
    $O(??)$
- Dynamic programming
    $O(nW)$

Dynamic programming implementation
-----

### With repetition

Space complexity: $O(W)$

```pseudocode
function knapsack(w, v)

    input: w - the weight of items, v - the value of items

    max_V = an array having all element initialized to 0

    for curr_w in 1 to W

        max_V[curr_w] = max{max_V[curr_w - w[i]] + v[i]} for i in [1,n]

    return max_V[W]
```


### Without repetition

Space Complexity: $O(W)$ since this algorithm only needs to keep two immediate rows


```pseudocode
function knapsack(w, v)

    input: w - the weight of items, v - the value of items

    max_V = an array having all element initialized to 0

    for j in 1 to w.length
        for curr_w in 1 to W

            max_V[curr_w, j] = max{max_V[curr_w - w[j], j-1] + v[j], max_V[w, j-1]}

    return max_V[W, w.length]

```



Graph
=====

A graph is a set of vertices connecting with edges.

Miscellaneous Definitions
-----

- two vertices $u$,$v$ are *connected* if there's a path from $u$ to $v$ and a path from $v$ to $u$
- a cycle in a directed graph is a circular path(e.g. $v_0 -> v_1 -> v_2 -> ... -> v_k -> v_0$)

Undirected Graphs
-----

An undirected graph is a graph with all undirected edges (i.e. edge connecting vertex a and vertex b will allow visiting from a to b and from b to a). 

### connected undirected graph

My understanding: A connected undirected graph is a graph such that there must be a path for traveling from $a$ to $b$, $a$ and $b$ are arbitrary vertices $\in G$. 

Formal Definition: An undirected graph is connected if there is a path between any pair of vertices.

Directed Graphs
-----

A directed graph is a graph which has edges directed.

### Directed Acyclic Graph (DAG)

- A directed graph with no cycle in it.
- It has **no back edge**
- has at least one source and at least one sink
- every edge leads to a vertex with a lower post number

### Strongly Connected Components(SCC)

A subset of a graph for which there must be a path between any pair of vertices in the subset.

A vertex can also be a SCC.

![SCC](https://upload.wikimedia.org/wikipedia/commons/5/5c/Scc.png?1466011918115)

- *Every directed graph is a dag of its strongly connected components*
- *The vertex that receives the highest post number in a depth-first search must lie in a source strongly connected component*
    + if we start running DFS at a sink SCC, the source SCC will be traveled later for sure
    + if we start running DFS at a source SCC, the source SCC must have the highest post number
- *when we reverse the directions of edges, all the SCCs are still the same*

### Find a sink SCC

1. we reverse the directions of edges
2. do `dfs` on the reserved graph, the vertex $a$ having the *highest post number* must be in the sink SCC
3. then do `dfs_visit` on the original graph on the $a$. Vertices visited by the recursive call are part of the sink SCC 



### Find all the SCC (kosaraju's algorithm)
```pseudocode
function kosaraju (V, E)

    input: V and E in graph G
    output: Strongly Connected Components defined in set s

    L = a queue

    modified_dfs(V, L) //when dfs_visit on the unvisited node, enqueue that node to L

    s = empty set

    while L is not empty

        v = L.dequeue
        sv = a new set created in s
        assign(v, sv, L, E)


function assign(v, set, L, E)
    
    put v to set

    for e(v, u) in E

        delete u from set
        assign(u, set)
```

Implementations
-----

- Adjacency-list

Insert an edge: $O(1)$
Delete an edge: $O(E)$

- Adjacency-matrix

Insert an edge: $O(1)$
Delete an edge: $O(1)$



DFS (Depth First Search)
=====

Time Complexity
-----

$$T = O(V + E)$$

DFS Template
-----
```pseudocode
function DFS
    input: V, E for which V,E in grpah G
    output: all vertices in G are visited

    for v in V
        dfs_visit(v, E) // call O(V) time

function dfs_visit
    input: v - the vertex visiting, E - all edges in G
    output: v and the vertices that we can reach from v are visited

    if v visited
        return
    
    for x in V such that there's an edge (v, x)
        dfs_visit(x,E) // call O(E) time

```


Application
-----

### DFS tree in directed graph

- Tree edge
part of the DFS forest
- Forward edge
lead from a node to a non-child descendant in the DFS tree
- Back edge
lead to an ancestor in the DFS tree
- Cross edge
lead to neither descendant nor ancestor (a node that has already been completely explored)  

![DFS tree](https://upload.wikimedia.org/wikipedia/commons/thumb/5/57/Tree_edges.svg/2000px-Tree_edges.svg.png)


### Pre and post numbering

when we *enter* a node, we assign the current time to the *"pre"* attribute of that node.   
when we *leave* a node, we assign the current time to the *"post"* attribute of that node.   

![relationship between pre/post numbering and DFS tree edges types](https://raw.githubusercontent.com/yxliang01/UnimelbSharedFiles/master/Design%20of%20Algorithm/Summary%20Resource/Algorithms%20DFS%20tree%20edges%20types%20and%20pre%20post%20numbering%20relationship.PNG)

### Check cyclicity in a directed graph

if dfs_visit tries to visit a visited and not left node, means there's cycle in the graph.



BFS (breath first search)
=====

Space complexity: $O(V)$
Time complexity: $O(V + E)$

- it's a linear time algorithm, but the space complexity is worse than DFS
- it travels following the order of depth of travel tree 

BFS template
```pseudocode
function bfs
    
    input: vertices V and edges E in graph G and s the source vertex
    output: all vertices accessible from s traveled

    x = a queue having only s in it // O(1)

    while x is not empty
    
        v = dequeue(x) // O(1) * O(v) times

        for all y such that there's an edge (v, y)
            if y has not visited // O(1) * O(E) times
                enqueue(x, y) // O(1) * O(v) times


```


Application
-----

- shortest paths in DAGs
    + in any path of a dag, the vertices appear in increasing linearized order
    + linearizion of vertices is the key of efficiency
    + the key is, it's a DAG guarantees that when the time we get to node $v$, we have enough information to compute $dist(v)$ because when we reach $v$ we have all the prerequisite of $v$ achieved
    + since the graph is directed and has no cycle, we can just from the source, keep going on without looking back all the edges that we 


Dijkstra's Algorithm
=====

Usage

- all positive edges
- both directed and undirected graphs


Complexity

$$T(V,E) \in O((V + E)log(V))$$

```pseudocode
function Dijkstra

    input: vertices V and edges E in graph G, s the source vertex
    output: the distance from s to all the vertices in V


    dist[all v in V] = infinity
    via[all v in V] = null

    dist[s] = 0

    q = make_priority_queue(V, dist) //dist as the priority

    while q is not empty

        v = q.extractMin()
        
        for all u, e for which there's an edge e(v, u)

            if dist[v] + e.length < dist[u]

                dist[u] = dist[v] + e.length
                via[u] = v
                q.update(u, dist[u])

```


Heapsort
=====

Heapsort basically keeps ExtractMin/ExtraMax. 

If you try to do ascending sorting

1. build a max heap
2. swap the root element with the leaf with the highest index in the heap tree
3. remove the leaf with the highest index in the heap tree from the heap tree
4. if the heap tree is empty, terminate  
5. perform SiftDown on the new root element
6. go to step 2






Abstract Data Type
=====

Heap
-----

use array as if it's a tree

Parent Index: int($\frac{i - 1}{2}$)
Left Child Index: $2 * i + 1$ 
Right Child Index: $2 * i + 2$ 

Time Complexity:

BuildMaxHeap / BuildMinHeap: $O(n)$
SiftDown / SiftUp: $O(log(n))$
ExtraMax / ExtraMin: $O(log(n))$ due to SiftDown / SiftUp


Max Heap
-----

In a max heap, the keys of parent nodes are always greater than or equal to those of the children and the highest key is in the root node. 

Min Heap
-----

In a min heap, the keys of parent nodes are less than or equal to those of the children and the lowest key is in the root node.



Linked List
-----

- doesn't support random access unless you have saved the address of a node beforehand
- ![the linked list structure](http://www.java2novice.com/images/linked_list.png)
- You can't do efficient binary search on it since it takes $O(n)$ time to get the address of the middle elements 


Stack
-----

- First In, Last Out
- ![stack structure](https://www.cs.cmu.edu/~adamchik/15-121/lectures/Stacks%20and%20Queues/pix/stack.bmp)
- it can be implemented using linked list
    + every time we *push*, we add a new item to the *tail* of the list
    + every time we *pop*, we return and remove the *tail* of the list


Queue
-----

- First In, First Out
- ![queue structure](https://upload.wikimedia.org/wikipedia/commons/thumb/5/52/Data_Queue.svg/2000px-Data_Queue.svg.png)
- it can be implemented using linked list
    + every time we *enqueue*, we add a new item to the *tail* of the list
    + every time we *dequeue*, we return and remove the *head* of the list


Priority Queue
-----

Insert: $O(log(n))$
ExtraMax: $O(log(n))$

- The item with highest priority will be dequeue the first
- ![priority queue structure](http://pages.cs.wisc.edu/~vernon/cs367/notes/PRIORITY-Q-FIGURES/conceptualQ.gif)
- can be implemented using heap (max heap)
    + when the time we want an item from the queue, we *ExtraMax*
    + when we want to insert an item, we insert the item into the lowest available index in the array then add the index into the heap tree, then perform SiftUp on it.


Binary Search Tree (BST)
-----

Space£º $O(n)$
Search: $O(log(n))$
Insert: $O(log(n))$
Delete£º $O(log(n))$


- A binary tree with left child less than/equal to its parent and right child greater than/equal to its parent
- ![BST structure](http://www.cosc.canterbury.ac.nz/research/RG/alg/bst.gif)
- can be implemented using linked list


Disjoint Set
-----

- Can be implemented using linked list
- operations
    + `makeset` $O(1)$
    + `find` worst: $O(V)$
    + `union` $O(1)$
- path compression
    + when we perform `find(x)` operation, we let the parent pointer of `x` point to the return result directly to increase the efficiency of later `fine` operations


![disjoint set data structure](https://helloacm.com/wp-images/acm/2012/data-structure/disjoint3.jpg)


Map/Dictionary
-----

### MISC Definition

- successor(next higher key)
    + smallest thing in right sub-tree, or parent of left-child ancestor
        * left-child ancester = an ancestor which is the left-child of its parent
    + Alternative explaination from [stack overflow](http://stackoverflow.com/questions/5471731/in-order-successor-in-binary-search-tree)
        1. The leftmost child of the right child, if your current node has a right child. If the right child has no left child, the right child is your inorder successor.

        ![finding successor case 1](http://i.stack.imgur.com/yxHBF.png)

        2. Navigate up the parent ancestor nodes, and when you find a parent whose left child is the node you're currently at, the parent is the inorder successor of your original node.
        
        ![finding successor case 2](http://i.stack.imgur.com/Dulhx.png)


- Implement using BST
    + `create` $\Theta(1)$
    + `insert` $\Theta(\log(n))$
    + `delete` $\Theta(\log(n))$
    + `find` $\Theta(\log(n))$
    + `size` $\Theta(n)$
    + `iterate over` $\Theta(n)$
    + `find smallest` $\Theta(\log(n))$
    + `find largest` $\Theta(\log(n))$
    + `find successor` $\Theta(\log(n))$
- operations
    + create
    + insert
    + delete 
    + find
- Implement using hash table(array) without collision
    + See [hash table](#hash-table)
    + `create` $\Theta(1)$
    + `insert` $\Theta(1)$
    + `delete` $\Theta(1)$
    + `find` $\Theta(1)$
    + `size` $\Theta(m)$
    + `iterate over` $\Theta(m)$
    + `find smallest` $\Theta(m)$
    + `find largest` $\Theta(m)$
    + `find successor` $\Theta(m)$

Topological sort
=====

### Usage

- only for DAGs
- get a linearized order of vertices such that all the vertices after vertex $x$ must be descendants of $x$ in a DFS tree
    + since it's a DAG (no back edge), descendants must not able to reach their ancestors


### Implementation

#### DFS

We can run the DFS on a graph, then push the vertex to the stack whenever we leave the vertex
When we have traveled all the vertices, the stack contains a valid toposort result

Time Complexity: $O(V + E)$

#### Kahn's algorithm

Time Complexity: $O(V + E)$

```pseudocode
function toposort_kahn

    input: V and E in graph G (a dag)
    output: x - the topological sorted vertices

    q = a queue with all vertices having no incoming edge // O(V)
    x = an empty linked list

    while q is not empty

        v = q.dequeue() // O(1) * O(V) times
        x.append(v) // O(1) * O(V) times

        for e, u in outgoing edges of v such that e(v,u)
            delete e // O(1) * O(E) times
            if u doesn't have any incoming edge // O(1) * O(E) times
                q.enqueue(u) // O(1) * O(E) times

```


Bellman-Ford Algorithm
=====

Usage
-----

- graph with **negative edges** but *without negative cycle*
- directed and undirected graphs



```pseudocode
function bellman_ford(V, E, s)

    input: V and E in graph G without negative cycle, s - the source vertex
    output: shortest path to all the vertices

    dist[all V] = infinity
    via[all V] = null
    dist[s] = 0

    repeat |V| - 1 times
        for e, u, v in all edges e(u,v)
            if dist[v] > dist[u] + e.length
                dist[v] = dist[u] + e.length
                via[v] = u

```


Greedy Algorithm
=====

An algorithm which only cares about how to get the most immediate advantage


Tree
=====

A tree is an undirected graph that is connected and acyclic

properties

- a tree on $n$ node has $n - 1$ edges
- Any connected, undirected graph with |E| = |V| - 1 is a tree
- An undirected graph is a tree $\iff$ there's a **unique path between any pair of nodes**


Minimum Spanning Tree
=====

A tree constructed from a graph by deleting unnecessary edges such that the connectedness of the graph remains the same but the sum of edge lengths reached minimum

Kruskal's Algorithm (TODO)
-----

Without path compression, time complexity: $O(Elog(V))$ (??? why not O(E*V))

A greedy algorithm

```pseudocode
function kruskal(V, E)

    input: V and E in undirected connected graph G
    output: a minimum spanning tree defined by edges in X

    makeset(all the vertices in V) // O(V)
    X = an empty linked list

    for e(u, v) in (E sorted in increasing order of edge lengths) // O(Elog(E))
        p_u = find(u) // without path compression, O(V) * O(E) times
        p_v = find(v) // without path compression, O(V) * O(E) times
        if p_u != p_v
            union(p_u, p_v) // O(1) * O(V) times
            X.append(e) // O(1) * O(V) times

```


Prim's Algorithm
-----

Time complexity: $O((V+E)log(V))$

```pseudocode
function prim(V, E)

    input: V and E in undirected connected graph G 
    output: a minimum spanning tree defined by the array 'via'

    cost[all vertices in V] = infinity
    via[all vertices in V] = null
    
    u = a random vertex in V
    cost[u] = 0

    X = an empty linked list
    Q = a priority queue contains all vertices with cost as its key

    while Q is not empty

        v = extraMin(Q)

        for e(v, z) in E && z in Q

            if cost[z] > cost[v] + e.length
                cost[z] = cost[v] + e.length
                via[z] = v
                Q.update(z, cost[z])


```


Comparison Sort
=====

A comparison sort is a type of sorting algorithm that only reads the list elements through a single abstract comparison operation (often a "less than or equal to" operator or a three-way comparison) that determines which of two elements should occur first in the final sorted list.

Examples

- Quick sort
- Heap sort
- Merge sort
- Intro sort
- Insertion sort
- Selection sort
- Bubble sort
- Odd-even sort
- Cocktail sort
- Cycle sort
- Merge insertion (Ford-Johnson) sort
- Smoothsort
- Timsort


RSA
=====

Encrypt: $m^{e} \mod N = c$
Decrypt: $c^{d} \mod N = m^{ed} \mod N = m^{k\phi(N)+1} \mod N = m^{k\phi(N)} * m \mod N = m$

$k\phi(N) + 1 = ed$

we can find $d$ using extended GCD
$$ed - k\phi(N) = 1$$

Don't use RSA directly
-----

If the message is easy to be guessed, attackers can just make guesses using the public key and $N$ to perform RSA to see whether the $c$ is same as the one captured. If so, the attacker just got the message.

As a result, we should pad the string with random strings (salt), then only perform RSA.


Hash table
=====

MISC definition
-----

- open hashing
    + all the data are stored outside of the hash table
    + hash table can contain infinite number of elements
- closed hashing
    + all the data are stored within the hash table array
    + hash table can contain limited number of elements


Ways to reduce collision
-----

- make $m$ bigger
    + pigeon hole principle: $n$ pigeons, $m$ holes, $m >= n$
    + not viable for large $n$
- If $m >= n$, make $h$ better
    + if we know all keys in advance, we can build a perfect hash function!
 

Collision resolution
-----

- separate chaining
    + open hashing
    + every element in the hash table is a *linked list* or *BST* or *unordered array*
    + linked list/unordered array implementation
        * Move to front (MTF)
            - whenever we access an element in a linked list, move that element to the front of that linked list
                + because elements accessed before are more likely to be accessed again
    + unordered array *only* implementation
        * the first element indicates the number of elements in the array
- open addressing
    + closed hashing
    + linear probing
        * $h(key, i) = (h(key) + i) \mod m$
        * when collision happens, the hash value += a constant value until an empty bucket had been found
        * keys tend to cluster
        * performance is easy to downgrade when $n$ becomes larger 
    + double hashing
        * $h(key, i) = (h_1(key) + i x h_2(key)) \mod m$
        * $h_2$ shouldn't evaluate to $0$
        * the value of $h_2(key)$ should be relatively prime to $m$
        * two easy ways of achieving this
            - $m$ be a power of $2$ and design $h_2(key)$ such that it only returns an odd number
            - choose $m$ to be prime and design $h_2(key)$ such that it only returns number in range $(0, m)$
                + example: $h_2(key) = 1 + (key \mod (m-1))$
    + cuckoo hashing
        * two hash tables
        * when they are full, rehash all elements into bigger hash tables
        * [visualization][www.lkozma.net/cuckoo_hashing_visualization/
]


We need
-----

- an array [0...m-1]
- a hash function $h: key \text{ -> integer in range $[0, m)$} $

Hash functions
-----

- Must be consistent
- Examples
    + simplest one $h(key) = key \mod m$
    + universal hash function


Universal Hash Function
=====

*Have to try the tutorial question*

A universal hash family $H$ allows generating hash functions $h \in H \text{ such that } Pr[h(x) = h(y)] = 1/p, p \text{ is the hash table size }$


A universal hash function

- should have its result generated randomly
- return a value depends on the every part of the key
- for any two distinct data items $x$ and $y$, exactly $|H|/n$ of all the hash functions in $H$ map $x$ and $y$ to the same bucket, where $n$ is the number of buckets 


Linear Congruential Generator
-----

$$h(x) = ((ax + b) \mod q) \mod p$$
$\text{for } a \ne 0, q \text{ a prime number $> p$ }, a,b \text{ are random integers}\mod q$


Cryptographic Hash Function
=====

still, they are hash functions $h: key \text{ -> integer in range $[0, m)$} $
But, the m is very large, at least $2^{256}$

They are often compared by the length in bits of their output
e.g. SHA-512 outputs a string of 512 bits

Three resistance
-----

- Collision Resistance
    + It should be computationally infeasible to find $x, y \text{ s.t. } h(x) = h(y)$
    + hard to find two different keys hashing to the same value  
- Second-preimage Resistance
    + Given $x$, it should be computationally infeasible to find $y \text{ s.t. } h(x) = h(y)$
    + hard to find another key having same hash value with $x$
- Preimage Resistance
    + Given $D$, it should be computationally infeasible to find any $x \text{ s.t. } D$
    + hard to find a key hashing to a given hash value $D$

$$1 \implies 2 \text{ and } 2 \implies 3$$

Usage
-----

- used to delete viruses or malware
- passwords are often stored as a hash
    + when log in, it checks whether your input has same hash value with the one stored


Symmetrical VS Asymmetrical
-----

Symmetrical

- encrypt and decrypt using the *same key*
- e.g. AES-256

Asymmetrical

- encrypt and decrypt using *different key*
- e.g. RSA


Trapdoor function
-----

A trapdoor function is a function which is easy to compute in one direction and very difficult to calculate in the other direction without special information


Digital Signature
=====

Alice has

- a private key (keep it herself)
- a public key (available to everyone)

A digital signature is a mathematical link between a particular message and a particular public key

- $signature = sign(message, private_key)$
    + a string of bits that Alice appends to her message
- $verify(message, signature, public_key)$
    + allows Bob to check that Alice's private key was used to sign (the message indeed comes from Alice)

Without Alice's private key, you `forge`/`modify`/`sign` a different message
If you try, the verification will fail

Most digital signature algorithms hash a message before signing
e.g. RSA, DSA

Certificate
-----

a certificate is a special kind of signed message, in which

- the message says "XYZ is the public key of So-and-so"
    + with some other data e.g. a date
- the signer is supposed to be something (whose public key) you already know
    + a typical web browser has lots of certificate authorities' public keys installed when it ships


Data compression
=====

Definitions
-----

- message
    + data to be stored
- symbol
    + each letter to be encoded
- codeword
    + each bit pattern for each symbol
- code
    + a collection of codewords


Code of a code can be measured in bits-per-symbol (bps)

$$bps = \frac{\text{total bits}}{\text{the number of symbols}}$$

We need 7 bits to represent all the English characters. But, ASCII is fixed 8 bits. So, wasted 1 bit.

Static code
-----

assign the same codewords to symbols regardless of the message

Semi-static code
-----

adjusting codeword assignment according to the probability of occurrence of each symbol in the message

Entropy
-----

If a symbol occurs with probability $p$, the best possible encoding for that symbol is $\log_2 p$

Means, a codeword of length $x$ implies an expected probability of occurrence of $2^{-x}$

A message with $n$ symbols each occurring $p_i$ times
$$\text{best bps } = -\sum_{i=1}^n {p_i \log_2 p_i}$$

Unary Code
-----

to store n(a integer), output $n$ 1-bits then a 0-bit

For example

| Number | Codeword |
|--------|----------|
|      0 |        0 |
|      1 |       10 |
|      2 |      110 |
|      3 |     1110 |
|      4 |    11110 |
|      5 |   111110 |



Prefix-free code
-----

- it has no codeword as the prefix of any other
- we can decode left to right one bit at a time
- easy to visualize using a code tree
- symbols are leaves
- path from root to leaf defines the codeword
- each path is *unique* and *prefix-free*


Shannon_Fano Algorithm
-----

- Top-down approach
- greedy algorithm
- you will get the best bps only when each time we divide the sets into halves, all halves have the same sum of probabilities of symbols
- steps
    1. put the symbols into a set
    2. divide the set into halves such that sum of probability of symbols of each half is (almost) equal 
    3. keep dividing until all the sets have only one symbol in it, we will get a binary tree and that's the prefix tree


Huffman Algorithm
-----

- Bottom-up approach
- steps
    1. make each symbol a node
    2. sort the set according to the probability in increasing order
    3. create a new node having two nodes having the smallest probabilities as its children until all the nodes are connected
- can always guarantee the best coding

Huffman tree is a binary tree

### Normal implementation

```pseudocode
function huffman_lens(s)

    input: s - the set of symbols with frequency 
    output: a Huffman tree

    n = convert s into set of nodes
    Q = queue containing all n and frequency of s as the keys

    while |Q| > 1

        a = ExtraMin(Q) 
        b = ExtraMin(Q)
        node = new internal node with a and b its children
        node.weight = a.weight + b.weight

        Q.enqueue(node, node,weight)

    return node, as the root of the constructed Huffman Tree
```



### Alistair Moffat's Implementation

Five important elements

- leaf node
- internal nodes
    + once there is one created, internal nodes will *never die out*
- internal parent nodes 
- internal depths
- leaf depths

(CHECK NEEDED)
```pseudocode
function alistair_huffman(F)

    input: F - frequency count of symbols in array (not taken as an argument), the array must be presorted in ascending order of the frequencies  
    output: an array of the lengths of codewords for each symbol in F

    //phase1

    idx_leaf = 0
    idx_internal = -1
    idx_next_internal = -1

    num = an array of size 2

    while idx_next_internal < F.length - 1

        idx_next_internal++

        for i in [0,1]

            if idx_internal == idx_parent or (idx_leaf != F.length and F[idx_leaf] < F[idx_internal])
                
                num[i] = F[idx_leaf]
                idx_leaf++
            else

                num[i] = F[idx_internal]
                F[idx_internal] = idx_next_internal
                idx_internal++


        F[idx_next_internal] = num[0] + num[1]

    // Phase 2

    F[F.length - 2] = 0

    for i from F.length - 3 to 0
    
        F[i] = F[F[i]] + 1


    // Phase 3

    last = F[F.length - 2]
    count_last = 1
    count_last_parent = 0

    idx_next = F.length - 1

    for i from F.length - 3 to 0    

        if F[i] != last
            max_ava = 2 * count_last_parent
            repeat (max_ava - count_last) times //could be 0 times
                if idx_next < 0
                    return F
                F[idx_next] = last
                idx_next--
            last = F[i]
            count_last_parent = count_last
            count_last = 1
        else
            count_last++

    max_ava = 2 * count_last_parent
    repeat (max_ava - count_last) times
        if idx_next < 0
            return F
        F[idx_next] = last
        idx_next--

    //hmm still got some symbols not assigned
    max_ava = 2 * last
    repeat (max_ava - count_last) times
        if idx_next < 0
            return F
        F[idx_next] = last + 1
        idx_next--

```



Secret Sharing
=====

XOR operation
-----

| $a$ | $b$ | $a \oplus b$ |
|-----|-----|--------------|
|   0 |   0 |            0 |
|   1 |   0 |            1 |
|   0 |   1 |            1 |
|   1 |   1 |            0 |

- $a \oplus b = b \oplus a$
- $a \oplus a = 0 $
- $a \oplus \bar a = 1 $
- $a \oplus 0 = a$
- $a \oplus 1 = \bar a$


You want to

- share a message with two people
- force them to exchange information; otherwise, none of them can get the original message

We can use *XOR* to achieve this

0. $s$ is the original message
1. give one person rand $r$
2. give another person $r XOR s$
3. they can recover the message by doing $(r \oplus s) \oplus r$

proof: 
$(r \oplus s) \oplus r$
$= r \oplus r \oplus s$
$= 0 \oplus s$
$= s $


If we want to distribute message to $n$ people and force them to work together to get the original message $s$, we can just generate more rand and *XOR* the message $s$ with them

If we want any two recipients to work together to be able to get the $s$, we can use Shamir's or Blakeley's secret sharing scheme

The idea is, we have a straight line with some slope $a$ such that $y = ax + s$. The y-intercept is $s$. We give everyone a pair $(i, ai + s)$. Since we only need to know two coordinates of the straight line to get the y-intercept, any two recipients can work out the $s$ now.


Dynamic Programming
=====

It's particularly useful when an algorithm needs the results of sub-problems for ****multiple times****.

It's a technique used to speed up calculations when there are lots of *redundant calculations*. We memorize the result of each calculation for the sub-problems, then use the memorized result when we have to need 

As a result, a main question is *What are the subproblems?*.


Fibonacci
-----

*Naive Implementation* Time Complexity: $O(2^{n})$
*Dynamic Programming* Time Complexity: $O(n)$

Naive Implementation
```pseudocode
function fib(n)
    if n <= 1
        return 1
    else
        return fib(n-2) + fib(n-1)
```

Dynamic programming
```pseudocode
function fib(n)

    arr = an array having index [0, n]

    arr[0] = arr[1] = 1

    if n > 1
        for i in range [2, n]
            arr[i] = arr[i-2] + arr[i-1]

    return arr[n]
```


Longest increasing subsequence
-----

### Problem

Given a sequence of numbers, find the longest increasing subsequence. A increasing subsequence is a subsequence with its numbers arranged in strictly increasing order. 


### Graph version

We build a graph such that there's an $edge(u,v)$ if $v$ has larger index in the array than $u$ and $v > u$.

Time complexity: $O(n^2)$

```pseudocode
function longest_increasing_subsequence(V, E)

    input: a graph converted from a sequence of integers
    output: the length of the longest increasing sequence

    L = an array having index in range [1, |V|] with all elements initialized to 0

    // i - the index of the current vertex in the original array
    for i in range [1, |V|] 

        L[i] = 1 + max{L[j] for (j, i) in E} //max of {} is 0
        
    return max{L(n) for n in [1,|V|]}

```



***Number Theory***
=====

$$(Z_N)^* = (\text{ set of invertible element in $Z_N$ }) = ( x \in Z_N : gcd(x, N) = 1)$$ 



Modular arithmetic
-----

You can do algebra normally then mod with the result

$(A * B) \mod C = (A \mod C * B \mod C) \mod C$
$(A + B) \mod C = (A \mod C + B \mod C) \mod C$
$A^B \mod C = ( (A \mod C)^B ) \mod C$


Greatest Common Divisor
-----

$gcd(x,y)$ is the **greatest common divisor** of x and y

For all integers $x$ and $y$ , $ax + by = gcd(x,y)$
$a$ and $b$ can be found efficiently using the extended Euclid algorithm

If $gcd(x,y) = 1$, we say that $x$ and $y$ are relatively prime

$x$ in $Z_N$ has an inverse $\iff$ $gcd(x, N) = 1$

$gcd(a, b) \text{ for } a >= b$
$= gcd(b, a \mod b)$

If $b = 0$, $gcd(a,b) = a$


**Extended GCD**
-----

My step

1. use normal gcd to calculate the gcd first
2. then do it backwards, trace all the argument $b \text{ of the } GCD$



**Fermat's theorem**
-----

Let $p$ be a prime 
$$\forall x \in (Z_p)^* : x^{p-1} = 1 \in Z_p$$


**Euler's theorem**
-----

$$\forall x \in (Z_N)^* : x^{\phi(N)} = 1$$



**Phi $\phi$ (Euler's totient function)**
-----

$$\phi(n) = \text{ the number of integers in range $[1, n)$ } , n \in N$$
When $n$ is a prime number, $\phi(n) = n - 1$
If $n = pq, \text{  $p$ and $q$ are prime} \implies \phi(n)=(p-1)(q-1)=N - p - q + 1$



NP/P/NPC problems
=====

Efficient algorithm -> polynomial time
Brute force -> exponential or factorial time


NP
-----

A problem is said to be in class *NP* if, given some input $I$ and a proposed solutions $S$, you can *verify* whether $S$ is a correct solution *in polynomial time* in the size of $I$. 

NP = Nondeterministic Polynomial time


P
-----

If there is a (deterministic) polynomial time algorithm for finding the solution, then the problem is also in class *P*



SAT
----- 


Given a boolean formula in conjunctive normal form (CNF), is there a truth assignment to the variables to make it true (to "satisfy" it)? 

CNF - clauses "and" together, each clause is "or" of variable x or its negation

2-SAT - CNF with all terms having two variables


Traveling salesman
-----

given a list of cities and the distances between each pair of cities, what is the shortest possible route that visits each city exactly once and returns to the origin city?


Reduction
-----

A reduction from a search problem $A$ to a search problem $B$ consists of two polynomial time algorithms ($f$, $h$)

Basically, trying to convert a problem into other problem type, use an existing algorithm to solve it, then convert back to the solution to the original problem type

$f$ maps the input of $A$ to the input of $B$
$h$ maps the output of $B$ to the output of $A$

![Reduction](https://raw.githubusercontent.com/yxliang01/UnimelbSharedFiles/master/Design%20of%20Algorithm/Summary%20Resource/Reduction.PNG)


NP-complete
-----

A problem is *NP-complete* if it is *in NP* and *all other problems in NP can be reduced to it*.

If one NP-complete problem could be solved in polynomial time, we would know $P=NP$

However, no-one has achieved that

### What to do when employer asks you to solve an NP-complete problem

- Hope $n$ is small
- Use an approximation (e.g. Set Cover)
- Use a search technique and hope for the best
    + Branch and bound
    + Backtracking


### Hilbert's 10<sup>th</sup> problem

Write an algorithm that will solve a given polynomial equation with integer solutions(Diophantine equation).

e.g. $x^{3}yz + x^{2}y^{4}z^{2} - 7xy^{5}z = 6$

### Halting Problem

Write an algorithm that tells me if program $P$ with integer $I$ will terminate


### Summary

problems

- can have a proposed solution verified in polynomial time -> NP
- have polynomial time algorithms to find the solution -> P
- A problem $p$ in NP is NP-complete if every other problem in NP can be transformed (or reduced) into $p$ in polynomial time. -> NP-complete

If one of the NP-complete can be solved in polynomial time, $NP = P$


Set Cardinality
=====

Problem
-----

Given a stream of items from a universe $U$ with $|U| = n$, keep track of the size $m$ of the set $S$ containing all *unique items* that have appeared so far.


Simple solutions
-----

Keep track of the items that have appeared so far in

- hash table
- binary search tree
- array of size $n$


However, when the |U| is big, the solutions above may not be feasible

Sometimes, estimation is good enough and preferred

Good estimate

- the estimation error should be low
- space and runtime efficient
- theoretical guarantees


The log log algorithm
-----

It's a good algorithm to estimate the number of traling 0s when the number of samples is very big.

Good at

1. it's very space efficient
2. low relative estimation error of $\sigma = 1.3 / \sqrt{q}$


### Symbols

$p$ - the number of values the hash value can possibly be 
$l$ - the number of bits determining the which group the hash value is in
    the greater the $l$ is, the more accurate the result will be, but, the more space it takes
$c$ - constant in formula
$m$ - the actual cardinali#ty
$\hat m$ - the estimated cardinality

$$\hat m = cq2^{\hat k}, c = 0.39701$$


### Idea

You have $2^{l}$ counters, with each one having size $\log \log p$

1. Now you have a hash value $x$ 
2. See at the last $l$ bits to see which group it's supposed to be in
3. count the number of tailing 0s from right to left start from the bit right before the $-l_{th}$ bit(the last bit is the $-1_{th}$ bit)
4. if the count of the current number is greater than the current value in the corresponding counter, update it with current count
5. when it's done, use the formula $\hat m = cq2^{\hat k}$ to estimate the cardinality $m$

### Complexity

Update Time complexity(calculation time for one item): $O(1)$ time
Estimation Time complexity: $O(q)$ time
Space complexity: $q\log \log p$ bits


Bitcoin
=====

- You want to prove that you have performed a certain amount of work in order to get awarded
- Small string $Q$ is generated based on the existing transactions in the bitcoin network
- Task: find a string $X$ which has $Q$ as a suffix, which produces a hash containing a certain amount of tailing 0s
- First person to "find" such a string gets awarded the next bitcoin


Frequency Estimation
=====

Problem
-----

Given a stream of items from a universe $U$, we want to know the frequency $f_i$ of each item $i$ in the stream


Count-Min Sketch
-----

### Definitions

$p$ = the number of buckets of the hash tables
$d$ = the number of hash tables
$N$ = the number of items counted

$p = ceil(e/\epsilon)$
$d = ceil(\log_e \frac{1}{\delta})$
It's guaranteed that after seeing $N$ items with probability $1-\delta$:
$$f_i \ge \hat {f_i} \ge f_i + \epsilon N$$

### Complexity

Update Time complexity(calculation time for one item): $O(d)$ time - compute $d$ hashes and update $d$ buckets
Estimation Time complexity: $O(d)$ time - take minimum of $d$ buckets
Space complexity: $p x d x \log_2 n$ bits


Sketches
=====

- allow space efficient processing of large data sets by utilizing summarization
- easy to implement
- provide theoretical guaranteed estimates of cardinality of a set and item frequencies


K-th smallest algorithm
=====

```pseudocode
function k_th_smallest(arr, k)

    input: arr - the array, k - the k_th smallest value looking (k starts from 0)
    output: the value of the k_th smallest element

    pivot_start, pivot_end = partition(arr, 0, arr.length - 1)
    
    if pivot_start <= k <= pivot_end
        return arr[idx_pivot]
    else if pivot_start > k
        return k_th_smallest(arr[0 to pivot_start - 1], k)
    else if pivot_end < k
        return k_th_smallest(arr[pivot_end + 1 to arr.length - 1], k - pivot_end - 1)


function partition(arr, start, end)
    idx_pivot = a random index between start and end(inclusive)

    pivot = arr[idx_pivot]

    arr[idx_pivot] swap with arr[end]

    pivot_start = end
    greater_start = end + 1
    
    idx = start

    while idx < pivot_start

        if arr[idx] > pivot
            greater_start--
            pivot_start--
            arr[greater_start], arr[pivot_start], arr[idx] = arr[idx], arr[greater_start], arr[pivot_start]

        else if arr[idx] == pivot
            pivot_start--
            arr[idx] swap with arr[pivot_start]
            
        else // arr[idx] < pivot
            idx++

    return pivot_start, greater_start - 1
```


Progress
=====

Steven
-----

Divide and conquer --> Big-O --> Merge sort --> matrix multiplication(not examinable) --> recurrence relation --> trimino(not examinable) --> compilation process(not examinable) --> master theorem --> ADT(abstract data type) --> graphs( formal definition --> toposort --> DAG --> source and sink --> kth-smallest --> DFS -> connectivity --> cylicity --> pre,pose numbers --> SCC -> distance --> BFS -> kosaraju's algorithm --> Dijkstra(code and definition) --> priority queue -> Bellman-Ford) --> greedy algorithm --> Minimum spanning tree --> Prim's Algorithm --> Krustal --> disjoint set

Vanessa
-----

Hash table(ADT, as BBST, collision) --> birthday "paradox" --> hashable collision resolution --> cryptographic hash function (SHA and MD5, properties, usage) --> Digital signatures(RSA) --> certificate --> compression(bps --> unary --> Shannon's Entropy --> static/semi-static code --> prefix-free code --> shannon-fano algorithm --> arithmetic coding) --> number theory(modular arithmetic, gcd -> phi --> Euler's theorem) --> symmetric v.s. public-key(asymmetric) --> RSA --> Huffman(algorithm and Alistair's implementation) --> how to distribute messages such that all the recipients have to exchange information to get the original message(XOR) --> Dynamic Programming -> Knapsack(brute-force and dynamic) -> NP,P,NPC with SAT(salsman problem) -> reduction -> Frequency and cardinality of set



Miscellaneous definition
=====

- relatively prime (coprime)
    + no common divisor other than 1
- digest
    + the output of a cryptographic hash function 

Checklist
=====

Steven
-----

- [X] Divide and conquer
- [X] Asymptotic Notation
- [X] Merge sort
- [X] Recurrence relation
- [X] Master Theorem
- [X] Formal Definition



Points
=====

Data Structure
-----

- [X] Linked List
- [X] Stack
- [X] Queue
- [X] Priority Queue
- [X] Disjoint Set
- [X] Heap
- [X] Binary Search Tree
- [X] Map

Algorithms
-----

- Sorting
    + [X] Mergesort
    + [X] Quicksort
- Graphs
    + [X] DFS
    + [X] BFS
    + [X] Topological sort
        * [X] DFS
        * [X] Kahn
    + [X] Dijkstra's Algorithm
    + [X] Bellman-Ford Algorithm
    + [X] Kosaraju's algorithm
- Trees
    + [X] Prim's Algorithm
    + [X] Kruskal's Algorithm 
- Cryptography
    + [X] RSA
- Compression
    + [X] Huffman coding
- knapsack
    + [X] dynamic programming
- [X] K-th smallest algorithm
- [X] Set Cardinality
- [X] Frequency estimation

Complexity Analysis
-----

- [X] Big-O
- [X] Big-Omega
- [X] Big-Theta
- [X] Master theorem
- [X] Recurrence Relations

Definition
-----

- [X] divide and conquer
- [X] graph
    + [X] what is graph
    + [X] directed graph
    + [X] undirected graph
    + [X] acyclic
    + [X] DAG
    + [X] strongly connection components (SCC)
    + [X] DFS tree
- tree
    + [X] what is a tree
    + [X] what is minimum spanning tree
- Math
    + [X] number theory
    + [X] GCD
    + [X] extended GCD
- Cryptography
    + [X] secret sharing - how to force recipients to exchange information in order to let them get the message
- Hashing
    + [X] Structure
    + [X] Universal Hash Function
- Algorithms
    + [X] NP-completeness
    + [X] P
    + [X] NPC
    + [X] reduction
    + [X] comparison sort
- [X] Dynamic Programming


Random
======

