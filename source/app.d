module dasfor;
import std.conv;
import std.stdio;
import core.vararg;
import std.regex;

auto dasformat(Args...)(string source, Args a)
{
    import std.typecons : Yes;
    
    auto result = "", 
         pattern = `\$[0-9]+`, 
         splitted = source.splitter!(Yes.keepSeparators)(pattern.regex);
    
    foreach (s; splitted)
    {
        if (s.matchFirst(regex("^" ~ pattern ~ "$")))
            result ~= a[s[1..$].to!uint].to!string;
        
        else result ~= s;
    }
    
    return result;
}

void main()
{
    "my mom is a $0, she liked her job as a $0, but now she's ready for a job as $2 or a $1"
    .dasformat("nurse", "teacher", "research assitant")
    .writeln;
}
