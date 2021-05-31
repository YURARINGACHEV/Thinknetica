#Заполнить хэш гласными буквами, где значением будет являться порчдковый номер 
#буквы в алфавите

alph_hash = {}
alphabet =('a'..'z').to_a
vowels= ['a', 'e','i','o','y' ]
num = 0
alphabet.each do |key|
  num += 1
  vowels.each do |i|
    if key == i
      alph_hash[i] = num
    end
  end
end
puts alph_hash
