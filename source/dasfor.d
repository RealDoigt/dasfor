module dasfor;
import std.conv;
import std.regex;
import std.string;
import std.typecons;

auto dasformat(Args...)(string source, Args a)
{
    auto result = "", 
         pattern = `\$[0-9]+(:([a-z][0-9]?)|([A-Z][0-9]?))?`, 
         splitted = source.splitter!(Yes.keepSeparators)(pattern.regex);
    
    foreach (s; splitted)
    {
        if (s.matchFirst(regex("^" ~ pattern ~ "$")))
        {
            auto markerSplitted = s.split(":"),
                 index = s[1..$].to!uint,
                 item = a[index].to!string;
                 
            if (markerSplitted.length == 2)
                switch (markerSplitted[1])
                {
                    case "a", "A":
                        item = "%a".format(a[index]);
                        break;
                        
                    case "b":
                        item = "%b".format(a[index]);
                        break;
                        
                    case "c":
                        item = "%c".format(a[index]);
                        break;
                        
                    case "d":
                        item = "%d".format(a[index]);
                        break;
                        
                    case "e", "E":
                        item = "%e".format(a[index]);
                        break;
                        
                    case "f", "F":
                        item = "%f".format(a[index]);
                        break;
                        
                    case "g", "G":
                        item = "%e".format(a[index]);
                        break;
                        
                    case "o":
                        item = "%o".format(a[index]);
                        break;
                        
                    case "r":
                        item = "%r".format(a[index]);
                        break;
                    
                    case "s":
                        item = "%s".format(a[index]);
                        break;
                        
                    case "u":
                        item = "%u".format(a[index]);
                        break;
                    
                    case "x", "X":
                        item = "%x".format(a[index]);
                        break;
                        
                    default: // do nothing
                }
            
            result ~= item;
        }
        
        else result ~= s;
    }
    
    return result;
}