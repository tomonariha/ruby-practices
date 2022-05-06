# frozen_string_literal: true

require_relative 'file_status'
require 'etc'

class FilePrinter
  COLUMN = 4
  MARGIN = 2

  def initialize(options)
    @options = options
    @file_names =
      if @options[:a]
        Dir.foreach('.').to_a.sort!
      else
        Dir.glob('*')
      end
  end

  def print_files
    @file_names.reverse! if @options[:r]
    if @options[:l]
      print_long
    else
      print_short
    end
  end

  private

  def print_short
    max_name_size = @file_names.map(&:size).max + MARGIN
    row = @file_names.size / COLUMN
    row += 1 unless (@file_names.size % COLUMN).zero?
    (0...row).each do |x|
      (0...COLUMN).each do |y|
        print @file_names[x + row * y].to_s.ljust(max_name_size)
      end
      print "\n"
    end
  end

  def print_long
    max_size_and_total_block_size = generate_max_size_and_total_block_size
    puts "total #{max_size_and_total_block_size[:total_block_size]}"
    @file_names.each do |file_name|
      file_status = FileStatus.new(file_name, max_size_and_total_block_size)
      puts file_status.building_data.values.join
    end
  end

  def generate_max_size_and_total_block_size
    total_blocks = []
    nlink_list = []
    user_list = []
    gloup_list = []
    size_list = []
    @file_names.each do |file_name|
      file_status = File.stat(file_name)
      total_blocks << file_status.blocks
      nlink_list << file_status.nlink.to_s.size
      user_list << Etc.getpwuid(file_status.uid).name.size
      gloup_list << Etc.getgrgid(file_status.gid).name.size
      size_list << file_status.size.to_s.size
    end
    {
      total_block_size: total_blocks.sum,
      max_nlink_size: nlink_list.max + MARGIN,
      max_user_name_size: user_list.max + MARGIN - 1,
      max_gloup_name_size: gloup_list.max + MARGIN,
      max_size_size: size_list.max + MARGIN
    }
  end
end
