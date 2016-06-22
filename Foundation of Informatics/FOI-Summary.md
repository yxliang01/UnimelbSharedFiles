Author: Xiao Liang Yu

Foundation of Informatics
=====
[TOC]


File Formats
=====

Plain Text
-----

Disadvantage

- No structure
- hard to index
- hard to organize

CSV
-----

Advantage

- easier to organize
- semi-structured

Disadvantage

- no hierarchy
- no relational structure


HTML
-----

refer to the HTML section


XML
-----

- A 'meta' mark-up language
    + can be used to create other mark up languages
    + extensible, user defined tags
- separates style and content
- supports internationalization(Unicode)
- rigorous adherence to rules
    + even the order of elements matters!
- device and system independent
- **both humans and machines can read**
- syntax
    + begin with declaration
        * `<?xml version="1.0" ?>`
    + must have ***one single root element***
        * `<catalog>...</catalog>`
    + elements are built with tags, must be properly closed
        * opening `<tag>`
        * closing `</tag>`
        * empty `<br />`
    + an element may have one or more attributes, attributes must be in quotes (can be either double or single, for me, stick with double)
        * e.g. `<person title="Sir">Tony</person>`  
    + Comments
        * e.g. `<!-- comments -->`
    + Element names must start with alphabetic character
- Case-sensitive
    + `<title>` is not the same as `<Title>`
- elements must be appropriately nested
    + wrong example `<author><firstname>James</author></firstname>`
- Special characters
    + like `<` and `&` are strictly illegal inside an element
    + we should use *entity name* or *CDATA*
    + Escape Characters
        * `"`   `&quot;`
        * `'`   `&apos;`
        * `<`   `&lt;`
        * `>`   `&gt;` (not necessary but recommended)
        * `&`   `&amp;`
- CDATA (character data) section may be used inside XML element to include large blocks of text, which may contain these special characters such as `&`, `>`
    + `<![CDATA [... ... ...]]>`
    + the xml below is valid
```xml
<?xml version="1.0" encoding="utf-8" ?>
<hi><![CDATA[<>'"&]]></hi>
```
- Correctness Checklist
    + Declaration
    + One root element
    + attributes and strings in quotes
    + empty tag
    + opening/closing tags
    + tags correctly nested
- DTD (Document Type Definition)
    + grammar for the application of XML
    + DTD is a *schema* that creates a **consistent data structure**
    + Once you used DTD, you must have **every element defined**
    + define what element it can contain
        * `<!ELEMENT element_name (element types)>`
        * e.g. `<!ELEMENT customers(customer+)>`
    + define what content it can contain
        * `<!ELEMENT name (#PCDATA)>`
        * Example #1
```xml
<?xml version="1.0" encoding="utf-8" ?>
<!DOCTYPE hi [
<!ELEMENT hi (#PCDATA)>
]>
<hi>123</hi>
```
        * Example #2
```xml
<?xml version="1.0" encoding="utf-8" ?>
<!DOCTYPE hi [
<!ELEMENT hi (#PCDATA)>
]>
<hi><![CDATA[<>'"&]]></hi>
```

    + Element Types
        * `(#PCDATA)` - Parsed character (text) only
        * `(child1, child2, child3, ...)` - Declare **order** of child elements
            - ***order matters***
        * `EMPTY` - it must be an empty tag
        * `(child1 | child2 | child3 | ...)` - Declare choice of child elements
        * `ANY` - any type of content (**no restrictions**)
    + Symbols
        * `?` - Allow **zero or one** of the item
        * `+` - Allow **one or more** of the item
        * `*` - Allow **zero or more** of the item
    + define attributes
        * `<!ATTLIST element attribute_name attribute_type default>`
            - e.g. `<!ATTLIST customer custID ID #REQUIRED>`
        * Attribute Types
            - `CDATA` Character data
            - `(value1 | value2 | ...)` allowed values (numerated list)
            - `ID` used to create a unique identifier for an attribute
            - `IDREF` allows an attribute to reference the ID attribute from another element
                + if points to ID which doesn't exist, the validator will give a warning
            - `NMTOKEN` a name token whose value is restricted to a **valid XML name**(???)
                + can't have special characters(like white-space)
            - `ENTITY` a **reference to an external file**, usually one containing *non-XML data*
        * Attribute Default
            - `#REQUIRED`
                + must appear with every occurrence of the element
            - `#IMPLIED`
                + attribute is optional
            - "default value"
                + attribute is optional, but if not specified, XML paraser supplies default value
            - `#FIXED "default"`
                + attribute is optional, but if value is specified it **must match the default value**
    + Can be declared *internally* or *externally*
        * internal
            - DTD is declared within the same XML file
```xml
<?xml version="1.0"?>
<!DOCTYPE root 
[
    declarations
]>
<root>
</root>
```
        * external
            - SYSTEM
                + *specifies location of an external DTD*
                + e.g. `<!DOCTYPE root SYSTEM "url">`
            - PUBLIC
                + where DTD appears in *publicly available* location
                + xml parser will try to locate DTD by `id` first, if it can't find by the `id`, it will try to retrieve by the `url`
                + e.g. `<!DOCTYPE root PUBLIC "id" "url">`
    + XML parser may ignore the DTD declaration (not validate the XML)
- A XML document can be *well-formed and NOT valid* if it didn't follow the rule defined by the DTD (If DTD is defined)
- namespaces
    + define collections of elements
    + declared as an attribute of element
        * e.g. `<customer xmls:cust="http://mycompany.com/customer">`
            - `cust` is the prefix
                + prefix is any string which is added to elements and attributes to associate them with a particular namespace
            - `http://mycompany.com/customer` is the ***URI*** (I not L)
                + URI (Uniform Resource Identifier) is a string the uniquely identifies the name of the namespace
                    * it's not a web address! But, of course, it can be
                    * it's for uniquely identifying
    + more than one namespaces can be in a single element
    + namespaces normally declared in the root element
        * **available for all children of the root** (???)
- Comparison between attribute and element
    + attribute
        * can't contain other elements
            - as a result *no explicit structure*
        * used for **small, simple, unstructured "extra"/secondary** information
        * can be specified *only once* and *in any order*
        * represents *properties of objects*
            - elements represent parts of objects
- Parsing XML
    + Document Object Model
        * most useful way of parsing XML
        * Parsing calls load the document into a **tree structure** with different nodes that can be navigated by the program
    + Simple API for XML (SAX)
        * *Stream-based* way of reading XML
        * Fast and efficient if you don't need *random access*    
- Criticism
    + XML is *verbose* and *overly complex*
        * large *overhead*
    + it's strictly ***hierarchical***
        * as a result, some structures are difficult to model
        * e.g. *relational* information
    + nowadays JSON is taking its place
- XML adds meaning to the formatting of other markup languages (like HTML)
- XML allows a standard method of data exchange


JSON
-----

"Lightweight" client-side programming language

Data is in name/value pairs
e.g. `"firstName":"John"`

