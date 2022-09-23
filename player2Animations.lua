require 'tables'

function player2Animations()
  if player2.isOnFwd == true then
    love.graphics.draw(player2.fwd, player2.x, player2.y)
  end
    
  if player2.isOnBack == true then
    love.graphics.draw(player2.back, player2.x, player2.y)
  end
  
  if player2.isOnRight == true then
    love.graphics.draw(player2.right, player2.x, player2.y)
  end
  
  if player2.isOnLeft == true then
    love.graphics.draw(player2.left, player2.x, player2.y)
  end
end