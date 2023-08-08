module dasfor;
import std.stdio;
import core.vararg;
import std.std.regex;

auto dasformat(string source, ...)
{
    import std.typecons : Yes;
    
    auto result = "", 
         pattern = `\$[0-9]+`.regex, 
         splitted = source.splitter!(Yes.keepSeparators)(pattern);
    
    foreach (s; splitted)
    {
        result
    }
    
    return result;
}

void main()
{
    writeln("Edit source/app.d to start your project.");
}
