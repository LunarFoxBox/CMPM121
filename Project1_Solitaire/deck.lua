require "card"
require "extractJson"

DeckClass = {}

function DeckClass:new(file, deckType)
  local deck = {}
  local metadata = {__index = DeckClass}
  setmetatable(deck, metadata)
  
  local json = ExtractJsonClass:new()
  deck.info = json:extract(file)
  deck.type = deckType
  return deck
end


local function standard(deck, position, deckSize)
  local size = math.floor(deckSize/4)
  local stdDeck = {}
  
  -- Suit generator
  local function generateSuit(size, deckTable, suit, color)
    for cardNum = 1, size do
      local card = CardClass:new(position.x, position.y, deck.info)
      card.color = deck.info.color[color]
      card.suit = deck.info.suit[suit]
      card.value = deck.info.value[cardNum]
      table.insert(deckTable, card)
    end
  end
  generateSuit(size, stdDeck, 1, 1)
  generateSuit(size, stdDeck, 2, 1)
  generateSuit(size, stdDeck, 3, 2)
  generateSuit(size, stdDeck, 4, 2)
  return stdDeck
end



function DeckClass:generateDeck(position, deckSize)
  if self.type == "standard" then return standard(self, position, deckSize) end
end