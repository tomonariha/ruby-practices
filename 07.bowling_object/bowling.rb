# frozen_string_literal: true

require_relative 'game'

game = Game.new
puts game.calc_points(ARGV[0])
