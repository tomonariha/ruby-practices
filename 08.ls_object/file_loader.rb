# frozen_string_literal: true

class FileLoader
  def generate_list(options)
    file_name_list = []
    if options[:a]
      Dir.foreach('.') { |file_name| file_name_list << file_name }
      file_name_list.sort!
    else
      Dir.glob('*') { |file_name| file_name_list << file_name }
    end
    file_name_list.reverse! if options[:r]
    file_name_list
  end
end
