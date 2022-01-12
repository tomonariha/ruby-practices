require 'date'
require 'optparse'
def calender
  options = ARGV.getopts('m:','y:')
  if options["y"] == nil
    year = Date.today.year
  else year = options["y"].to_i
  end
  if options["m"] == nil
    month = Date.today.mon
  else month = options["m"].to_i
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
    print(day.day)
    if day.saturday? == true
      print("\n")
    end
  end
end
calender