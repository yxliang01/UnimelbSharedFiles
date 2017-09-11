# Models of Computations

## Haskell

This section is meant to be a complimentary to my DP-Summary.

Prelude code: https://www.haskell.org/onlinereport/haskell2010/haskellch9.html

`==>`:**implies/only if**
`<=>`:**if and only if**
`<+>`:**exclusive or**

## Propositional Logic

### General Terminology
- conjunction : $ P \land Q $
- disjunction : $ P \lor Q $
- connectives : $ \neg, \lor, \land, \implies, \iff, \oplus $
- propositional letters : $ A, B, C, ... Z $ (upper case)- nand : $ \uparrow $
- nor : $ \downarrow $
- valid : **no truth assignment** makes it `false`
- non-valid : there exists **at least one truth assignment** to make it `false`
- unsatisfiable : **no truth assignment** makes it `true`
- satisfiable : there exists **at least one truth assignment** to make it `true`
- tautology : a **valid propositional formula**
- contradiction : a **unsatisfiable propositional formula**
- substitution : replace propositional letters by formulas
- interchange of equivalents : replace a formula with another formula
- decidability : 
- clause : a **set** (disjunction) of literals
- clausal form : TODO
- conjunctive normal form (CNF) : a conjunction of disjunctions of literals (a conjunction of *clauses*)
- reduced CNF (RCNF) : CNF formula that is in RCNF if for each of its clauses, no propositional letter occurs twice
- disjunctive normal form (DNF) : a disjunction of conjunctions of literals
- canonical form : a normal form leads to a *unique representation* for every Boolean function called canonical.
- Bottom : $ \bot $ - any unsatisfiable formula
- Top : $ \top $ - anby valid formula

### Concepts
- model
    + Let $ \theta $ be a truth assignment and $ \phi $ be a propositional formula. If $ \theta $ makes $ \phi $ `true` then $ \theta $ is a **model** of $ \phi $.
- Logical consequence
    + $ \Psi $ is a logical consequence of $ \phi $ iff every model of $ \phi $ is a model of $ \Psi $ as well -> $ \phi \vDash \Psi $
    + If $ \phi \vDash \Psi $ and $ \Psi \vDash \phi $ both hold, that is, $ \phi $ and $ \Psi $ have exactly the same models, then $ \phi $ and $ \Psi $ are (logically) **equivalent**. -> $ \phi \equiv \Psi $
- every propositional formula can be expressed in *CNF* and *DNF*
- A clause $ \{A,B\} $ represents $ A \lor B $
- Empty *clause* $ \varnothing $ represent $ \bot $
- Formula $ \{C_1, C_2\} $ represents $ C_1 \land C_2 $
- Empty *formula* $ \varnothing $ represents $ \top $
- *Xor normal form* is *canonical* which presents the function in a sum-of-products form using *exclusive or* and *conjunction*
- Binary decision diagrams (BDD) gives canonical form when we enforce maximal sharing of subgraphs (and agree on an ordering of variables) - called *ROBDD* - a reduced, ordered BDD ![Binary decision diagrams](Summary-Image/Binary-decision-diagrams.png)
    + A propositional formula is valid $ \iff $ its ROBDD is the single-leaf graph $ t $
    + A propositional formula is unsatisfiable $ \iff $ its ROBDD is the single-leaf graph $ f $
- An empty set of clauses is valid, because it is trivial to satisfy all of the set’s clauses—there is nothing to do
-  a (non-empty) set that contains an empty clause cannot be satisfied, because nothing satisfies that empty clause
- $ \phi \vDash \Psi $ iff $ \phi \land \neg \Psi $ is unsatisfiable
- A formula is **unsatisfiable** $ \iff $ its negation is **valid**

#### Resolution

##### Resolvent

Let $ C_1 $ and $ C_2 $ be clauses such that $ P \in C_1 $ and $ \neg P \in C_2 $.
$ (C_1 \{P\}) \cup (C_2 \{\neg P\}) $ is a resolvent of $ C_1 $ and $ C_2 $.

Theorem : If $ R $ is a resolvent of $ C_1 $ and $ C_2 $ then $ C_1 \land C_2 \vDash R $.

##### As a way to verify that a CNF formula is **unsatisfiable**

If we derive the empty clause $ \bot $, then the original set of clauses were unsatisfiable.

##### As a way to verify that a CNF formula is **valid**

We first negative the formula, then use resolution to try deriving $ \bot $. If the negated formula is unsatisfiable, then the original formula is valid.

##### Resolution deduction

A *resolution deduction* of clause $ C $ from a set $ S $ of clauses is a finite sequence $ C_1, C_2, ... , C_n $ of clauses such that $ C_n = C $ and for each $ i, 1 \ge i \ge n $, $ C_i $ is either a member of $ S $ or a resolvent of $ C_j $ and $ C_k $, for some $ j,k < 1 $.

A *resolution refutation* of a set $ S $ of clauses is a resolution deduction of $ \bot $ from $ S $.

### Converting formula

