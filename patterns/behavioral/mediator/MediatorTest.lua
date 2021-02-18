--[[
    module:MediatorTest
    author:DylanYang
    time:2021-02-18 01:39:56
]]
local ChatRoom = require("patterns.behavioral.mediator.ChatRoom")

local super = require("patterns.BaseTest")
local _M = Class("MediatorTest", super)

function _M.protected:DoExecTest()
    --"Chatroom"(Mediator) can be used to manage people and suppress speech operations.
    local chatRoom = ChatRoom.new()
    local robert = chatRoom:CreateColleague("Robert")
    local john = chatRoom:CreateColleague("John")
    robert:SendMessage("Hi! John!")
    john:SendMessage("Hello! Robert!")
end

return _M