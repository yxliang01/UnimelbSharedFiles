Author: Xiao Liang Yu

This document may contain some subjective opinions 

Declarative Programming 2016s2

=====

Why Declarative Language
=====

- Programs are normally shorter
- Thread-safe for sure (good for parallel programming)
- Can **allow us to write program using imperative language better!!!**


Side effects
=====

A side effect might

- modify a global or a static variable
- modify one of its arguments
- raise an exception
- write data to a display, file or network
- read data from a keyboard, mouse, file or network
- call other side-effecting functions

With side-effects, a program's behavior depends on history.
When you have a program with side-effects, you have to look through everything to understand the program

Declarative languages has only *one side-effect*. That is *raising an exception*.

### Not good for large systems

For example, one of your function's calls changed the input argument and you don't know and used it somewhere else and produced unexpected result, it's very hard to fix the bug since you don't know that unless you understand all the functions you function calls.




Referential Transparency
=====

The absence of side effects allows an expression can be replaced with its value
This requires that the expression has no side effects and is pure(i.e. always returns the same results on the same input)

In contrast, in imperative languages(like C, Lisp), functions in general are not pure and are thus not functions in a *mathematical sense*. Two identical calls may return different results. 




Comparison between imperative and functional
=====

Imperative

- based on *commands*, in the form of *instructions* and *statements*
- Commands
    + are executed
    + have an effect


Functional

- based on *expressions*
- Expressions
    + are evaluated
    + have no effect
- Calling a function with same arguments will always get the same result



Terminology
=====

- Command
    + are executed
    + have an effect
- Expression
    + are evaluated
    + have no effect
- Pure
    + code that doesn't modify data
- AntiPattern
    + An AntiPattern is a literary form that describes a commonly occurring solution to a problem that generates decidedly negative consequences.
- Reduction
    + reduce the dimension of a value
    + e.g. reduce a list to a single value

Haskell
=====

- equational reasoning
    + if two expressions have equal values, then one can be replaced by the other
- Function
    + consists of equations, each of which establishes an equality between the left and right hand sides of the equal sign
    + set of patterns should be exhaustive
        * at least one pattern should apply for any possible call
    + the set of patterns should also be exclusive
        * at *most one pattern should apply* for any possible call
    + matching lists
        * `[]` matches *empty* list
        * `[x]` matches list of *length 1*
        * `(_:_)` matches list of length *at least 1*
        * `(_:_:_)` matches list of length *at least 2*
        * e.g.
