#!/usr/bin/env ruby

easy = File.open('easy.txt', 'w')
medium = File.open('medium.txt', 'w')
hard = File.open('hard.txt', 'w')

File.foreach('words_alpha.txt') do |line|
  word = line.chomp
  length = word.length
  if (3..4).cover? length
    easy.puts word if rand > 0.9
  end
  if (4..6).cover? length
    medium.puts word if rand > 0.98
  end
  if (4..8).cover? length
    hard.puts word if rand > 0.993
  end
end

easy.close
medium.close
hard.close


mixed = File.open('mixed.txt', 'w')

File.foreach('commons.txt') do |line|
  word = line.chomp
  length = word.length
  if length > 6
    mixed.puts word if  rand > 0.6
  elsif (4..6).cover? length
    mixed.puts word
  end
end

mixed.close
