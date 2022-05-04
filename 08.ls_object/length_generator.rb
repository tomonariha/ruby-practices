# frozen_string_literal: true

require 'etc'

class LengthGenerator
  MARGIN = 2

  def initialize(file_names)
    @file_names = file_names
  end

  def name_length
    { name_length: @file_names.map(&:size).max + MARGIN }
  end

  def length_data
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
      nlink: nlink_list.max + MARGIN,
      user_name: user_list.max + MARGIN - 1,
      gloup_name: gloup_list.max + MARGIN,
      size: size_list.max + MARGIN
    }
  end
end
