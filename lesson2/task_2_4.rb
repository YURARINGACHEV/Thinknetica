#Заполнить хэш гласными буквами, где значением будет являться порчдковый номер 
#буквы в алфавите

alph_hash = {}
alphabet = ('a'..'z').to_a
vowels = ['a', 'e', 'i', 'o', 'y']
num = 0

alphabet.each.with_index(1) do |key, index|
  vowels.each do |i|
    alph_hash[i] = index if key == i 
  end
end

puts alph_hash
