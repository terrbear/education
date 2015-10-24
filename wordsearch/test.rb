require "minitest/autorun"

ARGV[0] ||= "nate.txt"
require File.join(File.dirname(__FILE__), "wordsearch.rb")

puts "TESTING!".colorize(:white)

class WordTest < Minitest::Test
  def setup
  end

  def test_teacher
    assert_equal [13, 0, 13, 6], find('TEACHER')
  end

  def test_reading
    assert_equal [14, 0, 14, 6], find('READING')
  end

  def test_social_studies
    assert_equal [0, 0, 12, 12], find('SOCIALSTUDIES')
  end

  def test_writing
    assert_equal [7, 17, 13, 17], find('WRITING')
  end

  def test_olar
    assert_equal [0, 8, 3, 5], find('olar')
  end

  def test_laicos
    assert_equal [5, 5, 0, 0], find('laicos')
  end

  def test_seiduts
    assert_equal [12, 12, 6, 6], find('seiduts')
  end

  def test_ralo
    assert_equal [3, 5, 0, 8], find('ralo')
  end

  def test_desk
    assert_equal [3, 0, 0, 3], find('desk')
  end

  def test_bus
    assert_equal [1, 9, 3, 7], find('bus')
  end

  def test_computer
    assert_equal [9, 2, 2, 9], find('computer')
  end

  def test_spelling
    assert_equal [2, 0, 9, 7], find('spelling')
  end

  def test_principal
    assert_equal [14, 9, 6, 17], find('principal')
  end

  def test_lunch
    assert_equal [5, 17, 9, 13], find('lunch')
  end

  def test_lunch_backwards
    assert_equal [9, 13, 5, 17], find('lunch'.reverse)
  end
end
