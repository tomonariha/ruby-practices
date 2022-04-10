# frozen_string_literal: true

require_relative 'frame'

class Game
  def initialize
    @status = :normal
  end

  def culc_points(arg = ARGV[0])
    total_points = []
    generate_frame_data(arg).each.with_index(1) do |score, frame_number|
      frame = Frame.new(score[0], score[1])
      frame.status = @status
      total_points << frame.score
      @status = if frame_number == 10 && (frame.next_status == :strike || frame.next_status == :double_strike)
                  :strike_remainder
                elsif frame_number > 9
                  :normal
                else
                  frame.next_status
                end
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
