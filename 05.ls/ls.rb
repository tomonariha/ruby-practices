@COLUMN = 3

def print_list
  get_list
  row = @list.size / @COLUMN
  row += 1 unless @list.size % @COLUMN == 0
  (0..row-1).each do |x|
    (0..@COLUMN-1).each do |number|
      print @list[x + row * number].to_s.ljust(24)
    end
    print "\n"
  end
end

def get_list
  @list = []
  Dir.glob("*"){|f|@list << f}
end

print_list