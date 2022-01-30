# frozen_string_literal: true

require 'optparse'

COLUMN = 3

def parse_options
  OptionParser.new do |opt|
    opt.on('-a') { |v| @option_a = v }
    opt.parse!(ARGV)
  end
end

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
  parse_options
  @list = []
  if @option_a
    Dir.foreach('.') { |f| @list << f }
    @list.sort!
  else
    Dir.glob('*') { |f| @list << f }
  end
end

print_list
