# Заданы три числа, найти порядковый номер даты.
puts "Введите год: "
year = gets.chomp.to_i

loop do
puts "Введите месяц: "
$month = gets.chomp.to_i
if (1..12).to_a.include?($month)
  break
end
end

loop do 
puts "Введите день: "
$day = gets.chomp.to_i
if (1..31).to_a.include?($day)
  break
end
end

d_in_m = {1=> 31,2=> 28,3=> 31,4=> 30,5=> 31,6=> 30,7=>31,8=> 31,9=> 30,10=> 31,
          11=> 30,12=> 31}
if (year % 4==0 && year % 100 !=0) || year % 400 == 0
  d_in_m[2]=29
end
print d_in_m
puts
sum = 0
d_in_m.each do |key,val|
  
  if key == $month
    sum+= $day
    break
  end
  sum += val

end
  puts sum
