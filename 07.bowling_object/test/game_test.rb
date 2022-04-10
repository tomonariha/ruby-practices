# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../game'

class GameTest < Minitest::Test
  def test_game1
    game = Game.new
    assert_equal(139, game.culc_points('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5'))
  end

  def test_game2
    game = Game.new
    assert_equal(164, game.culc_points('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,X,X'))
  end

  def test_game3
    game = Game.new
    assert_equal(107, game.culc_points('0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4'))
  end

  def test_game4
    game = Game.new
    assert_equal(134, game.culc_points('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,0,0'))
  end

  def test_game5
    game = Game.new
    assert_equal(144, game.culc_points('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,1,8'))
  end

  def test_game6
    game = Game.new
    assert_equal(300, game.culc_points('X,X,X,X,X,X,X,X,X,X,X,X'))
  end
end
