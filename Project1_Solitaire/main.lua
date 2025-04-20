-- Author: Ada Scales
-- CMPM121: Project 1 - Solitaire

require "board"
require "deck"
require "vector"

SOLITAIRE =
{
  WIDTH = 1400,
  HEIGHT = 1000,
  RGB = {0.3, 0.7, 0.1},
  ALPHA = 1,
  DRAW_POS = Vector(100, 50),
  OFFSET = 100,
  DRAW_NUM = 3,
  ZONE_SIZE = Vector(75, 120),
  DECK_SIZE = 52
}

function love.load()
  Board = BoardClass:new(SOLITAIRE.WIDTH, SOLITAIRE.HEIGHT, SOLITAIRE.RGB, SOLITAIRE.ALPHA)
  
  Deck = DeckClass:new("cards.json", SOLITAIRE.DECK_SIZE, SOLITAIRE.DRAW_POS)
  Deck:generate()
  print("--- Generated Deck ---")
  print("Length = " .. tostring(#Deck:getDeck()))
  for i, card in pairs(Deck:getDeck()) do
    print("card:\t" .. tostring(i) .. "\nColor:\t" .. tostring(card.color) .. "\nSuit:\t" .. tostring(card.suit) .. "\nValue:\t" .. tostring(card.value) .. "\n")
  end
end


function love.draw()
  Board:solitaire(SOLITAIRE.DRAW_POS, SOLITAIRE.OFFSET, SOLITAIRE.DRAW_NUM, SOLITAIRE.ZONE_SIZE)
  for _, card in pairs(Deck:getDeck()) do
    card:draw()
  end
end