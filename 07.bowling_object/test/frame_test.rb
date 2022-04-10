# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../frame'

class FrameTest < Minitest::Test
  def test_frame
    frame = Frame.new(1, 2)
    assert_equal(3, frame.score)
  end
end
