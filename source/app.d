module dasfor;
import std.conv;
import std.stdio;
import std.regex;

auto dasformat(Args...)(string source, Args a)
{
    import std.typecons : Yes;
    
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
}