#### to CNF or to DNF
1. Eliminate all occurrences of $ \oplus $ using $ A \oplus B \equiv (A \lor B) \land (\neg A \lor =neg B) $
2. Eliminate all occurrences of $ \iff $ using $ A \iff B \equiv (A \implies B) \land (B \implies A) $
3. Eliminate all occurrences of $ \implies $ using $ A \implies \equiv \neg A \lor B $
4. Use De Morgan's Laws to push $ \neg $ inward over $ \lor $ and $ \land $
5. Eliminate double negations using $ \neg\neg A \equiv A $
6. Use the distributive laws to get the required form


### Equivalences
- Absorption
    + $$ P \land P \equiv P $$
    + $$ P \lor P \equiv P $$
- Commutativity
    + $$ P \land Q \equiv Q \land P $$
    + $$ P \lor Q \equiv Q \lor P $$
- Associativity
    + $$ P \land (Q \land R) \equiv (P \land Q) \land R $$
    + $$ P \lor (Q \lor R) \equiv (P \lor Q) \lor R $$
- Distributivity
    + $$ P \land (Q \lor R) \equiv (P \land Q) \lor (P \land R) $$
    + $$ P \lor (Q \land R) \equiv (P \lor Q) \land (P \lor R) $$
- Double negation
    + $$ P \equiv \neg\neg P $$
- De Morgan
    + $$ \neg (P \land Q) \equiv \neg P \lor \neg Q $$
    + $$ \neg (P \lor Q) \equiv \neg P \land \neg Q $$
- Implication
    + $$ P \implies Q \equiv \neg P \lor Q $$
- Contraposition
    + $$ \neg P \implies \neg Q \equiv Q \implies P $$
    + $$ P \implies \neg Q \equiv Q \implies \neg Q $$
    + $$ \neg P \implies Q \equiv \neg Q \implies P $$ 
- Biimplication
    + $$ P \iff Q \equiv (P \land Q) \lor (\neg P \land \neg Q) $$


### Priority
$ \neg $ binds tighter than $ \land $ and $ \lor $.
These bind tighter than $ \oplus $, which binds tighter than $ \implies $ and $ \iff $.

### Side points
- In logic, *valid* means *vacuous (void of information)*
- $ A $ if $ B $ means that $ B \implies A $
- $ A $ only if $ B $ means that $ A \implies B $
- $ A $ if and only if $ B $ means that $ A \equiv B $

### Predicate logic

#### General Terminology
- Existential quantification (there exists) : $ \exists $
- Universal quantification (for all) : $ \forall $
- the arity of a function/predicate : a number that says how many arguments the function takes
- literal : an atomic formula or its negation
- valuation : a function which maps truth value to variables

#### Concept
- term - $ f(t_1, ..., t_n) $
    + definition : a variable or a constant or a construction
    + when $ n > 0 $, $ f $ is a function symbol of arity $ n $, and each $ t_i $ is a term
    + a term is an individual or object
- atomic formula (or atom)
    + a construction $ P(t_1, ..., t_n) $ where $ n \ge 0 $ and $ P $ is a predicate symbol of arity $ n $
    + an atom is an assertion ($ true $ or $ false $)
- variable
    + a variable which is in the scope of a quantifier is bound. Otherwise, it's free
    + TODO variable that is both free and bound in a formula
    + a formula with no free variable occurrences is *closed*
- interpretation
    + Consists of
        * Non-empty set $ D $ (the domain, or universe)
        * An assignment to each n-ary predicate symbol $ P $ of an n-place function $ p : D^n \rightarrow \{f, t\} $
        * An assignment to each n-ary function symbol $ g $, of an n-place function $ g : D^n \rightarrow D $
        * An assignment to each constant $ a $ of some fixed element of $ D $
    + A wff $ F $ is true interpretation I iff every valuation makes $ F $ true. If not true then it is false in interpretation $ I $
    + A model for F is an interpretation I such that F is true in I. We write $ I \vDash F $.
    + A wff $ F $ is logically valid iff every interpretation is a model for $ F $. In that case, we write $ \vDash F $
    + $ F_2 $ is a logical consequence of $ F_1 $ iff $ I \vDash F_2 $ whenever $ I \vDash F_1 $. We write $ F_1 \vDash F_2 $
    + $ F_1 $ and $ F_2 $ are logically equivalent iff $ F_1 \vDash F_2 $ and $ F_2 \vDash F_1 $. We write $ F_1 \equiv F_2 $
- Satisfiability and Validity
    + A closed wff $ F $ is:
        * *satisfiable* iff $ I \vDash F $ for some interpretation $ I $
        * *valid* iff $ I \vDash F $ for every interpretation $ I $
        * *unsatisfiable* iff $ I \nvDash F $ for every interpretation $ I $
        * *non-valid* iff $ I \nvDash F $ for some interpretation $ I 
$
#### Side points
- Usually use $ \implies $ with $ \forall $ and $ \land $ with $ \exists $
- $ \forall x \exists y $ is **not same** as $ \exists y \forall x $
- $ \forall x \forall y $ is same as $ \forall y \forall x $ and $ \exists x \exists y $ is same as $ \exists y \exists x $
- $ \exists x F \equiv \neg \forall x \neg F $

## Extra Stuff

### Terminology
- strict function : A function f is said to be strict if, when applied to a non-terminating expression, it also fails to terminate.


### refutable/irrefutable

Patterns that never fail is said to be *irrefutable*.
Otherwise, it is *refutable*.