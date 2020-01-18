gamestate = require('gamestate')
wordpro = require('wordpro')
keyboard = require('keyboard')
sideboard = require('sideboard')

function love.load()
   love.window.setMode(1024, 768)
   gamestate:setMenu()

   local boxWidth = love.graphics.getWidth() / 8
   local boxHeight = boxWidth / 2

   keyboard:setup(love.graphics.newFont('Kenney Thick.ttf', 24),
		  boxWidth, boxHeight)
   wordpro:setup('dictionaries/mixed.txt',
		 love.graphics.newFont('Kenney Thick.ttf', 32),
		 love.graphics.getWidth() / 2)

   background = {
      image = love.graphics.newImage('images/backgroundColorForest.png'),
      x = 0,
      y = -64
   }

   menu = {
      font = love.graphics.newFont('Kenney Thick.ttf', 32),
      message = 'Press any key to start',
      y = love.graphics.getHeight() / 2
   }
   menu.x = (love.graphics.getWidth() / 2) - (menu.font:getWidth(menu.message) / 2)
   endScreen = {
      font = menu.font,
      y = love.graphics.getHeight() / 2
   }

   sideboard:setup(love.graphics.newFont('Kenney Thick.ttf', 24))
end

function love.update()
   if gamestate:isMenu() then
   elseif gamestate:isGame() then
      sideboard:update()
      if wordpro:isComplete() then
	 sideboard:newWord(wordpro.current, wordpro.typingCorrectlyWord)
	 wordpro:newWord()
      end
      if sideboard:timesUp() then
	 gamestate:setScore()
      end

      keyboard:update(wordpro.nextLetter)
   elseif gamestate:isScore() then
   end
end

function love.draw()
   love.graphics.setColor(1, 1, 1)
   love.graphics.draw(background.image,
		      background.x, background.y)
   sideboard:draw()
   keyboard:draw()
      
   if gamestate:isMenu() then
      darkenScreen()
      love.graphics.setColor(0, 0, 0)
      love.graphics.setFont(menu.font)
      love.graphics.print(menu.message, menu.x, menu.y)
   elseif gamestate:isGame() then
      wordpro:draw()
   elseif gamestate:isScore() then
      if not endScreen.x then
	 endScreen.message = sideboard.score .. 'points'
	 endScreen.x = (love.graphics.getWidth() / 2) -
	    (endScreen.font:getWidth(endScreen.message) / 2)
      end
      darkenScreen()
      love.graphics.setColor(0, 0, 0)
      love.graphics.setFont(endScreen.font)
      love.graphics.print(endScreen.message, endScreen.x, endScreen.y)
   end
end

function love.keypressed(key, scancode, isrepeat)
   if gamestate:isMenu() then
      if key == 'escape' then
	 love.event.quit()
      end
   elseif gamestate:isGame() then
      if key == 'escape' then
	 gamestate:setMenu()
      end
   elseif gamestate:isScore() then
      if key == 'escape' or
	 key == 'space'
      then
	 endScreen.x = nil
	 gamestate:setMenu()
      end
   end
end

function love.keyreleased(key)
   if gamestate:isMenu() then
      if key ~= 'escape' then
	 newGame()
      end
   elseif gamestate:isGame() then
      wordpro:typing(key)
      sideboard:typing(wordpro.typingCorrectlyLetter)
   elseif gamestate:isScore() then
   end
end

function darkenScreen()
   love.graphics.setColor(0, 0, 0, 0.3)
   love.graphics.rectangle('fill', 0, 0,
			   love.graphics.getWidth(),
			   love.graphics.getHeight())
end

function newGame()
   gamestate:setGame()
   wordpro:newWord()
   sideboard:start()
end
