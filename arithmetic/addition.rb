#!/usr/bin/env ruby

gem 'colorize'
require 'colorize'
require 'timeout'

t0 = Time.now

TIMER = 4

$right = 0
$wrong = 0

at_exit do
  puts "You finished in #{"%.0f" % (Time.now - t0)} seconds!"
  puts "You solved a total of #{$right + $wrong} equations."
  puts "You got #{$right / ($right + $wrong).to_f * 100}% (#{$right}) correct!".colorize(:green)
  puts "You got #{$wrong / ($right + $wrong).to_f * 100}% (#{$wrong}) incorrect!".colorize(:red)
end

100.times do |test|
  left = (2..9).to_a.sample
  right = (2..9).to_a.sample
  answer = -1

  begin
    Timeout::timeout(4) do
      print "#{test})   #{left} + #{right} = "
      answer = gets.chomp
    end
  rescue Timeout::Error
    puts
  end

  if answer.to_i == (left + right)
    $right += 1
  else
    $wrong += 1
  end
end
