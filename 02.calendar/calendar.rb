# frozen_string_literal: true

require 'date'
require 'optparse'

class Calendar
  def print_days
    get_first_and_last_day
    print("      #{@first_day.mon}月 #{@first_day.year}\n")
    print(" 日 月 火 水 木 金 土\n")
    @first_day.wday.times do
      print('   ')
    end
    (@first_day..@last_day).each do |day|
      print(' ')
      @this_day = day.day
      print(' ') if @this_day.between?(1, 9)
      if today?
        print("\e[7m#{@this_day}\e[0m")
      else
        print(@this_day)
      end
      print("\n") if day.saturday?
    end
  end

  private

  def get_first_and_last_day
    get_option
    @first_day = Date.new(@year, @month, 1)
    @last_day = Date.new(@year, @month, -1)
  end

  def get_option
    options = ARGV.getopts('m:', 'y:')
    if options['y'].nil?
      @year = Date.today.year
    else
      @year = options['y'].to_i
      unless @year.between?(1, 9999)
        print("cal: year `#{options['y']}' not in range 1..9999")
        exit
      end
    end
    if options['m'].nil?
      @month = Date.today.mon
    else
      @month = options['m'].to_i
      unless @month.between?(1, 12)
        print("cal: #{options['m']} is not a month number(1..12)")
        exit
      end
    end
  end

  def today?
    @year == Date.today.year && @month == Date.today.mon && @this_day == Date.today.day
  end
end

calendar = Calendar.new
calendar.print_days
