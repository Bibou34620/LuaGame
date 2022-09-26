require 'tables'

function player2Animations()
  if player2.isOnFwd == true and player2.isAlive == true then
    love.graphics.draw(player2.fwd, player2.x, player2.y)
  end
    
  if player2.isOnBack == true and player2.isAlive == true  then
    love.graphics.draw(player2.back, player2.x, player2.y)
  end
  
  if player2.isOnRight == true and player2.isAlive == true  then
    love.graphics.draw(player2.right, player2.x, player2.y)
  end
  
  if player2.isOnLeft == true and player2.isAlive == true  then
    love.graphics.draw(player2.left, player2.x, player2.y)
  end
end