-- Author: Ada Scales
-- CMPM121: Project 1 - Solitaire

require "card"
require "extractJson"

function love.load()
    local json = ExtractJsonClass:new()
    local t = json:extract("cards.json")
    print("Printing colors from returned table")
    for _, value in pairs(t["colors"]) do
        print(value)
    end
end