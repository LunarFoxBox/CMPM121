-- Author: Ada Scales
-- CMPM121: Project 1 - Solitaire

require "card"
require "deck"
require "vector"

function love.load()
    local json = ExtractJsonClass:new()
    local t = json:extract("cards.json")
--    print("Printing colors from returned table")
--    for _, value in pairs(t["color"]) do
--        print(value)
--    end
    local deck = DeckClass:new("cards.json", "standard", 52, Vector(10,10))
    
    for _, card in pairs(deck) do
      print("card:\nColor = " .. tostring(card.color) .. "\nSuit = " .. tostring(card.suit) .. "\nValue = " .. tostring(card.value))
    end
end