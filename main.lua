--Cette ligne permet l'écriture dans la console
io.stdout:setvbuf('no')

--Import des fichiers
require 'conf'
require 'tables'
require 'player1_movement'
require 'player2_movement'
require 'player1Animations'
require 'player2Animations'
----------------------------------------------------------------------

function love.load()
  imageLogo = love.graphics.newImage("images/menuLogo.png")
  play = love.graphics.newImage("images/play.png")
  quit = love.graphics.newImage("images/quit.png")
  help = love.graphics.newImage("images/help.png")
  gameBG = love.graphics.newImage("images/menubg.png")
  
  player1.fwd = love.graphics.newImage("images/player1/player.png")
  player1.back = love.graphics.newImage("images/player1/player_back.png")
  player1.right = love.graphics.newImage("images/player1/player_right.png")
  player1.left = love.graphics.newImage("images/player1/player_left.png")
  
  player2.fwd = love.graphics.newImage("images/player2/player.png")
  player2.back = love.graphics.newImage("images/player2/player_back.png")
  player2.right = love.graphics.newImage("images/player2/player_right.png")
  player2.left = love.graphics.newImage("images/player2/player_left.png")
  
  bullet.texture = love.graphics.newImage("images/bullet.png")
  
  --Audio
  musicMenu = love.audio.newSource("musics/menuMusic.wav", "stream")
  musicGame = love.audio.newSource("musics/gameMusic.wav", "stream")
end

function love.draw()
  if scene.isOnMenu == true then
    love.audio.play(musicMenu)
    love.graphics.scale(1.4, 1.5)
    love.graphics.draw(imageLogo, 230, -8)
    
    love.graphics.draw(play, 220, 100)
    love.graphics.draw(quit, 220, 140)
    love.graphics.draw(help, 220, 180)
  end
  
  if scene.isOnGame == true then    
    love.audio.play(musicGame)
    love.graphics.draw(gameBG)
    
    player1Animations()
    player2Animations()
    love.graphics.draw(bullet.texture, bullet.x, bullet.y)
    
  end
end

function love.update(dt)
  if love.keyboard.isDown("q") and scene.isOnMenu == true then
    love.event.quit()
  end
  
  if love.keyboard.isDown("p") then
    scene.isOnGame = true
    scene.isOnMenu = false
    scene.isOnEndGame = false
    love.audio.stop(musicMenu)
  end
  
  if bullet.isShooted == false then
    bullet.x = player1.x
    bullet.y = player1.y
  end
  
  returnToMenu()
  player1Movement()
  player2Movement()
  collisionIn2Players(player1.x, player1.y, player2.x, player2.y)
  bulletCollisionWithPlayer2(bullet.x, bullet.y, player2.x, player2.y)
end

function returnToMenu()
  if scene.isOnGame == true and love.keyboard.isDown("escape") then
    scene.isOnGame = false
    scene.isOnMenu = true
    scene.isOnEndGame = false
    love.audio.setVolume(1)
  end
end

function checkIfPlayer1ExitScene()
  if player1.x > 800 then
    player1.x = -105
  end
  
  if player1.x < -105 then
    player1.x = 800
  end
  
  if player1.y > 600 then
    player1.y = -150
  end
  
  if player1.y < -150 then
    player1.y = 600
  end
end

function checkIfPlayer2ExitScene()
  if player2.x > 800 then
    player2.x = -105
  end
  
  if player2.x < -105 then
    player2.x = 800
  end
  
  if player2.y > 600 then
    player2.y = -150
  end
  
  if player2.y < -150 then
    player2.y = 600
  end
end

function love.keypressed(key, scancode, isRepeat)
  if key == "space" then
    bullet.isShooted = true
    bullet.x = bullet.x + 40
  end
end

function collisionIn2Players(x1, y1, x2, y2)
  if math.abs(x1 - x2) < 64 and math.abs(y1 - y2) < 64 then
    print("Collision !")
  end
end

function bulletCollisionWithPlayer2(x1, y1, x2, y2)
  if math.abs(x1 - x2) < 50 and math.abs(y1 - y2) < 50 then
    print("La balle à touché joueur 2 !")
  end
end

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

--Tirer la balle
function love.keypressed(key, scancode, isRepeat)
  if key == "space" then
    bullet.isShooted = true
  end
end
  
  