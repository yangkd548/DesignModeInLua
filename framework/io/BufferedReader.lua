--[[
    module:BufferedReader
    author:DylanYang
    time:2021-02-16 24:02:33
]]
local _M = Class("BufferedReader")
local public = _M.public

_M.string = nil
_M.lines = nil
_M.lineIndex = 0

function _M:ctor(fileReader)
    self.string =  fileReader.string
end

function public:ReadLine()
    if self.lines == nil then
        self.lines = string.split(self.string, "\n")
    end
    self.lineIndex  = self.lineIndex + 1
    return self.lines[self.lineIndex]
end

return _M