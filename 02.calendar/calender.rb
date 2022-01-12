require 'date'
require 'optparse'
def calender
  options = ARGV.getopts('m:','y:')
  if options["y"] == nil
    year = Date.today.year
  else year = options["y"].to_i
    unless year.between?(1, 9999) == true
      print("cal: year `#{options["y"]}' not in range 1..9999")
      exit
    end
  end
  if options["m"] == nil
    month = Date.today.mon
  else month = options["m"].to_i
    unless month.between?(1, 12) == true 
      print("cal: #{options["m"]} is neither a month number(1..12) nor name")
      exit
    end 
  end
  first_day = Date.new(year, month, 1)
  last_day = Date.new(year, month, -1)
  print("      " + first_day.mon.to_s + "月 " + first_day.year.to_s + "\n")
  print(" 日 月 火 水 木 金 土\n")
  first_day.wday.times do
    print("   ")
  end 
  (first_day..last_day).each do |day|
    print(" ")
    if day.day < 10
      print(" ")
    end
    if year == Date.today.year && month == Date.today.mon && day.day == Date.today.day
      print("\e[7m#{day.day}\e[0m")
      if day.saturday? == true
        print("\n")
      end
      next
    end
    print(day.day)
    if day.saturday? == true
      print("\n")
    end
  end
end
calender
