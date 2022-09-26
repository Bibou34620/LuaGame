--Cette ligne permet l'écriture dans la console
io.stdout:setvbuf('no')

--Import des fichiers
require 'conf'
require 'tables'
require 'player1_movement'
require 'player2_movement'
require 'player1Animations'
require 'player2Animations'
require 'collisonWithBarrier'
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
  
  down_barrier = love.graphics.newImage("images/barrier.png")
  up_barrier = love.graphics.newImage("images/barrier.png")
  left_barrier = love.graphics.newImage("images/barrier_rotate.png")
  right_barrier = love.graphics.newImage("images/barrier_rotate.png")
  
  --Audio
  musicMenu = love.audio.newSource("musics/menuMusic.wav", "stream")
  musicGame = love.audio.newSource("musics/gameMusic.wav", "stream")
  musicHowToPlay = love.audio.newSource("musics/howToPlayMusic.wav", "stream")
  
  howToPlayFont = love.graphics.newFont("fonts/Monocraft.otf")
  howToPlayLogo = love.graphics.newImage("images/ImageMenu.png")
  
  logoArena = love.graphics.newImage("images/Arenaimage.png")
end

--Dessiner a l'écran les composants
function love.draw()
  --Dessiner les composants menu
  if scene.isOnMenu == true then
    love.graphics.setFont(howToPlayFont)
    love.graphics.print("<X> pour couper / activer la musique", 10)
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
    love.graphics.draw(logoArena, 330, 210)
    love.graphics.draw(down_barrier, 0, 560)
    love.graphics.draw(up_barrier, 0, -20)
    love.graphics.draw(left_barrier, -20, 0)
    love.graphics.draw(right_barrier, 760, 0)
    player1Animations()
    player2Animations()
  end
  
  if scene.isOnHowToPlay == true then
    love.audio.play(musicHowToPlay)
    love.graphics.scale(0.9)
    love.graphics.draw(howToPlayLogo, 370)
    love.graphics.setFont(howToPlayFont)
    love.graphics.scale(2)
    love.graphics.print("PushIT !", 190, 80)
    
    love.graphics.scale(0.69)
    love.graphics.print("Joueur 1:", 60, 170)
    love.graphics.print("* Z: Aller devant", 20, 200)
    love.graphics.print("* Q: Aller à gauche", 20, 230)
    love.graphics.print("* S: Aller en arrière", 20, 260)
    love.graphics.print("* D: Aller à droite", 20, 290)
    love.graphics.print("* Espace: Attraper le joueur 2", 20, 320)
    love.graphics.print("* Espace + <Direction> pousser le J2", 20, 350)
    
    love.graphics.print("Joueur 2:", 370, 170)
    love.graphics.print("* Haut: Aller devant", 360, 200)
    love.graphics.print("* Gauche: Aller à gauche", 360, 230)
    love.graphics.print("* Bas: Aller en arrière", 360, 260)
    love.graphics.print("* Droite: Aller à droite", 360, 290)
    love.graphics.print("* Ctrl: Attraper le joueur 2", 360, 320)
    love.graphics.print("* Ctrl + <Direction> pousser le J1", 360, 350)
    
    love.graphics.print("Si vous voulez plus d'informations cliquez sur C", 140,430)
    
    love.graphics.scale(0.8)
    love.graphics.print("© 2022 Mathias Rubert alias Bibou34620", 250,590)
    
    love.graphics.scale(0.9)
    love.graphics.print("Echap pour retourner au menu", 30)

    if love.keyboard.isDown("escape") then
      scene.isOnHowToPlay = false
      scene.isOnMenu = true
      love.audio.stop(musicHowToPlay)
    end

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
  --Si le joueur 2 est frappé [EXPERIMENTAL]
  checkIfPlayer2Frapped()
  
  checkIfPlayer1Frapped()
  
  ifPlayer1CollidesWithDownBarrier(player1.x, 0, player1.y, 560)
  ifPlayer2CollidesWithDownBarrier(player2.x, 0, player2.y, 560)
  
  ifPlayer1CollidesWithUpBarrier(player1.x, 0, player1.y, -20)
  ifPlayer2CollidesWithUpBarrier(player2.x, 0, player2.y, -20)
  
  ifPlayer1CollidesWithLeftBarrier(player1.x, -20, player1.y, 0)
  ifPlayer2CollidesWithLeftBarrier(player2.x, -20, player2.y, 0)
  
  ifPlayer1CollidesWithRightBarrier(player1.x, 760, player1.y, 0)
  ifPlayer2CollidesWithRightBarrier(player2.x, 760, player2.y, 0)
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

--Si le joueur 1 collisionne avec joueur 2
function gloveCollisionWithPlayer2(x1, y1, x2, y2)
  if math.abs(x1 - x2) < 50 and math.abs(y1 - y2) < 50 then
    return true
  else
    return false
  end
end

--Idem mais pour le joueur 1
function gloveCollisionWithPlayer1(x1, y1, x2, y2)
  if math.abs(x1 - x2) < 50 and math.abs(y1 - y2) < 50 then
    return true
  else
    return false
  end
end

--Checker si le player1 attaque player2
function checkIfPlayer2Frapped()
  if gloveCollisionWithPlayer2(player1.x, player1.y, player2.x, player2.y) == true and glove1.attack == true then
    print("Joueur attaqué !")
    
    if player1.isOnLeft == true then
      player2.x = player2.x - 6
      player2.speed = 1
    end
    
    if player1.isOnRight == true then
      player2.x = player2.x + 6 
      player2.speed = 1
    end
    
    if player1.isOnBack == true then
      player2.y = player2.y - 6
      player2.speed = 1
    end
    
    if player1.isOnFwd == true then
      player2.y = player2.y + 6
      player2.speed = 1
    end
    
    
  else
    player2.speed = 5
  end
end


--Checker si le player2 attaque le player1
function checkIfPlayer1Frapped()
  if gloveCollisionWithPlayer1(player2.x, player2.y, player1.x, player1.y) == true and glove2.attack == true then
    print("Joueur attaqué !")
    
    if player2.isOnLeft == true then
      player1.x = player1.x - 6 
      player1.speed = 1
    end
    
    if player2.isOnRight == true then
      player1.x = player1.x + 6
      player1.speed = 1
    end
    
    if player2.isOnBack == true then
      player1.y = player1.y - 6
      player1.speed = 1
    end
    
    if player2.isOnFwd == true then
      player1.y = player1.y + 6
      player1.speed = 1
    end
    
    
  
  else
    player1.speed = 5
  end
end

function love.keypressed(key, scancode, isRepeat)
  --Attaquer
  isRepeat = false
  if key == "space" then
    glove1.attack = true
    
  else 
    glove1.attack = false
  end
  
  if key == "rshift" then
    glove2.attack = true
    
  else
    glove2.attack = false
  end
  
  --Ouvrir documentation
  if key == "c" and scene.isOnHowToPlay == true then
    love.system.openURL("https:/github.com/bibou34620/LuaGame")
    scene.isOnMenu = true
    scene.isOnHowToPlay = false
  end
  
  --Stopper / activer musique
  if key == "v" and scene.isOnMenu == true and music.playSound == true then
    music.playSound = false
  end
  
  if key == "v" and scene.isOnMenu == true and music.playSound == false then
    music.playSound = true
  end
  
end

--Checker si musique est activée ou stoppée
if music.playSound == false then
  love.audio.setVolume(0)
else
  love.audio.setVolume(1)
end
