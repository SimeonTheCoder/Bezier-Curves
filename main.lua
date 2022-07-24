function love.load ()
  t = 0
  
  points = {}
  lines = {}
  
  selectedPoint = 0
  
  local point = {}
  local point2 = {}
  local point3 = {}
  local point4 = {}
  
  local point12 = {}
  local point13 = {}
  local point14 = {}
  
  local point1213 = {}
  local point1314 = {}
  
  local b_point = {}
  
  point["x"], point["y"] = 100, 300
  point2["x"], point2["y"] = 300, 50
  point3["x"], point3["y"] = 400, 65
  point4["x"], point4["y"] = 500, 300
  
  point12["p1"], point12["p2"] = 1, 2
  point13["p1"], point13["p2"] = 2, 3
  point14["p1"], point14["p2"] = 3, 4
  
  point1213["p1"], point1213["p2"] = 5, 6
  point1314["p1"], point1314["p2"] = 6, 7
  
  b_point["p1"], b_point["p2"] = 8, 9
  b_point["px"], b_point["py"] = {}, {}
  
  points[1] = point
  points[2] = point2
  points[3] = point3
  points[4] = point4
  
  points[5] = point12
  points[6] = point13
  points[7] = point14
  
  lines[1] = {1, 2}
  lines[2] = {2, 3}
  lines[3] = {3, 4}
  lines[4] = {5, 6}
  lines[5] = {6, 7}
  lines[6] = {8, 9}
  
  table.insert(points, point1213)
  table.insert(points, point1314)
  
  table.insert(points, b_point)
  
  calc()
end

function calc()
  points[#points].px = {}
  points[#points].py = {}
  
  for k = 0, 100, 1
  do
    for i = 5, #points, 1
    do    
      points[i].x = (points[points[i].p2].x - points[points[i].p1].x) / 100. * k + points[points[i].p1].x
      points[i].y = (points[points[i].p2].y - points[points[i].p1].y) / 100. * k + points[points[i].p1].y
      
      if (i == #points)
      then
        table.insert(points[i].px, points[i].x)
        table.insert(points[i].py, points[i].y)
      end
    end
  end
end

function love.update (dt)
  calc()
  
  if (love.keyboard.isDown("["))
  then
    t = t - 1
  end
  
  if (love.keyboard.isDown("]"))
  then
    t = t + 1
  end
  
  if (love.keyboard.isDown("1"))
  then
    selectedPoint = 1
  end
  
  if (love.keyboard.isDown("2"))
  then
    selectedPoint = 2
  end
  
  if (love.keyboard.isDown("3"))
  then
    selectedPoint = 3
  end
  
  if (love.keyboard.isDown("4"))
  then
    selectedPoint = 4
  end
  
  if (love.keyboard.isDown("0"))
  then
    selectedPoint = 0
  end
  
  if (selectedPoint ~= 0)
  then
    points[selectedPoint].x, points[selectedPoint].y = love.mouse.getPosition()
  end
  
  for i = 5, #points, 1
  do    
    points[i].x = (points[points[i].p2].x - points[points[i].p1].x) / 100. * t + points[points[i].p1].x
    points[i].y = (points[points[i].p2].y - points[points[i].p1].y) / 100. * t + points[points[i].p1].y
  end
end

function love.draw ()
  love.graphics.setColor(1, 1, 1, 1)
  
  for i, v in ipairs(lines)
  do
    love.graphics.line(points[v[1]].x, points[v[1]].y, points[v[2]].x, points[v[2]].y)
  end
  
  for i, v in ipairs(points[#points].px)
  do
    love.graphics.setColor(0, 1, 0, 1)
    
    if (i > 1)
    then
      love.graphics.line(points[#points].px[i], points[#points].py[i], points[#points].px[i-1], points[#points].py[i-1])
    end
  end
  
  for i, v in ipairs(points)
  do
    love.graphics.setColor(1, 1, 1, 1)
    
    if (i == #points)
    then
      love.graphics.setColor(1, 0, 0)
    end
    
    love.graphics.rectangle("fill", v.x, v.y, 5, 5)
  end
end