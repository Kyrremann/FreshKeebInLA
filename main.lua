gamestate = require('gamestate')
wordpro = require('wordpro')
sideboard = require('sideboard')
font = 'Cousine-Regular.ttf'
Keyboard = require('keyboard')
Keyboards = {
   selected = 'butterstick'
}

function love.load(arg)
   success = love.window.setFullscreen(true)

   local fontSize = love.graphics.getHeight() / 32
   local lsKeyboards = io.popen("ls keyboards")
   if lsKeyboards then
      local keebs = lsKeyboards:read("*a")
      for keeb in keebs:gmatch("[^\r\n]+") do
	 keeb = keeb:sub(1, #keeb - 4)
	 if keeb ~= 'keyboard' then
	    Keyboards[keeb] = require('keyboards/' .. keeb)
	    Keyboards[keeb]:setup(love.graphics.newFont(font, fontSize))
	 end
      end
   else
      print("ERROR - failed to read keebs from keyboard-folder")
      love.event.quit()
   end

   gamestate:setMenu()

   local fontSize = love.graphics.getHeight() / 24
   wordpro:setup('dictionaries/mixed.txt',
		 love.graphics.newFont(font, fontSize),
		 love.graphics.getWidth() / 2)

   background = {
      image = love.graphics.newImage('images/backgroundColorForest.png'),
      y = -64
   }
   background.tiles = love.graphics.getWidth() / background.image:getWidth()

   local fontSize = love.graphics.getHeight() / 24
   menu = {
      font = love.graphics.newFont(font, fontSize),
      y = love.graphics.getHeight() / 2
   }
   menu.fontHeight = menu.font:getHeight('A')
   endScreen = {
      font = menu.font,
      y = love.graphics.getHeight() / 2
   }

   local fontSize = love.graphics.getHeight() / 32
   sideboard:setup(love.graphics.newFont(font, fontSize))
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

      Keyboards:update(wordpro.nextLetter)
   elseif gamestate:isScore() then
   end
end

function love.draw()
   love.graphics.setColor(1, 1, 1)
   for x=0,background.tiles do
      love.graphics.draw(background.image,
			 x * background.image:getWidth(), background.y)
   end

   sideboard:draw()
   Keyboards:draw()
   
   if gamestate:isMenu() then
      darkenScreen()
      love.graphics.setColor(0, 0, 0)
      love.graphics.setFont(menu.font)
      local anyKey = Keyboards:getEnterKeyCombo()
      local message = 'Press ' .. anyKey .. ' to start'
      local x = (love.graphics.getWidth() / 2) - (menu.font:getWidth(message) / 2)
      love.graphics.print(message, x, menu.y)
      message = '< ' .. Keyboards.selected .. ' >'
      x = (love.graphics.getWidth() / 2) - (menu.font:getWidth(message) / 2)
      love.graphics.print(message, x, menu.y + menu.fontHeight)
   elseif gamestate:isGame() then
      wordpro:draw()
   elseif gamestate:isScore() then
      if not endScreen.x then
	 endScreen.message = sideboard.score .. ' points, ' .. sideboard.words .. ' words'
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
      if key == 'left' or key == 'right' then
	 toggleKeyboard()
      elseif Keyboards.selected == 'butterstick' and key == 'a' then
	 newGame()
      elseif Keyboards.selected == 'asetniop' and key == 'return' then
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

function toggleKeyboard()
   if Keyboards.selected == 'butterstick' then
      Keyboards.selected = 'asetniop'
   elseif Keyboards.selected == 'asetniop' then
      Keyboards.selected = 'butterstick'
   end
end

function Keyboards:draw()
   self[self.selected]:draw()
end

function Keyboards:update(nextLetter)
   self[self.selected]:update(nextLetter)
end

function Keyboards:getEnterKeyCombo()
   if self.selected == 'asetniop' then
      return 'n i o p'
   elseif self.selected == 'butterstick' then
      return 'q z'
   end
end
