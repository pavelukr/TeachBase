#Сумма покупок. Пользователь вводит поочередно название товара,
# цену за единицу и кол-во купленного товара (может быть нецелым числом).
# Пользователь может ввести произвольное кол-во товаров до тех пор,
# пока не введет "стоп" в качестве названия товара. На основе введенных данных требуетеся:
#Заполнить и вывести на экран хеш, ключами которого являются названия товаров,
# а значением - вложенный хеш, содержащий цену за единицу товара и кол-во купленного товара.
# Также вывести итоговую сумму за каждый товар.
# Вычислить и вывести на экран итоговую сумму всех покупок в "корзине".

def input_products()
  $bucket_list = Hash.new(0)
  loop do
    puts 'Input name of the product: '
    name = gets.chomp
    puts 'Input price for one amount of this product: '
    price = gets.chomp.to_i
    puts 'Input quantity of this product'
    quantity = gets.chomp.to_f
    $bucket_list[name] = { price => quantity }
    puts "If you want to stop inputting, type 'stop': "
    input = gets.chomp
    break if input == 'stop'
  end
  $bucket_list
end

def show_bucket(bucket)
  bucket.each_value do |value|
    value.each do |price, quantity|
      puts "You have the #{bucket.key(value)} by the price for one: #{price}
and amount: #{quantity} "
    end
  end
end

def final_price_for_product(bucket)
  bucket.each_value do |value|
    value.each do |price, quantity|
      puts "You have to pay for the #{bucket.key(value)} : #{price * quantity}"
    end
  end
end

def final_sum(bucket, sum)
  bucket.each_value do |value|
    value.each do |price, quantity|
      sum += price * quantity
    end
  end
  puts "Overall you have to pay #{sum}"
end

bucket = input_products
show_bucket(bucket)
final_price_for_product(bucket)
sum = 0
final_sum(bucket, sum)
