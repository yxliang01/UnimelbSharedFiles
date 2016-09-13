Object Oriented Software Development
=====

Java
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
- Java classes are grouped into a *package*
    + by default, Java important `java.lang.*`
- Performing an action on an object is also called
    + invoking the method
    + calling the method
    + sending a message to the object
- File name and class name can be different
    + just that Java will **generate the `.class` file according the class name instead of the source file name**
- commands
    + `javac something.java` compile source code into byte code
    + `java something` execute the class `something`
- compare to C
    + no `goto`, `sizeof`, `typedef`
    + no `struct` and `union`
    + no explicit pointer type
    + no preprocessor
    + memory is managed by the virtual machine not the programmer  
- identifiers
    + A name that uniquely identifies a program element such as a class, object, variable, method
    + **Must not** start with a digit
    + can have letters, digits or the underscore
    + case-sensitive
    + convention
        * variables, methods and objects
            - identifiers start with a lowercase letter
            - captialise first letter of all other words
        * classes
            - starts with an uppercase letter
    + types
        * Keywords and Reserved words
            - identifiers that have a predefined meaning in Java
            - `public`, `class`, `void`, `static`
        * Predefined identifiers
            - identifiers that are defined in libraries required by the Java language standard packages
- types
![The Data Type Image](Summary_Images/The_Data_Type_Image.PNG)
- integer and float type
This length is fixed no matter what platform it's on
When you have a decimal constant like `21.02`, by default, it will be treated as `double`. If you want it to be `float`, add `F` or `f` at the end of the number like `21.02F`.
(TODO??)![The integer and float]()


Main Things
=====

class
-----

object
-----

an instance of a class

method (???)
-----

My understanding: a procedure/function defined in a class
Formally definition: the actions which can be performed within an object

interface
-----

- variables can be defined in interfaces. Just that they must be `final static` and you don't need to write them manually.