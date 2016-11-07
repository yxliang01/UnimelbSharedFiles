Object Oriented Software Development
=====

[TOC]

Java and Object-oriented programming
=====

- compiled and interpreted
    + Java source code(.java) ---Compiler---> Java byte-code(.class) ---Interpreter---> Execution
    + In order to port Java to other platform, we have to implement the interpreter for the other platform
- platform-independent and portable
- object-oriented 
   + programming methodology that views a program as consisting of *objects* that interact with one another by means of actions
- two types of programs
    + Application
        * there's a `main` method
        * a standalone program
        * can be executed from command line using Java interpreter
        * the execution argument passed to `main` method starts from index 0 (0 is not the program's path)
    + Applet
        * no `main` method
        * a program embedded in a web page
        * can be run by a Java enabled web browser
        * browser will create a new thread to run this
        * the class should extend from `java.applet.Applet`
        * HTML example
            - `<applet code="something.class" width=500 height=500></applet>`
- comments
    + `/** */` documentation comments
- imports
    + If you do import something, you don't need to specify the classes' full name in the code after the import statement
- Classes
    + a generalization of a real world entity that is used in a OO program depending on the application
    + In Java
        * are grouped into a *package*
- by default, Java important `java.lang.*`
- Performing an action on an object is also called
    + invoking the method
    + calling the method
    + sending a message to the object
- File name and class name can be different
    + just that Java will **generate the `.class` file according the class name instead of the source file name**
    + for inner classes, class names are `ClassName$InnerClassName.class`
- commands
    + `javac something.java` compile source code into byte code
        * we need to specify the path to the source files
    + `java something` execute the class `something`
        * we only need to specify the class names
- compare to C
    + no `goto`, `sizeof`, `typedef`
    + no `struct` and `union`
    + no explicit pointer type
    + no preprocessor
    + memory is managed by the virtual machine not the programmer  
- identifiers
    + A name that *uniquely identifies a program element* such as a class, object, variable, method
    + **Must not start with a digit**
    + can have letters, digits or the underscore
    + case-sensitive
    + convention
        * variables, methods and objects
            - *identifiers start with a **lowercase letter***
            - *captialise first letter of all other words*
        * classes
            - starts with an **uppercase letter**
    + types
        * Keywords and Reserved words
            - identifiers that have a predefined meaning in Java
            - `public`, `class`, `void`, `static`
        * Predefined identifiers
            - identifiers that are defined in libraries required by the Java language standard packages
    + In theory, it can be of any length
- types
![The Data Type Image](Summary_Images/The_Data_Type_Image.PNG)
- integer and float type
    + When you have a decimal constant like `21.02`, by default, it will be treated as `double`. If you want it to be `float`, add `F` or `f` at the end of the number like `21.02F`.
    + **Integer division occurs**
(TODO??)![The integer and float]()
- Type Classes (Wrapper Classes) 
    + `int` -> `Integer`
    + `float` -> `Float`
    + `double` -> `Double`
    + `char` -> `Character`
    + `boolean` -> `Boolean`
    + `byte` -> `Byte`
    + `short` -> `Short`
    + `String` doesn't have a wrapper class
    + we can compare using `==` between primitive value and value of the wrapper class
        * however, we can't use `==` to compare the value of two wrapper classes (`==` for them is for comparing reference)
- When we have declared a variable and haven't assigned value to it, it will have the default value
- `Object`
    + `equals(Object object)`
        * returns `true` only when `object` has the same reference(i.e. referring to the same object) with the *current calling object*  
- `Collection`
    + designed to hold generic (any) type of objects
    + collections let you **store**, **organize**, **access** objects in an efficient manner
    + Legacy types
        * `Vector`
            - components can be accessed using an integer index
            - the size of a vector is dynamic as needed
            - compared to arrays
                + size is dynamic
                + can't support primitive data types
            - normally you will use `ArrayList` or `Collections.synchronizedList`
            - useful methods
                + `addElement(Object item)`
                + `insertElementAt(Object item, int index)`
                + `elementAt(int index)`
                + `removeElementAt(int index)`
                + `size()`
                + `clone()`
                + `clear()`
                + `get(int index)`
                + `copyInto(array)`
        * `Hashtable`
            - allows associating values with keys
            - allows efficient look ups for the value associated with the key
            - doesn't allow `null` keys or values
            - normally use `HashMap` or `LinkedHashMap` (when the order of insertion matter) or `ConcurrentHashMap` (when you need synchronization)
            - useful methods
                + `put(Object key, Object value)`
                + `remove(Object key)`
                + `get(Object key)`
        * `Enumeration`
            - used to enumerate or iterate through a set of values in a collection
            - useful for iterating through a collection object
            - normally use `iterator` to replace it
                + main difference is `iterator` can be used to remove elements
            - useful methods
                + `hasMoreElements()`
                + `nextElement()`
    + Modern types
        * `ArrayList`
            - Can set initial size `SIZE` by constructor `ArrayList<~>(SIZE)`
            - the internal array size grows automatically, but not shrink
            - useful method
                + `add(ELEMENT)`
                + `add(int index, ELEMENT)`
                + `size()`
                + `set(int index, ELEMENT)`
                + `get(int index)`
                + `trimToSize()` adjust the size of the internal array to be as large as the size of the list
- higher-order programming
    + `Runnable`
    + Lambda
        * e.g. `() -> System.out.print("21")`
- Generics
    + definitions that **include parameters for types** are called generics
    + allows code for different types to be re-used
    + classes that have type parameters are called **parameterized classes** or **generic definitions**
    + type parameter can't be used in simple expressions e.g. `new T()` or `new T[10]`
    + we can limit the types that are able to be plugged in for a type parameter
        * once we defined the must-be-extended types, we can use the attributes and methods of them
        * e.g. `public class RClass<T extends Comparable & Cloneable & A_CLASS>`
    + `TYPE Obj = new <A> TYPE<B>()`
        * `A` is the type for generic method 
        * `B` is the type for generic class 
    + we can even have type parameters for methods
        * when invoking generic method, the type should be specify before the method name e.g. `CLASS.<TYPE>METHOD_NAME()`
    + Type Inference
        * when you constrained the generic type in some way for a generic method, you don't have to specify the generic type by angle brackets(`<>`), it will be inferred automatically (`<>` can be ignored)
        * for generic class constructor, we can `ArrayList<Integer> arr = new ArrayList<>();` - just put `<>` to let it be inferred 
    + example
```java
public class Sample<T, T2> {
    private T data;
    private T2 data2;

    public void setData(T newData) {
        data = newData;
    }

    public T getData() {
        return data;
    }

}
```
- Casting
    + It's safe to do upcasting but not vice versa.
    + because subclasses have everything from parent class but not vice versa
    + If you want to convert the other way, explicit type cast is needed
    + ***`instanceof CHILD_CLASS` will still return `true` after upcasting the variable to the parent class***
    + ![Updown Casting]()
    + e.g.
        * `discountVariable = (DiscountSale) saleVariable;` causes runtime error
        * `discountVariable = saleVariable;` causes compile time error
- ![](Assignment Compatibility)
- relational operators returns `boolean` and `boolean` is not a number type
- constants are defined `final`
- variables are classified into three categories
    + *instance* variables
    + *class* variables
    + *local* variable
- ![Redefining Variable]()
- bitwise operators
    + `&` Bitwise AND
    + `!` Bitwise OR
    + `^` Bitwise exclusive OR
    + `~` One's complement
    + `<<` shift left
    + `>>` shift right
        * Example: `A >> 2` will give 15 which is `1111`
    + `>>>` shift right ***with zero fill***
        * Example: `A >>>2` will give 15 which is `0000 1111`
- Ternary operator
- Popular modules
    + `Math`
    + `System`
        * `System.in`
        * `System.out`
        * `System.err`
    + `java.util.Scanner`
        * `nextInt()`
        * `next()`
            - Finds and returns the next complete token from this scanner
        * `nextDouble()`
        * `new Scanner(Stream)`
        * `hasNext()`
        * `nextLine()`
            - be careful! Sometimes, it will give you a string with only "\n"  
- Popular class
    + `java.text.NumberFormat`
    + `java.text.DecimalFormat`
        * `DecimalFormat pattern00dot000 = new DecimalFormat("00.000");`
        * `0` means a digit while `#` means a digit but zero shows as absent
- Popular methods
    + `System.out.println`
    + `System.out.print`
    + `System.out.printf`
    + 
- Operators
    + unary operators of equal precedence are grouped right-to-left
        * `+-+rate` = `+(-(+rate))`
    + binary operators of equal precedence are grouped left-to-right
        * `base + rate + hours == (base + rate) + hours`
    + the new operator instantiates a class and returns the reference of the newly created object
        * also it will call the object constructor 
    + `==` for primitive values, it compares the equality of values
    + `==` for objects is comparing the equality of the references
    + ***`OBJECT instanceof CLASS` will return `true` when `OBJECT` is an instance of any descendant class of `CLASS`***
    + `extends`
    + `implements`
- float and double numbers are **approximations** here as well
- Array
    + arrays are objects
        * i.e. Arrays can be converted to `Object`
        * e.g. 
```java
public class Main {

    public static void main(String[] args) {
        a(new Integer[]{1,1,1});
    }

    private static void a(Object b) {
        System.out.println(b);
    }
}

```
    + array types are class types
    + fixed length
        * maximum length is `Integer.MAX_VALUE` since the index is of type `int`
    + it's possible to define array like
```java
int[][] a = new int[3][];
a[1] = new int [4];
a[2] = new int [2];
```
    + it's a container
    + it will only create an array object when you 'new' an array without having elements inside instantiated to that type 
- bindings
    + binding is the process of associating a method definition with a method invocation
    + static/static binding = compile time binding = decide which definition is used at where at compile time
    + late/dynamic binding = runtime binding = decide which definition is used at where at run time
    + **Java uses late binding for all methods except `private`, `final`, `static` methods** *
        * ***as a result, the type that we treat objects matters to the calling to the `final`, `static` methods***
- errors
    + syntax errors
        * compilation errors
    + semantic errors
        * lead to programs producing unexpected outputs
    + runtime errors
        * most often lead to abnormal termination of programs or even cause the system to crash
- Throwable
    + Exception
        * allows us to handle unusual circumstances(error conditions)(might be runtime error) gracefully
        * allow errors to be handled in one central part of the code without cluttering code with ifs
        * if an exception object is not caught and handled properly, the Java interpreter will display an error and terminate the program
    + exception handling - catch and handle an exception
    + reason why it shouldn't be singleton is because of the stack trace functionality of it
    + when a method throws an throwable, the invocation to it is terminated immediately
    + Exception handling is an example of a programming methodology known as event-driven programming
        * an event is also an object
        * sending an event is called *firing an event*
        * In this exception handling case
            - an exception is an event
            - the method having `try` and `catch` block is the event listener
    + when overriding a method, ***the overriding method must `throws` the subset of the original set of exceptions***(might be the same set or empty set) that the original method throws
        * you can't add exceptions to `throws` that the original method doesn't allow to throw at all
    + `Throwable`, `Exception` and all descendants of `Exception` are ***checked exceptions***
    + `RuntimeException` and `Error` and all their descendant classes are called error classes and are ***unchecked exceptions***
        * An `Error` is a subclass of `Throwable` that indicates serious problems that a reasonable application **should not try to catch**
        * ***Not subject to Catch and Declare rule***
    + `try`
    + `catch`
        * can catch multiple exceptions together e.g. `catch (Exception1 | Exception2 e)`
    + `throw`
        * an exception object can be thrown more than once
        * the object throwing must be of class of `Throwable`
    + `finally`
        * can be added not only after the last `catch` block but also after `try`
        * statements in `finally` will be executed no matter what happened in the `try` block - will execute after all exceptions are handled unless the program exits before that 
            - if you throw another exception in `catch` block, the `finally` block will be executed before terminating the program due to the non-handled exception
        * it's particularly useful for putting cleanup code inside since **it will be executed even there are `return` statements in `try` or `catch` blocks**
    + `throws` for indicating the method might throw specific exceptions
        * `Exception`s that are explicitly thrown by the method must be in the `throws` list and handled by the caller
        * when we have specific exceptions declared in `throws`, we can call methods that throws part of the declared exceptions outside of a `try` block. When they throw, it will be passed to our method, and, our method will throw it to the calling method.
        * the process of including an exception class in a `throws` clause is called **declaring the exception**
        * `Error`s can appear in the list, but are not required to be caught
    + User-defined exception
        * behaviors that must be preserved
            - a constructor must be included having a string parameter whose body begins with a call to `super`
                + the call to `super` must use the parameter as its argument
            - a no-argument constructor musts also be included whose body begins with a call to `super`
                + this call to `super` must use a default string as its argument
        * For all predefined exception classes, `getMessage()` returns the string that is passed to its constructor as an argument
            - or it will return a default string if no argument is used with the constructor
    + if a method can throw an exception but doesn't catch it 
- `String` 
    + String is immutable
    + use `equals(String)` for comparing equality between strings
        * for `switch`, there is an exception -> we can still `switch("abc")` with `case "STRING"`
    + when string is concatenating with non-string objects, the `toString` method of the objects will be invoked automatically
    + `toString()` is defined as `public String toString()`
    + `StringBuffer`
        * `setCharAt(index,ch)`
        * `setLength(n)`
        * `insert(position, String)` insert the `String` into the `StringBuffer` at the specific `position`
    + `StringTokenizer`
        * `StringTokenizer(str, delim, returnTokens)`
        * `StringTokenizer(str)`
            - delimiters are `" \t\n\r\f"`(space is included)
        * `hasMoreTokens()`
        * `nextToken()`
        * `nextToken(delim)`
        * `countTokens()`
- `super`
    + call to `super()` must be first statement in construct body
- An object of a derived class has the type of every one of its ancestor classes
- define a function having same signature with one of the functions in the parent class is called override
    + must **same or stronger visibility**
    + covariant return
        *  a covariant return type of a method is one that can be replaced by a "narrower" type when the method is overridden in a subclass
-  define a function having different signature but having the same name and same return type with one of the functions in the parent class is called overload
    +  must same name
    +  must same return type
-  `final` modifier can prevent members from being overridden/extended
- shadow = overriding a variable
- ![Form of Inheritance]()
- Relationship
    + "is a" relationship is one way to make a more complex class out of a simpler class
    + "has a" relationship is **composition**
        * extended functionality in this case is achieved through **delegation**
- Unified Modeling Language
    + graphical modeling language that can be used to represent artifacts of object oriented analysis, design and implementation
- Event-driven programming
    + signal-and-response approach
    + asynchronous
        * programmer deals with events that are generated at unknown times
        * the program itself no longer determines the order in which things can happen
        * event handlers will never be explicitly invoked in any program written by the developer
    + event
        * an object that gets generated due to an external action
    + listener
        * a given component may have any number of listeners
        * each listener may respond to a different kind of event, or multiple listener may respond to the same event
        * listeners must register with the event generator in advance (normally)
    + firing an event = sending out an event
    + event handler
        * a method in the listener that specifies what will happen when event of various kinds are received by it
- Framework
    + a set of cooperating classes that represent reusable designs
    + consists of a set of abstract classes (that partially complete) and interface
        * partially complete classes can be customized to meet application needs
    + Example
        * Java Input/Output framework
        * Java Collections framework
        * Java Graphical User Interface (GUI) Framework
            - Abstract Windows Toolkit (AWT)
            - Swing portion of the Java Foundation Classes
                + an improved version of AWT
                + Some AWT classes are still needed by the Swing
                + using event-driven programming
                    * it's for avoiding the handling logic being too complicated 
        * The Microsoft Foundation Classes (MFC) for C++
    + Key features
        * Extensibility
            - has a set of abstract classes and interfaces to be extended and specialized
            - changeable aspects are represented as *hook methods*
        * Inversion of Control
            - with a conventional library, **the application** takes controls of the flow of execution
            - with a conventional framework, **the framework** normally controls the flow of execution
        * Design patterns as building blocks
            - most frameworks use design patterns as building blocks
    + Normally designing application frameworks is more challenging than designing applications
        * the designer has to foresee the potential changes and the variations required by potential users of the framework
    + normal design goals
        * Completeness
            - the framework must provide a family of classes, united by a shared interface but each employing a different representation
            - developer can select the classes appropriate for their application
        * Adaptability
            - all platform specific aspects of the framework must be clearly identified and isolated
        * Efficiency
            - components must be easily assembled
            - they must impose minimal run-time and memory overhead
            - they must be more reliable than hand-build mechanisms
        * Simplicity
            - must have a clear consistent organization that makes it easy to identify and select appropriate classes
        * Extensibility
            - developer must be able to add new classes to extend functionality
        * Safety
            - each abstraction must be type-safe

Main Things
=====

Class
-----

### Inner Class
- inner non-static class **can't have static** member
- inner class can access all the attributes of the outer class
- static inner class can only access static variables of outer class
- ***inner class methods and outer class methods have access to each other's private methods and instance variables***


### Abstract Class
- methods can't be both `private` and `abstract`
- can have static method
- 


object
-----

an instance of a class

method
-----
- My understanding: a procedure/function defined in a class
- Formally definition: the actions which can be performed within an object

interface
-----
- **variables can be defined in interfaces. Just that they must be `final static` and you don't need to write them manually.**
- **we can define `static` methods**
    + but, they **can't be overridden**
- an interface can **"extends"** another interface
    + the interface being extended is called *superinterface*
- we can't have `private` methods
- methods inside interface declaration can't have body

Software Design Pattern
-----
- Examinable Patterns
    + Singleton
    + Template Method
    + Strategy
    + Command Pattern
    + Observer Pattern
- a description of **a solution to a recurring problem** in software design
    + the recurring nature of the problems makes the solution useful to software developers
    + publishing it in the form of a Pattern enables the solution to be used without reinventing the wheel
- Creational Patterns
    + deal with solutions to problems related to **object creation**
    + e.g. Singleton, Factory
- Structural Patterns
    + deal with the **structure of classes and their relationships**
    + Adapter
        * translator adapts a server interface for a client
    + Bridge
        * abstraction for binding one of many implementations
    + Composite
        * structure for building recursive aggregations
    + Decorator
        * decorator extends an object transparently
- Behavioral Patterns
    + deal with the **dynamic interaction** among classes and objects
    + e.g. Strategy, Template Method
- Design Pattern Catalog
    + Pattern Name: The identification for the pattern
    + Category: Creational, Structural or Behavioral
    + Intent: A short description of the design issue or problem addressed
    + Also known as: Other well-known names for the pattern
    + Applicability: Situations where the pattern can be applied
    + Structure: A class and/or object diagram that depicts the participants of the pattern
    + Participants: A list of classes and/or subjects participating in the pattern
    + Sample Code
- Patterns
    + Refer to Slide T12
    + Template Method and Strategy
        * For building generic components that can be *extended, adapted and re-used*
        * main techniques
            - refactoring and generalizing
                + **identifying recurring code and replacing with generic code**
        * **inheritance** and **delegation** are normally used for building generic components
        * these two techniques are for solving the problem of separating a generic algorithm from a detailed design
        * "Template Method" uses **Inheritance**
        * "Strategy" uses **Delegation**
    + Reactor Design Patterns
        * "Command Pattern" and "Observer Pattern" are two commonly used reactor design patterns
        * assist in event-driven design
        * Behavioral phases
            - Setup Phase
                + the "Client" registers the "Reactor" with the "Target"
                    * "Client" interacts with the "Target"
            - Operational Phase
                + the "Reactor" responds to events in the "Target" on behalf of the "Client"
                    * "Client" is not involved
        * Advantage
            - Client and Target Decoupling
                + Once the client registers the reactor with the target, the client and target need not interact again
            - Low reactor and target coupling
                + The target only knows that the reactor is a receiver of event notifications
            - Client decomposition
                + The reactor takes over client responsibilities for reacting to target events
            - Operation encapsulation
                + The event handler in a reactor is an encapsulated operation that can be invoked in other ways for other reasons
- Patterns are 
    + solutions to problems that recur with variations
        * no need to reuse if the problem occurs only once
    + solutions that require several steps
        * patterns can be an overkill is problems have simple solutions

Software Engineering (Not Examinable)
=====
- an engineering discipline which is concerned with all aspects of software production from the early stages of system requirements to maintaining the system after it has gone into use
- aspects
    + historical aspects
        * it is a fact that electric generators fail, but far less frequently than payroll products
    + economical aspects
    + maintenance aspect
    + team programming aspects
    + design and programming aspects
- why can't other engineering techniques be used to build operating systems
    + attitude to collapse
    + imperfect engineering
    + complexity
    + maintenance
- examples of attitudes on software
    + people have the attitude that software collapse is not considered an unusual occurrence and therefore don't pay as much attention to design
- Refer to Slides



Terminology
=====
- Computer Science 
    + concerned with the theories and methods which underlie computers and software systems
- Software Engineering
    + concerned with the practical problem of producing software 
- Encapsulation
    + the capability of hiding information
- Byte code
    + thing that is created from the source code for executing later. It allows Java interpreters to execute the program more efficient. By having it, we can run the Java program in different platform as long as there's Java interpreter in that platform.
    + It's small in size
    + easy for interpreter to read
    + It's a type of compiled code.
- Late binding
    + the type of variables is decided in runtime
- Legacy code
    + code that is old fashioned but too expensive to replace is called legacy code
- index = subscript
- base class = super class = parent class
- sub class = derived class = child class
- Access Levels

|     Modifier    | Class | Package | Subclass | World |
|-----------------|-------|---------|----------|-------|
| public          | Y     | Y       | Y        | Y     |
| protected       | Y     | Y       | Y        | N     |
| package-private | Y     | Y       | N        | N     |
| private         | Y     | N       | N        | N     |

- Polymorphism
    + ***the ability of associate many meanings to one method name***
    + it does this through *late binding*
    + different behavior is possible based on the object type at runtime
    + basically, different implementations having the same name
- Concrete class
    + A derived class that **implements all the missing functionality is called a concrete class**
        * must be classes that are not abstract
        * class that can be instantiated
- Abstract Data Type 
    + a definition that contains data and procedures that operate on the data
    + 'class' is an implementation on an abstract data type
- data -> fields, parameters, attributes
- procedure -> methods, operations
- Graphical User Interface (GUI)
    + a windowing system that interacts with the user
- Abstract Window Toolkit (AWT)
    + a package that is the original Java package for doing GUIs

UML Class/Object diagram
=====
- class visibility
    + public - `+`
    + protected - `#`
    + private - `-`
    + package-private `~`
        * **the classes inside a sub-package still can't access the package-private things in the parent package**
- for derived attribute, we use `/` to indicate
- for static attribute/method, we use underline to indicate
- `PackageName::ClassName`
- Associations
    + plain association
    + aggregation
    + composition
- Directions
    + unidirectional
        * only one object can send messages to the other, but this other object cannot send messages back and has no knowledge about the object referring to it
    + bidirectional
        * both objects know about each other and messages can be passed in either direction
- Same class can be modeled in four different ways
    + with no attributes or operations shown
    + with only the attributes shown
    + with only the operations (methods) shown
    + with both the attributes and operations shown
    + So, the only required component is the class name
    + Therefore, when there is a class has no attribute/method, we have to draw a horizontal line to indicate this 
- Attribute details
    + Data Type
        * the thing after a colon `:`
        * e.g. `- height : float`
    + Initial Values
        * e.g. `- height : float = 10`
        * additionally, can add `{readOnly}` after the initial value
        * ![Read Only Attribute Example](Read_Only_Attribute_Example.png)
    + Multiplicity
        * indicates how many attributes of the type is associated
        * e.g. `- height[1] : float = 10`
    + Derived Attributes
        * a derived attribute is one that is derived from some business logic
        * e.g. `-/GPA[1] : double = null`
    + Static
        * static attributes are underlined
- Method details
    + Return Type
        * e.g. `- getHeight() : float`
    + Class Multiplicity
        * A multiplicity in a class specifies the number of instances (object) of that class that can exist simultaneously
        * Default is 0 or more (if not specified)
        * e.g. ![Singleton Example](Singleton_Example.png)
- Class diagram specific
    + consists of several classes connected with relationships 
- Object diagram specific
    + Object diagram shows the relationship between objects
    + Unlike classes objects - it has a state
    + ![Object Diagram Examples](Object_Diagram_Examples.PNG)
    + ![Object Diagram Example2](Object_Diagram_Example2.PNG)
- Package
    + package is a way of grouping classes into common categories
    + e.g. `PackageName::ClassName`
- Class relationships
    + The arrow (reading direction arrow) on the label of the relationship has no meaning except to **indicate direction of reading the association label**
    + Association (Delegation)
        * it describes a link
        * shown by **solid line**
        * Properties
            - Name
                + e.g. `work for`
            - Role
                + e.g. in the example "Person" plays the role "employee" and the "Company" plays the role "Employer"
            - Multiplicity
                + specifies the number of links that can exist between instances (objects) of the associated classes
                + must be integers
                + ![Multiplicity Example](Multiplicity_Example.png)
            - Type
                + Plain Association
                + Aggregation
                    * special form of aggregation
                    * represent the part-whole relationship
                + Composition
                    * stronger form of aggregation where the part objects can't exist without the whole object
            - Direction
                + unidirectional
                    * one object can send messages to the other, but this other object can't send messages back and has *no knowledge about the object referring to it*
                    * we should draw an arrow to indicate the direction
                + bidirectional
                    * both objects know about each other and messages can be passed *in either direction*
        * Self association
            - ![Self Association Example](Self_Association_Exampe.png)
    + Generalization (Inheritance)
        * solid line
        * when if you override a method in a deviated class, you should show the method inside the box of the deviated class]
        * for extending classes
    + Realization (Interfaces)
        * interface in UML is a set of operation the class carries out
        * dotted line
        * for implementing interfaces
    + Dependency
        * Situation 1: Change in specification of one class can change the other class. This can happen when one class is using another class.
        * Situation 2: `<<instanceOf>>`
          ![Dependency Situation2 Example](Dependency_Situation2_Example.png)


MISC
=====
- we can initialize array `int[] a = {1,2,3};`

For Exam
=====
- Before Exam
    + [] read all examples in slides
- remember to add `private` for attributes
- remember the keyword `class`
- when you are asked to write a class, remember to add all `import` statements needed
- must write `static` before the type
- there is no `String.compare`, use `"SOME STRING".compareTo(ANOTHER_STRING)` instead