
Author: Xiao Liang Yu

Part of the content is taken from Tim and Andrew's slides
This document may contain subjective opinions 


Foundation of Computing 2016s1
=====


Python Feature
=====

- Easy to learn
- Interpreted language
- Interactive experimentation
- Free
- Open source
- Highly readable
- Cross - platform compatible
- Powerful, extensive libraries
- imperative language
	+ it has "program state"
	+ the value of variables are changed only through assignments


Syntax
=====

- stacked assignment
	+ e.g. a = b = c = 1 + 2
- variable names must start with a letter or underscore
- variable names must consist of only alphanumeric characters and underscore
- casing is significant
- reserved words
	+ operators and literals
	+ e.g. 
        ```python
        exec yield
        ```

- *default arguments must come after non - default arguments*
- *keyword arguments must come after positional arguments*

Basic arithmetic
-----

- `+` addition, `-` subtraction, `*` multiplication, `**` exponent and `%`	modulo
	+ if one of the operands has type *`float`* , the result will be *`float`*
	+ otherwise, *`int`*
- `/` division
	+ the return result has type *`float`*
- `//` floor division(integer division)
	+ the return result has type *`int`* and will be rounded down to the nearest integer

Shorthand arithmetic assignments
-----

- `+=`, `-=`, `*=`, `|=`, `&=`
- `/=` will change the original variable to be float if it was int
- `//=` will change the original variable to be int if it was float

Comparison operators
-----

- `==` equal to
- `!=` not equal to
- `in` is an element of
	+ 2 in (2, 3) == True
- `is` have same identity with
	+ `True is True` == True
	+ `2305 is 2305` == True
	+ `(1, 2, 5) is (1, 2, 5)` == False * although tuples are immutable, each time we assign a tuple having elements and order same as an existent tuple, they still have different identity. Same goes to list.
    + use to check if `is None`

Logic Operators
-----

- `and`
- `or`
- `not`

precedence: `not` > `and` > `or`


Comment
-----

- `  # ` single line(inline) comment
- `"""` multi-line comment
- `'''` multi-line comment


With statement
-----

`with open("some.txt", "r") as file_opened: ` 

- this opens a file and `file_opened` is the file handling object.
- only statements within the `with` block can access the file
- the object will be freed when statements in the `with` block had been completely executed

Numbers
-----

- `0x` represents a hex number (base 16)
- `0b` represents a binary number (base 2)
- _`0o` represents a octal number_ (base 8)
    + previously, it was `0` (one single zero represents octal)


Special variable
=====

