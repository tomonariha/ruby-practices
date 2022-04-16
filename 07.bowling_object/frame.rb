# frozen_string_literal: true

class Frame
  attr_reader :first_shot, :second_shot
  attr_accessor :status

  def initialize(shot)
    @first_shot = shot[0]
    @second_shot = shot[1] ||= 0
    @status = :normal
  end

  BONUS = { double_strike: [3, 2],
            strike: [2, 2],
            strike_remainder: [2, 1],
            spare: [2, 1],
            normal: [1, 1] }.freeze

  def score
    [first_shot * BONUS[status][0], second_shot * BONUS[status][1]].sum
  end

  def next_status
    if first_shot == 10 && (status == :double_strike || status == :strike)
      :double_strike
    elsif first_shot == 10
      :strike
    elsif [first_shot, second_shot].sum == 10
      :spare
    else
      :normal
    end
  end
end
