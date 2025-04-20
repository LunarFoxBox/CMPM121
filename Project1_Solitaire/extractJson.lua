-- Author: Ada Rose Scales
-- CMPM 121 - Project 1, Solitaire


-- Recieved debugging help from the professor 

ExtractJsonClass = {}

function ExtractJsonClass:new()
  local jsonExtract = {}
  jsonExtract.indexTable =
  {
    fieldStart = nil,
    fieldEnd = 1,
    valueStart = nil,
    valueEnd = 1
  }
  local metatable = {__index = ExtractJsonClass}
  setmetatable(jsonExtract, metatable)
  return jsonExtract
end

-- return string of file
local function fileString(fileName)
  if type(fileName) ~= "string" then return error("Invalid input!\t- Expected type string") end
  local file = io.open(fileName, "r")
  if file == nil then return error("Could not open file!") end
  local json = file:read("*a")
  print("--- JSON CONETNETS ---\n" .. json)
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
  local json = fileString(fileName)
  local jsonTable = {}
  if debug then print("--- Starting Extraction ---") end
  while self.indexTable.fieldEnd ~= nil do
    -- field itself
    if self.indexTable.fieldEnd > #json then break end
    self.indexTable.fieldStart = string.find(json, "\"", self.indexTable.fieldEnd)
    if self.indexTable.fieldStart == nil then break end
    self.indexTable.fieldStart = self.indexTable.fieldStart + 1 -- Offset for quote marks

    _, self.indexTable.fieldEnd = string.find(json, "\"", self.indexTable.fieldStart)
    if self.indexTable.fieldEnd == nil then break end

    -- add field to the jsonTable
    local field = string.sub(json, self.indexTable.fieldStart, self.indexTable.fieldEnd - 1)
    local valueTable = {}

    -- field values
    self.indexTable.valueEnd = string.find(json, ": ", self.indexTable.fieldEnd)

    while self.indexTable.valueEnd ~= nil do
      -- parses for the value to insert them
      self.indexTable.valueStart = string.find(json, "\"", self.indexTable.valueEnd)
      if self.indexTable.valueStart == nil then break end
      self.indexTable.valueStart = self.indexTable.valueStart + 1 -- offset for quote marks
      _, self.indexTable.valueEnd = string.find(json, "\"", self.indexTable.valueStart)
      if self.indexTable.valueEnd == nil then break end

      -- insert the values into the jsonTable's sub table
      local value = string.sub(json, self.indexTable.valueStart, self.indexTable.valueEnd - 1)
      table.insert(valueTable, value)

      -- Move to next element and if the eleemnt indicates end then break
      self.indexTable.valueEnd = self.indexTable.valueEnd + 1
      if string.find(json, "]", self.indexTable.valueEnd - 1) == self.indexTable.valueEnd then break end
    end
    jsonTable[field] = valueTable
    self.indexTable.fieldEnd = self.indexTable.valueEnd
  end

  if debug then
    debugPrint(jsonTable)
    print("--- Extraction Complete ---")
  end
  return jsonTable
end

