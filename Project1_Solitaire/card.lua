require "vector"

CardClass = {}

CARD_STATE = {
  IDLE = 0,
  MOUSE_OVER = 1,
  GRABBED = 2
}

function CardClass:new(xPos, yPos, info)
    local card = {}
    local metatable = {__index = CardClass}
    setmetatable(card, metatable)

    card.position = Vector(xPos, yPos)
    card.size = {}
    for field, value in pairs(info) do
      if field == "CARD_SIZE" then
        card.size.x = value[1]
        card.size.y = value[2]
      end
    end
    card.state = CARD_STATE.IDLE
  
    -- Adds the fields to the card based on provided info
    for fields, _ in pairs(info) do
      if fields ~= "DECK_TYPE" and fields ~= "CARD_SIZE" then
        load("card." .. tostring(fields) .. " = nil")
      end
    end
    return card
end


function CardClass:draw()
  -- NEW: drop shadow for non-idle cards
  if self.state ~= CARD_STATE.IDLE then
    love.graphics.setColor(0, 0, 0, 0.8) -- color values [0, 1]
    local offset = 4 * (self.state == CARD_STATE.GRABBED and 2 or 1)
    love.graphics.rectangle("fill", self.position.x + offset, self.position.y + offset, self.size.x, self.size.y, 6, 6)
  end
  
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.rectangle("fill", self.position.x, self.position.y, self.size.x, self.size.y, 6, 6)
  
  love.graphics.print(tostring(self.state), self.position.x + 20, self.position.y - 20)
end


function CardClass:checkForMouseOver(grabber)
  if self.state == CARD_STATE.GRABBED then
    self.position = grabber.currentMousePos - self.size * 0.5
    grabber.heldObject = self
  end
    
  local mousePos = grabber.currentMousePos
  local isMouseOver = 
    mousePos.x > self.position.x and
    mousePos.x < self.position.x + self.size.x and
    mousePos.y > self.position.y and
    mousePos.y < self.position.y + self.size.y
  
  self.state = isMouseOver and CARD_STATE.MOUSE_OVER or CARD_STATE.IDLE
  
  -- If grabbed update state
  if self.state == CARD_STATE.MOUSE_OVER and grabber.grabPos ~= nil then
    self.state = CARD_STATE.GRABBED
    grabber.previousMousePos = mousePos
  end
end