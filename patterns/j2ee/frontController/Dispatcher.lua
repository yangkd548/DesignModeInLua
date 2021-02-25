--[[
    module:  Dispatcher
    author:  DylanYang
    time:    2021-02-25 24:25:21
	idea:    
	advance: 
]]
local StudentView = require("patterns.j2ee.frontController.StudentView")
local HomeView = require("patterns.j2ee.frontController.HomeView")

local _M = Class("Dispatcher")
local public = _M.public

_M.studentView = nil
_M.homeView = nil

function _M:ctor()
    self.studentView = StudentView.new()
    self.homeView = HomeView.new()
end

function public:Dispatch(request)
    if string.upper(request) == "STUDENT" then
        self.studentView:Show()
    else
        self.homeView:Show()
    end
end

return _M