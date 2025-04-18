-- Author: Ada Scales
-- CMPM121: Project 1 - Solitaire

require "card"
require "extractJson"

function love.load()
    ExtractJsonClass:new("cards.json")
end