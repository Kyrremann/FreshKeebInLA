local WordPro = {
   dictionary = {}
}

function WordPro:setup(file, font, center, y)
   self.font = font
   self.center = center
   self.y = y

   for line in io.lines(file) do 
      self.dictionary[#self.dictionary + 1] = line
   end

   self:newWord()
end

function WordPro:isComplete()
   return #self.left == 0
end

function WordPro:newWord()
   self.current = self.dictionary[math.random(1, #self.dictionary)]
   self.typed = ''
   self.left = self.current
   self.typingCorrectly = true
   self.letter = ''
   self.nextLetter = self.left:sub(1, 1)
   self.letterWidth = self.font:getWidth(self.letter)
   self.nextLetterWidth = self.font:getWidth(self.nextLetter)
end

function WordPro:typing(letter)
   self.nextLetter = self.left:sub(1, 1)

   if letter ~= self.nextLetter then
      self.typingCorrectly = false
      return
   end
   self.typingCorrectly = true

   self.left = self.left:sub(2)
   self.typed = self.typed .. letter
   self.letter = self.nextLetter
   self.nextLetter = self.left:sub(1,1)
   self.letterWidth = self.font:getWidth(self.letter)
   self.nextLetterWidth = self.font:getWidth(self.nextLetter)

   self.typedX = self.center - self.font:getWidth(self.typed)
end

function WordPro:draw()
   love.graphics.setFont(self.font)

   if self.typed ~= '' then
      love.graphics.setColor(1, 1, 1)
      love.graphics.print(self.letter, self.center - self.letterWidth, self.y)
      love.graphics.setColor(1, 1, 1, 0.75)
      love.graphics.print(self.typed:sub(1, #self.typed - 1), self.typedX, self.y)
   end

   love.graphics.setColor(0, 1, 0)
   if not self.typingCorrectly then
      love.graphics.setColor(1, 0, 0)
   end

   love.graphics.print(self.nextLetter, self.center, self.y)
   love.graphics.setColor(1, 1, 1, 0.75)
   love.graphics.print(self.left:sub(2), self.center + self.nextLetterWidth, self.y)
end

return WordPro
