# frozen_string_literal: true

require 'optparse'

COLUMN = 3

def parse_options
  OptionParser.new do |opt|
    opt.on('-a') { |v| @option_a = v }
    opt.on('-r') { |v| @option_r = v }
    opt.parse!(ARGV)
  end
end

def print_list
  generate_list
  row = @list.size / COLUMN
  row += 1 unless (@list.size % COLUMN).zero?
  (0...row).each do |x|
    (0...COLUMN).each do |y|
      print @list[x + row * y].to_s.ljust(24)
    end
    print "\n"
  end
end

def generate_list
  parse_options
  @list = []
  if @option_a
    Dir.glob('*', File::FNM_DOTMATCH) { |f| @list << f }
  else
    Dir.glob('*') { |f| @list << f }
  end
  @list.reverse! if @option_r
end

print_list
