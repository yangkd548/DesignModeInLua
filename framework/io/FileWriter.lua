--[[
    module:FileWriter
    author:DylanYang
    time:2021-02-09 22:16:58
]]
local _M = Class("FileWriter")
local public = _M.public

_M.file = nil

function _M:ctor(path)
    self.file = io.open(path, "w")
end

function public:Write(str)
    self.file:write(str)
end

function public:Close()
    self.file:close()
end

return _M