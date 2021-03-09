local cacheStr = nil
local tab = "\t"
local tabs = nil
local tabCount = 0

local rawPrint = print

local function printCache()
    local temp = cacheStr
    cacheStr = nil
    rawPrint(temp)
end

local function doPrint(...)
    if cacheStr then
        printCache()
    end
    local args = {...}
    if #args == 0 then
        rawPrint("")
    else
        local temps = {}
        for i,v in ipairs(args) do
            table.insert(temps, v and IsTable(v) and v.ToString and v:ToString() or v)
        end
        rawPrint(unpack(temps))
    end
end

function print(...)
    tabs = nil
    doPrint(...)
end

function println(...)
    doPrint(...)
end

local function printf(args)
    local f = table.remove(args, 1)
    if f then
        if IsString(f) then
            local ss = string.split(f, "\n")
            if #ss > 1 then
                for i,v in ipairs(ss) do
                    --避免v是nil
                    v = v or ""
                    println(tabs..v)
                end
                if #args > 1 then
                    println(unpack(args))
                end
            else
                if #args > 1 then
                    println(tabs..f, unpack(args))
                else
                    println(tabs..f)
                end
            end
        elseif IsTable(f) then
            println(tabs..(f.ToString and f:ToString() or tostring(f)), unpack(args))
        end
    else
        println("nil", unpack(args))
    end
end

function printlt(...)
    local args = {...}
    tabs = tabs == nil and tab or tabs..tab
    if #args > 0 then
        printl(...)
    end
end

function printlb(...)
    local args = {...}
    if not string.isempty(tabs) then
        if #tabs == 1 then
            tabs = nil
        else
            tabs = string.sub(tabs, -#tabs + 1)
        end
    end
    if #args > 0 then
        printl(...)
    end
end

function printl(...)
    local args = {...}
    if #args == 0 then
        --Don't reset 'tabs', don't print 'tabs', just print a blank line.
        doPrint()
    else
        tabs = tabs or ""
        printf(args)
    end
end

function prints(str, todo)
    cacheStr = cacheStr and (cacheStr..str) or str
    if todo then
        printCache()
    end
end

--@TODO print相关扩展 说明：
--printlt   增加缩进，并进行打印
--printlb   减少缩进，并进行打印
--printl    保持缩进，并进行打印
--print     常规打印，重置缩进
--println   常规打印，不重置缩进
--prints    缓存打印，第二个参数，表示是否输出