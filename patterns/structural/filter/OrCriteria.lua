--[[
    module:OrCriteria
    author:DylanYang
    time:2021-02-09 14:33:57
]]
local super = require("patterns.structural.filter.Criteria")
local _M = Class("OrCriteria", super)

_M.criteria = nil
_M.otherCriteria = nil

function _M:ctor(cirteria, otherCirteria)
    self.criteria = cirteria
    self.otherCriteria = otherCirteria
end

function _M.public:MeetCriteria(persons)
    local firstPersons = self.criteria:MeetCriteria(persons)
    local otherPersons = self.otherCriteria:MeetCriteria(persons)
    for i, v in pairs(otherPersons) do
        if not table.indexof(firstPersons, v) then
            table.insert(firstPersons, v)
        end
    end
    return firstPersons
end

return _M