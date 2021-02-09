--[[
    module:AndCriteria
    author:DylanYang
    time:2021-02-09 14:26:51
]]
local super = require("patterns.structural.filter.Criteria")
local _M = Class("AndCriteria", super)

_M.criteria = nil
_M.otherCriteria = nil

function _M:ctor(criteria, otherCriteria)
    self.criteria = criteria
    self.otherCriteria = otherCriteria
end

function _M.public:MeetCriteria(persons)
    local results = self.criteria:MeetCriteria(persons)
    return self.otherCriteria:MeetCriteria(results)
end

return _M