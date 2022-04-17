# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../frame'

class FrameTest < Minitest::Test
  def test_frame
    frame = Frame.new([1, 2], :strike)
    assert_equal(6, frame.score)
  end
end
