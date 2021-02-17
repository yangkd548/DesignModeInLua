--[[
    module:ProgramNode
    author:DylanYang
    time:2021-02-12 21:44:28
]]
local CommandListNode = require("patterns.behavioral.interpreter.CommandListNode")

local super = require("patterns.behavioral.interpreter.Node")
local _M = Class("ProgramNode", super)
local public = _M.public

_M.cmdListNode = nil

function public:Parse(context)
    context:SkipToken("program")
    self.cmdListNode = CommandListNode.new()
    self.cmdListNode:Parse(context)
end

function public:ToString()
    return string.format("[program%s]", self.cmdListNode:ToString())
end

return _M