# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../shot'

class ShotTest < Minitest::Test
  def test_shot
    shot = Shot.new('1')
    assert_equal(1, shot.score)
  end
end
