module dasfor;
import std.conv;
import std.stdio;
import std.regex;
import std.array;
import std.string;
import std.typecons : Yes;

package
{
    enum romanFives = "vld", romanUnits = "ixcm";
    
    auto toRoman(char letter, bool isLowerCase = false, bool useG = true)
    {
        letter = cast(char)letter.toLower;
        
        switch (letter)
        {
            case 'j':            letter = 'i'; break;
            case 'u', 'w':       letter = 'v'; break;
            case 'g': if (!useG) letter = 'c'; break;
            default: break;
        }
        
        return isLowerCase ? letter : cast(char)letter.toUpper;
    }
    
    auto buildRomanUnits(int num, byte level)
    {
        string result;
        
        for (int i; i < num; ++i)
            result ~= romanUnits[level];
            
        return result;
    }
    
    auto buildRomanNumerals(int num, byte level)
    {
        switch (num)
        {
            case 0: return "";
            case 9: return romanUnits[level] ~ romanUnits[level + 1];
            case 5: return romanFives[level];
            case 4: return romanUnits[level] ~ romanFives[level];
            
            default:
                
                if (num > 5)
                    return romanFives[level] ~ BuildRomanUnits(num - 5, level);
                    
                return buildRomanUnits(num, level);
        }
    }
}

auto toRoman(int num, bool isLowerCase = false, bool useJ = false)
{
    string result;
    
    if (num > 4999 || num < 0) result = "?";
    else if (num == 0) result = "nulla";
    
    else
    {
        
    }
    
    return isLowerCase ? result : result.toUpper;
}

auto toRoman(string word, bool isLowerCase = false, bool useG = true)
{
    string result;
    
    foreach (l; word) 
        result ~= l.toRoman(isLowerCase, useG);
    
    return result;
}

/*
auto romformat(string source, uint[] args ...)
{
    auto result = "", 
         pattern = `\$[0-9]+:?(j|c|C)?(m|a|p|d|A|C|v|V)`,
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
*/

auto romformat(string source, string[] args ...)
{
    auto result = "", 
         pattern = `\$[0-9]+:c?g?`,
         splitted = source.splitter!(Yes.keepSeparators)(pattern.regex);
         
    foreach (s; splitted)
    {
        if (s.matchFirst(regex("^" ~ pattern ~ "$")))
        {
            auto codes = s.split(":");
            enum m = "args[codes[0][1..$].to!uint]";
            
            switch(codes[1].length)
            {
                case 2:
                
                    result ~= mixin(m).toRoman(false);
                    break;
                    
                case 1:
                    
                    if (codes[1] == "c")
                        result ~= mixin(m).toRoman(false, false);
                        
                    else
                        result ~= mixin(m).toRoman(true);
                    
                    break;
                    
                default: result ~= mixin(m).toRoman(true, false);
            }
        }
        
        else result ~= s;
    }
    
    return result;
}

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
    
    "This $0:g's price will be $1:c and $1:cg, but of $0: quality"
    .romformat("good", "greatly overvalued")
    .writeln;
}
