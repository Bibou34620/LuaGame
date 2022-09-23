--[[IMPORTANT

Ce fichier sert a paramétrer la fenêtre du jeu

--]]

require 'win_constants'

function love.conf(t)
  t.window.title = TITLE
  t.window.width = WIDTH
  t.window.height = HEIGHT
end