JSON is basically native JavaScript
As a result, this just seems like a shortcut to mixing program code and data

Designed to speed up client/server interactions
Widely used in Big Data database

However, *lacks context and schema definitions*




JSON data format

- A number (integer or floating point)
- A string (in ****double quotes****)
- A boolean (*true* or *false*, all in lower case)
- An array (in square brackets) e.g. `[1,2,3]`
- An object (in curly braces) e.g. `{"x":1}`
    + the key *must be a string*, as a result, *enclosed with double quotes!!*
- null  


|                     JSON                     |           XML            |
|----------------------------------------------|--------------------------|
| faster and better efficiency                 | allows formal validation |
| more streamlined, lightweight and compressed | gives you context        |


* XML gives you context because it's verbose, it gives you the idea of what that's about (???)


YAML
-----

even more lightweight
But **not* a markup language*

```YAML
firstName: David,
lastName: Lynn,
address:
- streetAddress: 211 Fox Street
- city: Greenville
- state: NH
```


HTML (hypertext markup language)
=====

- was designed for pure presentation
- **it's concenrd with formatting not meaning**
- not *extensible*
    + can't be modified to meet specific domain knowledge
    + browsers have developed their own tags
        * but not *portable*
- can be *inconsistently applied*
    + almost everything is rendered
    + normally, browsers can render incorrect written HTML pages
        * tolerance of errors
- Three broad categories of body markup
    + **structural**
        * defines *document* and ***layout structure***
    + **stylistic**
        * modifies the ***appearance*** of text
    + **semantic**
        * *identifies specific types* of ***information***
- structural markup
    + headings `<h1>`, `<h2>`, `<h3>`, `<h4>`, `<h5>`, `<h6>`  
    + paragraphs `<p>`
    + lists `<dl>`(description list, example below), `<ol>`, `<ul>`
    + block and inline content `<div>` `<span>`
- stylistic markup
    + bold `<em>`, `<strong>`
    + deleted `<del>`
    + italic `<i>`
    + pre-formatted `<pre>`
    + subscript `<sub>`
    + superscript `<sup>`
- semantic markup
    + links `<a>`
    + tables `<table>`
    + forms `<form>`
    + images `<img />`
    + others `<address>`, `<code>`
- Block-level and inline elements
    + by default, block-level elements begin on newlines whereas inline elements don't
    + block-level elements may contain inline elements and other block-level elements
    + inline elements may contain only data and other inline elements
- HTML entity
    + `<` `&lt;`
    + `>` `&gt;`
    + `&` `&amp;`
- markup tags details
    + Anchor `<a href="URL">`
    + `<form method="post or get" action="the submission link">`
        * `<input type="TYPE" name="NAME" />` define an input
            - TYPE
                + `text` - text box
                + `submit` - submit button 
                + `reset` - reset button
                + `checkbox` - check box
                + `radio` - radio button
        * forms *can't be nested*
- HTML examples
    + `<dl>`
```html
<!DOCTYPE html>
<html>

<body>
    <dl>
        <dt>FOI</dt>
        <dd>Something interesting</dd>
    </dl>
</body>

</html>
```
    + `<address>`
```html
<!DOCTYPE html>
<html>

<body>
    <address>
        <span>dsfsdfdfdsfds</span>
        <span>ewrewrewrewrw</span>
    </address>
    <address>
        <span>dsfsdfdfdsfds</span>
        <span>ewrewrewrewrw</span>
    </address>
</body>

</html>
```


CSS (cascading style sheets)
=====


- declarative language for *specifying HTML presentation*
- **separates content from presentation**
- reduces the amount of effort required to style a document or web site
- can use both single quote and double quote for string
- three use method
    + inline style (specify as properties)
        * specifying CSS by the *`style` attribute* of a single element
    + embedded style (specify as rules)
        * specified as rules that tell the browser that styles to apple and to which elements
        * declared in a `<style>` block inside the document `<head>`
    + linked / imported style
        * can be imported from an external file using the `<link>`
        * styles *applied in the order they are loaded* 
- selectors
    + used to select elements
    + **the more specific one has more precedence**
    + *the latter loaded selectors will overwrite all the properties defined by the selectors with the same precedence loaded before if they have the same properties defined*   
    + can be specified by
        * Type, Universal
        * ID
        * Attribute, Class
        * Pseudo-class
        * adjacent, child, descendant
- selector details 
    + ID selector
        * elements can be assigned a unique identifier using the `id` attribute
        * `#id`
    + attribute selector
        * select elements that have a property setting or have a property setting of a particular value
        ```html
        <input type="text" name="name" />
        <input type="email" name="email" />
        ```
        ```css
        input[type="text"] {background-color: red;}
        ```
    + class selector
        * every element can have classes assigned using attribute `class`
        * every element can have any number of classes (none, one, or more)
        * `span.big` selects elements `span` with class `big`
        * `*.big` is same as `.big` selects all elements having class `big`
    + pseudo-class selector
        * HTML elements may have one or more states associated with them
        * this enables selecting elements in a specified state
        ```css
        selector:pseudo-class {property: value;}
        ```
        * example
        ```css
        a:link {color:red;} /* unvisited link */
        a:visited {color:yellow;} /* visited link */
        a:hover {color:green;} /* mouse over link */
        a:active {color:orange;} /* selected link */
        a.big:link {color:white;}

        ```
    + descendant selector
        * select elements that are a child of another element
        * e.g. `parent_ele descendant_ele {property: value}`
    + child selector
        * **select children**
        ```css
        selector1 > selector2 {property: value;}
        ```
    + adjacent selector (next-sibling selector)
        * select *"only"* the **right next element matching the selector**
        * although you had specified the previous element, but you don't select it 
```css
previousElement + nextElement {property: value;}
/* example */
img + span.caption {font-style: italic;}
```
```html
<!DOCTYPE html>
<html>
<head>
<style>
span.big {color:red;}
.big {color:green; font-size: 100px;}
*.big {color:yellow;}

.parent > .child {color: orange;}
.parent > span {border:1px solid;}

.child + .spec {color: purple;}
</style>
</head>
<body><span class="big">span</span>
<div class="big">div</div>
<div class="parent">
<span class="child">0</span>
<span class="spec">hellow hi</span>
<span class="spec">hellow hi</span>
<span class="child">1</span>
<span class="spec">hellow hi</span>
<span class="spec">hellow hi</span>
<span class="child">2</span>
<span class="spec">hellow hi</span>
<span class="spec">hellow hi</span>
<span class="child">3</span>
<span class="spec">hellow hi</span>
<span class="spec">hellow hi</span>
<span class="child">4</span>
<span class="spec">hellow hi</span>
<span class="spec">hellow hi</span>
<span class="child">5</span>
<span class="spec">hellow hi</span>
<span class="spec">hellow hi</span>
<span class="child">6</span>
<span class="spec">hellow hi</span>
<span class="spec">hellow hi</span>
<span class="child">7</span>
<span class="spec2">hellow hi</span>
<span class="spec">hellow hi (won't be selected)</span>
</div>
</body>
</html>
```
        the last `.spec` won't be selected 
