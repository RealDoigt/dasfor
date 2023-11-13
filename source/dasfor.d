module dasfor;
import std.conv;
import std.regex;
import std.typecons;

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