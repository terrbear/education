#!/usr/bin/env ruby
#
require 'colorize'

$debug = false

$lines = File.read(ARGV[0])

$width = $lines.split("\n").first.scan(/./).join(' ').size

#put words to find here. case insensitive
words_to_find = %w(ART BACKPACK BUS CAFETERIA CALENDAR CLASSROOM COMPUTER CRAYONS DESK ERASER FOLDER FRIENDSHIP GLOBE GLUE GYM LUNCH MAP MUSIC PENCIL PRINCIPAL RULER SCIENCE SCISSOR SOCIALSTUDIES STUDENT THINKINGCAP WELCOME WRITING)

def debug(str)
  return unless $debug
  puts str
end

def print_board(x0, y0, x1, y1)
  x_range = ([x0, x1].min .. [x0, x1].max).to_a
  y_range = ([y0, y1].min .. [y0, y1].max).to_a

  x_range.reverse! if(x0 < x1)
  y_range.reverse! if(y0 < y1)

  if x_range.size != y_range.size
    red_letters = x_range.product(y_range)
  else
    red_letters = [x_range, y_range].transpose
  end

  debug ["x0:#{x0}", "y0:#{y0}", "x1:#{x1}", "y1:#{y1}"].join(', ')

  $lines.split("\n").each_with_index do |line, row|
    chars = line.scan(/./)
    chars.each_with_index do |char, col|
      if(red_letters.index([row, col]))
        print char.colorize(:red)
      else
        print char
      end
      print " "
    end
    puts
  end
end

def find(word)
  w = word.upcase
  match = find_horizontal(w) || find_vertical(w) || find_diagnoal(w)
  puts match.inspect
  if match && match.size == 4
    puts " #{w} ".center($width, "*")
  end
  match
end

def find_horizontal(word)
  board = $lines.split("\n").map{|line| line.split(" ")}

  board.each_with_index do |row, index|
    line = row.join('')

    found = line.index(word)
    return [index, found, index, (found + word.size) - 1] if found

    found = line.reverse.index(word)
    return [index, line.size - found - word.size, index, line.size - found - 1] if found
  end
  nil
end

def find_vertical(word)
  board = $lines.split("\n").map{|line| line.scan(/./)}.transpose

  board.each_with_index do |col, index|
    line = col.join('')

    found = line.index(word)
    return [found, index, found + word.size - 1, index] if found

    found = line.reverse.index(word)
    return [line.size - found - word.size, index, line.size - found - 1, index] if found
  end
  nil
end

def northwest_diagonal(word)
  lines = $lines.split("\n")
  height = lines.size
  width = lines.first.size

  (-width .. width).each do |col_start|
    col = col_start
    str = ''

    height.times do |row|
      if col >= 0
        str += lines[row][col].to_s
      else
        str += '0'
      end
      col += 1
    end

    found = str.index(word)
    if found
      return [found,
              col_start + found,
              found + word.size - 1,
              col_start + found + word.size - 1]
    end

    found = str.reverse.index(word)
    if found
      puts "found it reversed NW"
      puts str
      row = str.size - found - 1
      puts "found: #{found}"
      puts "col_start: #{col_start}"
      col = col_start + row
      return [row, col, row - word.size + 1, col - word.size + 1]
    end
  end

  nil
end

def northeast_diagonal(word)
  lines = $lines.split("\n")
  height = lines.size
  width = lines.first.size

  #my math got a little screwy w/ the absolute value, but the consequence is just checking
  #some of the diagonals twice (which already didn't match, so nbd)
  (width * 3).times do |col_start|
    col = (width - (col_start + 1)).abs
    str = ''

    height.times do |row|
      if col >= 0 && col <= width
        str += lines[row][col].to_s
      else
        str += '0'
      end
      col -= 1
    end

    found = str.index(word)

    if found
      if col_start > width
        zeros = str[/0*/].size

        row = found + 1
        col = col_start - width - found

        return [row, col, row + word.size - 1, col - word.size + 1]
      end

      return [found,
              width - col_start - found - 1,
              found + word.size - 1,
              width - col_start - found - word.size] if found
    end


    found = str.reverse.index(word)
    if found
      found = str.size - found

      if col_start > width
        zeros = str[/0*/].size
        row = height - (height - word.size) + (found - word.size)
        #col = width - (col_start + (width - col_start - word.size - (found - word.size))) - zeros
        col = col_start - width - found + 1
        return [row, col, row - word.size + 1, col + word.size - 1]
      else
        return [height - (height - word.size) - 1 + (found - word.size),
                (width - col_start - word.size - (found - word.size)),
                height - (height - word.size) - word.size + (found - word.size),
                width - col_start - 1 - (found - word.size)]
      end
    end
  end

  nil
end

def find_diagnoal(word)
  northwest_diagonal(word) || northeast_diagonal(word)
end

if __FILE__ == $0
  puts "HI!".colorize(:white)
  puts
  puts

  if ARGV[1]
    print_board(*find(ARGV[1].upcase))
  else
    words_to_find.each do |word|
      puts
      print_board(*find(word))
    end
  end
end
