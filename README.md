# Doigt's Awesome String FORmat
To use, simply import `dasfor` then call the dasformat function. `dasformat` expects a string and one or more arguments of various types. Inside the string, use $ followed by a number referring to the position of the argument after the string in order of left to right starting at 0. The value matching that position will be interpolated into the string.

Example 1:
```d
"my mom is a $0, she liked her job as a $0, but now she's ready for a job as a $2 or as a $1"
.dasformat("nurse", "teacher", "research assitant")
.writeln;
```
Output:
`my mom is a nurse, she liked her job as a nurse, but now she's ready for a job as a research assitant or as a teacher`

Example 2:
```d
"$0 is an int, $1 is a float, $2 is a char and $3 is a string"
.dasformat(1, 0.5, '$', "GREETINGS MORTALS")
.writeln;
```
Output:
`1 is an int, 0.5 is a float, $ is a char and GREETINGS MORTALS is a string`

Example 3:
```
"$2 $1 $0 $1 $0 $2"
.dasformat("hello", "world", "abc")
.writeln;
```
Output:
`abc world hello world hello abc`

### IMPORTANT TO KNOW
The function expects you to give it valid arguments. If you get out of bounds or use the wrong specifiers, it's your problem!
