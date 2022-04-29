# frozen_string_literal: true

require 'optparse'
require_relative 'file_loader'
require_relative 'printer'
require_relative 'length_generator'

class Main
  def start
    file_loader = FileLoader.new
    options = parse_options
    file_name_list = file_loader.generate_list(options)
    length_generator = LengthGenerator.new
    printer = Printer.new
    if options[:l]
      length_data = length_generator.length_data(file_name_list)
      printer.print_long(file_name_list, length_data)
    else
      length_data = length_generator.name_length(file_name_list)
      printer.print_short(file_name_list, length_data)
    end
  end

  private

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
end

main = Main.new
main.start
