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
    while true do
        if context.curToken == nil then
            Error("Missing 'end'")
        elseif context.curToken == "end" then
            context:SkipToken("end")
        else
            local cmdNode = CommandNode.new()
        end
    end
end

return _M