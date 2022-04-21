# frozen_string_literal: true

require_relative 'frame'

class Game
  def calc_points(score_text)
    prev_status = :normal
    generate_frame_data(score_text).each.with_index(1).sum do |shots, frame_number|
      frame = Frame.new(shots, prev_status)
      prev_status = frame.current_status(frame_number)
      frame.score
    end
  end

  private

  def generate_frame_data(score_text)
    score_text
      .split(',')
      .flat_map { |score| score == 'X' ? [10, 0] : score.to_i }
      .each_slice(2)
      .to_a
  end
end
