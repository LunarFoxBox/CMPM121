require("extractJson")
CardClass = {}

function CardClass:new(xPos, yPos, color, suit, value)
    local card = {}
    local metatable = {__index = CardClass}
    setmetatable(card, metatable)

    local file = JsonClass:new("cards.json")

    card.position = {
        x = xPos,
        y = yPos
    }
    card.info = {
        
    }
end