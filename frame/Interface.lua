--[[
    Module:Interface
    Author:DylanYang
    Time:2020-11-12 12:02:18
]]
local function ErrorNameFront(name, level)
    error(string.format("The front of name (%s) is not 'I'(capital i).", name), level or 3)
end

--名字必须为：大写“I”开头
local function CheckName(name)
    return string.find(name, "I") == 1
end

--@TODO 2020-11-12 12:13:37 Interface目标，记录必须的public成员（属性、方法、事件<后续再扩展>）

function Interface(name)
    if not CheckName(name) then
        ErrorNameFront(name)
    end
    --@TODO 2020-11-12 12:15:30 需要设置一个代理
    --@TODO 2020-11-12 12:15:50 代理用于定义结构（记录成员）（只记录名字，没有数值）
    --@TODO 2020-11-12 12:16:38 可以只允许读取（__index），用读取当时来定义成员（禁止写入__newindex）
    --@TODO 2020-11-12 12:18:26 Interface允许继承结构
    --@TODO 2020-11-12 12:18:45 需要在Class中，实现Interface的兑现检查功能（包含递归检查Interface的继承结构的兑现）
    --@TODO 2020-11-12 12:20:18 需要在Class中，实现虚拟类abstract类型的Class，具备跟Interface一样的“定义结构”功能

    --@TODO 2020-11-12 14:18:18 覆盖系统的require一个Class时，如果其实现了一个Interface，则需要检测是否定义了所有的Interface成员
    local interface = {name = name}
    return interface
end