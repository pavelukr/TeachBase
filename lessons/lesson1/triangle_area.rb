# Площадь треугольника. Площадь треугольника можно вычилсить,
#  зная его основание (a) и высоту (h) по формуле: 1/2*a*h.
#  Программа должна запрашивать основание и высоту треуголиника и возвращать его площадь.

def area(base, height)
  (base * height) * 1 / 2
end

puts 'Input the base of the triangle here: '
base = gets.chomp.to_f
puts 'Input the height of the triangle here: '
height = gets.chomp.to_i
puts "The area of your triangle is #{area(base, height)}"
