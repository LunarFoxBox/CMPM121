-- Author: Ada Scales
-- CMPM121: Project 1 - Solitaire

require "board"
require "deck"
require "vector"

BOARD =
{
  WIDTH = 1400,
  HEIGHT = 1000,
  RGB = {0.3, 0.7, 0.1},
  ALPHA = 1,
  DRAW_POS = Vector(100, 50),
  OFFSET = 100,
  DRAW_NUM = 3,
  ZONE_SIZE = Vector(75, 120),
}

function love.load()
  Board = BoardClass:new(BOARD.WIDTH, BOARD.HEIGHT, BOARD.RGB, BOARD.ALPHA)
  
  Deck = DeckClass:new("cards.json", "standard", 52, BOARD.DRAW_POS, BOARD.ZONE_SIZE)
  Deck.std = Deck:generate()
  print("--- Generated Deck ---")
  print("Length = " .. tostring(#Deck.std))
  for _, card in pairs(Deck.std) do
    print("card:\nColor = " .. tostring(card.color) .. "\nSuit = " .. tostring(card.suit) .. "\nValue = " .. tostring(card.value) .. "\n")
  end
end


function love.draw()
  Board:solitaire(BOARD.DRAW_POS, BOARD.OFFSET, BOARD.DRAW_NUM, BOARD.ZONE_SIZE)
  for _, card in pairs(Deck.std) do
    card:draw()
  end
end