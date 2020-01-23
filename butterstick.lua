local Keyboard = require('keyboard')
Keyboard.toprow = {'q', 'w', 'e', 'r', 't', 'y', 'u', 'i', 'o', 'p'}
Keyboard.bothrow = {'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ''}
Keyboard.bottomrow = {'z', 'x', 'c', 'v', 'b', 'n', 'm', '', '', ''}

function Keyboard:setup(font)
   self.font = font
   self.boxWidth = math.floor(love.graphics.getHeight() / 10)
   self.boxHeight = math.floor(self.boxWidth / 2)
   self.xBase = (love.graphics.getWidth() / 2) - 5 * self.boxWidth
end

function Keyboard:update(nextLetter)
   self.nextLetter = nextLetter
end

function Keyboard:draw()
   love.graphics.setColor(0, 0, 0)
   love.graphics.rectangle('fill',
			   self.xBase - 4,
			   (love.graphics.getHeight() - self.boxHeight * 2) - 4,
			   (self.boxWidth * 10) + 8,
			   (self.boxHeight * 2) + 4)

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
			      self.xBase - 4,
			      love.graphics.getHeight() - self.boxHeight - 2,
			      (self.boxWidth * 10) + 8, 4)
   end

   for i=2,10 do
      local x = self.boxWidth * (i - 1)
      local y = love.graphics.getHeight() - self.boxHeight * 2
      love.graphics.rectangle('fill',
			      self.xBase + x, y,
			      4, self.boxHeight * 2)
   end
end

function Keyboard:findLetter(nextLetter)
   local row = self.toprow
   if self:contains(nextLetter, row) then
      return row
   end
end

return Keyboard
