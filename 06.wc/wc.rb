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

def bytesize(text)
  bytesize = []
  text.each { |b| bytesize << b.bytesize }
  bytesize.sum
end

def line(text)
  line = []
  text.each { |l| line << l.scan(/\n/).size }
  line.sum
end

def words(text)
  word = []
  text.each { |w| word << w.scan(/\S\s/).size }
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
    text = file.readlines
    total_line << line(text)
    total_words << words(text)
    total_bytesize << bytesize(text)
    name = arg
    print_list(line(text), words(text), bytesize(text), name, options)
  end
  name = 'total'
  print_list(total_line.sum, total_words.sum, total_bytesize.sum, name, options) if ARGV.size > 1
end

def main
  options = parse_options
  if ARGV == []
    text = $stdin.readlines
    name = nil
    print_list(line(text), words(text), bytesize(text), name, options)
  else
    print_files(options)
  end
end

main
