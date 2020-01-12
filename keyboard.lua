local Keyboard = {
   homerow = {'a', 's', 'e', 't', 'n', 'i', 'o', 'p'},
   a = {[2] = 'w', [3] = 'x', [4] = 'f', [8] = '?'},
   s = {[3] = 'd', [5] = 'j', [6] = 'k', [7] = '.', [8] = ')'},
   e = {[4] = 'r', [5] = 'y', [6] = ',', [7] = '-', [8] = ',', },
   t = {[8] = '<-'},
   n = {[1] = 'q', [4] = 'b'},
   i = {[1] = 'z', [4] = 'v', [5] = 'h', [7] = 'l', [8] = '!'},
   o = {[1] = '(', [4] = 'g', [5] = 'u', [8] = ';'},
   p = {[5] = 'm'},
   -- TODO: Add æøå
   colors = {
      a = {255,103,102}, s = {255,149,75}, e = {255,206,69}, t = {254,255,101},
      n = {104,186,66}, i = {97,235,234}, o = {79,183,255}, p = {178,141,216}
   }
}

function Keyboard:setup(font, boxWidth, boxHeight)
   self.alphabet = self.homerow
   self.font = font
   self.boxWidth = boxWidth
   self.boxHeight = boxHeight
   self.letters = {
      x = (boxWidth / 2) - (font:getWidth('a') / 2),
      y = love.graphics.getHeight() - (boxHeight / 2) - (font:getHeight('a') / 2)
   }
end

function Keyboard:update()
   if pressed then -- TODO
      self.alphabet = self[pressed]
   else
      self.alphabet = self.homerow
   end
end

function Keyboard:draw()
   if self.alphabet then
      for i=1,8 do
	 local letter = self.alphabet[i]
	 local colors = self.colors[self.homerow[i]]
	 self:drawBox(letter, colors, i - 1)
      end
   else
      for i=1,8 do
	 self:drawBox('', {0.12, 0.12 * i, 0.12, 0.5}, i - 1)
      end
   end
end

function Keyboard:drawBox(letter, colors, placement)
   local x = self.boxWidth * placement
   local y = love.graphics.getHeight() - self.boxHeight
   self:setColor(colors)
   love.graphics.rectangle('fill', x, y, self.boxWidth, self.boxHeight)
   if letter then
      love.graphics.setColor(0, 0, 0)
      love.graphics.setFont(self.font)
      love.graphics.print(letter, self.letters.x + x, self.letters.y)
   end
end

function Keyboard:setColor(rgba)
   if not rgba[4] then rgba[4] = 255 end
   love.graphics.setColor(rgba[1]/255, rgba[2]/255, rgba[3]/255, rgba[4]/255)
end

return Keyboard
