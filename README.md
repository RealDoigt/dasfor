# MIGRATED TO CODEBERG
https://codeberg.org/doigt/dasfor
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

## Format Specifiers

Dasfor also supports format specifiers. It covers all of D's format specifiers and some more. To use a specifier, just add a colon `:` after the index, then use a one-letter code that corresponsds to the desired functionality; you might also need a numeric argument following that code (hexadecimal number from 1 to F). Here's a table of all the current specifiers:

|Code|Case Sensitive?|Arguments|Description|
|-|-|-|-|
|a|No|None|Same as std.string.format's `%a`.|
|b|Yes|None|Same as std.string.format's `%b`.|
|c|Yes|None|Same as std.string.format's `%c`.|
|C|Yes|None|Same as std.string.capitalize|
|d|Yes|Optional; represents the minimal number of digits (filled by leading 0s if not reached)|Same as std.string.format's `%d`.|
|e|No|None|Same as std.string.format's `%e`.|
|f|No|Optional; represents the number of digits after the decimal (filled by 0s if not reached)|Same as std.string.format's `%f`.|
|g|No|None|Same as std.string.format's `%g`.|
|k|Yes|None|Transforms letter combos into characters that aren't always easy to find on a keyboard (find list below).|
|K|Yes|None|Ditto but for legal characters.|
|l|Yes|None|Same as std.uni.toLower.|
|M|Yes|Optional; represents the number of digits after the decimal (filled by 0s if not reached)|Per myriad number notation. Will multiply the input by 10,000|
|m|Yes|Optional; will format the amount using a specifc glyph and position that glyph according to native usage see list below for list of arguments (Does not try to use the correct decimal sign however)| Money without any specific glyph, same as std.string.format's `%0.2f`|
|o|Yes|None|Same std.string.format's `%o`.|
|p|Yes|Optional; represents the number of digits after the decimal (filled by 0s if not reached)|Permille number notation. Will multiply the input by 1,000|
|P|Yes|Optional; represents the number of digits after the decimal (filled by 0s if not reached)|Percent number notation. Will multiply the input by 100|
|r|Yes|None|Same as std.string.format's `%r`.|
|s|Yes|None|Same as std.string.format's `%s`.|
|t|Yes|Either nothing or C (for Celsius) and F (For farenheit)|Formats the number as an indice of temperature, by default Kelvins, the input is expected to be in Kelvin if if using Celsius or Farenheit.|
|u|Yes|None|Same as std.string.format's `%u`.|
|U|Yes|None|Same as std.uni.toUpper.|
|x|No|None|Same as std.string.format's `%x`.|

lists for k, K and m (because github's markdown is limited and doesn't allow multiline tables with lists inside like Pandoc does):
* k
    * !? -> ‽
    * ¿¡ -> ⸘
    * N° -> №
    * ... -> …
    * \*\*\* -> ⁂
    * \+\- -> ±
    * \-\+ -> ∓
    * \|\- -> †
    * \|= -> ‡
    * \-. -> –
    * \-\- -> ‒
    * \-\-. -> —
    * \-\-\- -> ⸺
    * \<\< -> «
    * \>\> -> »
    * \<\* -> ⟨
    * \>\* -> ⟩
* K
    * (C) -> ©
    * ()) -> 🄯
    * (P) -> ℗
    * (R) -> ®
    * (SM) -> ℠
    * (TM) -> ™
    * (MC) -> 🅪
    * (M) -> Ⓜ
    * (Wz) -> 🄮
* m
    * 0 -> canadian french dollar
    * 1 -> dollar
    * 2 -> canadian french cent
    * 3 -> cent
    * 4 -> euro, most languages
    * 5 -> euro, english
    * 6 -> yen
    * 7 -> yen, international use
    * 8 -> ruble
    * 9 -> ¤
    * A -> won
    * B -> bitcoin
    * C -> hryvnia
    * D -> turkish lira
    * E -> rupee
    * F -> pound

## Write Functions
Now also comes with convenient terminal `daswrite` and `daswriteln` functions which are direct equivalents of doing something like `write(dasformat(str, params...))`.
    
### IMPORTANT TO KNOW
The function expects you to give it valid arguments. If you get out of bounds or use the wrong specifiers, it's your problem!
