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
        _, indexTable.fieldEnd = string.find(json, "\"", indexTable.fieldStart + 1)

        -- add field to the dataTable
        local field = string.sub(json, indexTable.fieldStart, indexTable.fieldEnd - 1)

        -- field values
        indexTable.valueEnd = string.find(json, ": ", indexTable.fieldEnd)
        while field ~= nil do
            -- parses for the value to insert them
            indexTable.valueStart = string.find(json, "\"", indexTable.valueEnd)
            if indexTable.valueStart == nil then break end
            _, indexTable.valueEnd = string.find(json, "\"", indexTable.valueStart + 1)
            if indexTable.valueEnd == nil then break end

            -- insert the values into the dataTable's sub table
            local value = string.sub(json, indexTable.valueStart, indexTable.valueEnd - 1)
            dataTable[field] = value
        end
        print(#dataTable)
        for i, v in pairs(dataTable) do
            print(tostring(i))
        end
    end
    print("Extraction complete")
end
