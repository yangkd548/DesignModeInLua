--[[
    module:  FrontController
    author:  DylanYang
    time:    2021-02-25 24:29:21
	idea:    
	advance: 
]]
local Dispatcher = require("patterns.j2ee.frontController.Dispatcher")

local _M = Class("FrontController")
local public = _M.public

_M.dispatcher = nil

function _M:ctor()
    self.dispatcher = Dispatcher.new()
end

function _M:IsAuthenticUser()
    print("User is authenticated successfully.")
    return true
end

function _M:TrackRequest(request)
    print("Page requested: " .. request)
end

function public:DispatchRequest(request)
    --记录每一个请求
    self:TrackRequest(request)
    --对用户进行身份验证
    if self:IsAuthenticUser() then
        self.dispatcher:Dispatch(request)
    end
    print()
end

return _M