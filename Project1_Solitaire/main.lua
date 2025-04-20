-- Author: Ada Scales
-- CMPM121: Project 1 - Solitaire

require "card"
require "deck"
require "vector"

function love.load()
    local json = ExtractJsonClass:new()
    local t = json:extract("cards.json", true)
--    print("Printing colors from returned table")
--    for _, value in pairs(t["color"]) do
--        print(value)
--    end
    local deckData = DeckClass:new("cards.json", "standard")
    deck = deckData:generateDeck(Vector(10,10), 52)
    for _, card in pairs(deck) do
      print("card:\nColor = " .. tostring(card.color) .. "\nSuit = " .. tostring(card.suit) .. "\nValue = " .. tostring(card.value))
    end
end