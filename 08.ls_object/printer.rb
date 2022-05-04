# frozen_string_literal: true

require_relative 'file_status'

class Printer
  COLUMN = 4

  def initialize(file_names, length_data)
    @file_names = file_names
    @length_data = length_data
  end

  def print_short
    row = @file_names.size / COLUMN
    row += 1 unless (@file_names.size % COLUMN).zero?
    (0...row).each do |x|
      (0...COLUMN).each do |y|
        print @file_names[x + row * y].to_s.ljust(@length_data[:name_length])
      end
      print "\n"
    end
  end

  def print_long
    puts "total #{@length_data[:total_block_size]}"
    @file_names.each do |file_name|
      file_status = FileStatus.new(file_name, @length_data)
      puts file_status.building_data.values.join
    end
  end
end
