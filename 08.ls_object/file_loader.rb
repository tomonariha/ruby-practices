# frozen_string_literal: true

class FileLoader
  def initialize(options)
    @options = options
  end

  def generate_list
    file_names = []
    if @options[:a]
      Dir.foreach('.') { |file_name| file_names << file_name }
      file_names.sort!
    else
      file_names = Dir.glob('*')
    end
    file_names.reverse! if @options[:r]
    file_names
  end
end