- `_` stores the return value of last statement executed
	+ only available in interactive shell
	+ initially, _ is undefined
	+ If last statement didn't return any value(or return None), _ won't be changed(or created if it's undefined).



Boring Definitions
=====

- computer programs
	sets of steps to complete some task
- Method
	a function that is a member of an object
- Object
	a collection of data and functions
- Function
	functions take a set of input values, perform some calculation based on them, and optionally return a value
- Parameter
	names appear in function declarations
- Argument
	values that are passed to functions when calling
- Namespace
	a mapping from names to objects
- Scope
	area of python code where a particular namespace is used
- Module
	modules are pre-prepared "stores" of convenient functions/variables which expend the functionality of python
- Bug
	an error/flaw in a piece of code that leads to a malfunction
- docstring
	comments appear right after the function declarations telling people what it's supposed to do, receive(input arguments) and return
- generator
	a function which returns an iterator
- *API*
    a set of functions and procedures that allow the creation of applications which access the features or data of an operating system, application, or other service

    + modularity
    + abstraction
    + convenience

- Bit
    a single digit binary number
    bits are generally processed as vectors of 8 bits(= a byte/octet) or larger
- Byte
    8 bits
    often represented in hexadecimal(two hex digits)
- Literal
    constant values of a given type

Built-in Functions
=====

- `print(object(s))`
	+ used to print out values
	+ each time it will print a *newline* at the end
    + when you input more than one object, it will use space to separate each object

- `type(an object)`
	+ return the type of the argument inputted to `type`
	+ return a 'type' object

- class constructors
	+ cast values to a type

- `abs(number)`
	+ absolute value of the argument
- `len(iterable)`
	+ the length of an iterable passed as an argument
- `range(start=0,end,step=1)`
	+ generate an sequence(iterable) returning number from $start$ to *** $end - 1$*** with step of numbers $step$
    + careful with *off-by-one error* on the argument *`end`*
- `id(object)`
	+ return the identify of an object
- `enumerate(iterable)`
    + return an iterator returning tuples `(index, element)`, `element` is an element in the iterable, `index` is the index of the element in the iterable
- `sorted(iterable/iterator, key=None, reverse=False)`
	+ key is a function
	+ if the iterable is a *dict*, it will return **only the keys**
	+ return a list with elements contained in the iterable/iterator with the order sorted according to the `key` in ascending/descending order(ascending when `reverse = False`)
- `reversed(sequence)`
    + return an iterator which allows you to traverse a sequence in reverse order(from the last element to the first)
- `zip(iterables/iterators)` - put iterables together such that it *groups elements having the same index* together
    + the number of elements returned depends on the argument which has the least number of elements
    + return an iterator
    ```python
    a = zip([1,2,3],[4,5,6])
    list(a) # [(1,4),(2,5),(3,6)]
    ```
- get string representation of numbers with different base
    + `hex(num)` str representation of a number in base 16 
    + `oct(num)` str representation of a number in base 8 
    + `bin(num)` str representation of a number in base 2 
- `chr(Unicode code point)`
    + return the character corresponding to that inputted Unicode code point
- `ord(str(a character))`
    + the only argument can only *take a `str` which contains one single character*
    + return the code point of the character as based on the Unicode standard
- `isinstance(obj, classinfo)` 
    + return true if the object argument is an instance of the classinfo argument
- `input(prompt)`
    + print the prompt, then wait for user input from `stdin`

Character Encoding
=====

Unicode
-----

- Lecturer's definition:
    + Unicode is a map of all of the glyphs in the world's documented language (and much else besides) to a unique code point.
- My understanding:
    + Unicode is a map of characters of different languages in the world to a unique code point trying to allow different languages to appear in the same document. 
- normally python `str` is natively in Unicode
- But for file IO, it may use different default encoding
- `open(path, encoding)` to let python interpreting the file in a specified encoding, specify the encoding when opening the file  
- basic philosophy behind Unicode has been to add more code points for different "languages", starting with the pre-existing encodings
- an attempt to represent all *text from all languages* in a single standard
- intended to support the electronic rendering of all texts and symbols in the world's languages
- each grapheme is assigned a unique number or *code point*
- there's scope within unicode for both precomposed (e.g. à) and composite characters/glyphs (e.g. ` + a) 

### Variable-width Unicode encoding

encode the code points using a variable number of "code units" of fixed size

Encoding
-----

### Utf-32

- uses 32-bit encoding to represent each Unicode code point value **directly**

### ASCII

- 128 characters, based on 7-bit encoding
- can only encoding a small number of characters

### ISO-8859

- built on top of ASCII (7-bit), to include an extra 128 characters
- code points are 8 bits

### UTF-8

- Lecturer's definition:
    + UTF-8 is an encoding used to represent Unicode strings, based on 8-bit code units
- code unit = 8 bits (1 byte)
- compatible with ASCII
- standard encoding within XML and for HTML5
- byte sequence for a given code point never occurs as part of a longer sequence
- character boundaies are easily locatable

### UTF-16

- code unit = 16 bits (2 bytes)



Error Handling
=====

Error Types
-----

### Syntax Error

incompatibility with the syntax of the programming language
caused by statement which isn't understood by interpreter/compiler

### Run-time Error

error at run-time, casuing the code to crash

### Logic Error

design error, code is working but doesn't do what it's supposed to do

### IndentationError 

unexpected indentation
```python
min = 1
    max = 2
```



Exceptions
-----

- `ZeroDivisionError` (division by 0)
- `TypeError` an operation has been attempted which is invalid for the type of the target object or object type combination(unhashable type error, etc...)
- `NameError` (name is undefined, etc...)
- `ValueError` the value of an object is invalid for that type (`int("a")`, `"a"` can be converted to int, etc...)
- `KeyError` (key doesn't exist in a `dict`, etc...)
- `IndexError` (index out of range, etc...)
- `AssertionError` raised by assert statement
- `StopIteraton` raised by iterators indicating it has no elements in it

`try: .... except Exception: .... else: .... finally: ....`
-----

- if the statement in the try block raises exceptions which match with one of the except blocks, program will stop running statements in try block and start executing the statements in the matched except block
- the else clause will be executed when no exception was raised
- the finally clause will always be execute after done executing try/except/else blocks
	+ if there's exception raised without matching any of except block, it will execute the finally clause before crashes 
- empty `except` clause will catch all the exceptions which didn't match any of other `except` clauses. However, this empty `except` clause must be put after all other `except` clauses.

Assert
-----

- It's a statement (not function)
- Should be used for checking whether the program has entered impossible code states
- It's an important tool in defensive programming

File Operations
=====

- `open(path, mode)` creates an object for accessing the file opened
	+ modes
		* `'r'`, `'w'`, `'a'`
		* `'rb'`, `'wb'`, `'ab'`
- methods
	+ `write(x)`
        * It will *not add newline character* after writing `x`! 
	+ `read()` read the whole file and return its content
	+ `readline()` read a line
	+ `readlines(hint=-1)` read the whole file and return its content split by lines into a list. no more lines will be read if the total size (in bytes/characters) of all lines so far exceeds hint.
	+ `close()` close the file handler
- when iterating through lines, use `for line in file:`
	+ the newline character will be *included* at the end of the variable `line`

Library
=====

collections
-----

### defaultdict

- a dict which will create a new entry automatically by a factory function when it was tried to access a key which doesn't exist

e.g.
```python
from collections import defaultdict as dd
a = dd(int)
b = a["hi"]
print(a) # defaultdict(<class='int', {'hi': 0})
print(b) # 0
```

csv
-----

- csv files normally uses *commas* to separate values
- __values read by csv libraries are in str!!__
    + convert to number types when necessary
- functions
	+ `csv.DictReader(file_object)`
		* first line will be the column row
		* return a `list` of `dict`
		* get value by column names(they are keys)
	+ `csv.reader(file_object)`
		* return a `list` of `list`
		* each line will be a `list`
		* the index of level 1 list indicates the line number
			+ first line has index 0
		* the index of level 2 list indicates the column number
			+ first column has index 0
        * the returned object has *method `next()`*, can be used to read/skip a row

itertools
-----

- standardizes a set of fast, memory efficient tools
- functions
	+ `product(iterables/iterators...)`
		* return a product object
		```python
		a = list(product((1,2),(3,4))) 
		print(a) # [(1,3),(1,4),(2,3),(2,4)]
		```
	+ `cycle(iterable/iterator)`
		* return an iterator
		* repeat the iterator/iterable passed infinite times
	+ `groupby(iterable/iterator, key=None)`
		* key is a function
		* _the iterable/iterator has to be **sorted according to the key** first!!!_
		* return an iterator, elements can be treated as 2-tuple having form `(key value, an iterator containing all elements in the group)`
		```python
		for key, group in groupby([1,1,1,2,2,3]):
			print(key, tuple(group))
		```
		gives you
		```
		1 (1, 1, 1)
		2 (2, 2)
		3 (3,)
		```
    + `chain(iterators/iterables)` yields the elements in iterables one by one
        * e.g. `list(chain("abc,"def"))` -> ['a', 'b', 'c', 'd', 'e', 'f']
    + `chain.from_iterable(iterable/iterator)` same as chain, but now the input is a chained iterable
        * e.g. `chain.from_iterable(["abc", "def"])` -> ['a', 'b', 'c', 'd', 'e', 'f']
    + `combinations(iterable/iterator, k)`
        * return an iterator
        * `combinations` ends with **'s'**
        * elements in the iterable will be treated as unique *by their index not their value*
        * k is the number of elements of each combination (n choose k)
        * each element is in the form of a *tuple*
    + `permutations(iterable/iterator, k)`
        * return an iterator
        * `permutations` ends with **'s'**
        * elements in the iterable will be treated as unique *by their index not their value*
        * k is the number of elements of each permutation
        * each element is in the form of a *tuple*

PIL (Not examinable)
-----

- `Image` object
    + methods
        * `new(mode, (width, height))` create a new image
        * `open(path)` open an image file and return its image object
- Image object created
    + methods
        * `load()` return something that allows us to modify the image in *pixel level*
        * `save(path)` save the image to the path
            - path should contain the *extension* as well
    + variable
        * `mode` the mode of the image object
            - e.g. `"RGB"`, `"1"` binary, `"L"` grayscale
        * `size` a tuple having form (width, height)

Type
=====

Everything in python is an object

Object Properties
-----

- *iterable*
	+ an object capable of returning its members(elements) one at a time
        * namely, an objecct has `__iter__` method 
- *hashable*
	+ an object has hash value which never changes during its lifetime and can be compared with other objects
	+ hashable objects which compare equal must have the same hash value
    + for built-in objects, "recursively immutable $=$ hashable"
- *sequence*
	+ iterable
	+ the order of the elements in iterable matters
	+ must be finite
    + supports indexing
        * negative indexing (e.g. a[-1] will give the last element of a)
    + supports slicing
        * `lst[b:c]` will return a newly created object will have elements in `lst` from element of index b to the element of index **c-1**
        * `lst[b:]` will return a newly created object will have elements in `lst` from element of index b to the **last** element
        * `lst[c:b:-1]` will return a newly created object will have elements in `lst` from element of index c to the element of index **b + 1** with order reversed
        * `lst[:b]` will return a newly created object will have elements in `lst` from element of index of 0 to the element of index **b-1**
- *immutable*
	+ the value of an immutable object can't be changed after the object had been created
- *mutable*
	+ the value of a mutable object can be modified after the object had been created

Number Types
-----

- `int` integer
- `float` real number
	When you input a number with `.`, it will be treated as a float
- `complex` complex numbers

String `str`
-----

- can be enclosed within either single quotes ('') or double quotes ("") or the triple version (""" or ''')
	+ the triple version of quotes is for avoiding escaping quotes in string
    + we must use the triple version to have a str having multiple lines (i.e. a str having newline character in it)
- escape characters
	+ prefix with `\`
	+ Common ones
		* `\"`
		* `\'`
		* `\\`
- special characters for formatting
	+ `\t` tab
	+ `\n` newline
- overloaded operators
	+ `+` concatenation
	+ `*` repeat string N times
	+ `in` subset
		* `"abc" in "abc343243"` == True
- support splitting
	+ break up a string into components based on particular substrings
- methods
 	+ `format(args)` method
		* very powerful
		* `{}` means a positional argument
        * `{2}` the third positional argument
        * `{name}` the keyword argument `name`
        * `{person.name}` the `name` attribute of the keyword argument `person`
        * `{2.name}` the `name` attribute of the third positional argument
        * `{1:specifier}` the second positional argument
            - the specifier can be
                + `d` integer
                + `f` floating point number
        * `{1:10.5f}` displays at least 10 columns for this number and 5 digits after the `'.'` 
	+ `STRING.join(iterable)`
        * the iterable must contain all `str` elements 
		* return a string with `str`s in the iterable `iterable` joined with str `STRING`
            + namely, elements in `iterable` must all be `str` 
		* sometimes, you may want to put STRING to the 'start' and 'end' of the returned str
	+ `upper()` return a new str with all characters converted to *upper-case*
	+ `lower()` return a new str with all characters converted to *lower-case*
	+ `strip(STRING=White space characters)`
		* return a str with STRING from the str removed if STRING appears at the start or the end of `str`
        * e.g. `"ssdds".strip("s")` returns `'dd'`
        * e.g. `'              d            '.strip()` returns `'d'` 
	+ `split(delimiter)`
		* separate a string by delimiter, and store each separated part to a `list`
        * the default is whitespace character(like space, ***newline character***, tab etc...)
        * if `delimiter` doesn't exist in the `str`, it returns a list with only one element which is the original `str`
    + `isdigit()` return bool to indicate whether the str *contains all digits* (can be converted to `int`)
        * str containing floating point number will return False (because of `'.'`) 

Container
-----

- `tuple`
	+ once created, we can't change add/remove/replace elements in a tuple (in other words, the identities of elements of tuples can't be changed once a tuple had been created)
	+ but, if the element in it is mutable object, we can change it (since the identity of it is unchanged)
	+ tuple with one element, __use `(a,)` not `(a)`__
    + it's a sequence (therefore, supports slicing)
- `list`
	+ same as tuple just that it's mutable
	+ methods
		* **`append(element)`**
		* `remove(element)`
		* **`pop(index)`** remove the element with index `index` and return it
			- the default value of `index` is `len(list) - 1`. So, it will delete and return the last element
		* `insert(index, element)` add the element to the index `index`, elements after it will be moved by one to the right 
	+ support deletion (i.e. `del lst[idx]`)
- `dict`
	+ key-value pair mapping
	+ key must be hashable(normally $==% recursively immutable)
	+ empty dict == `{}`
	+ when we get an iterator from a dict, the elements of that iterator are **only the keys** of the dict 
	+ methods
		* `get(key, default=None)`
            * if the key doesn't exist in the dict, it will return `default`
        * `setdefault(key, default)`
            - return `dict[key]` if it exists
            - otherwise, it will create the entry then assign `default` as its value then return `dict[key]`   
		* `pop(key)` delete and return `dict[key]`
            - argument `key` is not optional
		* `clear()` delete everything from dict in-place
		* `keys()` return a view of dictionary keys, when the dict changes, its return object will be updated automatically(actually it's a reference to the `dict`), normally convert to tuple before access it
		* `values()` return a view of dictionary values, when the dict changes, its return object will be updated automatically(actually it's a reference to the `dict`), normally convert to tuple before access it  
		* `items()` return a view of dictionary values, when the dict changes, its return value will be updated automatically(actually it's a reference to the `dict`), normally convert to tuple before access it as a tuple of 2-tuples
		* the inner tuple has structure (key, value)
	+ supports deletion	(i.e. `del dictionary[key]`)
    + since it's not a sequence, *the order of keys may not follow the order that you added them to it*
- `set`
	+ mutable
	+ not a sequence
	+ it's unordered
	+ elements are unique
    + elements must be hashable
	+ empty set == set()
	+ special operators
		* `-` set difference
		* `|` set union
		* `&` set intersection
	+ methods
		* `add(element)`
		* `remove(element)`
- `iterator`
	+ formal definition: an iterator is an object that keeps track of traversal of a container
	+ Another formal definition: an interface allows us to traverse a container sequentially
	+ it keeps track of what you have accessed and what you haven't
	+ right after returned an element, it will be deleted from the iterator
	+ use `iter(iterable)` to get an iterator from an iterable
	+ the order of elements is defined
	+ Methods
		* `__next__()` return the first element in the iterator
			- we should use `next(iterator)` to access it
	+ it raises `StopIteraton` exception when the iterator is empty
	+ It's good to use when traversing an iterable
		* less scope for a programmer to make an error
			- don't have to 'initializes' the index variable
			- don't have to 'define the end value' of the index variable
			- don't have to 'increment' the index variable
		* convenient
			- just use `next(iterator)` to access the next element
	+ can be **infinite**
	+ can't `len(iterator)`
	+ no random access


Scope
=====

- functions can access variables defined outside functions ("global" variables), although they should be used with extreme caution
- variables have scope of their defined level. Variables defined in a function is not accessible from outside
- when we want to use global variable, use the keyword `global` to declare them inside of a function.
- when python starts up, a global namespace is created
- when a function is called, a local namespace for that function is created, and then forgotten when it ends
- when we try to access a variable, python will try to look at the local namespace first. If not found, move up a level until it found or not found at the global namespace. (**shadowing happens here!!**)
- `dir()` to list the current namespace


Convention
=====

- Use capital letters for constants
- don't compare True and False
- don't compare None
    + use `is None` instead

Misc
=====

- Value assignment
	+ When assigning values, it will try to evaluate right-hand side value first then assign it to the left-hand side variable

- function default value
	+ they can be a return value of a function, list, anything!
	+ the default value is evaluated and memorized *at the time the function is defined*
	+ careful to have default value a list since list is mutable object(it will take the identity of the list as a default value, therefore, all changes to that list will be kept)

- reasons for using functions
	+ archiving code in libraries
	+ removing redundancy
	+ ease of testing
	+ increasing modularity
	+ increasing readability

- functions share the same namespace with variables, and are called 'standalones'
- When using for loop iterating an iterable, **do not** modify the iterable
- `import` adds an object to the *local namespace*
- docstring will be the `__doc__` attribute of an object, use `help(obj)` to view that
- defensive programming
	+ build up your code bit by bit
	+ "log" each step of your progress
	+ use comments to remind you about any assumptions made by the code
	+ always be on the lookout for common gotchas
	+ program code must *communicate with humans*, not just machines

- general approach to debugging
	+ reproduce the bug
	+ determine exactly what the problem is
	+ eliminate "obvious" causes
	+ divide the process, separating out the parts that are confirmed correct from the parts that might have flaw
	+ when you reach a dead end, reassess your information. then step through the process again
	+ as you proceed, make predictions about what should happen and verify the outcome
- actuality of software testing
	+ **execution-based verification**
		* *generate and execute test cases, and check the correctness of the output*
		* generally impossible to enumerate all possible inputs/use cases, so instead focus on developing a set of "representative" inputs to test the code over
		* in addition to "integration" testing (between system components), "unit" test the components of the system
	+ **non-execution-based verification**
		* detect bugs by *eyeballing* the code directly
- Test cases
	+ test cases should be independent of the software implementation, and (ideally) be designed to:
		* test one thing each
		* test over the spectrum of use cases for the software (often based on the "boundaries" of inputs)
		* (in part) identify and test "corner case" inputs
- Common python gotchas
	+ Correct use of types
	+ incorrect use of function/method (e.g. `return lst.sort()`)
	+ spelling and capitalization
	+ loops and incrementing
	+ conditionals and indentation
	+ namespace problems
- Call stack
	Functions called are stored in a call stack
	It allows functions to communicate with each other with suspended functions' local state/namespace preserved 
- IP
	+ each device on the Internet has an IP address
	+ In IPv4, IP address consist of four 8-bit integers, each in the range [0,255]
	+ IP is allocated either "dynamically" (an IP is allocated when the device connects to Internet) or "statically" (an IP reserved for a given device)
	+ It can be either "local" (addressable only on a private network) or "external" (directly addressable from anywhere on the Internet)
		* 192.168.x.x is one of the local IP ranges
	+ devices with local IPs can often access open Internet through proxy server or gateways
    + we want to move to IPv6 is because we are running out of IPv4 addresses
- Hostname
    + domain name (e.g. unimelb.edu.au) and end with a "top-level domain" (TLD, e.g. au)
    + hostnames resolve to IP addresses via the Domain Name System (DNS) using "name servers"
- Router
    + connects devices to allow different devices to communicate with each other
- URL
    + Uniform Resource Locator
    + $scheme://address:port/path$
        * scheme - the protocol for accessing the file
        * address - the device which contains the file
        * port - access port(optional)
        * path - where the file is at on the device 
- Units
    + for memory and storage, sizes are generally reported in bytes("B")
    + for network speeds which are reported in bits ("b")
- Dynamic Web Programming
    + there's interaction between web pages and the user
    + *the content of web pages can be changed according to the user input in realtime*
    + Ajax is an important technology for this

HTML
=====

- *HyperText Markup Language*
- made up of "elements" ("tags" and "entities"), which are used to mark up content
    + tags are used to apply some operation to a document extent
    + entities are special characters
- tags are enclosed in "angle brackets" (e.g. `<tag>`), and take the form of:
    1. empty elements (e.g. `<tag />`)
    2. tag pairs (e.g. `<tag></tag>`)
- tags may contain attributes
- HTML documents start with `<!DOCTYPE html>` and normally has `<head>` and `<body>`
- The `<head>`
    + `<title>` - define the title for the file
    + `<meta />` - define a meta-data (like `keywords`, `description`, character encoding information)
        * e.g. `<meta name="keywords" content="python" />`
        * e.g. `<meta charset="UTF-8" />`
- The `<body>`
    + `<h1>`, `<h2>`, `<h3>`... - headers
    + `<p>` - paragraphs
    + `<br />` - line breaks
    + `<hr />` - horizontal lines
    + `<a href="URL">` - hyperlink
        * absolute URL
        * relative URL
        * `.` - current directory
        * `..` - parent directory
    + `<pre>` - pre-formatted paragraph (spaces and empty lines will be preserved)
    + `<img src="" alt="" />` - insert image
        * `src` - the location of the image
        * `alt` - alternative text (shows if the image doesn't load) 
    + `<audio><source src="" type=""/>alt</audio>` - include audio
    + `<video><source src="" type=""/>alt</video>` - include video
    + `<ul>` - unordered list
    + `<ol>` - ordered list
    + `<li>` - list item
    + `<i>` - italic
    + `<u>` - underline
    + `<b>` - bold
    + `<table border="width">` - define a table
        * `<tr>` - define a row
        * `<td>` - define a cell(column) with data putting within
        * `<th>` - define a cell which is a header
        * `border="width"` specify the width of the border of the table
- White spaces are not significant in HTML, any sequence of white space characters will turn into one single space
- HTML entities `&entity;`
    + most commonly used entities
        * `&quot;` " (**quot**ation)
        * `&nbsp;` space (**n**on-**b**reaking **sp**ace)
        * `&lt;` < (**l**ess **t**han)
        * `&gt;` > (**g**reater **t**han)
        * `&apos;` ' (**apos**trophe)
        * `&amp;` & (**amp**ersand)




Cryptography
=====

General Idea
-----

- sending messages that are secret from everyone but the intended recipient
- sender has to hide the message for sending, so nobody else can understand it
	+ called encrypting
- receiver has to un-hide and recover the message
	+ called decrypting

Secret-key Cryptography
-----

- both the sender and the receiver had to *agree on the secret key in advance*
	+ they had to "meet" somehow
- Encrypting and decrypting used the *same key*

Public-key Cryptography
-----

- receiver has to generate two keys
	+ public key $e$ (for encrypting)
	+ private key $d$ (for decrypting)
- She publicizes the public key $e$
- People use the public key $e$ to encrypt the message and send to her
- she uses her private key $d$ to decrypt
- *encrypt and decrypt using different keys~!*

# RSA

- two large prime numbers $p$ , $q$
- $N = p * q$
- generate the public key $e$
- publicizes ($N$, $e$)
- To encrypt message m
	+ computer $m^{e} \mod N$
- receiver can decrypt because she knows $p$ and $q$


PEP8
=====

- use multiple of 4 spaces to indent
- lines do not exceed 79 characters
- black lines to separate logical sections
- avoid multiple statement on the same line
- always start a new line after if, elif, else...
- comments not contradict to your code
- do not state the obvious in comments
- do not use single character variable names
- use self-descriptive variable names
- function names should be in lower case, use _ to separate words
- use upper case for names of constants, use _ to separate words
- Do not compare values to True and False using ==

Useful Methods
=====

counting with dictionaries
-----

```python
d = {}
for color in colors:
    d[color] = d.get(color, 0) + 1
```

`dict.get(key, value)` method's second argument is the value that it will return if the key `key` does not exist in the dictionary  

Unpacking sequences
-----

```python
one, two, three = (1,2,3)
```



Python special feature
=====

List/Dict/Set Comprehension
-----

`[x+1 for x in range(3)]` will give you `[1,2,3]`
this is very powerful since it can save you loops!!!

### Use with filtering

`[x for x in range(1, 10) if x % 2 == 0]` will give you a list of even numbers for which $>= 1$ and $< 10$ -> `[2,4,6,8]`


### Use with nested iterations and filtering

```python
threeD = [(1,2,3),(4,5,6),(2,3,9)]
a = [x for y in threeD for x in y] # since list and tuple are sequence, the order will be preserved
print(a) # [1,2,3,4,5,6,2,3,9]

# actually for the case above, use list(itertools.chain.from_iterable(iterable)) is better
a = list(itertools.chain.from_iterable([(1,2,3),(4,5,6),(2,3,9)]))
print(a) # [1,2,3,4,5,6,2,3,9]


a = [x for y in threeD for x in y if y == (4,5,6)]
print(a) # [4,5,6]

a = [x for y in threeD for x in y if y != (4,5,6) if x in (2,3)]
print(a) # [2,3,2,3]

```

When using list/dict/set comprehension with "nested iterations", The higher level comes first


Algorithms
=====

****An algorithm is a set of steps for solving an instance of a particular problem type****

Computational desiderata of algorithms
-----

- ****Correctness****
    + an algorithm should terminate for every input with the correct output
    + incorrect algorithm can either
        * doesn't terminate
        * produce wrong result
- ****Efficiency****
    + runtime: run as fast as possible
    + storage: require as little storage as possible


Categories
-----

- Search
    + looking for particular value in a "collection"

Approach
-----

- Exact approach
    + calculate the solution (set), with a guarantee of correctness
        * brute force (generate and test)
            - Assumptions
                + a candidate answer is *easy to test*
                + the set of candidate answers is *ordered* or can be *generated exhaustively*
            - Strategy
                + ***generate *candidate answers* and *test them one by one until a solution is found****
            - Example
                + linear search
                + test whether a number is prime
        * divide and conquer
            - Strategy
                + solve a *smaller sub-problem*
                + *extend* the sub-solution to *create the solution of the original problem*
            - Example
                + Binary Search
                + Greatest Common Divisor
                + Merge sort
                + Towers of Hanoi
- Approximate approaches
    + *estimate the solution* (set), ideally with an additional estimate of how "close" this is to the exact solution (set)
        * Simulation
        * Heuristic search
- always use exact approaches where possible

Simulation
-----

- Strategy
    + ***randomly generate a *large amount of data to predict an overall trend****
    + use multiple runs to verify the stability of an answer
    + used in applications where it is possible to describe individual properties of a system, but hard/impossible to capture the interactions between them
- Application
    + weather forecasting
    + movement of planets
    + prediction of share markets
    + humans doing vision tests
- Monte Carlo Simulation
    + Method
        * ***iterative test a model using *random numbers as inputs****
        * *problem is complex* and/or *involves uncertain parameters*
        * approximate solution to problem that *is not (readily) analytically solvable*


Heuristic Search
----

- Strategy
    + search via a *cheap, approximate solution which reasonably well most of the time*, but where there is *no proof of how close to optimal the proposed solution is*


Recursion
-----

It's ****particular effective when we need a level of iterative nesting proportionate to the size of the input****

e.g. the powerset problem and the change problem

### Two basic forms

- head recursion (recursive call at the head)

****recurse first then perform some local calculation****
e.g. mergesort

```python
def counter_head(n):
    if n < 0: return
    counter_head(n-1)
    print(n)  # The local calculation
```


- tail recursion (recursive call at the tail)

****perform some local calculation first, then recurse****


```python
def counter_tail(n):
    if n < 0: return
    print(n)  # The local calculation
    counter_tail(n-1)
```

#### Conclusion

- *function calls are expensive*, meaning deep recursion comes at a price
- always make sure to *catch the base case*, and *avoid infinite recursion*!
- there's often a more efficient iterative solution to the problem, although there may not be a general iterative solution (esp. in cases where the obvious solution involves arbitrary levels of nested iteration)
- recursion is elegant, but elegance $\ne$ more readable or efficient


Contiguous sublist of elements in the list
-----

```python
def maxsubsum_bf(lst):
    """ brute force """
    maxsubsum = lst[0]
    for s in range(0, len(lst)):
        for e in range(s, len(lst)):
            curr_sum = sum(lst[s:e+1])
            if  curr_sum > maxsubsum:
                maxsubsum = curr_sum

    return maxsubsum 

def maxsubsum_dc(lst):
""" divide and conquer 
    linear O(n)~
"""
    max_sum_i = [lst[0]]

    for x in lst[1:]:
        max_sum_i.append(max(x, x+max_sum_i[-1]))

    return max(max_sum_i)

```

### Time complexity
Brute-force: $O(n^{2})$
Divide-and-conquer: $O(n)$

### Space complexity
Brute-force: $O(1)$
Divide-and-conquer: $O(n)$

The Powerset Problem
-----

Given a set, S, compute the powerset $P(S)$ of that set (a set of all subsets, including {})

Linear Search
-----

Search for an item by iterate through an iterable checking elements one by one
(brute force)

Binary Search
-----

Idea: If the middle value is greater than the one we are looking for, search the value in the left half of the list. If the middle value is less than the one we are looking for, search in the right half. If the middle value is the one we are looking for, return the index of the "middle value". If the current searching list has length of 1 and it's not equal to the value looking for, return None

We require the input array to be **sorted**
Each time we divide the array into halves (n divided by 2)
```python
def bsearch(lst, x):
"""
If found, return the index of the element.
Otherwise, None.
"""
    return bs_rec(lst, x, 0, len(lst)-1)

def bs_rec(lst, x, start, end):
    
    if start > end:
        return None

    mid = start + (start - end) // 2
    if x == lst[mid]:
        return mid
    elif x > lst[mid]:
        return bs_rec(lst, x, mid+1, end)
    else: # x < lst[mid]
        return bs_rec(lst, x, start, mid-1)


def bsearch_iter(lst, x):
    start = 0
    end = len(lst) - 1

    while start <= end:
        mid = start + (end - start) // 2
        if lst[mid] == x:
            return mid
        elif lst[mid] > x:
            end = mid - 1
        else:  # lst[mid] < x
            start = mid + 1

    return None
```

Image
=====

Raster Images
-----

represented as individual color *pixels*, navigate from top-left row-by-row to bottom-right
The **width and height of a raster image are required** in order to render the image from the list of pixel values

popular format: PNG, JPEG

Vector Images
-----

represented as points, lines, curves
order of vectors unimportant

popular format: SVG, PDF


Types of digital raster image
-----

- Binary
- Grayscale
    + each pixel is a single integer specifying its grayscale value
    + e.g. 0 = black; 255 = white
- Color
    + RGB
        * each pixel is represented by three integers(a triple of integers) specifying its RGB value
        * e.g. (0,0,0) = black; (255,255,255) = white
        * RGB values are often expressed in the form of a hexadecimal value representing 24-bit RGB value

Transformation
-----

### Reflect in the vertical axis

pix_out[x,y] = pix_in[dim[0]-1-x, y]

### reflect in the horizontal axis

pix_out[x,y] = pix_in[x, dim[1]-1-y]

Not Examinable
=====

- recursion
- knowledge of character encoding


Steven reviving dead language
=====

We can use computer to machine translating a language! AI-Complete problems - the difficulty of these computational problems is as hard as making computers to make decisions as intelligent as people.


Anna Data Science
=====

We use physics simulation and detector simulation to predict what kind of data we want.


Marco Data Science
=====

### What's so good about python

- easy to use
- there're lots of libraries doing things that you need
    + you don't need to implement them yourself!

### Regular Expression

- used to describe string patterns
- it provides a standardized way to do string pattern matching without having to deal with low level programming details (like spliting, stripig string using methods manually)


*We have to keep trying in order to know which one is the better.*

Extra
=====

- `list(range(0)) == []`
- `"a"[0:0] == "a"[:0] == ""`
- Remember to use quotation marks to enclose string in answers
- range(num) will give you an iterator having values from ***0*** up to ***num-1***!!!
- `if key = val:` is a syntax error (python doesn't allow assign in if statement)
- **good to assign numbers to all the requirements of questions!!**
- JSON is a data format for representing semi-structured data
- Exam
    + It's okay to answer with an equation without calculating the actual value
    + when writing code, be patient, spend more time to think of good solution
    + careful the HTML table border (have to know the border width by seeing it)
    + It's okay to write code to do extra work as long as it's *"safe"* 
    + *when dealing with `range()`, have to put extra effort to make it right*


Checklist
=====

- [X] all lecture slides
- [X] all tutorials
    + [X] Week 3
    + [X] Week 4
    + [X] Week 5
    + [X] Week 6
    + [X] Week 7
    + [X] Week 8
    + [X] Week 10
    + [X] Week 11
    + [X] Week 12
- [X] Guest Lectures
    + [X] crypto Vanessa
    + [X] Application Steven 
    + [X] Data science Anna
    + [X] JS Julia
    + [X] Natural language Marco
- [X] last review of this summary
- [X] all past exams


Special Questions
=====

- Explain the processes of “sampling” and “quantisation” in the context of “scanning” a physical image to generate a digital representation. You may optionally use a diagram in your answer.
    

Sampling - partitioning of image into regular-sized segments(pixels)
Quatisation - conversion of each pixel into a digital value


- With the aid of an example, explain the difference between an HTML “tag” and an HTML “entity”.

a tag is used to insert an object of some description at a particular point in the document like `<p>paragraph</p>` putted within the body tag, whereas an entity is simply a special character like `&nbsp;`.

- What is the relationship between the “internet” and the “(worldwide) web”?

the internet is the (open) network by which *computers are connected* and *communication between computers takes place*; the web is a subset of the internet used to *link hypertext documents*

- What is a `tuple`?

`tuple` is a container which can contain objects of different types, and the identity of elements within the `tuple` can't be changed once it's created.

- What's difference between Python and Javascript?

Javascript is the most popular scripting language running in browsers while all browsers(or most of the browsers) don't support python to be loaded in web pages natively. There're many libraries for Javascript for running in browser environments while there's none(or very few) for python for that.

- What is dynamic web programming?

It's the act of writing a script which allows web pages to change its content according to user's input in real-time without reloading the whole web page .

- Computational simulation was a vital component of the discovery of the Higgs boson at CERN in 2012. Without any details of the underlying particle Physics, briefly describe the interaction between "computational simulation", "theoretical prediction" and "measurement" that led to the discovery.

    + computational simulation used to *calculate the expected measurements associated with a given theoretical prediction*
    + *measurement* of the actual particle collisions *compared with the expected measurements*, to see if any of the *expected measurements fit with the actual measurements*.

- What is regular expression?
    
It's a language for doing *string pattern matching*. It provides a standardized way to do string pattern matching without having to deal with low level programming details (like spliting, stripig string using methods manually)

- With the aid of an example, describe what "alignment" means in the context of statistical machine translation, e.g. as used for language decipherment purposes.

Alignment is the process of determining which substrings in the target language are translations of which particular substrings in the source language.

- In the context of algorithmic developement, what is the difference between an "exact" and "approximate" approach?

An exact approach provides an exact solution, whereas an approximate approach provides an estimate of the solution (which may or may not be the exact value)

- What is the relationship between a "hostname" and an "IP address"?

A hostname is a human-readable of IP address(es). Hostnames can be resolved to IP by DNS servers.

- Explain what sort of problems generate-and-test is commonly applied to.

When the candidate answers are ordered or can be generated exhaustively. The candidate answers should be easy to test. It's commonly applied to problems where the number of solutions is relatively small. Such as small-scale combinatoric problems. (e.g. logic puzzles)
