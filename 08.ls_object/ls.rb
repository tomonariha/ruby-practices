# frozen_string_literal: true

require 'optparse'
require_relative 'file_loader'
require_relative 'file_printer'

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
file_printer = FilePrinter.new(file_names, options)
file_printer.print_files
