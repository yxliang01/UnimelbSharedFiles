Question 1
=====

a)
-----
Encapsulation: hide information that is not necessary to be known by other classes - only expose the onces that are essential to them

Inheritance: to get specific attributes and methods (method definition) from other classes or interfaces to reuse code and reduce code redundancy

Polymorphism: The same method can have behave differently for different kind of inputs

c)
-----

Class Variables: static variable having class scope
Instance Variables: variables that will be created when we instantiate a class, having class scope
Local Variables: variables that are inside methods, having local scope


Question 2
=====
```java

import java.util.Scanner;

public class Main {

    public static void main(String[] arg) {

        Scanner sc = new Scanner(System.in);
        
        int N = 0;

        try {
            N = getN(sc);
        }
        catch(Exception e) {
            // Assume the program should terminate (not specify in question)
            System.out.println(e.getMessage());
            System.exit(0);
        }

        int[] arr = new int[N];

        for(int i=0;i<N;i++) {
            arr[i] = promptInt("Enter the next integer: ", sc);
        }

        float average = 0;

        for(int ele : arr) {
            average += ele;
        }

        average /= N;

        System.out.println("The average is " + average);
        

    }

    private static int getN(Scanner sc) throws Exception {
        int N = promptInt("Enter the value N: ", sc);
        if(N <= 0) {
            throw new Exception("N must be positive.");
        }

        return N;
    }

    private static int promptInt(String prompt, Scanner sc) {

        while(true) {
            try {
                System.out.print(prompt);
                return sc.nextInt();
            }
            catch(Exception e) {
                System.out.println(e.getMessage() + " Please enter again.");
                sc.next();
            }
        }
        
    }

}
```

Question 6
=====
```java
public void wages(int[] hours, int standardHours, int standardRate) {

    // Assumes hours.length will always be 7

    int total = 0;

    for(int i=0;i<hours.length;i++)
    {
        String day = "";
        switch(i) {
            case 0: day = "Sunday"; break;
            case 1: day = "Monday"; break;
            case 2: day = "Tuesday"; break;
            case 3: day = "Wednesday"; break;
            case 4: day = "Thursday"; break;
            case 5: day = "Friday"; break;
            case 6: day = "Saturday"; break;
        }

        int wage;

        wage = hours[i] * standardRate;

        if(hours[i] - standardHours > 0)
        {
            wage += (hours[i] - standardHours) * standardRate;
        }

        total += wage;
        System.out.println(day + " " + wage);
        
    }

    System.out.println("Total " + total);
}
```