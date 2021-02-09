--[[
    module:FilterTest
    author:DylanYang
    time:2021-02-09 14:14:40
]]
local Person = require("patterns.structural.filter.Person")
local CriteriaMale = require("patterns.structural.filter.CriteriaMale")
local CriteriaFemale = require("patterns.structural.filter.CriteriaFemale")
local CriteriaSingle = require("patterns.structural.filter.CriteriaSingle")
local AndCriteria = require("patterns.structural.filter.AndCriteria")
local OrCriteria = require("patterns.structural.filter.OrCriteria")

local super = require("patterns.BaseTest")
local _M = Class("FilterTest", super)

function _M.protected:DoExecTest()
    local persons = {}
    table.insert(persons, Person.new("Robert", Person.GenderType.Male, Person.MaritalType.Single))
    table.insert(persons, Person.new("John", Person.GenderType.Male, Person.MaritalType.Married))
    table.insert(persons, Person.new("Laura", Person.GenderType.Female, Person.MaritalType.Married))
    table.insert(persons, Person.new("Diana", Person.GenderType.Female, Person.MaritalType.Single))
    table.insert(persons, Person.new("Mike", Person.GenderType.Male, Person.MaritalType.Single))
    table.insert(persons, Person.new("Bobby", Person.GenderType.Male, Person.MaritalType.Single))

    local male = CriteriaMale.new()
    local female = CriteriaFemale.new()
    local single = CriteriaSingle.new()
    local singleMale = AndCriteria.new(single, male)
    local singleOrFemale = OrCriteria.new(single, female)

    print("Males:")
    self:PrintPersons(male:MeetCriteria(persons))

    print("\nFemales:")
    self:PrintPersons(female:MeetCriteria(persons))

    print("\nSingle Males:")
    self:PrintPersons(singleMale:MeetCriteria(persons))

    print("\nSingle Or Females:")
    self:PrintPersons(singleOrFemale:MeetCriteria(persons))
end

function _M:PrintPersons(persons)
    for i, v in pairs(persons) do
        print(string.format("Persons:[ Name : %s, Gender : %s, Marital : %s ]", v.name, v.gender, v.marital))
    end
end

return _M