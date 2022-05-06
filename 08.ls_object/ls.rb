# frozen_string_literal: true

require 'optparse'
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
FilePrinter.new(options).print_files
