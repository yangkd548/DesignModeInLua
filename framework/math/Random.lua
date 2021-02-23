--[[
    module:  Random
    author:  DylanYang
    time:    2021-02-21 24:51:13
	idea:    
	advance: 
]]
local _M = {}

function _M.nextBoolean()
    return math.random() > 0.5
end

function _M.nextInt(n, m)
    if m == nil then
        if n == nil then
            error("Provide one argument at least in random.nextInt(n,[m])")
        end
        return math.random(n)
    else
        return math.random(n, m)
    end
end

function _M.nextFloat(n, m)
    if m == nil then
        return math.random() * (n or 1)
    else
        return n + math.random() * m
    end
end

random = Readonly(_M)