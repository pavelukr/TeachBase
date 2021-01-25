def months_count_for_leap_year(month)
  days = 0
  months = year_leap
  (1..month - 1).each do |i|
    days += months[i.to_s]
  end
  days
end

def months_count_for_non_leap_year(month)
  days = 0
  months = year_non_leap
  (1..month - 1).each do |i|
    days += months[i.to_s]
  end
  days
end

def sum_of_days(month, year)
  if (year % 4).zero?
    months_count_for_leap_year(month)
  else
    months_count_for_non_leap_year(month)
  end
end

def day_year(day, month, year)
  days_month = sum_of_days(month, year)
  puts "#{days_month + day} is your number in current year"
end

def year_leap
  months = {
    '1' => 31, '2' => 29, '3' => 31, '4' => 30,
    '5' => 31, '6' => 30, '7' => 31, '8' => 31,
    '9' => 30, '10' => 31, '11' => 30, '12' => 31
  }
end

def year_non_leap
  months = {
    '1' => 31, '2' => 28, '3' => 31, '4' => 30,
    '5' => 31, '6' => 30, '7' => 31, '8' => 31,
    '9' => 30, '10' => 31, '11' => 30, '12' => 31
  }
end

puts 'Input day of the month: '
day = gets.chomp.to_i
puts 'Input month by number: '
month = gets.chomp.to_i
puts 'Input year: '
year = gets.chomp.to_i
day_year(day, month, year)
