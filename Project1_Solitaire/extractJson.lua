-- Recieved debugging help from the professor 
ExtractJsonClass = {}

function ExtractJsonClass:new(fileName)
    -- open and read file
    if type(fileName) ~= "string" then return error("Invalid input!\t- Expected type string") end
    local file = io.open(fileName, "r")
    if file == nil then return error("Could not open file!") end
    local json = file:read("*a")
    print("--- JSON CONETNETS ---\n" .. json)
    
    local indexTable = {
        fieldStart = nil,
        fieldEnd = 1,
        valueStart = nil,
        valueEnd = 1
    }
    local dataTable = {}
    while indexTable.fieldEnd ~= nil do
        -- field itself
        if indexTable.fieldEnd > #json then break end
        indexTable.fieldStart = string.find(json, "\"", indexTable.fieldEnd)
        if indexTable.fieldStart == nil then break end
        indexTable.fieldStart = indexTable.fieldStart + 1 -- Offset for quote marks
        
        _, indexTable.fieldEnd = string.find(json, "\"", indexTable.fieldStart)
        if indexTable.fieldEnd == nil then break end
        
        -- add field to the dataTable
        local field = string.sub(json, indexTable.fieldStart, indexTable.fieldEnd - 1)
        local valueTable = {}
        
        -- field values
        indexTable.valueEnd = string.find(json, ": ", indexTable.fieldEnd)

        while indexTable.valueEnd ~= nil do
            -- parses for the value to insert them
            indexTable.valueStart = string.find(json, "\"", indexTable.valueEnd)
            if indexTable.valueStart == nil then break end
            indexTable.valueStart = indexTable.valueStart + 1 -- offset for quote marks
            _, indexTable.valueEnd = string.find(json, "\"", indexTable.valueStart)
            if indexTable.valueEnd == nil then break end

            -- insert the values into the dataTable's sub table
            local value = string.sub(json, indexTable.valueStart, indexTable.valueEnd - 1)
            table.insert(valueTable, value)
            
            -- Move to next element and if the eleemnt indicates end then break
            indexTable.valueEnd = indexTable.valueEnd + 1
            if string.find(json, "]", indexTable.valueEnd - 1) == indexTable.valueEnd then break end
        end
        dataTable[field] = valueTable
        indexTable.fieldEnd = indexTable.valueEnd
    end
    print("Extraction complete")
    for field, values in pairs(dataTable) do
      print("Field: " .. tostring(field) .. "\nValues:")
      for _, value in pairs(values) do
        print(value)
      end
    end
end
