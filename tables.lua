--Déclaration des tables
player1 = {}
player2 = {}
scene = {}
bullet = {}

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


--Variables player2
player2.x = 645
player2.y = 10
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

--Variables bullet
bullet.texture = nil
bullet.x = player1.x
bullet.y = player1.y
bullet.isShooted = false
bullet.speed = 0.5

