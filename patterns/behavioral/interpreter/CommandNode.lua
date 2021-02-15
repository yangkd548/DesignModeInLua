--[[
    module:CommandNode
    author:DylanYang
    time:2021-02-12 21:43:15
]]
local RepeatCommandNode = require("patterns.behavioral.interpreter.RepeatCommandNode")
local PrimitiveCommandNode = require("patterns.behavioral.interpreter.PrimitiveCommandNode")

local super = require("patterns.behavioral.interpreter.Node")
local _M = Class("CommandNode", super)
local public = _M.public

_M.node = nil

function public:Parse(context)
    if context.curToken =="repeat" then
        self.node = RepeatCommandNode.new()
        self.node:Parse(context)
    else
        self.node = PrimitiveCommandNode.new()
        self.node:Parse(context)
    end
end

function public:ToString()
    return self.node:ToString()
end

return _M