require "card"
require "extractJson"

DeckClass = {}

function DeckClass:new(file, size, position)
  local deck = {}
  local metadata = {__index = DeckClass}
  setmetatable(deck, metadata)
  
  local json = ExtractJsonClass:new()
  deck.info = json:extract(file)
  for field, value in pairs(deck.info) do
    if field == "DECK_TYPE" then
      deck.type = value[1]
    end
  end
  deck.size = size
  deck.position = position
  return deck
end


-- Generate Deck based on type
function DeckClass:generate()
  -- Used ChatGPT 4.0 to reference how to use load for functions
  local buildString = load("return function(self) return " .. tostring(self.type) .. "(self)" .. " end")
  if not buildString then
    print("Error loading function: " .. tostring(buildString))
    return
  end
  local buildDeck = buildString()
  self.cards = buildDeck(self)
end

function DeckClass:getDeck()
  return self.cards
end

function standard(deck)
  local size = math.floor(deck.size/4) -- Distributes cards between suits
  local stdDeck = {}
  
  -- Suit generator
  local function generateSuit(size, deckTable, color, suit)
    for cardNum = 1, size do
      local card = CardClass:new(deck.position.x, deck.position.y, deck.info)
      card.color = deck.info.color[color]
      card.suit = deck.info.suit[suit]
      
      local value = cardNum % #deck.info.value -- Loops values if there are more cards than valid values
      if value == 0 then value = #deck.info.value end
      card.value = deck.info.value[value]
      table.insert(deckTable, card)
    end
  end
  generateSuit(size, stdDeck, 1, 1) -- Red Diamonds
  generateSuit(size, stdDeck, 1, 2) -- Red Hearts
  generateSuit(size, stdDeck, 2, 3) -- Black Clubs
  generateSuit(size, stdDeck, 2, 4) -- Black Spades
  return stdDeck
end