```Haskell
f (_:_:_) = 1 -- for length at least 2
f (_:_) = 2 -- for length at least 1
f [] = 3 -- for length == 0
```
    + calling a function: `f fa1 fa2 fa3`
    + recursion is the key
    + `function_name :: [TYPE1] -> TYPE2`
        * declare function `function_name` 
    + Partial applications of functions
        * we can define a function with a call to the other function sharing some of the arguments while some of the arguments of that call are fixed
        * It's with the creation of *closure* when it's a function
            - e.g. `(some_function first_argument)`
        * When it's an infix operator, we can make it a partially applied function with surrounding buckets. This involves creating a *section* 
            - e.g. `(/3)`, `(3/)`
    + infix operators can be used as if it's a function by having brackets surrounding it
        * e.g. `(*) 8 9 == 72`
    + any arity-2 function can be turned into an infix operator by surrounding with backquotes(`)
        * e.g. ``3 `mod` 2 == 1``
    + Pattern Matching Misc
        * `lst@(x:xs)`
    + currying
        *  `->` denotes a function that takes an argument of the type on the left, and returns a value of the type on the right
        *  in Haskell, all functions take only one argument and return one value
- Naming
    + must start with a lower case letter
    + consists of letters, numbers and/or underscores
- Indentation matters
    + Suppose line1 starts in column `n` and the following nonblank line, line2, starts in column `m`. The *offside rule* says
        * if `m > n`, line2 is a continuation of the construct on line1
        * if `m = n`, line2 is the start of a new construct at the same level as line1
        * if `m < n`, line2 is either the continuation of something else that line1 is part of, or a new item at the same level as something else that line1 is part of
- Order of Evaluation
    + it matters when it comes to efficiency
- lexicographic ordering
    + It compares the values in turn, from left to right. Means the value that comes the first will have the most significance.
- Single assignment
    + You can only define a variable's value ***once***
        * You can't change it later (all `const` variables)
    + `let a=12302130213232 in .....`
        * only define `a` in the expression after `in`
- *strong*, *safe* and *static* type system
    + *strong*
        * you can't cast
    + *safe*
        * it won't crash because of a type error
    + *static*
        * types are checked when the program is compiled, not when the program is run
    + Although it's rare, Haskell can have a dynamic type
- Special things
    + `_` is a placeholder for things that you want to ignore
- Variables
    + must start with a lowercase letter
    + `it` the result returned by the last successfully evaluated expression (only for ghci)
- Types
    + Must start with Upper-case letter
    + `Maybe`
    + in declarative languages, all types are immutable
    + Mutually recursive type
        * a type that has component refer to another type while the another type has component refer to the type.
    + Define a new type
        * `data Name = S1 | S2` a type with two possible values
        * create a new structure
        * `deriving SOMETHING`
            - `Eq` can compare equality
            - `Show` show the value using the string representation of the values 
            - `Ord` ordered
                + must be in `Eq` as well
                + a constructor listed earlier is less than a constructor listed later!!
        * sum types and product types
        * Two types of induction(methods of proving things)
            - Structural induction
                + Typically function that handles recursive type will have
                    1. pattern matching the recursive constructor
                    2. pattern matching the non-recursive data constructor
                + If we have a recursive type, we must have a non-recursive data alternative
            - Proof by induction
                + prove that it does the right thing on the base case
                + it does the right thing for n $ \le $ k
                + as a result, it will do the right thing for n $ \le $ k+1 implying it will be right for all n
        * `type` creates new alias of existing types
        * record syntax
            -  
```Haskell
data Something = Something {
    something1 :: Int
    ,something2 :: String
}
something1 (Something 1 "Str") -- 1
something2 (Something 1 "Str") -- "Str"
```
            - Accessor functions will be created automatically
    + `Bool`
        * `True` | `False`
        * `False` != 0  and `True` != (not 0) (not like Ｃ)
    + `Int`
        * either 32 or 64 bits
        * `Int32`, `Int64`, ....
    + `Integer`
        * unbounded size
    + `Float`, `Double`
    + `Char`
    + `list`
        * a type constructor
        * all the elements must be of the same type
        * `[T]` - a list of type `T`
        * `[[T]]` - a list of lists of type `T`
        * list enumeration
            * `[1..10] = [1,2,3,4,5,6,7,8,9,10]` (it's inclusive)
            * `[1.0,1.25..2.0] = [1.0,1.25,1.5,1.75,2.0]`
            * if the endpoint doesn't fit the step, it won't be included
            * `[1..]` will give you an infinte list (won't stop and have to be killed) which each element step of 1
            * careful with floating point enumeration
                - `[1.0..1.8] = [1.0,2.0]`
            * If you want custom step, specify the first two elements of the list
                - e.g. `[1,3..]` step of 2
    + `Ratio Integer`
        * Use `%` to define
        * e.g. `11 % 29`
    + `head:rest`
        * `head` is **an element** while `rest` can be either a `list` or an element(when the list has length 2)
        * `[]` empty list
        * `["a","b"]` is shorthand for `"a":"b":[]`
- `['a', 'b', 'c'] = "abc"`
- `[] == ""`
- built-in function
    + `head`
        * return the head of a list
        * `head "hellow" = 'h'`
    + `let`
        * assign a value to a name
    + `not`
        * same as `!` in C
    + `succ`
        * `succ 6 == 7`
    + `pred`
        * `pred 7 == 6`
    + `truncate`
        * rounds towards 0
        * `truncate 3.9 == 3`
    + `floor`
    + `ceiling`
    + `filter func lst`
        * return a list with elements such that `func element == True`
    + `map func lst`
        * return a list of `func element`
    + folds
        * left fold will execute the function on the leftmost element to the rightmost element while right fold is the other way around
        * `foldl :: (v -> e -> v) -> v -> [e] -> v` (deprecated definition)
        * `foldr :: (e -> v -> v) -> v -> [e] -> v` (deprecated definition)
        * balanced fold
            - TODO!!!
- List comprehension
    + consists of 
        * *1* template - an expression
        * *1+* generators (e.g. `var <- list`)
        * *0+* tests (boolean expressions)
        * *0+* let expression defining local variables
    + `[template | generator1, generator2, test1, test2, let1, let2]`
    + e.g.
        *
```Haskell
[ c | a<-[1,2,3],b<-[1,2,3],let c=(a,b)] 
-- [(1,1),(1,2),(1,3),(2,1),(2,2),(2,3),(3,1),(3,2),(3,3)]
```
- built-in command(starts with `:`)
    + `:type VALUE` or `:t`
    + `:load`
        * load a "hs" script
    + `:edit`
    + `:reload`
    + `:set prompt "SOMETHING"`
    + `:set +t`
        * print the type of an expression after the expression
    + `:unset SOMETHING`
    + `:info SOMETHING`
- Type inference
    + If you don't define types, Haskell will try to define it with the most general types(like `Num`)
- Operators
    + `++` concatenation
    + `/=` not equal
    + we can write in *prefix* form
        * like `(+) 2 3 = 5`
    + `-` negation
        * do put brackets around negative number
    + `^` raise a number to an *integer* power
    + `**` raise a number to a *floating point* number
    + define a infix operator
        * precedence
            - `1` the lowest, `9` the highest
            - higher-precedence operator will be applied first
    + `.` point operator
        * `(f . g) x = f (g x)`
        * `(.) :: (b -> c) -> (a -> b) -> a -> c`
        * created the *point-free style*
- fixity rule
- Conditions
    + case VARIABLE_NAME of 
        * have different value depending on the type of 
        * Example
            - 
    ```Haskell
    case var of
        something -> True
        somethingElse -> False
    ```
    + if-then-else
        * `else` is not optional
        * `then` and `else` are expressions, not statements
        * `then` and `else` must return the same type
        * `iota n = if n == 0 then [] else iota (n-1) ++ [n]`
    + guards
        * 
```Haskell
iota n
    | n == 0 = []
    | n > 0 = iota (n-1) ++ [n]
```
    + Structured
```Haskell
iota n =
    if n == 0
    then
        []
    else
        iota (n-1) ++ [n]
```
- a lazy language
    + only evaluate expressions when needed
- Anonymous function
    + start with `\`
    + whatever at the left-hand side of `->` is input arguments
    + right-hand side of `->` is the return value
    + e.g. `\x y -> x+y`
        * simple addition function
- 


Chruch-Rosser Theorem
=====

- for the rewriting system known as the lambda calculus, regardless of the order in which the original term's subterms are rewritten, the final result is always the same
- this holds for Haskell and for some other functional programming language, but not for all
- not applicable to imperative languages


Orders
=====

- first order values are data
- second order values are functions whose arguments and results are first order values
- third order values are functions whose arguments and results are either first order values or second order values
- *n-th order values are function whose arguments and results are values of any order from first up to n-1*
- Values belong to an order higher than first are higher order values
- reasons of using higher order functions
    + code reuse
    + a higher level of abstraction
    + a set of *canned solutions* to frequently encountered problems


Questions
=====

1. what is the type of `[]`?

`[]` can be any type that is a list type
