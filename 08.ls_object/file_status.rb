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

  def initialize(file_name, length_data)
    @file_name = file_name
    @length_data = length_data
    @file_status = File.stat(file_name)
  end

  def building_data
    {
      file_type: FILE_TYPES[@file_status.ftype.to_s],
      permission: permission.map { |i| PERMISSIONS[i] }.join,
      nlink: @file_status.nlink.to_s.rjust(@length_data[:nlink]),
      user_name: Etc.getpwuid(@file_status.uid).name.rjust(@length_data[:user_name]),
      gloup_name: Etc.getgrgid(@file_status.gid).name.rjust(@length_data[:gloup_name]),
      size: @file_status.size.to_s.rjust(@length_data[:size]),
      birth_time: @file_status.mtime.strftime(' %_m %e %R '),
      file_name: @file_name
    }
  end

  private

  def permission
    (format('0%o', @file_status.mode).to_i % 1000).digits.reverse
  end
end
