# rbxobfusc
Obfuscates RBXML script contents into an extremely confusing format.
It uses a variety of simple methods (junk methods, junk comments, scrambled reference names, scrambled strings, byte encoded version of strings, etc...)

Thanks to mlnlover11 for XFuscator!

### Syntax
> `lua5.2 rbxobfusc.lua <input_file> [output_file]`

### Warnings
1.  Only runs on Lua 5.2 to my knowledge.
2.  getfenv() and setfenv() are unlikely to work.
3.  If you are stupid enough to overwrite your old file, there's nothing I or anyone else can do to retrieve your source.  You've been warned!
