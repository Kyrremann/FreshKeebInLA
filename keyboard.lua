local Keyboard = {}

function Keyboard.drawBox(keeb, letter, x, y, colors, alpha, boxWidth, boxHeight)
   letter = letter:upper()
   boxWidth = boxWidth or keeb.boxWidth
   boxHeight = boxHeight or keeb.boxHeight
   Keyboard.setColor(colors, alpha)
   love.graphics.rectangle('fill', x + keeb.xBase, y, boxWidth, boxHeight)
   if letter then
      love.graphics.setColor(0, 0, 0)
      love.graphics.setFont(keeb.font)
      local lx = (boxWidth / 2) - (keeb.font:getWidth(letter) / 2)
      local ly = y  + (boxHeight / 2) - (keeb.font:getHeight(letter) / 2)
      love.graphics.print(letter, keeb.xBase + lx + x, ly)
   end
end

function Keyboard.setColor(rgb, a)
   if not a then a = 255 end
   love.graphics.setColor(rgb[1]/255, rgb[2]/255, rgb[3]/255, a/255)
end

function Keyboard.contains(letter, list)
   for i,v in pairs(list) do
      if letter == v then
	 return true
      end
   end

   return false
end

return Keyboard
