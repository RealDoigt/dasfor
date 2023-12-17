module dasfor;
import std.conv;
import std.regex;
import std.string;
import std.typecons;

auto dasformat(Args...)(string source, Args a)
{
    auto doFormat(string str, size_t index)
    {
        final switch (index)
            static foreach(argIndex; 0 .. a.length)
            {
                case argIndex:
                    return str.format(a[argIndex]);
            }
    }
    
    auto result = "", 
         pattern = `\$[0-9]+(:(([a-z]|[A-Z])([0-9]|[a-f]|[A-F])?))?`,
         splitted = source.splitter!(Yes.keepSeparators)(pattern.regex);
    
    foreach (s; splitted)
    {
        if (s.matchFirst(regex("^" ~ pattern ~ "$")))
        {
            auto markerSplitted = s.split(":"),
                 index = markerSplitted[0][1..$].to!uint,
                 item = doFormat("%s", index);
                 
            if (markerSplitted.length == 2)
                switch (markerSplitted[1][0])
                {
                    case 'a', 'A':
                        item = doFormat("%a",index);
                        break;
                        
                    case 'b':
                        item = doFormat("%b",index);
                        break;
                        
                    case 'c':
                        item = doFormat("%c",index);
                        break;
                        
                    case 'd':
                    
                        if (markerSplitted[1].length == 1)
                            item = doFormat("%d",index);
                            
                        else
                            item = doFormat("%0" ~ markerSplitted[1][1].to!string.to!uint(16).to!string ~ "d", index);
                        break;
                        
                    case 'e', 'E':
                        item = doFormat("%e",index);
                        break;
                        
                    case 'f', 'F':
                        
                        if (markerSplitted[1].length == 1)
                            item = doFormat("%f",index);
                        
                        else 
                            item = doFormat("%0." ~ markerSplitted[1][1].to!string.to!uint(16).to!string ~ "f", index);
                        break;
                        
                    case 'g', 'G':
                        item = doFormat("%e",index);
                        break;
                        
                    case 'o':
                        item = doFormat("%o",index);
                        break;
                        
                    case 'r':
                        item = doFormat("%r",index);
                        break;
                    
                    case 's':
                        item = doFormat("%s",index);
                        break;
                        
                    case 'u':
                        item = doFormat("%u",index);
                        break;
                    
                    case 'x', 'X':
                        item = doFormat("%x",index);
                        break;
                        
                    default: // do nothing
                }
            
            result ~= item;
        }
        
        else result ~= s;
    }
    
    return result;
}