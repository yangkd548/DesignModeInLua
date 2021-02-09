--[[
    module:FacadeTest
    author:DylanYang
    time:2021-02-09 18:29:47
]]
local super = require("patterns.BaseTest")
local _M = Class("FacadeTest", super)

function _M.protected:DoExecTest()
    -- PageMaker.makeWelcomePage("hyuki@hyuki.com", "welcome.html");
end

return _M