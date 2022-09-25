function player2Movement()
    if love.keyboard.isDown("left") and scene.isOnGame == true then
    player2.x = player2.x - player2.speed
    player2.isOnRight = false
    player2.isOnLeft = true
    player2.isOnFwd = false
    player2.isOnBack = false    
  end
  
  if love.keyboard.isDown("right") and scene.isOnGame == true then
    player2.x = player2.x + player2.speed
    player2.isOnRight = true
    player2.isOnLeft = false
    player2.isOnFwd = false
    player2.isOnBack = false
  end
  
  if love.keyboard.isDown("down") and scene.isOnGame == true then
    player2.y = player2.y + player2.speed
    player2.isOnRight = false
    player2.isOnLeft = false
    player2.isOnFwd = true
    player2.isOnBack = false
  end
  
  if love.keyboard.isDown("up") and scene.isOnGame == true then
    player2.y = player2.y - player2.speed
    player2.isOnRight = false
    player2.isOnLeft = false
    player2.isOnFwd = false
    player2.isOnBack = true
  end
  
  if love.keyboard.isDown("*") then
    player2.speed = 2
  else
    player2.speed = 5
  end
end
