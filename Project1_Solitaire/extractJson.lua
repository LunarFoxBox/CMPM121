-- Author: Ada Rose Scales
-- CMPM 121 - Project 1, Solitaire


-- Recieved debugging help from the professor 

ExtractJsonClass = {}

function ExtractJsonClass:new()
  local jsonExtract = {}
  local metatable = {__index = ExtractJsonClass}
  setmetatable(jsonExtract, metatable)
  return jsonExtract
end

-- return string of file
local function fileString(fileName, debug)
  if type(fileName) ~= "string" then return error("Invalid input!\t- Expected type string") end
  local file = io.open(fileName, "r")
  if file == nil then return error("Could not open file!") end
  local json = file:read("*a")
  if debug then print("--- JSON CONETNETS ---\n" .. json) end
  return json
end

-- Print contents of table for debugging
local function debugPrint(fieldTable)
  for field, values in pairs(fieldTable) do
    print("Field: " .. tostring(field))
    for _, value in pairs(values) do
      print("\t\t" .. value)
    end
  end
end


-- Extracts json data into a table
-- arg1 = name of file, arg2 if in debug mode (default false)
function ExtractJsonClass:extract(fileName, debug)
  local json = fileString(fileName, debug)
  local jsonTable = {}
  local indexTable =
  {
    fieldStart = nil,
    fieldEnd = 1,
    valueStart = nil,
    valueEnd = 1
  }
  if debug then print("--- Starting Extraction ---") end
  
  
  while indexTable.fieldEnd ~= nil do
    -- parse for the field
    indexTable.fieldStart = string.find(json, "\"", indexTable.fieldEnd)
    if indexTable.fieldStart == nil then break end
    indexTable.fieldStart = indexTable.fieldStart + 1 -- Offset for quote marks

    _, indexTable.fieldEnd = string.find(json, "\"", indexTable.fieldStart)
    if indexTable.fieldEnd == nil then break end

    -- get field
    local field = string.sub(json, indexTable.fieldStart, indexTable.fieldEnd - 1)
    local valueTable = {}

    -- field values
    indexTable.valueEnd = string.find(json, ": ", indexTable.fieldEnd)
    while indexTable.valueEnd ~= nil do
      -- parses for the values
      indexTable.valueStart = string.find(json, "\"", indexTable.valueEnd)
      if indexTable.valueStart == nil then break end
      indexTable.valueStart = indexTable.valueStart + 1 -- offset for quote marks
      
      _, indexTable.valueEnd = string.find(json, "\"", indexTable.valueStart)
      if indexTable.valueEnd == nil then break end

      -- insert the values into the jsonTable's sub table
      local value = string.sub(json, indexTable.valueStart, indexTable.valueEnd - 1)
      table.insert(valueTable, value)

      -- Move to next element and if the eleemnt indicates end then break
      indexTable.valueEnd = indexTable.valueEnd + 1
      if string.find(json, "]", indexTable.valueEnd - 1) == indexTable.valueEnd then break end
    end
    
    -- Add field and values into table
    jsonTable[field] = valueTable
    indexTable.fieldEnd = indexTable.valueEnd
  end


  if debug then
    debugPrint(jsonTable)
    print("--- Extraction Complete ---")
  end
  return jsonTable
end

