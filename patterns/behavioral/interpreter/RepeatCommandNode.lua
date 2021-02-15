--[[
    module:RepeatCommandNode
    author:DylanYang
    time:2021-02-12 21:44:37
]]
local CommamdListNode = require("patterns.behavioral.interpreter.CommandNode")

local super = require("patterns.behavioral.interpreter.Node")
local _M = Class("RepeatCommandNode", super)
local public = _M.public

_M.number = nil
_M.cmdListNode = nil

function public:Parse(context)
    context:SkipToken("repeat")
    self.number = context.curToken
    context:NextToken()
    self.cmdListNode = CommamdListNode.new()
end

function public:ToString()
    return string.format("[repeat %s %s]", self.number, self.cmdListNode:ToString())
end

return _M