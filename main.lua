wordpro = require('wordpro')
keyboard = require('keyboard')

function love.load()
   love.window.setMode(1024, 768)

   local boxWidth = love.graphics.getWidth() / 8
   local boxHeight = boxWidth / 2

   keyboard:setup(love.graphics.newFont('Kenney Thick.ttf', 24),
		  boxWidth, boxHeight)
   wordpro:setup(love.graphics.newFont('Kenney Thick.ttf', 32),
		 love.graphics.getWidth() / 2, boxHeight)

   background = {
      image = love.graphics.newImage('images/backgroundForest.png')
   }
end

function love.update(dt)
   if wordpro:isComplete() then
      wordpro:newWord()
   end

   keyboard:update(wordpro.nextLetter)
end

function love.draw()
   love.graphics.setColor(1, 1, 1)
   love.graphics.draw(background.image, 0, 0)

   keyboard:draw()
   wordpro:draw()
end

function love.keypressed(key, scancode, isrepeat)
   if key == 'escape' then
      love.event.quit()
   end
end

function love.keyreleased(key)
   wordpro:typing(key)
end
