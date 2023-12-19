module dasfor;
import std.uni;
import std.conv;
import std.stdio;
import std.range;
import std.regex;
import std.string;
import std.typecons;
import std.algorithm;

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
         splitted = splitter!(Yes.keepSeparators)(" " ~ source, pattern.regex);
    
    foreach (i, s; splitted.enumerate)
    {
        if (i % 2)
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
                        
                    case 'C':
                        item = item.capitalize;
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
                        item = doFormat("%g",index);
                        break;
                        
                    case 'k':
                    
                        item = item.replace("!?", "‽");
                        item = item.replace("¿¡", "⸘");
                        item = item.replace("N°", "№");
                        item = item.replace("...", "…");
                        item = item.replace("***", "⁂");
                        item = item.replace("+-", "±");
                        item = item.replace("-+", "∓");
                        item = item.replace("|-", "†");
                        item = item.replace("|=", "‡");
                        item = item.replace("-.", "–");
                        item = item.replace("---", "⸺");
                        item = item.replace("--.", "—");
                        item = item.replace("--", "‒");
                        item = item.replace("<<", "«");
                        item = item.replace(">>", "»");
                        item = item.replace("<*", "⟨");
                        item = item.replace(">*", "⟩");
                        break;
                        
                    case 'K':
                        
                        item = item.replace("(C)", "©");
                        item = item.replace("())", "🄯");
                        item = item.replace("(P)", "℗");
                        item = item.replace("(R)", "®");
                        item = item.replace("(SM)", "℠");
                        item = item.replace("(TM)", "™");
                        item = item.replace("(MC)", "🅪");
                        item = item.replace("(M)", "Ⓜ");
                        item = item.replace("(Wz)", "🄮");
                        break;
                        
                    case 'l':
                        item = item.toLower;
                        break;
                        
                    case 'M':
                    
                        if (markerSplitted[1].length == 1)
                            item = to!string(item.to!double * 10_000) ~ " ‱";
                        
                        else
                            item = format("%0." ~ markerSplitted[1][1].to!string.to!uint(16).to!string ~ "f ‱", item.to!double * 10_000);
                        break;
                        
                    case 'm':
                        
                        auto f = "%0.2f", glyph = "", before = true;
                        
                        if (markerSplitted[1].length == 2)
                            final switch (markerSplitted[1][1].to!string.toLower)
                            {
                                case "0": before = false; goto case;
                                case "1": glyph  = "$";       break;
                                case "2": before = false; goto case;
                                case "3": glyph  = "¢"; 
                                          f      = "%d";      break;
                                case "4": before = false; goto case;
                                case "5": glyph  = "€";       break;
                                case "6": glyph  = "円";
                                          before = false;     break;
                                case "7": glyph  = "¥";       break;
                                case "8": glyph  = "₽";
                                          before = false;     break;
                                case "9": glyph  = "¤";       break;
                                case "a": glyph  = "₩";       
                                          before = false;     break;
                                case "b": glyph  = "₿";
                                          f      = "%0.9f";   break;
                                case "c": glyph  = "₴";       break;
                                case "d": glyph  = "₺";       break;
                                case "e": glyph  = "₹";       break;
                                case "f": glyph  = "£";       break;
                            }
                        
                        if (before) f = glyph ~ f;
                        else f = f ~ glyph;
                        
                        item = doFormat(f, index);
                        break;
                        
                    case 'o':
                        item = doFormat("%o", index);
                        break;
                        
                    case 'P':
                    
                        if (markerSplitted[1].length == 1)
                            item = to!string(item.to!double * 100) ~ " %";
                        
                        else
                            item = format("%0." ~ markerSplitted[1][1].to!string.to!uint(16).to!string ~ "f %", item.to!double * 100);
                        break;
                        
                    case 'p':
                    
                        if (markerSplitted[1].length == 1)
                            item = to!string(item.to!double * 1000) ~ " ‰";
                        
                        else
                            item = format("%0." ~ markerSplitted[1][1].to!string.to!uint(16).to!string ~ "f ‰", item.to!double * 1000);
                        break;
                        
                    case 'r':
                        item = doFormat("%r",index);
                        break;
                    
                    case 's':
                        item = doFormat("%s",index);
                        break;
                        
                    case 't':
                        
                        item = item ~ " K";
                        
                        if (markerSplitted[1].length == 2)
                        {
                            auto sign = markerSplitted[1][1].to!string.toLower;
                            
                            if (sign == 'c') 
                                item = to!string(item.to!double - 273.15) ~ " °C";
                                
                            else if (sign == 'f')
                                item = to!string(item.to!double * 1.8 - 459.67) ~ " °F";
                        }
                        break;
                        
                    case 'u':
                        item = doFormat("%u",index);
                        break;
                        
                    case 'U':
                        item = item.toUpper;
                        break;
                    
                    case 'x', 'X':
                        item = doFormat("%x",index);
                        break;
                        
                    default: // do nothing
                }
            
            result ~= item;
        }
        
        else result ~= i == 0 ? s[1..$] : s;
    }
    
    return result;
}

void daswrite(Args...)(string source, Args a)
{
    dasformat(source, a).write;
}

void daswriteln(Args...)(string source, Args a)
{
    dasformat(source, a).writeln;
}