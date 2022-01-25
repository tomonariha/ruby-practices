# frozen_string_literal: true

COLUMN = 3

def print_list
  generate_list
  row = @list.size / COLUMN
  row += 1 unless (@list.size % COLUMN).zero?
  (0..row - 1).each do |x|
    (0..COLUMN - 1).each do |y|
      print @list[x + row * y].to_s.ljust(24)
    end
    print "\n"
  end
end

def generate_list
  @list = []
  Dir.glob('*') { |f| @list << f }
end

print_list
