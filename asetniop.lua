local Keyboard = require('keyboard')
Keyboard.homerow = {'a', 's', 'e', 't', 'n', 'i', 'o', 'p'}
Keyboard.a = {[2] = 'w', [3] = 'x', [4] = 'f', [8] = '-'}
Keyboard.s = {[3] = 'd', [5] = 'j', [6] = 'k', [7] = '.', [8] = ')'}
Keyboard.e = {[4] = 'r', [5] = 'y', [6] = ',', [7] = '+', [8] = ',', }
Keyboard.t = {[2] = 'c', [8] = '<-'}
Keyboard.n = {[1] = 'q', [4] = 'b'}
Keyboard.i = {[1] = 'z', [4] = 'v', [5] = 'h', [7] = 'l', [8] = '!'}
Keyboard.o = {[1] = '(', [4] = 'g', [5] = 'u', [8] = ';'}
Keyboard.p = {[5] = 'm'}
Keyboard.colors = {
   a = {255,103,102}, s = {255,149,75}, e = {255,206,69}, t = {254,255,101},
   n = {104,186,66}, i = {97,235,234}, o = {79,183,255}, p = {178,141,216}
}

function Keyboard:setup(font)
   self.font = font
   self.boxWidth = math.floor(love.graphics.getHeight() / 8)
   self.boxHeight = math.floor(self.boxWidth / 2)
   self.xBase = (love.graphics.getWidth() / 2) - 4 * self.boxWidth
end

function Keyboard:update(nextLetter)
   self.nextLetter = nextLetter
   if self[nextLetter] then
      self.helper = nil
   else
      self.helper = self:findHomerow(nextLetter)
   end
end

function Keyboard:draw()
   love.graphics.setColor(0, 0, 0)
   love.graphics.rectangle('fill',
			   self.xBase - 4,
			   (love.graphics.getHeight() - self.boxHeight * 2) - 4,
			   (self.boxWidth * 8) + 8,
			   (self.boxHeight * 2) + 4)

   for i=1,#self.homerow do
      local letter = self.homerow[i]
      local colors = self.colors[self.homerow[i]]
      local alpha = 128
      if self.nextLetter == letter then alpha = 255 end
      if self.helper == letter then alpha = 255 end
      local x = self.boxWidth * (i - 1)
      local y = love.graphics.getHeight() - self.boxHeight
      self:drawBox(letter, x, y, colors, alpha)
   end

   for i=1,#self.homerow do
      local letter = ''
      local alpha = 128
      if self.helper then
	 letter = self[self.helper][i] or ''
	 if letter == self.nextLetter then alpha = 255 end
      end
      local colors = self.colors[self.homerow[i]]
      local x = self.boxWidth * (i - 1)
      local y = love.graphics.getHeight() - self.boxHeight * 2
      self:drawBox(letter, x, y, colors, alpha)
   end
end

function Keyboard:findHomerow(letter)
   for i=1,#self.homerow do
      local homerow = self.homerow[i]
      if self:contains(letter, self[homerow]) then
	 return homerow
      end
   end
end

return Keyboard
