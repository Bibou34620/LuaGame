require 'tables'

function player1Movement()
  if love.keyboard.isDown("q") and scene.isOnGame == true then
    player1.x = player1.x - player1.speed
    player1.isOnRight = false
    player1.isOnLeft = true
    player1.isOnFwd = false
    player1.isOnBack = false    
  end
  
  if love.keyboard.isDown("d") and scene.isOnGame == true then
    player1.x = player1.x + player1.speed
    player1.isOnRight = true
    player1.isOnLeft = false
    player1.isOnFwd = false
    player1.isOnBack = false
  end
  
  if love.keyboard.isDown("s") and scene.isOnGame == true then
    player1.y = player1.y + player1.speed
    player1.isOnRight = false
    player1.isOnLeft = false
    player1.isOnFwd = true
    player1.isOnBack = false
  end
  
  if love.keyboard.isDown("z") and scene.isOnGame == true then
    player1.y = player1.y - player1.speed
    player1.isOnRight = false
    player1.isOnLeft = false
    player1.isOnFwd = false
    player1.isOnBack = true
  end
  
  if love.keyboard.isDown("lshift") then
    player1.speed = 2
  else
    player1.speed = 5
  end
end