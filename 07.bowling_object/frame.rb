# frozen_string_literal: true

class Frame
  def initialize(shot, prev_status)
    @first_shot = shot[0]
    @second_shot = shot[1] ||= 0
    @prev_status = prev_status
  end

  BONUS = { double_strike: [3, 2],
            strike: [2, 2],
            strike_remainder: [2, 1],
            spare: [2, 1],
            normal: [1, 1] }.freeze

  def score
    [@first_shot * BONUS[@prev_status][0], @second_shot * BONUS[@prev_status][1]].sum
  end

  def current_status(frame_number)
    if @first_shot == 10 && (@prev_status == :double_strike || @prev_status == :strike) && frame_number == 10
      :strike_remainder
    elsif frame_number >= 10
      :normal
    elsif @first_shot == 10 && (@prev_status == :double_strike || @prev_status == :strike)
      :double_strike
    elsif @first_shot == 10
      :strike
    elsif [@first_shot, @second_shot].sum == 10
      :spare
    else
      :normal
    end
  end
end
