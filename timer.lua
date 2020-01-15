local Timer = {
   tiles = {},
   duration = 60,
   left = 60,
   startTimer = 0
}

function Timer:setup()
   for i=0,9 do
      self.tiles[i] = love.graphics.newImage('images/tile' .. i .. '.png')
   end
end

function Timer:start()
   self.left = self.duration
   self.startTimer = love.timer.getTime()
end

function Timer:update()
   local timeUsed = love.timer.getTime() - self.startTimer
   self.left = self.duration - timeUsed

   if self.left <= 0 then
      self:start()
   end
end

function Timer:draw()
   local time = math.floor(self.left)
   if time > 9 then
      self:drawNumber(math.floor(time/10), 10, 10)
      self:drawNumber(time%10, 74, 10)
   else
      self:drawNumber(0, 10, 10)
      self:drawNumber(time, 74, 10)
   end
end

function Timer:drawNumber(int, x, y)
      love.graphics.draw(self.tiles[int], x, y, 0, 0.5, 0.5)
end

return Timer
