# frozen_string_literal: true

require 'optparse'
require_relative 'file_loader'
require_relative 'printer'
require_relative 'length_generator'

def parse_options
  options = {}
  OptionParser.new do |opt|
    opt.on('-a') { |v| options[:a] = v }
    opt.on('-r') { |v| options[:r] = v }
    opt.on('-l') { |v| options[:l] = v }
    opt.parse!(ARGV)
  end
  options
end

options = parse_options
file_loader = FileLoader.new(options)
file_names = file_loader.generate_list
length_generator = LengthGenerator.new(file_names)
if options[:l]
  length_data = length_generator.length_data
  printer = Printer.new(file_names, length_data)
  printer.print_long
else
  name_length = length_generator.name_length
  printer = Printer.new(file_names, name_length)
  printer.print_short
end
