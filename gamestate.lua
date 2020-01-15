local Gamestate = {
   state = NONE,
   MENU = 1,
   GAME = 2,
   SCORE = 3
}

function Gamestate:isMenu()
   return self.state == self.MENU
end

function Gamestate:isGame()
   return self.state == self.GAME
end

function Gamestate:isScore()
   return self.state == self.SCORE
end

function Gamestate:setMenu()
   self.state = self.MENU
end

function Gamestate:setGame()
   self.state = self.GAME
end

function Gamestate:setScore()
   self.state = self.SCORE
end

return Gamestate
