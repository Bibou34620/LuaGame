require 'tables'

function player1Animations()
  if player1.isOnFwd == true then
      love.graphics.draw(player1.fwd, player1.x, player1.y)
    end
    
    if player1.isOnBack == true then
      love.graphics.draw(player1.back, player1.x, player1.y)
    end
    
    if player1.isOnRight == true then
      love.graphics.draw(player1.right, player1.x, player1.y)
    end
    
    if player1.isOnLeft == true then
      love.graphics.draw(player1.left, player1.x, player1.y)
    end
end