#числа фибоначи от 0 до 100
f_arr = [0]
r = 1
i = 0

loop do 
  break if r >= 100
  f_arr = f_arr.push(r)
  r=r+ f_arr[i]
  i += 1
end

print  f_arr
puts
