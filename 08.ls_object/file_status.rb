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

  def building_data(file_name, length_list)
    file_status = File.stat(file_name)
    {
      file_type: FILE_TYPES[file_status.ftype.to_s],
      permission: permission(file_status).map { |i| PERMISSIONS[i] }.join,
      nlink: file_status.nlink.to_s.rjust(length_list[:nlink]),
      user_name: Etc.getpwuid(file_status.uid).name.rjust(length_list[:user_name]),
      gloup_name: Etc.getgrgid(file_status.gid).name.rjust(length_list[:gloup_name]),
      size: file_status.size.to_s.rjust(length_list[:size]),
      birth_time: file_status.mtime.strftime(' %_m %e %R '),
      file_name: file_name
    }
  end

  private

  def permission(file_status)
    (format('0%o', file_status.mode).to_i % 1000).digits.reverse
  end
end
