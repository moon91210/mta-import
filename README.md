# mta-import

A substitute for the native lua require for Multi Theft Auto. This allows you to import modules from other resources.

# how to use

SomeResource utils file:
```lua
local utils = {}

function utils.capitalize(str)
    return str:sub(1,1):upper()..str:sub(2)
end

function utils.constrain(num, low, high)
	return math.max(math.min(num, high), low)
end

return utils
```

MyResource:
```lua
loadstring(exports.import:load())()

local utils = import('SomeResource/utils.lua')

print(utils.capitalize('hello')) --> Hello
```
