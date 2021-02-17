--[[
    module:CommandListNode
    author:DylanYang
    time:2021-02-12 21:43:04
]]
local CommandNode = require("patterns.behavioral.interpreter.CommandNode")

local _M = Class("CommandListNode")
local public = _M.public

_M.list = {}

function public:Parse(context)
    local i = 0
    while true do
        if context.curToken == nil then
            Error("Missing 'end'")
        elseif context.curToken == "end" then
            context:SkipToken("end")
            break
        else
            i = i + 1
            local cmdNode = CommandNode.new()
            cmdNode:Parse(context)
            table.insert(self.list, cmdNode)
        end
    end
end

function public:ToString()
    local str = "["
    for i, v in pairs(self.list) do
        str = string.format("%s%s%s", str, i == 1 and "" or ", ", v:ToString())
    end
    str = str.."]"
    return str
end

return _M