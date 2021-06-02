# Заданы три числа, найти порядковый номер даты.
puts "Введите год: "
year = gets.chomp.to_i
month = 0
day = 0
day_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30 ,31]

day_in_month[1]=29 if (year % 4==0 && year % 100 != 0) || year % 400 == 0

loop do
  puts "Введите месяц: "
  month = gets.chomp.to_i
  break if (1..12).to_a.include?(month)
end

loop do 
  puts "Введите день: "
  day = gets.chomp.to_i
  break if (1..31).to_a.include?(day)
end

puts "Порядковый номер #{day_in_month.take(month-1).sum + day}"