- Color
    + named `red`, `green`, `blue`
    + hexadecimal value `#10FFA9`
    + RGB decimal value `rgb(255, 255, 255)`
    + RGBA decimal value `rgba(255, 255, 255, 0.5)`
- Font
    + fonts specified have to be available to the browser on the local system or linked into the document
    + specify using `font-family` attribute
        * it's good to specify more than one font, so that, when the first is not available, it can attempt to show the second, third... ones.
    + we can add fonts using `<link>`
- media queries
    + media queries are filters that enable the browser to change styles depending on the device rendering the document or its ***state***
    + queries can be specified either on the *stylesheet link* or in the *CSS itself*
    + examples
        * `<link rel="stylesheet" type="text/css" media="screen" href="screen.css">`
        * `<link rel="stylesheet" type="text/css" media="handheld" href="handheld.css">`
        * `<link rel="stylesheet" type="text/css" media="print" href="print.css">`
        * defined in CSS
```css
@media (min-width: 500px) and (max-width: 600px) {
    h1 {
        color: red;
    }
    
    .desc:after {
        content: " In fact, it's between 500px and 600px wide.";
    }

}
```
- cascading styles
    + HTML elements *inherit* some or all presentation properties from their parent elements
- limitation of CSS
    + *can't target specific text without markup tags.*
    + The exception is `:first-letter` pseudo-element
    + can't *name rules* (no variable)
    + *no expressions*
    + *very easy to overwrite other rules in a complex CSS file*
- Common Properties
    + `color: red`
    + `border`
        * can specify *thickness*, *line style* and *link color*
        * you can select exactly which side you want to change
            - `top`, `right`, `bottom`, `left`
        * `border: 1px solid red`
        * `border: 1px dashed red`
    + `padding` and `margin`
        * you can select exactly which side you want to change
            - `top`, `right`, `bottom`, `left`
        * Or, you can just specify them using one line
            - `padding: 1px 2px 3px 4px;`
    + `background-color: red`
    + `height` and `width`
        * specified in either *absolute* or *relative length*
        * absolute lengths are specified in pixels (px)
        * relative lengths are specified as a *percentage of the **parent** element's dimension*
    + `position`
        * `relative` - relative to the *top left corner of **parent***
        * `absolute` - *document* coordinate position
        * `fixed` - *screen* coordinate position
            - relative to the *top left corner of **viewpoint***


Spreadsheet
=====

Spreadsheet can be only for everything that can be modeled in a table

Basic element

- Sheet
- Row
- Column
- Cell Reference
- Static Data (literals)
- Formula

Formula
-----

a formula is constructed from literals, operators, functions and cell references

start with "`=`"

### Cell reference

absolute cell reference: `$A$1`
relative cell reference: `A1`
mixed: `$A1`
using name ranges `NAME_`

when copying a formula that contains column and/or row relative references to another cell, the references in the copied formula will be offset by the distance between source and target cells


### Aggregate functions

The number of arguments is at most 30 for the functions below.

- `SUM(number_1, number_2,... number_30)`
    + sum all the numbers/numbers in the given ranges
- `AVERAGE`
- `MAX`
- `MIN`
- `COUNT(value_1, value_2, ... value_30)`
    + count how many **numbers** are in the list of arguments. ***Text entries are ignored***. Values could also be ranges.
- `COUNTA(value_1, value_2, ... value_30)`
    + count how many **values** are in the list of arguments. ***Text entries are also counted***, *even when they contain an empty string of length 0*.

### Conditional functions

- `COUNTIF(range, criteria)`
    + return the number of elements that meet certain criteria within a cell range.
    + `criteria` is *a number or a text* used for the search criteria.
- `SUMIF(range, criteria, sum_range)`\*
    + sum the cells specified by a given criteria. `sum_range` is the range from which values are summed.



### Conditionals

Use function `IF(test_expression, then_value, otherwise_value(optional))`
if `otherwise_value` is not specified, it will be FALSE

#### Logic Operators

- Use `+` as logic OR operator
- Use `*` as logic AND operator


### Array formula

with arrayformula, we can pass arrays(ranges) to functions and operators that typically only *take non-array arguments*. Those functions and operators will be *applied to each member of the arrays one at a time*. These *results of these operation will be presented as a new array*.


### Index and offset

- `INDEX(range, row, column)`
    + return the *content of a cell*, specified by rows and columns from a starting cell reference
- `OFFSET(cell_reference, offset_rows, offset_columns, [height], [width])`
    + return a *range reference* shifted a specified number of rows and columns from a starting cell reference

### filtering and sorting functions

- `UNIQUE(sourceArray)`
    + returns only the *unique rows in the source array*, *discarding duplicates*, in the order in which those rows first appears.
- `FILTER(sourceArray, arrayCondition_1, arrayCondition_2, ... arrayCondition_30)`
    + return a *filtered version of the given source array*
    + each condition should be a *column(row) of boolean values*
    + only rows (columns) from the source array corresponding to the true values of the condition array will be returned
    + If there are multiple conditions, *all of them must be true in order to output the specific rows(columns)*
- `SORT(data, keyColumn_1, ascOrDesc_1, keyColumn_2, ascOrDesc_2, ... keyColumn_30, ascOrDesc_30)`
    + return the rows in the given data range sorted according to key columns
    + Key columns might be part of the data range, or as another column outside the range
    + each key column must also be marked to sort either ascending or descending, by adding either TRUE(ascending) or FALSE(descending).
    + the keyColumns come first will be higher precedence of the keyColumns come after


### lookup functions

`=vlookup(key_value, range, index, is_sorted)`

finds `key_value` in the first column of `range` and returns the value in the matching row and column-`index`

`is_sorted` (optional): TRUE or FALSE Indicates whether the column to be searched (the first column of the specified range) is sorted (default: TRUE)

If that's TRUE, when searching for a key, it will return the *nearest match (less than or equal to the search key)*. *If all values in the search column are greater than the search key, #N/A is returned*. But, if the first column is not in sorted order, an incorrect value might be returned.

If that's FALSE, only the first *exact match* is returned. If not found, #N/A will be returned.



Named Range
-----

Define a symbolic name for a particular cell or range of cells

Do not use names that have a potential of conflict with cell references
e.g. `A1`, `ABC123`

Can use underscore to avoid conflict
e.g. `name_` or `_name`


Pivot Table (Crosstab / OLAP Cube)
-----

- it has Dimensions and Measurements
- it *provides data summarization (aggregation) over selected dimensions* (typically subset of all dimensions).
- provide *sorting* and *ranking* function

Visualization
=====

- way of seeing meaning/relationships in data
- amplifies cognition
- provides a space for *exploring data*
- exploratory and explanatory
    + exploratory:discover the unexpected; explanatory:describe and explain the expected
