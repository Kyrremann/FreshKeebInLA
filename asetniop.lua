local Keyboard = {
   homerow = {'a', 's', 'e', 't', 'n', 'i', 'o', 'p'},
   a = {[2] = 'w', [3] = 'x', [4] = 'f', [8] = '-'},
   s = {[3] = 'd', [5] = 'j', [6] = 'k', [7] = '.', [8] = '¨'},
   e = {[4] = 'r', [5] = 'y', [6] = ',', [7] = '+', [8] = 'æ', },
   t = {[2] = 'c', [8] = '<-'},
   n = {[1] = 'q', [4] = 'b'},
   i = {[1] = 'z', [4] = 'v', [5] = 'h', [7] = 'l', [8] = '!'},
   o = {[1] = 'å', [4] = 'g', [5] = 'u', [8] = 'ø'},
   p = {[5] = 'm'},
   -- TODO: Add æøå
   colors = {
      a = {255,103,102}, s = {255,149,75}, e = {255,206,69}, t = {254,255,101},
      n = {104,186,66}, i = {97,235,234}, o = {79,183,255}, p = {178,141,216}
   }
}

function Keyboard:setup(font)
   self.font = font
   self.boxWidth = love.graphics.getWidth() / 8
   self.boxHeight = self.boxWidth / 2
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
			   0, love.graphics.getHeight() - self.boxHeight * 2,
			   love.graphics.getWidth(), self.boxHeight * 2)

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
	 letter = self[self.helper][i]
	 if letter == self.nextLetter then alpha = 255 end
      end
      local colors = self.colors[self.homerow[i]]
      local x = self.boxWidth * (i - 1)
      local y = love.graphics.getHeight() - self.boxHeight * 2
      self:drawBox(letter, x, y, colors, alpha)
   end
end

function Keyboard:drawBox(letter, x, y, colors, alpha)
   self:setColor(colors, alpha)
   love.graphics.rectangle('fill', x, y, self.boxWidth, self.boxHeight)
   if letter then
      love.graphics.setColor(0, 0, 0)
      love.graphics.setFont(self.font)
      lx = (self.boxWidth / 2) - (self.font:getWidth(letter) / 2)
      ly = y  + (self.boxHeight / 2) - (self.font:getHeight(letter) / 2)
      love.graphics.print(letter, lx + x, ly)
   end
end

function Keyboard:setColor(rgb, a)
   if not a then a = 255 end
   love.graphics.setColor(rgb[1]/255, rgb[2]/255, rgb[3]/255, a/255)
end

function Keyboard:findHomerow(letter)
   for i=1,#self.homerow do
      local homerow = self.homerow[i]
      if self:contains(letter, self[homerow]) then
	 return homerow
      end
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
