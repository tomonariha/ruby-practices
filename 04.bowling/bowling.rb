# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  if s == 'X' # strike
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = shots.each_slice(2).to_a
point = 0
spare = false # spare flag
strike = false # strike flag
double_strike = false # double strike flag
frames.each.with_index(1) do |frame, lane|
  if spare
    point += frame[0]
    spare = false
  end
  if double_strike
    point += frame[0]
    double_strike = false
  end
  if strike 
    if frame[0] == 10
      point += 10
      strike = false
      double_strike = true
    else
      point += frame.sum
      strike = false
    end
  end
  if lane.between?(1,9)
    if frame[0] == 10 # strike
      strike = true 
    elsif frame.sum == 10 # spare
      spare = true
    end 
  end
  point += frame.sum
end
puts point
