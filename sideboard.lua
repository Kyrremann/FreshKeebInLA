local Sideboard = {}

function Sideboard:setup(font)
   self.font = font
   self.fontHeight = font:getHeight("A")
   self:setDefaultValues()
end

function Sideboard:start()
   self:setDefaultValues()
   self.startTimer = love.timer.getTime()
end

function Sideboard:setDefaultValues()
   self.duration = 60
   self.left = 60
   self.startTimer = 0
   self.score = 0
   self.combo = 1
   self.letterBonus = 1
   self.x = 5
   self.y = 5
   self.words = 0
end

function Sideboard:update()
   local timeUsed = love.timer.getTime() - self.startTimer
   self.left = self.duration - timeUsed
end

function Sideboard:draw()
   local time = math.floor(self.left)

   love.graphics.setFont(self.font)
   love.graphics.setColor(0, 0, 0)
   love.graphics.print("Score " .. self.score, self.x, self.y)
   love.graphics.print("Time " .. time, self.x, self.y + self.fontHeight * 2)
   love.graphics.print("Words " .. self.words, self.x, self.y + self.fontHeight * 3)

   if self.combo >= 10 then
       love.graphics.setColor(1, 0.5, 0)
   end
   love.graphics.print("Combo " .. self.combo .. "x", self.x, self.y + self.fontHeight)
end

function Sideboard:newWord(word, typingCorrectly)
   self.score = self.score + self.combo * #word

   if typingCorrectly then
      self.combo = self.combo + 1
   end

   self.letterBonus = 1
   self.words = self.words + 1
end

function Sideboard:typing(correctly)
   if correctly then
      self.score = self.score + self.letterBonus
      self.letterBonus = self.letterBonus + 1
   else
      self.combo = 1
      self.letterBonus = 1
   end
end

function Sideboard:timesUp()
   if self.left <= 0 then
      self.left = 0
      return true
   end
end

return Sideboard
