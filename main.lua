wordpro = require('wordpro')

function love.load()
   love.window.setMode(1024, 768)

   boxWidth = love.graphics.getWidth() / 8
   boxHeight = boxWidth / 2
   alphabet = {
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
      colours = {
	 a = {255,103,102}, s = {255,149,75}, e = {255,206,69}, t = {254,255,101},
	 n = {104,186,66}, i = {97,235,234}, o = {79,183,255}, p = {178,141,216}
      },
      current = nil
   }

   lastPressed = nil
   pressed = nil
   uppercase = false

   thiccc = love.graphics.newFont('Kenney Thick.ttf', 32)
   typing = {
      x = love.graphics.getWidth() / 2,
      y = boxHeight * 3,
      written = ''
   }

   wordpro:setup(thiccc,
		 love.graphics.getWidth() / 2, boxHeight)

   thicc = love.graphics.newFont('Kenney Thick.ttf', 24)
   letters = {
      x = (boxWidth / 2) - (thicc:getWidth('a') / 2),
      y = love.graphics.getHeight() - (boxHeight / 2) - (thicc:getHeight('a') / 2)
   }

   background = {
      image = love.graphics.newImage('images/backgroundForest.png')
   }
end

function love.update(dt)
   if wordpro:isComplete() then
      wordpro:newWord()
   end

   if pressed then
      alphabet.current = alphabet[pressed]
   else
      alphabet.current = alphabet.homerow
   end
end

function love.draw()
   love.graphics.setColor(1, 1, 1)
   love.graphics.draw(background.image, 0, 0)

   if alphabet.current then
      for i=1,8 do
	 local letter = alphabet.current[i]
	 local alpha = 0.5

	 if pressed == letter then
	    alpha = 1
	 end
	 local colours = alphabet.colours[alphabet.homerow[i]]
	 drawBox(letter, colours, i - 1)
      end
   else
      for i=1,8 do
	 local alpha = 0.5
	 drawBox('', {0.12, 0.12 * i, 0.12, alpha}, i - 1)
      end

      local x = typing.x - thiccc:getWidth('Release to type') / 2
      love.graphics.setColor(1, 1, 1)
      love.graphics.setFont(thicc)
      love.graphics.print('Release to type', x, letters.y)
   end

   wordpro:draw()
end

function drawBox(letter, colours, placement)
   local x = boxWidth * placement
   local y = love.graphics.getHeight() - boxHeight
   setColor(colours)
   love.graphics.rectangle('fill', x, y, boxWidth, boxHeight)
   if letter then
      love.graphics.setColor(0, 0, 0)
      love.graphics.setFont(thicc)
      love.graphics.print(letter, letters.x + x, letters.y)
   end
end

function love.keypressed(key, scancode, isrepeat)
   if key == 'escape' or key == 'q' then
      love.event.quit()
   end

   if key == 'shift' then
      uppercase = true
   end

   pressed = key
end

function love.keyreleased(key)
   if pressed then
      if uppercase then
	 -- TODO turn pressed uppercase
      end
      typing.written = typing.written .. pressed
      wordpro:typing(key)
   end

   pressed = nil
end

function setColor(rgb, a)
   if not a then a = 1 end
   love.graphics.setColor(rgb[1]/255, rgb[2]/255, rgb[3]/255, a)
end
