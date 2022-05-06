# frozen_string_literal: true

require 'etc'

class FileStatus
  FILE_TYPES = {
    'file' => '-',
    'directory' => 'd',
    'characterSpecial' => 'c',
    'blockSpecial' => 'b',
    'fifo' => 'p',
    'link' => 'l',
    'socket' => 's',
    'unknown' => 'u'
  }.freeze

  PERMISSIONS = {
    0 => '---',
    1 => '--x',
    2 => '-w-',
    3 => '-wx',
    4 => 'r--',
    5 => 'r-x',
    6 => 'rw-',
    7 => 'rwx'
  }.freeze

  def initialize(file_name, max_size_and_total_block_size)
    @file_name = file_name
    @max_size_and_total_block_size = max_size_and_total_block_size
    @file_status = File.stat(file_name)
  end

  def building_data
    {
      file_type: FILE_TYPES[@file_status.ftype.to_s],
      permission: permission.map { |i| PERMISSIONS[i] }.join,
      nlink: @file_status.nlink.to_s.rjust(@max_size_and_total_block_size[:max_nlink_size]),
      user_name: Etc.getpwuid(@file_status.uid).name.rjust(@max_size_and_total_block_size[:max_user_name_size]),
      gloup_name: Etc.getgrgid(@file_status.gid).name.rjust(@max_size_and_total_block_size[:max_gloup_name_size]),
      size: @file_status.size.to_s.rjust(@max_size_and_total_block_size[:max_size_size]),
      birth_time: @file_status.mtime.strftime(' %_m %e %R '),
      file_name: @file_name
    }
  end

  private

  def permission
    (format('0%o', @file_status.mode).to_i % 1000).digits.reverse
  end
end
