local Keyboard = {
   toprow = {'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'},
   bothrow = {'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ''},
   bottomrow = {'z', 'x', 'c', 'v', 'b', 'n', 'm', '', '', ''},
}

function Keyboard:setup(font)
   self.font = font
   self.boxWidth = love.graphics.getWidth() / 10
   self.boxHeight = self.boxWidth / 2
end

function Keyboard:update(nextLetter)
   self.nextLetter = nextLetter
--   if self[nextLetter] then
--      self.helper = nil
--   else
--      self.helper = self:findLetter(nextLetter)
--   end
end

function Keyboard:draw()
   love.graphics.setColor(0, 0, 0)
   love.graphics.rectangle('fill',
			   0, love.graphics.getHeight() - self.boxHeight * 2,
			   love.graphics.getWidth(), self.boxHeight * 2)

   local colors = {255, 255, 255}

   if self:contains(self.nextLetter, self.bothrow) then
      for i=1,#self.bothrow do
	 local alpha = 128
	 local letter = self.bothrow[i]
	 if letter == self.nextLetter then alpha = 255 end
	 local x = self.boxWidth * (i - 1)
	 local y = love.graphics.getHeight() - self.boxHeight * 2
	 self:drawBox(letter, x, y, colors, alpha, self.boxWidth, self.boxHeight * 2)
      end
   else
      for i=1,#self.toprow do
	 local letter = self.toprow[i]
	 local alpha = 128
	 if self.nextLetter == letter then alpha = 255 end
	 if self.helper == letter then alpha = 255 end
	 local x = self.boxWidth * (i - 1)
	 local y = love.graphics.getHeight() - self.boxHeight * 2
	 self:drawBox(letter, x, y, colors, alpha)
      end
      
      for i=1,#self.bottomrow do
	 local letter = self.bottomrow[i]
	 local alpha = 128
	 if self.nextLetter == letter then alpha = 255 end
	 if self.helper == letter then alpha = 255 end
	 local x = self.boxWidth * (i - 1)
	 local y = love.graphics.getHeight() - self.boxHeight
	 self:drawBox(letter, x, y, colors, alpha)
      end
      love.graphics.rectangle('fill',
			      0, love.graphics.getHeight() - self.boxHeight - 2,
			      love.graphics.getWidth(), 4)
   end

   for i=2,10 do
      local x = self.boxWidth * (i - 1)
      local y = love.graphics.getHeight() - self.boxHeight * 2
      love.graphics.rectangle('fill',
			      x, y,
			      4, self.boxHeight * 2)
   end

   love.graphics.rectangle('fill',
			   0, love.graphics.getHeight() - (self.boxHeight * 2) - 2,
			   love.graphics.getWidth(), 4)
   love.graphics.rectangle('fill',
			   0, love.graphics.getHeight() - 2,
			   love.graphics.getWidth(), 2)
end

function Keyboard:drawBox(letter, x, y, colors, alpha, boxWidth, boxHeight)
   boxWidth = boxWidth or self.boxWidth
   boxHeight = boxHeight or self.boxHeight
   self:setColor(colors, alpha)
   love.graphics.rectangle('fill', x, y, boxWidth, boxHeight)
   if letter then
      love.graphics.setColor(0, 0, 0)
      love.graphics.setFont(self.font)
      lx = (boxWidth / 2) - (self.font:getWidth(letter) / 2)
      ly = y  + (boxHeight / 2) - (self.font:getHeight(letter) / 2)
      love.graphics.print(letter, lx + x, ly)
   end
end

function Keyboard:setColor(rgb, a)
   if not a then a = 255 end
   love.graphics.setColor(rgb[1]/255, rgb[2]/255, rgb[3]/255, a/255)
end

function Keyboard:findLetter(nextLetter)
   local row = self.toprow
   if self:contains(nextLetter, row) then
      return row
   end
end

function Keyboard:contains(letter, list)
   for i,v in pairs(list) do
      if letter == v then
	 return true
      end
   end

   return false
end

return Keyboard
