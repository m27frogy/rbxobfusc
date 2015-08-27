#!/usr/bin/env lua

--[[
 Copyright (c) 2015 Mfrogy Starmade
 
 Permission is hereby granted, free of charge, to any person obtaining
 a copy of this software and associated documentation files (the
 "Software"), to deal in the Software without restriction, including
 without limitation the rights to use, copy, modify, merge, publish,
 distribute, sublicense, and/or sell copies of the Software, and to
 permit persons to whom the Software is furnished to do so, subject to
 the following conditions:
 
 The above copyright notice and this permission notice shall be included
 in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
 CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
]]


-- Sloppy, I know.  WHO CARES!!!! :D


require'XFuscator.init'

function Parse(section)
	local result, msg = XFuscator.XFuscate(section, 1, 1, false, false, false, false, true, false, false)
	if not result then
		error(msg)
	else
		return string.gsub(result,"%]%]>","]]]]><![CDATA[>")
	end
end

function SearchAndDestroy(object)
	local start,ending = string.find(object,"<ProtectedString.-><!%[CDATA%[.-%]%]>")
	if start then
		local string_begin,string_end = string.find(string.sub(object,start,ending),"<ProtectedString.->")
		string_begin = string_begin + start
		string_end = string_end + start
		
		local result = Parse(string.sub(object,string_end+9,ending-3))
		if result then
			return ending,(string.sub(object,1,string_end+8))..result.."]]>" --..(string.sub(object,ending-3,string.len(object)))
		end
	end
end

function GetFileSize(name)
	local f = assert(io.open(name,"r"))
	
	local current = f:seek()
	local size = f:seek("end")
	
	f:close()
	return math.floor(size / 1000)
end

print("------rbxobfusc------")
print("Lua Version:		".._VERSION)
if _VERSION ~= "Lua 5.2" then
	print("WARNING:			rbxobfusc is designed for 5.2!")
end
print("Input:			"..arg[1])
local oio = arg[2]
if not oio then
	oio = "output.rbxlx"
end
io.output(oio)
print("Output:			"..oio)
print("------rbxobfusc------")

local t1 = os.time()

io.input(arg[1])
local contents = io.read("*all")

local output = ""
local section = contents
local ending, result = SearchAndDestroy(section)
while ending and result do
	output = output..result
	section = string.sub(section,ending+1,string.len(section))
	ending, result = SearchAndDestroy(section)
end
output = output..section

io.write(output)

print("\n")
print("Size Increase:		"..tostring(GetFileSize(oio) - GetFileSize(arg[1])).." KBs")
print("Time taken:		"..tostring(os.time() - t1).." seconds")
