#!/usr/bin/env ruby

gem 'colorize'
require 'colorize'
require 'timeout'

t0 = Time.now

$right = 0
$wrong = 0

at_exit do
  out = "You finished in #{"%.0f" % (Time.now - t0)} seconds!\n"
  out += "You solved a total of #{$right + $wrong} equations.\n"
  out += "You got #{$right / ($right + $wrong).to_f * 100} (#{$right}) correct!\n".colorize(:green)
  out += "You got #{$wrong / ($right + $wrong).to_f * 100} (#{$wrong}) incorrect!\n".colorize(:red)

  File.open("division.stats", "a") do |f|
    f.write("-" * 80)
    f.write("\n")
    f.write(Time.now.to_s)
    f.write("\n")
    f.write(out)
    f.write("-" * 80)
    f.write("\n")
    f.write("\n")
  end
  puts out
end

TIMER = 5000
QUESTIONS = 100

# NATE DON'T TOUCH BELOW THIS LINE
# --------------------------------


QUESTIONS.times do |test|
  left = (1..12).to_a.sample
  right = (1..12).to_a.sample

  left = left * right

  answer = 1000000
  ts = Time.now

  print "#{test + 1})   #{left} ÷ #{right} = "
  answer = gets.chomp

  if answer.to_i == (left / right)
    if (Time.now - ts > TIMER)
      puts "TIME!".colorize(:orange)
      $wrong += 1
    else
      $right += 1
    end
    puts "Y".colorize(:green)
  else
    puts "X (#{left / right})".colorize(:red)
    $wrong += 1
  end
end
