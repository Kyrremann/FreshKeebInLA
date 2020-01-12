local WordPro = {
   dictionary = {'train', 'snow', 'monkey', 'skiing'}
}

function WordPro:setup(font, x, y)
   self.font = font
   self.x = x
   self.y = y
   self:newWord()
end

function WordPro:newWord()
   self.current = 'train'
   self.typed = ''
   self.left = self.current
   self.typingCorrectly = true
end

function WordPro:typing(letter)
   local nextLetter = self.left[1]
   if letter != nextLetter then
      self.typingCorrectly = false
      return
   end

   table.remove(self.left, 1)
   table.append(self.typed, letter)
end

function WordPro:draw()
   -- TODO tegn det som gjenstår på høyre side av skjermen
   -- og det som de har skrevet på venstre side av skjermen
   --   local x = typing.x - thiccc:getWidth(typing.written) / 2
   --   love.graphics.setColor(1, 1, 1)
   --   love.graphics.setFont(thiccc)
   --   love.graphics.print(typing.written, x, typing.y)

   love.graphics.setColor(1, 1, 1)
   love.graphics.setFont(self.font)
   love.graphics.print(word.current, word.x, word.y)
end
