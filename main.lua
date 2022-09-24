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

--Fonction de chargement des textures
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
  
  glove.texture = love.graphics.newImage("images/bullet.png")
  down_barrier = love.graphics.newImage("images/barrier.png")
  up_barrier = love.graphics.newImage("images/barrier.png")
  
  --Audio
  musicMenu = love.audio.newSource("musics/menuMusic.wav", "stream")
  musicGame = love.audio.newSource("musics/gameMusic.wav", "stream")
  
  howToPlayFont = love.graphics.newFont("fonts/Monocraft.otf")
  howToPlayLogo = love.graphics.newImage("images/ImageMenu.png")
end

--Dessiner a l'écran les composants
function love.draw()
  --Dessiner les composants menu
  if scene.isOnMenu == true then
    love.audio.play(musicMenu)
    love.graphics.scale(1.4, 1.5)
    love.graphics.draw(imageLogo, 230, -8)
    
    love.graphics.draw(play, 220, 100)
    love.graphics.draw(quit, 220, 140)
    love.graphics.draw(help, 220, 180)
  end
  
  --Dessiner les composants de jeu
  if scene.isOnGame == true then    
    love.audio.play(musicGame)
    love.graphics.draw(gameBG)
    love.graphics.draw(down_barrier, 0, 560)
    love.graphics.draw(up_barrier, 0, -20)
    player1Animations()
    player2Animations()
    love.graphics.draw(glove.texture, glove.x, glove.y)
    
  end
  
  if scene.isOnHowToPlay == true then
    love.graphics.scale(0.9)
    love.graphics.draw(howToPlayLogo, 370)
    love.graphics.setFont(howToPlayFont)
    love.graphics.scale(2)
    love.graphics.print("PushIT !", 190, 80)
    
    love.graphics.scale(0.69)
    love.graphics.print("Joueur 1:", 80, 170)
  end
end

--Fonction d'update
function love.update(dt)
  
  --Quitter le jeu
  if love.keyboard.isDown("q") and scene.isOnMenu == true then
    love.event.quit()
  end
  
  --Jouer
  if love.keyboard.isDown("p") then
    scene.isOnGame = true
    scene.isOnMenu = false
    scene.isOnEndGame = false
    scene.isOnHowToPlay = false
    love.audio.stop(musicMenu)
  end
  
  --Comment jouer
  if love.keyboard.isDown("h") then
    scene.isOnGame = false
    scene.isOnMenu = false
    scene.isOnEndGame = false
    scene.isOnHowToPlay = true
    love.audio.stop(musicMenu)
  end
  
  --Fonctions
  
  --Retourner au menu
  returnToMenu()
  --Pour que player1 se déplace
  player1Movement()
  --Pour que player2 se déplace
  player2Movement()
  --Collision entre 2 joueurs [DEBUG]
  collisionIn2Players(player1.x, player1.y, player2.x, player2.y)
  --Si le joueur 2 est frappé [EXPERIMENTAL]
  checkIfFrapped()
end

--Fonction pour retourner au menu
function returnToMenu()
  if scene.isOnGame == true and love.keyboard.isDown("escape") then
    scene.isOnGame = false
    scene.isOnMenu = true
    scene.isOnEndGame = false
    love.audio.setVolume(1)
  end
end

--Fonction si le player1 sort de la scène [A REMETTRE DANS UPDATE]
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

--Idem mais pour player2
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

--Si espace est appuyé alors attaquer [PLAYER 1 [EN CREER UNE POUR PLAYER 2]]
function love.keypressed(key, scancode, isRepeat)
  if key == "space" then
    bullet.isShooted = true
    bullet.x = bullet.x + 40
  end
end

--Fonction de DEBUG pour la collision entre 2 joueurs
function collisionIn2Players(x1, y1, x2, y2)
  if math.abs(x1 - x2) < 64 and math.abs(y1 - y2) < 64 then
    print("Collision !")
    
  end
end

--Changer bullet par glove
function bulletCollisionWithPlayer2(x1, y1, x2, y2)
  if math.abs(x1 - x2) < 50 and math.abs(y1 - y2) < 50 then
    return true
  else
    return false
  end
end

--Checker si le player1 attaque player2
function checkIfFrapped()
  if bulletCollisionWithPlayer2(player1.x, player1.y, player2.x, player2.y) == true and glove.attack == true then
    print("Joueur attaqué !")
    
    if player1.isOnLeft == true then
      player2.x = player2.x - 6 
    end
    
    if player1.isOnRight == true then
      player2.x = player2.x + 6 
    end
    
    if player1.isOnBack == true then
      player2.y = player2.y - 6 
    end
    
    if player1.isOnFwd == true then
      player2.y = player2.y + 6 
    end
    
    
  end
end

--Mouvement joueur 1 [A REMETTRE DANS FICHIER ATTRIBUÉ]
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

--Idem mais pour player2 [IDEM]
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

--Attaquer
function love.keypressed(key, scancode, isRepeat)
  isRepeat = false
  if key == "space" then
    glove.attack = true
    
  else 
    glove.attack = false
  end
end
  
  