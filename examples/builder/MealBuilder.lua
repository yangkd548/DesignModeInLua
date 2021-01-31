--[[
    Module:MealBuilder
    Author:DylanYang
    Time:2021-01-30 22:43:14
]]
local Meal = require("examples.builder.Meal ")
local VegBurger = require("examples.builder.VegBurger")
local Coke = require("examples.builder.Coke")
local ChickenBurger = require("examples.builder.ChickenBurger")
local Pepsi = require("examples.builder.Pepsi")

local _M = Class("MealBuilder")
local public = _M.public

function public:PrepareVegMeal()
    local meal = Meal.new()
    meal:AddItem(VegBurger.new())
    meal:AddItem(Coke.new())
    return meal
end

function public:PrepareNonVegMeal()
    local meal = Meal.new()
    meal:AddItem(ChickenBurger.new())
    meal:AddItem(Pepsi.new())
    return meal
end

return _M