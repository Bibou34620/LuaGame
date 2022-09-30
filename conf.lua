--[[IMPORTANT

Ce fichier sert a paramétrer la fenêtre du jeu

--]]

require 'win_constants'
require 'tables'

function love.conf(t)
  t.window.title = TITLE
  t.window.width = WIDTH
  t.window.height = HEIGHT
  t.window.icon = PATH_ICON
  
  if scene.isOnGame == true then
    t.window.title = "GrabIT | En Jeu"
  end
end