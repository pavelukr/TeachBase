def roots(a, b, c)
  discriminant = b**2 - 4 * a * c
  if discriminant.negative?
    puts "The equation can't have roots"
  elsif discriminant.zero?
    x = -b / 2 * a
    puts "The equation has only one root : #{x}\n the discriminant = #{discriminant}"
  else
    x1 = (-b + Math.sqrt(discriminant)) / 2
    x2 = (-b - Math.sqrt(discriminant)) / 2
    puts "The equation has two roots:\n first root = #{x1}\n second = #{x2}\n
 the discriminant = #{discriminant}"
  end
end

puts 'Input a: '
a = gets.chomp.to_f
puts 'Input b: '
b = gets.chomp.to_f
puts 'Input c: '
c = gets.chomp.to_f

roots(a, b, c)
