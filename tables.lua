--Déclaration des tables
player1 = {}
player2 = {}
scene = {}
glove1 = {}
glove2 = {}

--Variables player1
player1.x = 5
player1.y = 370
player1.left = nil
player1.right = nil
player1.back = nil
player1.fwd = nil
player1.isOnRight = false
player1.isOnLeft = false
player1.isOnFwd = true
player1.isOnBack = false
player1.speed = 5
player1.isAlive = true


--Variables player2
player2.x = 645
player2.y = 60
player2.left = nil
player2.right = nil
player2.back = nil
player2.fwd = nil
player2.isOnRight = false
player2.isOnLeft = false
player2.isOnFwd = true
player2.isOnBack = false
player2.speed = 5

--Variables scene
scene.isOnMenu = true
scene.isOnGame = false
scene.isOnEndGame = false
scene.isOnHowToPlay = false

--Variables glove1
glove1.texture = nil
glove1.x = player1.x
glove1.y = player1.y
glove1.attack = false
glove1.speed = 0.5


--Variables glove2
glove2.texture = nil
glove2.x = player1.x
glove2.y = player1.y
glove2.attack = false
glove2.speed = 0.5

