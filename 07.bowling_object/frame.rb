# frozen_string_literal: true

class Frame
  BONUS = {
    double_strike: [3, 2],
    strike: [2, 2],
    strike_remainder: [2, 1],
    spare: [2, 1],
    normal: [1, 1]
  }.freeze

  def initialize(shots, prev_status)
    @shots = shots
    @shots[1] ||= 0
    @prev_status = prev_status
  end

  def score
    2.times.sum { |i| @shots[i] * BONUS[@prev_status][i] }
  end

  def current_status(frame_number)
    if strike_remainder?(frame_number)
      :strike_remainder
    elsif last_shot?(frame_number)
      :normal
    elsif double_strike?
      :double_strike
    elsif strike?
      :strike
    elsif spare?
      :spare
    else
      :normal
    end
  end

  private

  def last_shot?(frame_number)
    frame_number >= 10
  end

  def prev_strike_or_double_strike?
    @prev_status == :double_strike || @prev_status == :strike
  end

  def double_strike?
    strike? && prev_strike_or_double_strike?
  end

  def strike?
    @shots[0] == 10
  end

  def strike_remainder?(frame_number)
    strike? && prev_strike_or_double_strike? && frame_number == 10
  end

  def spare?
    !strike? && @shots.sum == 10
  end
end
