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


Master Theorem
=====

If the recurrence equation has form $T(n) = aT(\frac{n}{b}) + O(n^{d})$, Then

\\[
T(n) =
\begin{cases}
O(n^{d}),  & \text{if $d > \log_b a$} \\\\\\\\
O(n^{d}\log ({n})), & \text{if $d = \log_b a$} \\\\\\\\
O(n^{\log_b a}), & \text{if $d < \log_b a$} \\\\\\\\
\end{cases}
\\]


Merge Sort
=====

$T(n) = 2T(\frac{n}{2}) + O(n)$

```
arr - the array

function merge_sort(arr, start, end)

    if start >= end
        return

    mid = int(start + (end-start) / 2)
    merge_sort(arr, start, mid)
    merge_sort(arr, mid+1, end)

    merge(arr, start, mid, mid+1, end)

function merge(arr, start, mid, mid+1, end)
    
    A = arr[start:mid]
    B = arr[mid+1:end]

    idx_A 

```


Knapsack
=====

Two variant:

- amount of items is **infinite** 
- amount of items is **finite** 

naive way is bruce-force. But we can use dynamic programming to speed it up.

Time complexity: 

- Bruce-force
    $O()$
- Dynamic programming
    $O(nw)$


Dynamic Programming
=====



Graph
=====

A graph is a set of vertices connecting with edges.

Miscellaneous Definitions
-----

- two vertices $u$,$v$ are *connected* if there's a path from $u$ to $v$ and a path from $v$ to $u$

Undirected Graph
-----

An undirected graph is a graph with all undirected edges (i.e. edge connecting vertex a and vertex b will allow visiting from a to b and from b to a). 

### connected undirected graph

My understanding: A connected undirected graph is a graph such that there must be a path for traveling from $a$ to $b$, $a$ and $b$ are arbitrary vertices $\in G$. 

Formal Definition: An undirected graph is connected if there is a path between any pair of vertices.

Directed Graph
-----

A directed graph is a graph which has edges directed.

### Directed Acyclic Graph (DAG)

A directed graph with no cycle in it.

Strongly Connected Components(SCC)
-----

A subset of a graph for which there must be a path between any pair of vertices in the subset.

A vertex can also be a SCC.


Progress
=====

Steven
-----

Divide and conquer --> Big-O --> Merge sort --> matrix multiplication(not examinable) --> recurrence relation --> trimino(not examinable) --> compilation process(not examinable) --> master theorem --> ADT(abstract data type) --> graphs( formal definition --> toposort --> DAG --> source and sink --> kth-smallest --> DFS -> connectivity --> cylicity --> pre,pose numbers --> SCC -> distance --> BFS -> kosaraju's algorithm --> Dijkstra(code and definition) --> priority queue -> Bellman-Ford) --> greedy algorithm --> Minimum spanning tree --> Prim's Algorithm --> Krustal --> disjoint set

Vanessa
-----

Hash table(ADT, as BBST, collision) --> birthday "paradox" --> hashable collision resolution --> cryptographic hash function (SHA and MD5, properties, usage) --> Digital signatures(RSA) --> certificate --> compression(bps --> unary --> Shannon's Entropy --> static/semi-static code --> prefix-free code --> shannon-fano algorithm --> arithmetic coding) --> number theory(modular arithmetic, gcd -> phi --> Euler's theorem) --> symmetric v.s. public-key(asymmetric) --> RSA --> Huffman(algorithm and Alistair's implementation) --> how to distribute messages such that all the recipients have to exchange information to get the original message(XOR) --> Dynamic Programming -> Knapsack(brute-force and dynamic) -> NP,P,NPC with SAT(salsman problem) -> reduction -> Frequency and cardinality of set


### Hash table

- Map/Dictionary ADT
    + create
    + insert
    + delete find



Checklist
=====

Steven
-----

- [X] Divide and conquer
- [X] Asymptotic Notation
- [X] Merge sort
- [] Recurrence relation
- [X] Master Theorem
- [] Formal Definition


Random
======

NP -> problem which we can check the validness of an answer in polynomial time 