- a mapping from data variables to visual variables
    + example
        * temperature -> brightness of color
        * city -> hue of color
        * city -> location (x coordinate)

Why Visualization
-----

- pre-attentive processing is done quickly, effortlessly and in parallel without any attention being focused on the display

Functions of Visualization
-----

- Associative function
    *grouping* of all correspondences **differentiated by a variable**
    perceived as *similar*
- selective function
    *isolation* of correspondences **differentiated by a variable**
    perceived as *different*, forming families
- ordering function
    a spontaneous visual perception of rank
    perceived as *ordered*
- quantitative function
    a visual difference between *two categories expressed* as a **numerical ratio**
    perceived as *proportional*

![variable vs function](https://raw.githubusercontent.com/yxliang01/UnimelbSharedFiles/master/Foundation%20of%20Informatics/Summary%20Resource/visualization-variable-vs-function.PNG)

![accuracy of visual variables](https://raw.githubusercontent.com/yxliang01/UnimelbSharedFiles/master/Foundation%20of%20Informatics/Summary%20Resource/visualization-accuracy-of-visual-variables.PNG)



Visualization for Univariate
-----

- Boxplot
    + display **variability** of a data variable
    + **five-number summary**
    ![boxplot example](https://raw.githubusercontent.com/yxliang01/UnimelbSharedFiles/master/Foundation%20of%20Informatics/Summary%20Resource/visualization-boxplot.PNG)
- Histogram
    + display the **distribution** of a data variable


*!important* Visualization for Bivariate
-----

- Pie chart
    + a *small number of nominal values* over a single continuous variable
    + communicating the *rough proportions*
- Bar chart
    + *continuous values vs nominal values*
    + **comparing a property of nominal entities**
- Scatter plot
    + **relationship between two continuous variables**
- Line chart
    + used to **compare two or more continuous variable**
    + can be used to display a *trend of a continuous variable* over time

Visualization for multivariate
-----

- stacked area chart / stream graph
    + ![stacked area chart](https://raw.githubusercontent.com/yxliang01/UnimelbSharedFiles/master/Foundation%20of%20Informatics/Summary%20Resource/visualization-stacked%20area%20graph.PNG)
- Trellis
    + not understood yet
- Tile map
- Coordinate Plot (parallel coordinates)
    + example
        * ![coordinate plot1](https://raw.githubusercontent.com/yxliang01/UnimelbSharedFiles/master/Foundation%20of%20Informatics/Summary%20Resource/visualization-coordinate%20plot.PNG)
        * ![coordinate plot2 with analysis](https://raw.githubusercontent.com/yxliang01/UnimelbSharedFiles/master/Foundation%20of%20Informatics/Summary%20Resource/visualization-coordinate-plot-with-analysis.PNG)
- Star plot/radar plot/spider plot
    + ![star plot](https://raw.githubusercontent.com/yxliang01/UnimelbSharedFiles/master/Foundation%20of%20Informatics/Summary%20Resource/visualization-star-plot.PNG)


Guidelines
-----

- Don't change the scale across charts which are intended to be contrasted (rubber scaling)
- Don't leave out the origin for *ratio variables* unless necessary
- Don't use *line chart* for *comparing nominal variables* (is that possible??)
- Don't *change* the *ordering of ordinal variables*
- careful about red-green color blindness
- visually impaired people need HIGH contrast
- set the context for what you are presenting
    + axes labels, legend, units, captions
- determine what numbers need to be presented to get your message across
    + more numbers vs less; exact vs rough; major vs minor axes, scale, absolute vs relative

Measuring Visualization Effectiveness
-----

- data density index(ddi)
    + the number of numbers plotted per square inch
- data ink ratio (???)
    + the ink used for **showing data** divided by the total ink used for the **whole graphic**
    + the proportion of ink used for non-erasable display of information
    + 1.0 - redundant ink



Visualization steps
-----

- Data Definition
    + define the visualization goal and the supporting data variables
- Visualization selection
    + select appropriate visual structure
- Data pre-processing
    + preparing raw to visualization-ready data
- Visual transformation
    + mapping data variables to visual elements


Matplotlib
-----

- plotting library for python
- produce static/non-interactive visualization



Interactivity
=====

W3schools says that for good web development you need to know "at least"

- HTML for structure
- CSS for style
- JavaScript for browser control

MISC Synchronous & Asynchronous
-----

Synchronous = occurring in a specified sequence or at a sepcified time interval
Asynchronous = time intervals/sequences are not specified


### AJAX (Asynchronous Javascript and XML)

Group of technologies used to communicate between client and server without *interfering with display or behavior of a page*

- HTML/CSS for presentation
- DOM for dynamic display
- XML for data interchange
- XMLHttpRequest object (asynchronous)
- JavaScript to tie all the technologies together

XMLHttpRequest (XHR)
It's an API that browsers support that allows you to send information over HTTP
This object is relied by Ajax 

`onreadystatechange()` is an event listener
`send()` sends the information along the HTTP request

XMLHttpRequest Example
```js
function getCenterInfo(server_root, str)
{
    var xmlhttp;
    if (window.XMLHttpRequest) {
        // code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp = new XMLHttpRequest();
    } else {
        // code for IE6, IE5
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }

    xmlhttp.onreadystatechange = function() {
        if(xmlhttp.readyState == 4 && xmlhttp.status == 200)
            document.getElementById("center_info").innerHTML = xmlhttp.responseText;

    }
    
    var script_url = server_root + "/scripts/getcenterinfo.jsp?centerid="+str;
    xmlhttp.open("POST", script_url, true);
    xmlhttp.send();

}

```




JavaScript
-----

### Syntax

- Names
    + reserved words
        * e.g. `boolean`, `char`
        * but, not including *`undefined` and `NaN`* !!!
- Numbers (`number`)
    + a single number type
        * 1 and 1.0 are the same value having the same type            
        * e.g. `1 === 1.0` is True
- Strings (`string`)
    + string literals can be wrapped in single or double quotes
    + JS doesn't have a char type, it just has `string` type
        * just like python
- JS is weakly typed
    + you don't have to declare the variable types
    + it will be firgued out at run-time
- Basic types
    + basic types - `number`, `string`, `boolean`, `null` and `undefined`
    + everything else is an Object
```js
var obj = {
    name: some_value
}
```

### JavaScript Event-driven programming

Five most common events

- `onclick`
- `onmouseover`
- `onmousedown`
- `onblur`
- `onfocus`

### manipulating DOM

You can

- change HTML elements, attributes, and CSS styles
- remove/add HTML elements and attributes
- react to existing HTML "events" within a page
- create new HTML "events" within a page


### jQuery

At it's core, it's a DOM manipulation library

Advantage

- Extensible
- Cross-browser compatibility
- Separation of JavaScript and HTML

`$(selector)`

#### jQuery Note

- `selector` may match more than one elements
    + manipulating with `$(selector)` will let you do things with the first element
    + `$(selector)[i]` will give you the *DOM object* of the $i_th$ element
    + `$(selector).eq(i)` will give you the *jQuery object* of the $i_th$ element     

### Reason of using JavaScript to do interactivity

- Client-side processing
    + faster for non computational expensive calculations
- Document Object Model (DOM)
    + part of the content of the web-page can be changed without having to build the whole thing from scratch
- Event-driven programming
    + changes are being triggered by many events built into that page, rather than only the HTTP requests





Database
=====

NoSQL is an alternative to the traditional SQL databases.
With SQL, you have a structure that has been optimized for navigation

- structure and organization is high
- speed of query is low

With NoSQL, the optimization is for storage

- Speed is high (as long as data is ordered and regular)
    + \*however, when the ordering matters or access is random, the speed slows significantly\*
- Structure is low
- *Good for highly regular and predictable data patterns*


Normally, Big Data databases use JSON


Big Data
=====

Big data is about **handling** a large amount of data, **not analyzing**
Big data didn't change the way we apply science on data

Definition
-----

A term for data-sets that are so large or complex that traditional data *processing applications* are inadequate. - Wikipeida

The number of transistors in an integrated circuit doubles approximately every two years. - Moore's Law

The thing the law states leads to increased capabilities in *storage* and *execution*

Benefits

- data "miners"
    + gives you deeper insight into your population of study
- data "consumers"
    + gives you access to convenient and useful services

Costs (accidental) (???)

- concentrate on handling rather-than representative sample sizes
- volume without judgment or inference (cleverness)

Costs (deliberate)

- the consumer's privacy


Big infrastructure
-----

- cluster computing (90's and earlier)
    + set of computers that work together and can be viewed at a single system
- grid computing (00's)
    + collection of computer resources to achieve common goal
    + modeled on the electricity grid
    + process grids/information grids
    + SETI@home was one of the original concepts
- cloud computing (10's)
    + Infrastructure As A Service (IAAS)
    + Platform As A Service (PAAS)
    + Software As A Service (SAAS)


Big Data Details
-----

- Volume
    + How big is the data?
- Velocity
    + How fast is the data generated?
- Variability
    + how regular or varies is the data?
- Veracity
    + What is the quality/consistency of the data?


Three problems (What Big Data is trying to deal with)

- Data Consistency
    + How to deal with data from different sources
    + Can you standardize and clean data from different sources easily?
- Networks
    + Trade-Off: Speed if processing on individual node VS the time taken to get the data to other resources
    + Can you communicate this data between computers easily?
- Storage (Size vs Structure)
    + Structure
        * Structured database organized into tables
            - Query using SQL(Standard Query Language)
            - organization allows optimization of speed to "finding useful stuff"
    + Size
        * No SQL
            - one big repository that follows a simple syntax and grows by simple addition
    + Can you store all that data in an organized and easily accessible way?


These are the unsolved problems that Big Data tries to fix so that large volumes of data can be collected, stored and accessed easily.

They *DO NOT* impact the science that you are trying to do.


Security
=====

Security philosophy - Three Categories of actions (sorted from least effective to most effective)

- Prevention (gates, locks, etc..)
    + Username/passwords
- Detection (alarms)
    + Audit trails
- Reaction (prosecution, payback, etc...)
    + Auditing and attribution


Security Layers
-----

![Layers](https://raw.githubusercontent.com/yxliang01/UnimelbSharedFiles/master/Foundation%20of%20Informatics/Summary%20Resource/Security%20Layers.PNG)



De-identify the data

- no names
- no addresses


i18n & L10n
=====

Misc Definitions
-----

A locale is a collection of parameters that defined specific language, country, script, rules, and code character set

A character is a indivisible unit of text. A character set defines the range of a character collection.





Localization
-----

modifying or adapting an application to fit the requirements of a particular locale


Internationalization
-----

designing an application so that it **can operate in multiple locales without any engineering change** to the application




Unicode
-----

- provide a universal character set that encapsulates almost all characters in the world's languages
- A collection of abstract characters, each identified by an integer/number called *code point* and unique name (coded character set)
- In Unicode, code point is *NOT the way computer represents (encodes) the character*, but it's used to identify the character

Character encoding
-----

- A character is NOT the physical (binary) representation in a file, in a web page or in a device. A character is an abstract entity, its actual representation is determined by **character encoding**. Encoding maps a logical character to a numerical value.
- character set and encoding are often *used interchangeably*.
- Encoding is a mapping from a logical representation of a character to its physical representation
- Encoding maps a character (one or more) bytes
- It's important to know what the encoding the incoming/outgoing data is in, it will affect whether the programs will interpret the file content correctly


### UTF-8

The most commonly used encoding is UTF-8
*Backward compatible with ASCII!!*

### ASCII

American Language Code for Information Interchange
Supports Basic Latin Characters
Limited support for European language

If you want to support other languages, you need to use extended catharses (like Windows-1252, Big5). But they are not compatible with each other since the code points they have have overlaps. 


Python and character encoding
------

Unicode string is an abstract or logical representation of character.
Python byte string is a physical representation

`\uCODE_POINT` to get a Unicode character 

Sending to a file, web page, device, you need to **encode**.
e.g.`u'\u00e9'.encode('utf-8')`

When we want to convert byte string to Unicode string (so that python can process easily), we need to **decode**.
e.g. `b'\xc3\xa9'.decode('utf-8')`


In python 2, lxml will give you Unicode string when necessary. Normally, when you try to output (e.g. `print`) a byte string, it will try to *encode* it using local default encoding (can retrieve using `sys.getdefaultencoding()`).

In order to support internationalization in python well, you have to

- logically store characters in Unicode
- perform all string processing in Unicode string
- Decode early
    + decode straightaway when you get the data from input (can be a file, device, etc...)
    + have to decode using correct encoding, otherwise, python will interpret the data wrongly
- encode last
    + when encoding, have to choose an encoding which can be supported by the device


Use the python module `locale` to do the internationalization

However, using that module can't help with the language translation. As a result, we have to deal with language ourselves. Putting translation strings in XML files separated by the languages is a good way.







Web Server back-end process
=====

There are few ways to construct a web page using information from a client (web page generated dynamically).

CGI script
-----

the old way
URL for the requested content identifies the name of the CGI script to use
The server will locate the CGI script, execute it and sends the output of the script back to the client
The script can be implemented in any programming language


FLASK
-----

a framework for python for web back-end processing

encapsulate low-level information passing between browser and application
provide routing of the URL
provide templating or abstraction for HTML

If debug mode is ON, changes on the source code will refresh the web application server.

for POST, we get the parameter by `request.form['NAME']`
for GET, we get the parameter by `request.args.get('NAME')`

### Basic structure
```python
from flask import Flask, request


# just serve all the static files under root
app = Flask(__name__, static_folder='.', static_url_path='')


# for / root, return Hello World
@app.route("/")
def root():
    return 'Hello World!'

@app.route("/handler", methods=['POST','GET'])
def handler():
    if request.method == "POST":
        name = request.form['name']
    else:
        name = request.args.get('name')

# start listening
if __name__ == "__main__":
    app.run(debug=True)
```



HTTP (HyperText Transfer Protocol)
=====

protocol for the transfer of data on the Internet
*Version 1.1 is the most popular version* in use today
Originally intended for transmission of "hypertext" documents (text with links)
now used for a wide variety of media

a HTTP requests contain

- method
- path
- version

e.g. `GET /index.html HTTP/1.0`


HTTP request *methods*

- `GET` - retrieve an entity (document) from the server
- `POST` - submit data to the server for processing
- `PUT` - send an entity to be stored on the server
- `DELETE` - request the removal of an entity from the server
- `OPTIONS` - ask the server to reveal its capabilities
- `HEAD` - same as GET but only return HTTP headers and not the document


HTTP respond

- Status Code
- MINE type
    + tell client what kind of content it returns
    + specified by `Content-Type`
- Response Header
- Response Body
- Request and response terminated by blank lines


Difference between GET and POST when sending data
-----

An idempotent request is one that doesn't produce "side effects"

GET: information is sent as part of the **URL**
    we expect GET requests to be idempotent
POST: information is sent as part of **HTTP body/data**
    we expect POST requests to produce side effects


Analytics
=====

Analytics $=$ discovery and communication of meaningful patterns in data


Definitions
-----

- variable type
    + continuous (*numerical*, *quantitative*)
        * numbers or anything that can have a range
        * examples
            - Temperature
            - Velocity
            - Time
    + discrete (categorical)
        * *numbers can also be discrete* (e.g. number of people)
        * examples
            - number of people
            - Colors
            - Political party
            - favorite food
            - car models
            - age
        * Two main types
            - nominal
                + the values of the variable is not ranked (unordered)
                + e.g. names
            - ordinal
                + ordinal variable is the one which allows *rank order* by which data can be sorted.
                + e.g. best, average and worst
- Steven's variable types
    + nominal scale
    + ordinal scale
    + interval scale
        * has no meaningful zero point (no origin)
        * express difference (interval) between two measurements
        * examples
            - dates, latitude
            - Celsius temperature
            - To say that "2 degree Celsius is twice as hot as 1 degree" is *NOT* meaningful
    + ratio scale
        * has a meaningful, unique and non-arbitrary zero point
        * examples
            - mass, length, duration, angle
            - it's meaningful to say "2-meter object is twice as long as a 1-meter object"

Steps of doing data analysis
-----

1. **Sourcing**
    + *find* your data
2. **Understanding**
    + what do the columns and values *represent*?
    + figure out what *story* is buried in that data
3. **Cleaning**
    + are there *errors* and is the data *valid*?
    + what was the original data collection purpose?
4. **Transformation**
    + Turn the data into something *presentable*
5. **Feature selection**
    + Pull out the relevant bits to *address* your *hypothesis*


Sourcing
-----

Data-set types

- Surveys or polls 
- experiments
- observational
- other studies

Repository types

- Operation databases 
- Data warehouses
- Historical databases
- Purchased data

Data types

any kind of persistent file storage

- SQL
- CSV
- XML
- JSON
- ......


Understanding
-----

- table approach
    + make *columns* as *variables* and *rows* as *observations*
    + can use either *raw* or *derivative* data in the table
- plot frequency distribution
    + define categories and plot them along the x-axis
    + if the variable is in numerical, you have to convert them to categorical by counting the instances and put them into categories (called a histogram)
        * we divide the range into intervals that have well-defined boundaries (called "binning" into a histogram)
            - ways to define boundaries
                + Equal interval
                    * split up the range equally
                + Quantile
                    * the most commonly used method to define class boundaries
                    * look at the data and break up the categories so that each one has equal member numbers
                    * First quantile $Q1$ - Lower Quantile (25<sup>th</sup> percentile)
                    * Second quantile $Q2$ - Median (50<sup>th</sup> percentile)
                    * Third quantile $Q3$ - Upper Quantile (75<sup>th</sup> percentile)
                    * Interquartile range (IQR) - $Q_3 - Q_1$
                    * Split into four evenly-populated sections ($Q1 - Q4$)
                + Jenks (Natural Breaks)
                    * look at the data and see what's "natural" intervals lie (by measuring the distance from the mean)
                    * Cluster a set of values into different classes by reducing the variance within classes and maximizing the variance between classes
        * e.g. make age groups with each one has the same interval
      
cleaning
-----

validation and tidying of the data

**two problems**

- semantic similarities
    + example
        * "General Electric Company"
        * "General Elec Co."
        * "GE"
        * "Gen. Electric Company"
- Range problems (or wrong units)
    + example
        * Age - 150 years
        * Blood pressure - 250 mmHg

when we say remove variables, we mean we remove an entire category because it contributes nothing of interest or relevance to the analysis. It does not mean that we remove a single data point because it makes the graph look bad. The data points which makes the whole graph look bad are called outliers. 

Transformation
-----

- Normalization
    + scale numerical columns so that they can be *compared fairly*
    + e.g. converting absolute numbers to *percentages*, then scaling
- Value mapping
    + convert text data (nominal) to numbers
    + e.g. low = 0, medium = 1, high = 2
- Discretization
    + convert numerical variables into categorical ones
- Aggregation
    + derive a variable (???)


Feature Extraction
-----

Feature Extraction is an algorithm to pull only the information of relevance -> data mining

If your data is too big, then there will probably be some redundancy
e.g. measurements in meters and feet 

This is yet another branch of mathematics in itself






MISC Definitions
=====

- URL (Uniform Resource Locator)
    + a formal representation of the location and means of access for a resource on the Internet (actually not only Internet!)
    + `scheme://user:password@host:port/path?query#fragment`
    + absolute URL
        * e.g. `http://www.xyh-info.tk/page.html`
    + relative URL
        * e.g. `page.html`
        * e.g. `../page.html`
- accessibility
    + using descriptive tags to aid screen-readers and audio browsers
- Search-engine optimization (SEO) 
    + to help your web pages to be shown at the top of search engine pages
- semantic web
    + all about having descriptive tags in everything so that it can be more efficiently mined. (kinda controversial) 



Tools Of Analysis
=====

MISC definition
-----

- Bivariate
    + two variables
- Univariate
    + One variable


When we do bivariate analysis, we want to find the relationship between two variables.


In any experiment, you have at least

- one independent variable
- one dependent variable
- every else controlled

Contingency Table
-----

- A matrix that shows the *frequency distribution* of the two variables being correlated
- cross tabulation
- shows the number of observations for each combination of discrete values from two categorical variables
- categorical values can be *ordinal* or *nominal*
- continuous values must be made discrete (categorized)

rank correlation
-----

basically, calculate similarities between ranks

### Spearman's rank correlation

$$p = 1 - \frac{6\sum{d^2}}{n(n^{2}-1)}$$
$$\text{ where }d_i = x_i - y_i$$

relatively high value (nearer + 1) suggests yes, there is a relationship

### regression (regression line)

the concept that in the long-term, extreme measurements of a continuous variable will converge on a single "average" relationship

the idea is that there is a defined meaning of "normal" of this data-set, and in a good model the data points are never very far from "normal"

#### Linear regression

The slope of the linear regression line is the *correlation co-efficient*

$$ \text{(inverse correlation)} -1 <= r <= 1 \text{(positive correlation)} $$
If $r$ = 0, means (no correlation)


### Pearson correlation coefficient

the degree of relationship between two continuous variables


Data Mining
=====

Unsupervised VS Supervised
-----

Unsupervised learning: provide broader view to get the "data landscape" or "interesting recurrent pattern"
Supervised learning: some prior knowledge about what you want to find out (target variable)


Unsupervised learning (???)
-----

- Association rule
    + generate rules based on observations of the data-set
    + good when
        * rule is easy to apply to other data points
        * rule can be generated by analyzing the data-set
    + advantage
        * easy to understand
        * actionable (something that can do)
        * good for large data
    + disadvantage
        * categorical only
        * time-consuming to generate
        * many rules means priority to be worked out
- Clustering
    + groups data into sets of observations or clusters
    + K-means clustering
    + advantage
        * flexible
        * hierarchical approach possible
    + disadvantage
        * setting initial cluster number
        * can be slow
        * size limits


Supervised
-----

- using historical patterns to predict what will happen next
- regression
    + mathematical model to predict a *continuous response* variable
- classification
    + allows observations to be assigned to different categories
    + build the model to predict which category the next data-point is going to fall into
    + a classifier is a model that *contains some parameters*
    + commonly used classifiers
        * K-nearest neighbor classifier
        * Naive Bayes classifier
        * Support Vector Machine
        * Decision Tree
    + have a "training data set" for a classifier to learn from (use the data to find the parameters)
    + test the performance using "test data set"
    + KNN classification
        * the class of an unknown instance is the majority of k closest sample/training data
    + the confusion matrix
    
    | Actual/Predicted | Positive | Negative |
    | True             | TP       | FN       |
    | False            | FP       | TN       |

    T/F indicates whether the predicted result is correct
    P/N indicates whether the predicted result is positive or negative

    + sensitivity = how well the model is able to predict **true** values
        * $Sensitivity = \frac{TP}{TP + FN}$
        * $TP + FN = \text{ the number of actually true cases }$
    + specificity = how well the mode is abel to predict **false** values
        * $specificity = \frac{TN}{FP + TN}$
        * $FP + TN = \text{ the number of actually false cases }$
    + In real life, there's usually a *trade-off* between theses two 


Network of data
=====

we can represent a network as a graph.

Graph
-----

### Definition

- Directed graph
    + edges own directionality between two nodes
- Weighted graph
    + edges have values that indicate a property of the connection
- Acyclic
    + no loop/cycle
- Degree of a node
    + the number of edges of a node (indegree/outdegree)
- Path
    + A sequence of nodes that can be traversed by traveling through edges from a starting node to an ending node
- Geodesic Path
    + the *shortest path between two nodes*, path with **minimum number of edges**(not minimum weight)


### Properties

- order of a graph
    + the number of vertices
- size of a graph
    + the number of edges
- degree of node $deg(v)$ 
    + the number of edges incident to it
- geodesic distance between $v$ and $w$ -> $\delta(v, w)$
    + *number of edges in the geodesic path* between $v$ and $w$
    + Application: Bacon number
- graph centrality
    + see [Centrality](#graph-centrality)

### Graph Centrality

Four categories

- A = Degree centrality
    + how many neighbors
    + $C_d = $the degree of a node (the number of edges attached to it) (???what if directed???)
    + $C_d(v) = deg(v)$
- B = Closeness centrality
    + how close to other nodes
    + how close you are in general with other people in the network
    + $C_s = $the reciprocal of the average length of geodesic paths between a node and all other nodes
    + $C_s(v) = \frac{1}{\sum \delta(v,w)} , w \in V$
- C = Betweenness centrality
    + bridging nodes
    + an important node lies on most of the paths between other nodes in the network, bridging the connectivity between other nodes
    + $C_b = $the total proportion of geodesic paths between any two nodes in which the node of interest lies
    + $C_b(v) = \sum_{v \ne s \in V} \sum_{v \ne t \in V} \frac{\sigma_{st}(v)}{\sigma_{st}}$, $\sigma_{st}$ is the number of *geodesic paths* from node $s$ to node $t$, $\sigma_{st}(v)$ is the *number of those paths that pass through $v$*, $\frac{\sigma_{st}(v)}{\sigma_{st}}$ is the proportion of geodesic paths from node $s$ to node $t$ that pass through $v$
    + has example in slide
- D = Eigenvector centrality
    + connect to well-connected nodes
    + no only concern about the degree of the node but also the degree of the connected nodes
    + Application: Google PageRank and SocialRank 


Databases
-----

Relational

- PostgreSQL
- MySQL
- MS SQL
- Oracle

Document/NoSql

- MongoDB
- CouchDB
- Cassandra

Graph

- neo4j


Information
=====

Information means to give form, shape, or character to. It's therefore to be formative principle of, or to imbue with some specific character or quality.

Oxford's definition
-----

- As a mathematically defined quantity divorced from any concept of news or meaning... One which represents the degree of choice exercised in the selection or formation of one particular symbol, message, etc... out of a number of possible ones, and which is defined logarithmically in terms of the statistical probabilities of occurrence of the symbol or the elements of the message
    + information as a fact
    + out-of-context
    + according to them, the following has the same information
        * "4566 7450 2344 1935 AMEX 08/17"
        * "I am floating like a butterfly"
- contrasted with data: that which is obtained by the processing of data
    + information as a subjective entity
    + data is raw facts, information is processed data, within organizations, in a social context
    + A pragmatic definition defines the topic as the most valuable form of content in a continuum starting at *data*, encompassing *information*, and ending at *knowledge*
    + we will stick to this one

![Information Triangle](https://raw.githubusercontent.com/yxliang01/UnimelbSharedFiles/master/Foundation%20of%20Informatics/Summary%20Resource/Information%20Triangle.PNG)

- Data
    + know nothing (symbols)
- Information
    + know what, who, when, where (processed data)
- Knowledge
    + Know how (actionable information)
- Wisdom
    + know why (evaluated understanding)

Data as signals *ignores the meaning of its content*
Information in context considers observers (subject) and *what the information means to them*
Information as a *relationship between the subjective and the objective*
As information is shared, information is also a *form of communication*

Information as signs
-----

- *syntactics* (rules)
    + formal structures of signs, grammar/rules, of *signs construction and relation*
- *semantics* (meaning)
    + *relation between signs and objects* (the things to which they refer) *in the mind of the observers*
- *pragmatics* (what you can do with that)
    + *relation between signs and their context* (of *the observers that interact with the things*)


Peirce's typology of signs
-----

- Icons
    + likenesses
    + **direct, similar representations of objects**, shared quality
    + things that have meaning itself (ambiguous..)
    + examples
        * road signs
        * computer icons
- **Indices**
    + Correspondence in fact
    + **indirect representations of objects**
    + thing that ****implies**** something else
    + examples
        * phone ring and calls
        * smoke and fire 
- Symbols
    + Imputed character
    + arbitrary representations of objects
    + a social convention should be established to understand the representation
    + things actually don't imply other things but, we **force them to imply** something  
    + my examples
        * Company logos

From [Indiana University](http://www.cs.indiana.edu/~port/teach/103/sign.symbol.short.html)

- **Icons** have a physical resemblance between the signal and the meaning
- **Indices** have a correlation in space and time with its meaning.
- **Symbols** (content words like nouns, verbs and adjectives) are (sound)patterns) that get meaning:
    + primarily from its mental association with other symbols and
    + secondarily from its correlation with environmental patterns.



Information Theory
-----

Information represents the degree of freedom in choosing one particular symbol from all possible ones

Bit as the *fundamental unit* of information

### Binary Code

Two-symbol language: two alphabets "0" and "1"

Information quantity depends on the number of alternative message choices encoded in the binary system

![flags required](https://raw.githubusercontent.com/yxliang01/UnimelbSharedFiles/master/Foundation%20of%20Informatics/Summary%20Resource/flags.PNG)


### Hartley function (Hartley uncertainty measure)

- Selecting up a particular symbol on a finite set $X$ of uniformly discrete symbols
- Amount of information *needed to remove the uncertainty*
- Amount of uncertainty associated with a set of $n$ alternatives
- quantifies how many $b$-choice questions need to be asked to uncover the selected symbol

$$H_0(x) = \log_b |X| = \log_b n$$

b = 2, the unit of measurement is called shannan (Sh)
b = e, the unit of measurement is called nat (for natural logarithmic)
b = 10, the unit of measurement is called hartley (Hart)


### Entropy of information

Shannon's Entropy probabilistic-based measurement

Hartley **works for uniformly distributed symbol**, Shannon's for non-uniform distribution

__The more unpredictable a symbol is, the higher its information value__


Entropy of selecting a symbol from $X$ is:

$$H(X) = -\sum_{i=1}^{n} p(x_i) \log p(x_i)$$

$H$ is maximum when *all* $p(x_i)$ are equal
$H$ is minimum when *any of* $p(x_i)$ is 1 (since the information is fixed(certain to be the thing))

$H$ indicates the *theoretical bounds for the average bits needed to
represent/compress the symbols*


Not Examinable
=====

- lxml
- matplotlib


Extra
=====

Difference between URI and URL
-----

From RFC 3986:

A URI can be further classified as a Locator, a name, or both. The term *"Uniform Resource Locator" (URL) refers to the **subset** of URIs that*, *in addition to identifying a resource, provide a means of locating the resource* by describing its primary access mechanism (e.g., its network "location"). The term "Uniform Resource Name" (URN) has been used historically to refer to both URIs under the "urn" scheme [RFC2141], which are required to remain globally unique and persistent even when the resource ceases to exist or becomes unavailable, and to any other URI with the properties of a name.
So all URLs are URIs (actually not quite - see below), and all URNs are URIs - but URNs and URLs are different, so you can't say that all URIs are URLs.

Not "all URLs are URIs". It depends on the interpretation of the RFC. For example in Java the URI parser does not like [ or ] and that's because the spec says "should not" and not "shall not"



Why do we want client-side processing
-----

If we always need to send data to server in order to process, it will be too slow. As a result, we want to do some lightweight processing on client side. In the early 2000's, people send pre-compiled code to client browser to process. But, this approach lacked flexibility because we have to load the whole compiled application. Ajax is one of the solution for this. With Ajax,
we can load the part that we need in real-time without having to load everything no matter whether we need it or not. So that, client browsers don't have to download large amount of data. 



Questions
=====

What is the Document Object Model(DOM) of a web page? Describe it using common examples of tags, elements and attributes.
-----
(Not sure)
It is an object which allows us to manipulate the HTML elements. For example, if we have an element `<p id="yu">abc</p>`, we can use JavaScript to change its text by doing `document.getElementById("yu").text = "123";`. 


What aspects of JavaScript make it ideally suited to building interactive web-sites?
-----

- it's cross-platform
- it's supported by most of the browsers nowadays
- it has many libraries for building interactive web-site
- it can access DOM which allows us to change the HTML page on-the-fly(without reloading the pages).


Replace a text in `<something>` tag using 1. JavaScript 2. jQuery
-----

1. document.getElementsByTagName('something')[0].innerText = 'something';
2. $('something').eq(0).text('something');


The harvesting of personal information for Big Data projects has ramifications for the privacy of an individual. Describe an example where information is gathered on an individual through social media. What is the potential impact if this social information was linked to their electronic medical record? What steps could the curators of the social information and the medical records take to minimize this impact?
-----

If someone had posted a photo of his electronic medical record id having details related to the illness he has at the moment accidentally, salesmen selling medicines may try to get his electronic medical record by the id and try to know what illness he has now, then try to promote medicines to him which may disturbing his life badly. The curators of the social information and the medical records can set an appropriate privacy setting on the data (e.g. for social information, only viewable by his friends; for medical record, only viewable by himself and doctors curing him).


Last Lecture Practice Exam Questions
=====

A
-----

A and G have the highest betweenness centrality. Since for A, All geodesic paths from {B,C,D,E} to nodes other than {A} are having A in them and for G, All geodesic paths from {H, I, J, K} to nodes other than {G} are having G in them. Betweenness centrality of A and G is $1/1 * 9 * 4 = 36$ with A and G in between. You may think that F has the highest betweenness centrality since it connects up the nodes connected to A and G together. However, F has the betweenness centrality of $1/1 * 5 * 5 = 25$ which is less than $36$.

GET and POST are two methods of passing information through the HTTP protocol. Describe both of these methods, emphasising similarities and differences, and their implications for privacy
-----


Describe two differences between the ASCII character system and the Unicode character system, including the difference in how they can be represented in Python
-----


In the field of social network analysis, closeness centrality and eigenvector centrality are two of the numerous measures of centrality of a vertex in a graph (or a network). Briefly (5-10 lines) describe these two notions of centrality
-----




Checklist
=====

- [] Review this note
- [] Workshops
    + [] Week2
    + [] Week3
    + [] Week4
    + [] Week5
    + [] Week6
    + [] Week7
    + [] Week8
    + [] Week9
    + [] Week10
    + [] Week11
- [] Questions
    + [] Last lecture
    + [] Sample Set 1
    + [] Sample Set 2
    + [] Network of data
    + [] Spreadsheet
    + [] Interactive Web Application