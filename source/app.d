module dasfor;
import std.conv;
import std.stdio;
import std.regex;
import std.array;
import std.string;
import std.typecons : Yes;

auto dasformat(Args...)(string source, Args a)
{
    auto result = "", 
         pattern = `\$[0-9]+`, 
         splitted = source.splitter!(Yes.keepSeparators)(pattern.regex);
         
    string[] items;
    foreach(item; a) items ~= item.to!string;
    
    foreach (s; splitted)
    {
        if (s.matchFirst(regex("^" ~ pattern ~ "$")))
            result ~= items[s[1..$].to!uint];
        
        else result ~= s;
    }
    
    return result;
}

void main()
{
    "my mom is a $0, she liked her job as a $0, but now she's ready for a job as a $2 or as a $1"
    .dasformat("nurse", "teacher", "research assitant")
    .writeln;
    
    "$0 is an int, $1 is a float, $2 is a char and $3 is a string"
    .dasformat(1, 0.5, '$', "GREETINGS MORTALS")
    .writeln;
    
    "$2 $1 $0 $1 $0 $2"
    .dasformat("hello", "world", "abc")
    .writeln;
}
