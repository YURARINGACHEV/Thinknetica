#Идеальный вес
print "Введите имя "
name = gets.chomp

print "Введите рост "
growth = gets.chomp
growth = growth.to_i
growth_name = (growth - 110)*1.15
if growth_name >0
  puts name + ", ваш вес + #{(growth-110)*1.15})"
else 
  puts name + ", ваш вес идеальный"
end

