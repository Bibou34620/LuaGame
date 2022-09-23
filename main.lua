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
  
  returnToMenu()
  player1Movement()
  player2Movement()
  checkIfPlayer1ExitScene()
  
  if bullet.isShooted == false then
    bullet.x = player1.x
    bullet.y = player1.y
  end
  
  
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

function love.keypressed(key , scancode, isRepeat)
  if key == "space" then
    bullet.isShooted = true
    bullet.x = bullet.x + 40
    
  end
end

co = coroutine.create(function()
  wait(3)
  print("Bonjour le monde !")
end)