local modules = {
    ["Module:languages/data2"] = true,
    ["Module:languages/data3/a"] = true,
    ["Module:languages/data3/b"] = true,
    ["Module:languages/data3/c"] = true,
    ["Module:languages/data3/d"] = true,
    ["Module:languages/data3/e"] = true,
    ["Module:languages/data3/f"] = true,
    ["Module:languages/data3/g"] = true,
    ["Module:languages/data3/h"] = true,
    ["Module:languages/data3/i"] = true,
    ["Module:languages/data3/j"] = true,
    ["Module:languages/data3/k"] = true,
    ["Module:languages/data3/l"] = true,
    ["Module:languages/data3/m"] = true,
    ["Module:languages/data3/n"] = true,
    ["Module:languages/data3/o"] = true,
    ["Module:languages/data3/p"] = true,
    ["Module:languages/data3/q"] = true,
    ["Module:languages/data3/r"] = true,
    ["Module:languages/data3/s"] = true,
    ["Module:languages/data3/t"] = true,
    ["Module:languages/data3/u"] = true,
    ["Module:languages/data3/v"] = true,
    ["Module:languages/data3/w"] = true,
    ["Module:languages/data3/x"] = true,
    ["Module:languages/data3/y"] = true,
    ["Module:languages/data3/z"] = true,
    ["Module:languages/datax"] = true,
}

local m = {}

for mname in pairs(modules) do
    for key, value in pairs(require(mname)) do
        m[key] = value
    end
end

return m