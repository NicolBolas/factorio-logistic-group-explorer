local util = {}

-- Find the index of an element in the table.
---@param table table
---@param element string
---@return uint32
function util.find(table, element)
  for index, value in pairs(table) do
    if value == element then
      return index
    end
  end
  return 0
end

local suffix_list = {
  G = 10 ^ 9,
  M = 10 ^ 6,
  k = 10 ^ 3,
}

-- Convert an integer into a magnitude unit-based string, to keep the string
-- size at 5 characters max.
--
-- The core/lualib/util.lua function does not match what the circuit and
-- logistic systems do.
-- Factorio does not support localized number separators.
-- Always display negative sign.
-- Always display unit if above 999, truncating.
-- Always display 2 digits if truncated number above 99, otherwise 3.
---@param amount int32
---@return string
function util.format_number(amount)
  local suffix = ""
  for letter, limit in pairs(suffix_list) do
    if math.abs(amount) >= limit then
      amount = amount / limit
      suffix = letter
      break
    end
  end
  if suffix ~= "" then
    return string.format("%." .. (math.abs(amount) < 10.0 and 1 or 0) .. "f", amount) .. suffix
  end
  return tostring(amount)
end


--Logistic group type definitions for drop-down list.
local group_types = {
  {
    display_name = "Logistics",
    define = defines.logistic_group_type.with_trash,
  },
  {
    display_name = "Roboport",
    define = defines.logistic_group_type.roboport,
  },
}

util.group_types = group_types

--For debugging. Should be commented out on release.
local function internal_debug_print(msg)
    game.print(msg, {
        skip = defines.print_skip.never,
        game_state = false,
      })
end

--For release. Should be commented out when debugging.
--local function internal_debug_print() end

function util.debug_print(msg)
  internal_debug_print(msg)
end


return util
