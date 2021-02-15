--[[
    module:InterpreterTest
    author:DylanYang
    time:2021-02-12 21:38:44
]]
local FileReader = require("framework.io.FileReader")
local ProgramNode = require("patterns.behavioral.interpreter.ProgramNode")
local Context = require("patterns.behavioral.interpreter.Context")
local BufferedReader = require("framework.io.BufferedReader")

local super = require("patterns.BaseTest")
local _M = Class("InterpreterTest", super)

function _M.protected:DoExecTest()
    --@TODO 需要开发BuffereReader工具类
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
            print(string.format("node = %s", node:ToString()))
        end
    end
end

return _M