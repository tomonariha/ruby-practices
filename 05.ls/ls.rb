list = []
Dir.glob("*"){|f|list << f}
@LINE = 3
@karam = list.size / @LINE
@karam += 1 unless list.size % @LINE == 0
(0..@karam-1).each do |x|
  (0..@LINE-1).each do |number|
    print list[x + @karam * number].to_s.ljust(24)
  end
  print "\n"
end