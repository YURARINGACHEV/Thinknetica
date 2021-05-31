#Сумма покупок
hash_cart={}
sum_item= 0.0
sum_total_item= 0.0
loop do 
  puts "Введите товар или введите 'стоп' для окончания"
  item = gets.chomp
  break if item == "стоп"

  puts "Введите цену за единицу товара"
  price = gets.to_f

  puts "Введите количество "
  quantity = gets.to_f

  hash_cart[item] = {price: price, quantity: quantity}

end

hash_cart.each do |item, val|
  sum_item = val[:price] * val[:quantity]
  sum_total_item += sum_item
  puts "Сумма за товар #{item} равна #{sum_item}"

end
puts "Сумма за все товары равна #{sum_total_item}"
