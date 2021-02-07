--[[
    module:IElecAppBridge
    author:DylanYang
    time:2021-02-07 20:15:44
]]
local _M = Class("IElecAppBridge")

_M.protected.runApi = nil

function _M:ctor(runApi)
    self.runApi = runApi
end

function _M.public:AutoRun()
end

return _M