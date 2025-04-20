require("extractJson")
CardClass = {}

function CardClass:new(xPos, yPos, info, values)
    local card = {}
    local metatable = {__index = CardClass}
    setmetatable(card, metatable)

    card.position = {
        x = xPos,
        y = yPos
    }
    for fields, _ in pairs(info) do
      local f = "card." .. tostring(fields) .. " = " .. tostring("nil")
      load(f)
    end
    return card
end