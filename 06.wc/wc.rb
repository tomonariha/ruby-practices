# frozen_string_literal: true

require 'optparse'

def parse_options
  options = {}
  OptionParser.new do |opt|
    opt.on('-c') { |v| options[:c] = v }
    opt.on('-l') { |v| options[:l] = v }
    opt.on('-w') { |v| options[:w] = v }
    opt.parse!(ARGV)
  end
  options
end

def count_bytesize(lines)
  lines.sum(&:bytesize)
end

def count_line(lines)
  lines.size
end

def count_words(lines)
  lines.sum { |line| line.split(/\s+/).size }
end

def print_list(line, words, bytesize, name, options)
  if !options[:l] && !options[:w] && !options[:c]
    print line.to_s.rjust(8)
    print words.to_s.rjust(8)
    print bytesize.to_s.rjust(8)
  else
    print line.to_s.rjust(8) if options[:l]
    print words.to_s.rjust(8) if options[:w]
    print bytesize.to_s.rjust(8) if options[:c]
  end
  print " #{name}\n"
end

def print_files(file_names, options)
  total_line = []
  total_words = []
  total_bytesize = []
  file_names.each do |file_name|
    file = File.open(file_name.to_s)
    lines = file.readlines
    total_line << count_line(lines)
    total_words << count_words(lines)
    total_bytesize << count_bytesize(lines)
    print_list(count_line(lines), count_words(lines), count_bytesize(lines), file_name, options)
  end
  name = 'total'
  print_list(total_line.sum, total_words.sum, total_bytesize.sum, name, options) if file_names.size > 1
end

def main
  options = parse_options
  if ARGV.empty?
    lines = $stdin.readlines
    name = nil
    print_list(count_line(lines), count_words(lines), count_bytesize(lines), name, options)
  else
    print_files(ARGV, options)
  end
end

main
