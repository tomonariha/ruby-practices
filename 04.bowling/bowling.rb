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
frames.each.with_index(1) do |frame, lane|
  if spare == true
    point += frame[0]
    spare = false
  end
  if strike == true
    if frame[0] == 10
      point += 10
      strike = false
      spare = true
    else
      point += frame[0]
      point += frame[1]
      strike = false
    end
  end
  if frame[0] == 10 # strike
    point += 10
    strike = true if lane < 10
  elsif frame.sum == 10 # spare
    point += 10
    spare = true if lane < 10
  else
    point += frame.sum
  end
end
puts point
