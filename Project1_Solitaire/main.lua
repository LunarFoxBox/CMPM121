-- Author: Ada Scales
-- CMPM121: Project 1 - Solitaire

require "card"
require "extractJson"

function love.load()
    local json = ExtractJsonClass:new()
    json:extract("cards.json", true)
end