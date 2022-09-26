function ifPlayer1CollidesWithDownBarrier(px, bx, py, by)
  if math.abs(px - bx) < 800 and math.abs(py - by) < 60 then
    player1.isAlive = false
  end
end

function ifPlayer2CollidesWithDownBarrier(px, bx, py, by)
  if math.abs(px - bx) < 800 and math.abs(py - by) < 60 then
    player2.isAlive = false
  end
end

function ifPlayer1CollidesWithUpBarrier(px, bx, py, by)
  if math.abs(px - bx) < 800 and math.abs(py - by) < 60 then
    player1.isAlive = false
  end
end

function ifPlayer2CollidesWithUpBarrier(px, bx, py, by)
  if math.abs(px - bx) < 800 and math.abs(py - by) < 60 then
    player2.isAlive = false
  end
end

function ifPlayer1CollidesWithLeftBarrier(px, bx, py, by)
  if math.abs(px - bx) < 800 and math.abs(py - by) < 60 then
    player1.isAlive = false
  end
end

function ifPlayer2CollidesWithLeftBarrier(px, bx, py, by)
  if math.abs(px - bx) < 800 and math.abs(py - by) < 60 then
    player2.isAlive = false
  end
end

function ifPlayer1CollidesWithRightBarrier(px, bx, py, by)
  if math.abs(px - bx) < 60 and math.abs(py - by) < 800 then
    player1.isAlive = false
  end
end

function ifPlayer2CollidesWithRightBarrier(px, bx, py, by)
  if math.abs(px - bx) < 60 and math.abs(py - by) < 800 then
    player2.isAlive = false
  end
end