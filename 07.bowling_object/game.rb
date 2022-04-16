# frozen_string_literal: true

require_relative 'frame'

class Game
  def initialize
    @status = :normal
  end

  def calc_points(arg = ARGV[0])
    total_points = []
    generate_frame_data(arg).each.with_index do |shot, frame_number|
      frame = Frame.new(shot)
      frame.status = :strike_remainder if (@status == :strike || @status == :double_strike) && frame_number == 10
      frame.status = @status if frame_number < 10
      total_points << frame.score
      @status = frame.next_status
    end
    total_points.sum
  end

  private

  def generate_frame_data(arg)
    scores = arg.split(',')
    shots = []
    scores.each do |score|
      if score == 'X'
        shots << 10
        shots << 0
      else
        shots << score.to_i
      end
    end
    shots.each_slice(2).to_a
  end
end
