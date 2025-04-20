require "card"
require "extractJson"

DeckClass = {}

function DeckClass:new(file, deckType, size, position)
  local deck = {}
  local metadata = {__index = DeckClass}
  setmetatable(deck, metadata)
  
  local json = ExtractJsonClass:new()
  deck.info = json:extract(file)
  deck.type = deckType
  deck.size = size
  deck.position = position
  
  return deck:generateDeck()
end


function standard(deck)
  local size = math.floor(deck.size/4) -- Distributes cards between suits
  local stdDeck = {}
  
  -- Suit generator
  local function generateSuit(size, deckTable, suit, color)
    for cardNum = 1, size do
      local card = CardClass:new(deck.position.x, deck.position.y, deck.info)
      card.color = deck.info.color[color]
      card.suit = deck.info.suit[suit]
      card.value = deck.info.value[cardNum]
      table.insert(deckTable, card)
    end
  end
  generateSuit(size, stdDeck, 1, 1) -- Diamonds, Red
  generateSuit(size, stdDeck, 2, 1) -- Hearts, Red
  generateSuit(size, stdDeck, 3, 2) -- Clubs, Black
  generateSuit(size, stdDeck, 4, 2) -- Spades, Black
  return stdDeck
end



function DeckClass:generateDeck()
  local loadString = load("return function(self, position, deckSize) return " .. tostring(self.type) .. "(self)" .. " end")
  if not loadString then
    print("Error loading function: " .. tostring(loadString))
    return
  end
  local buildDeck = loadString()
  return buildDeck(self)
end