# frozen_string_literal: true

require 'optparse'
require 'etc'

COLUMN = 3

def parse_options
  OptionParser.new do |opt|
    opt.on('-a') { |v| @option_a = v }
    opt.on('-r') { |v| @option_r = v }
    opt.on('-l') { |v| @option_l = v }
    opt.parse!(ARGV)
  end
end

def print_list(list)
  if @option_l
    sizing_list(list)
  else
    row = list.size / COLUMN
    row += 1 unless (list.size % COLUMN).zero?
    (0...row).each do |x|
      (0...COLUMN).each do |y|
        print list[x + row * y].to_s.ljust(24)
      end
      print "\n"
    end
  end
end

def generate_list
  parse_options
  list = []
  if @option_a
    Dir.foreach('.') { |f| list << f }
    list.sort!
  else
    Dir.glob('*') { |f| list << f }
  end
  list.reverse! if @option_r
  print_list(list)
end

def processing_data(list, **size_data)
  list.each do |file_name|
    file_status = File.stat(file_name)
    origin_number = format('0%o', file_status.mode)
    permission_origin = origin_number.to_i % 1000
    permission_number = permission_origin.digits.reverse
    print_long_list(file_status, file_name, permission_number, **size_data)
  end
end

def sizing_list(list)
  total_blocks = []
  nlink_list = []
  user_list = []
  gloup_list = []
  size_list = []
  list.each do |name|
    file_status = File.stat(name)
    total_blocks << file_status.blocks
    nlink_list << file_status.nlink.to_s.size
    user_list << Etc.getpwuid(file_status.uid).name.size
    gloup_list << Etc.getgrgid(file_status.gid).name.size
    size_list << file_status.size.to_s.size
  end
  print "total #{total_blocks.sum}\n"
  size_data = {nlink_size: nlink_list.max,
               user_size: user_list.max, 
               gloup_size: gloup_list.max,
               size_size: size_list.max}
  processing_data(list, **size_data)
end

def print_long_list(file_status, file_name, permission_number, **size_data)
  margin = 2
  file_type = { 'file' => '-',
                'directory' => 'd',
                'characterSpecial' => 'c',
                'blockSpecial' => 'b',
                'fifo' => 'p',
                'link' => 'l',
                'socket' => 's',
                'unknown' => 'u' }
  permission = { 0 => '---',
                 1 => '--x',
                 2 => '-w-',
                 3 => '-wx',
                 4 => 'r--',
                 5 => 'r-x',
                 6 => 'rw-',
                 7 => 'rwx' }
  print file_type[file_status.ftype.to_s]
  permission_number.each { |i| print permission[i] }
  print file_status.nlink.to_s.rjust(size_data[:nlink_size] + margin)
  print Etc.getpwuid(file_status.uid).name.rjust(size_data[:user_size] + margin -1)
  print Etc.getgrgid(file_status.gid).name.rjust(size_data[:gloup_size] + margin)
  print file_status.size.to_s.rjust(size_data[:size_size] + margin)
  print file_status.mtime.strftime(' %_m %e %R ')
  print file_name
  print "\n"
end

generate_list
