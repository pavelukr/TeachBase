# Прямоугольный треугольник. Программа запрашивает
#  у пользователя 3 стороны треугольника и определяет,
#  является ли треугольник прямоугольным, используя
#  теорему Пифагора (www-formula.ru) и выводит результат
#  на экран. Также, если треугольник является при этом 
# равнобедренным (т.е. у него равны любые 2 стороны),
#  то дополнительно выводится информация о том, что
#  треугольник еще и равнобедренный. Подсказка: чтобы 
# воспользоваться теоремой Пифагора, нужно сначала найти 
# самую длинную сторону (гипотенуза) и сравнить ее значение 
# в квадрате с суммой квадратов двух остальных сторон.
#  Если все 3 стороны равны, то треугольник равнобедренный и равносторонний, но не прямоугольный.

def type_of_triangle(array_of_side)
  return 'Your triangle has equal sides' if array_of_side[0] == array_of_side[1] &&
                                            array_of_side[0] == array_of_side[2]

  array_of_side.sort
  right_triangle(array_of_side)
end

def right_triangle(array_of_side)
  if array_of_side[0]**2 + array_of_side[1]**2 == array_of_side[2]**2
    print 'Your triangle is right'
    print ' and also has two equal sides' if array_of_side[0] == array_of_side[1]
  else
    print "Your triangle isn't right"
    print ' but it has two equal sides' if array_of_side[0] == array_of_side[1]
  end
end

puts 'Input your first side here: '
first_side = gets.chomp.to_f
puts 'Input your second side here: '
second_side = gets.chomp.to_f
puts 'Input your third side here: '
third_side = gets.chomp.to_f
sides = [first_side, second_side, third_side]
puts type_of_triangle(sides) if type_of_triangle(sides).is_a?(String)
