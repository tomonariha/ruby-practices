# frozen_string_literal: true

require_relative 'file_status'

class Printer
  COLUMN = 4

  def print_short(file_name_list, length_list)
    row = file_name_list.size / COLUMN
    row += 1 unless (file_name_list.size % COLUMN).zero?
    (0...row).each do |x|
      (0...COLUMN).each do |y|
        print file_name_list[x + row * y].to_s.ljust(length_list[:name_length])
      end
      print "\n"
    end
  end

  def print_long(file_name_list, length_list)
    puts "total #{length_list[:total_block_size]}"
    file_name_list.each do |file_name|
      file_status = FileStatus.new
      puts file_status.building_data(file_name, length_list).values.join
    end
  end
end
