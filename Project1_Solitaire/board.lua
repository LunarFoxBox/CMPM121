BoardClass = {}

function BoardClass:new(width, height, rgb, alpha)
  local board = {}
  local metadata = {__index = BoardClass}
  setmetatable(board, metadata)
  
  board.width = width
  board.height = height
  board.bg =
  {
    red = rgb[1],
    green = rgb[2],
    blue = rgb[3],
    alpha = alpha
  }
  
  -- Setup background
  love.window.setMode(board.width, board.height)
  love.graphics.setBackgroundColor(board.bg.red, board.bg.green, board.bg.blue, board.bg.alpha)
  return board
end


local function drawRect(fill, startX, startY, width, height)
  love.graphics.rectangle(fill, startX, startY, width, height)
end


-- Setup board for solitaire
function BoardClass:solitaire(drawPos, drawOffset, maxDraw, zoneDim)
  -- Draw the card draw pile
  drawRect("fill", drawPos.x, drawPos.y, zoneDim.x, zoneDim.y)
  for i = drawPos.x + drawOffset, (drawPos.x + (drawOffset * maxDraw)), drawOffset do
    drawRect("line", i, drawPos.y, zoneDim.x, zoneDim.y)
  end
  
  -- Draw the winning piles
  for i = drawPos.y + 2*drawOffset, (drawPos.y + (2*drawOffset * 4)), 2*drawOffset do
    drawRect("line", drawPos.x, i, zoneDim.x, zoneDim.y)
  end
  
  -- Play piles
  for i = drawPos.x + 2*drawOffset*maxDraw, drawPos.x + (4 * drawOffset * 7), drawOffset do
    drawRect("line", i, drawPos.y, zoneDim.x, zoneDim.y)
  end
end