local Keyboard = {}

function Keyboard:drawBox(letter, x, y, colors, alpha, boxWidth, boxHeight)
   letter = letter:upper()
   boxWidth = boxWidth or self.boxWidth
   boxHeight = boxHeight or self.boxHeight
   self:setColor(colors, alpha)
   love.graphics.rectangle('fill', self.xBase + x, y, self.boxWidth, self.boxHeight)
   if letter then
      love.graphics.setColor(0, 0, 0)
      love.graphics.setFont(self.font)
      local lx = (self.boxWidth / 2) - (self.font:getWidth(letter) / 2)
      local ly = y  + (self.boxHeight / 2) - (self.font:getHeight(letter) / 2)
      love.graphics.print(letter, self.xBase + lx + x, ly)
   end
end

function Keyboard:setColor(rgb, a)
   if not a then a = 255 end
   love.graphics.setColor(rgb[1]/255, rgb[2]/255, rgb[3]/255, a/255)
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
