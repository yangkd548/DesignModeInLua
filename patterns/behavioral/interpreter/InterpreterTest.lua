--[[
    module:InterpreterTest
    author:DylanYang
    time:2021-02-12 21:38:44
]]
local FileReader = require("framework.io.FileReader")
local BufferedReader = require("framework.io.BufferedReader")
local ProgramNode = require("patterns.behavioral.interpreter.ProgramNode")
local Context = require("patterns.behavioral.interpreter.Context")

local super = require("patterns.BaseTest")
local _M = Class("InterpreterTest", super)

--Mini language grammar
--[[
    <program> ::= program <command list>
    <command list> ::= <command>* end
    <command> ::= <repeat command> | <primitive command>
    <repeat command> ::= repeat <number> <command list>
    <primitive command> :: go | right | left
]]

--[[
    Node--基类
    ProgramNode--对应Program（一段程序最开头的标记）
    CommandListNode--命令序列容器
    CommandNode--独立 命令（基类）
    RepeatCommandNode--独立的重复命令
    PrimitiveCommandNode--独立的原始命令（go | right | left）

    Context--语法解析的上下文的类
    ParseException--语法解析中的异常处理类
]]

function _M.protected:DoExecTest()
    local filename = string.format("%s.txt", "program")
    local path = string.format("%s/%s", os.GetCurDir(), filename)
    local reader = BufferedReader.new(FileReader.new(path))
    while true do
        local text = reader:ReadLine()
        if text == nil then
            break
        else
            print(string.format("text = \"%s\"", text))
            local node = ProgramNode.new()
            node:Parse(Context.new(text))
            print(string.format("node = %s\n", node:ToString()))
        end
    end
end

return _M