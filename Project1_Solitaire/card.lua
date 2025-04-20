require("extractJson")
CardClass = {}

function CardClass:new(xPos, yPos, info)
    local card = {}
    local metatable = {__index = CardClass}
    setmetatable(card, metatable)

    card.position = {
        x = xPos,
        y = yPos
    }
    -- Adds the fields to the card based on provided info
    for fields, _ in pairs(info) do
      local insertField = "card." .. tostring(fields) .. " = nil"
      load(insertField)
    end
    return card
end