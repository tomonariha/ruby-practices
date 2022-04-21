# frozen_string_literal: true

require_relative 'frame'

class Game
  def calc_points(arg = ARGV[0])
    prev_status = :normal
    total_points = []
    generate_frame_data(arg).each.with_index(1) do |shot, frame_number|
      frame = Frame.new(shot, prev_status)
      total_points << frame.score
      prev_status = frame.current_status(frame_number)
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
