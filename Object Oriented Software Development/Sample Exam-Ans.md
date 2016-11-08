Question 1
=====

1.
-----
An exception is an object indicating a situation occurred (normally a runtime error). We must either handle(using `catch` block) or declare all the checked exceptions while for unchecked exceptions, this is not required (therefore, it's possible for us to avoid them using `if` statements). 

2.
-----
```java
public class InvalidValueException extends Exception {

    public <T> InvalidValueException(T value) {
        super(String.format("Value %s is invalid.", value.toString()));// Assume full stop is part of the message specified in the question
    }
}
```

3.
-----
```java
public class Circle {
    double centreX, centreY, radius;

    public Circle(double centreX_, double centreY_) {
        centreX = centreX_;
        centreY = centreY_;
        
    }

   public Circle(double centreX_, double centreY_, double radius_) throws InvalidValueException {
        this(centreX_, centreY_);
        if(radius_ <= 0)
        {
            throw new <Double>InvalidValueException(radius_); // Assume my answer to subquestion 3 has been imported
        }
        
        radius = radius_;

    }
}
```

4.
-----
```java
// Assume we only need to define the method only
public Circle[] createCircles(double[][] circleData) {

    ArrayList<Circle> rst = new ArrayList<>();
    for(double[] data : circleData) {
        try {
            rst.add(new Circle(data[0], data[1], data[2]));
        }
        catch(InvalidValueException e)
        {
            System.out.println(e.getMessage());
        }
    }

    return rst.toArray(new Circle[1]);
}
```


Question 2
=====
Employee Class
```java
public class Employee implements Comparable {

    private String ID, name;

    public Employee(String ID_, String name_) {
        ID = ID_;
        name = name_;
    }

    public String getID() {return ID;}
    public void setID(String ID_) {ID = ID_;}

    public String getName() {return name;}
    public void setName(String name_) {name = name_;}

    public int compareTo(Object o) {
        if(o instanceof Employee)
            return ID.compareTo(((Employee)o).ID);
        else
            throw new Error("Type error for argument o (not Employee)")
    }
}
```
The methods
```java
public void sortArray(Employee[] emp) {

    while(true) {
        boolean swapped = false;
        for(int i=0;i<emp.length-1;i++) {
            if(emp[i].compareTo(emp[i+1]) >= 0) {
                Employee temp = emp[i];
                emp[i] = emp[i+1];
                emp[i+1] = temp;
                swapped = true;
            }
        }

        if(!swapped)
            break;
    }

}
```

Question 3
=====

1.
-----
```java
public class Pair<K,V> {

    private K key;
    private V value;

    public Pair(K key_, V value_) {
        key = key_;
        value = value_;
    }

    public K getKey() {return key;}
    public void setKey(K key_) {key = key_;}

    public V getValue() {return value;}
    public void setValue(V value_) {value = value_;}
}
```

2.
-----
The method
```java
public static ArrayList<Pair<String, Integer>> countOccurances(String[] words) {
    HashMap<String, Pair<String, Integer>> map = new HashMap<>();
    ArrayList<Pair<String, Integer>> rst = new ArrayList<>();

    for(String word : words) {
        Pair<String, Integer> pair = map.get(word);
        if(pair == null) {
            pair = new Pair<>(word, 0);
        }

        pair.setValue(pair.getValue() + 1);
        map.put(word, pair); // have to put because pair might be newly created

    }

    for(String word : map.keySet()) {
        rst.add(map.get(word));
    }

    return rst;

}
```

Question 5
=====

1.
-----
Design pattern is a solution for solving recurring problems. Using them can create the least risk since patterns are verified by many people for a long time and it's time-saving to reuse solutions. e.g. When you have observers interested to be informed when there's any change in values, we can apply observer pattern immediately.

2.
-----
Event driven programming is asynchronous - instead of writing code for sequential execution(the commonly used sequential programming style), we write code for responding to certain events fired (We mainly write event listeners which are registered to certain events).

4.
-----
Basically, the client registers event listeners(commands) to the invokers, when there is an event, just call the invoker, and the invoker will execute the appropriate registered event handlers (which are in event listeners). e.g. Initially, register event listener `EL` which is for handling button clicks to the event system. Then, when we click a button, the event system will invoke the appropriate event handler in `EL`.