--[[
    module:StringDisplayImpl
    author:DylanYang
    time:2021-02-09 11:14:59
]]
local super = require("patterns.structural.bridge.DisplayImpl")
local _M = Class("StringDisplayImpl", super)
local public = _M.public
local private = _M.private

private.str = nil
private.width = nil

function _M:ctor(str)
    self.str = str
    self.width = #str
end

function public:RawOpen()
    self:PrintLine()
end

function public:RawPrint(index)
    print(string.format("|%s|\t%s", self.str, index or ""))
end

function public:RawClose()
    self:PrintLine(true)
end

function private:PrintLine(isClose)
    local str = "+"
    for i = 1, self.width do
        str = str.."-"
    end
    print(str.."+")
    if isClose then
        print("")
    end
end


return _M