#Заполнить массив числами фибоначи до 100

def fibonacci
  array = [0, 1]
  (2..100).each do |i|
    array[i] = array[i - 1] + array[i - 2]
    break if array[i] > 100
    i += 1
  end
  array.delete_at(array.length - 1)
  array.each { |value| print "#{value} " }
end

fibonacci
