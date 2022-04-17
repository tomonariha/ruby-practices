# frozen_string_literal: true

require_relative 'frame'

class Game
  def initialize
    @next_status = :normal
  end

  def calc_points(arg = ARGV[0])
    total_points = []
    generate_frame_data(arg).each.with_index(1) do |shot, frame_number|
      frame = Frame.new(shot, @next_status)
      total_points << frame.score
      @next_status = frame.next_status(frame_number)
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
