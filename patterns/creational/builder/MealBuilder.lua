--[[
    Module:MealBuilder
    Author:DylanYang
    Time:2021-01-30 22:43:14
]]
local Meal = require("patterns.creational.builder.Meal ")
local VegBurger = require("patterns.creational.builder.VegBurger")
local Coke = require("patterns.creational.builder.Coke")
local ChickenBurger = require("patterns.creational.builder.ChickenBurger")
local Pepsi = require("patterns.creational.builder.Pepsi")

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