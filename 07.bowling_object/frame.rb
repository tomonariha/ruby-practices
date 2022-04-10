# frozen_string_literal: true

require_relative 'shot'

class Frame
  attr_reader :first_shot, :second_shot
  attr_accessor :status

  def initialize(first_mark, second_mark)
    @first_shot = Shot.new(first_mark)
    @second_shot = Shot.new(second_mark)
    @status = :normal
  end

  BONUS = { double_strike: [3, 2],
            strike: [2, 2],
            strike_remainder: [2, 1],
            spare: [2, 1],
            normal: [1, 1] }.freeze

  def score
    [first_shot.score * BONUS[status][0], second_shot.score * BONUS[status][1]].sum
  end

  def next_status
    if first_shot.score == 10 && (status == :double_strike || status == :strike)
      :double_strike
    elsif first_shot.score == 10
      :strike
    elsif [first_shot.score, second_shot.score].sum == 10
      :spare
    else
      :normal
    end
  end
end
