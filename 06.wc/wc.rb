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

def bytesize(lines)
  bytesize = []
  lines.each { |b| bytesize << b.bytesize }
  bytesize.sum
end

def line(lines)
  line = []
  lines.each { |l| line << l.scan(/\n/).size }
  line.sum
end

def words(lines)
  word = []
  lines.each { |w| word << w.scan(/\S\s/).size }
  word.sum
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

def print_files(options)
  total_line = []
  total_words = []
  total_bytesize = []
  ARGV.each do |arg|
    file = File.open(arg.to_s)
    lines = file.readlines
    total_line << line(lines)
    total_words << words(lines)
    total_bytesize << bytesize(lines)
    name = arg
    print_list(line(lines), words(lines), bytesize(lines), name, options)
  end
  name = 'total'
  print_list(total_line.sum, total_words.sum, total_bytesize.sum, name, options) if ARGV.size > 1
end

def main
  options = parse_options
  if ARGV == []
    lines = $stdin.readlines
    name = nil
    print_list(line(lines), words(lines), bytesize(lines), name, options)
  else
    print_files(options)
  end
end

main
