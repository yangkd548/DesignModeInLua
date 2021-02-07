--[[
    Module:
    Author:DylanYang
    Date: 2021-01-27 19:53:58
]]
local _M = Class("BaseTest")
_M.abstract = true

_M.static.private.startFormatStr = "\n%s. -------------------------%s-------------------------\n"
_M.static.private.endFormatStr = _M.startFormatStr.."\n"
_M.static.private.count = 0
_M.private.uid = nil

function _M.private:ctor()
    self.count = self.count + 1
    self.uid = self.count
end

function _M.public:ExecTest()
    self:PrintStartLine(true)
    self:DoExecTest()
    self:PrintEndLine()
end

function _M.protected:DoExecTest()
end

function _M.private:PrintStartLine(isFront)
    print(string.format(self.startFormatStr, self.uid, self.__name))
end

function _M.private:PrintEndLine(isFront)
    print(string.format(self.endFormatStr, self.uid, self.replaceName))
end

function _M.private.get:replaceName()
    local result = "end"
    local count = #self.__name - #result
    for i = 1, count do
        if i % 2 == 0 then
            result = result.."-"
        else
            result = "-"..result
        end
    end
    return result
end

return _M