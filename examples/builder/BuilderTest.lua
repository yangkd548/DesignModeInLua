--[[
    Module:BuilderTest
    Author:DylanYang
    Time:2021-01-30 22:48:18
]]
local MealBuilder = require("examples.builder.MealBuilder")

local super = require("examples.BaseTest")
local _M = Class("BuilderTest", super)

function _M.protected:DoExecTest()
    local mealBuilder = MealBuilder.new()

    local vegMeal = mealBuilder:PrepareVegMeal()
    print("Veg Meal")
    vegMeal:ShowItems()
    print("Total count: "..vegMeal.count)
    print("Total Cost: "..vegMeal.cost)

    local nonVegMeal = mealBuilder:PrepareNonVegMeal()
    print("\nNon-Veg Meal")
    nonVegMeal:ShowItems()
    print("Total count: "..nonVegMeal.count)
    print("Total Cost: "..nonVegMeal.cost)
end

return _M