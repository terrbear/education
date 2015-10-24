gem 'colorize'
require 'colorize'

WORDS = {}

begin
  File.read(ARGV.first).split("\n").sample(20).each do |line|
    word, explanation = line.split(':')
    WORDS[word] = explanation
    puts "added word: #{word}"
  end
rescue
  $stderr.puts "Have to provide a filename for words"
  exit 1
end

right = wrong = 0
wrong_words = []
name = ''

at_exit do
  puts "#{name}'s report card:"
  puts "You spelled a total of #{right + wrong} words."
  
  if(wrong == 0)
    puts "You spelled all the words right!".colorize(:green)
  else
    puts "#{"%.0f" % (right / (right + wrong).to_f * 100)}% right".colorize(:green)
    puts "#{"%.0f" % (wrong / (right + wrong).to_f * 100)}% wrong".colorize(:red)
    puts "Wrong words: #{wrong_words.join(', ')}".colorize(:red)
  end
  puts
  puts

  exit
end

puts "Type your name!"
name = STDIN.gets.chomp

puts "Hi, #{name}. Let's see how well you spell!"

while WORDS.any?
  puts
  word = WORDS.keys.sample
  explanation = WORDS.delete(word)

  input = ''

  loop do
    `say the word is: #{word}`
    if explanation
      sleep 0.5
      `say #{explanation}`
    end
    print "Spell it! > "
    input = STDIN.gets.chomp
    break if input.to_s != ''
  end

  if word == input
    right += 1
    puts "You got it right! Let's go again!".colorize(:green)
  else
    wrong += 1
    wrong_words << word
    puts "You got it wrong. It's spelled: #{word.scan(/./).join('-').upcase}. Better luck next time!".colorize(:red)
  end
  sleep 1
end

