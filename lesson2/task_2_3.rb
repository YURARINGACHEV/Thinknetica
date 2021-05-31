#числа фибоначи от 0 до 100


f_arr = [0,1]
r=1
for i in (0..99)
  r=r+ f_arr[i]
  f_arr = f_arr.push(r)
end
print  f_arr
puts
