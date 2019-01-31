require 'date'
class WordFinder
 
 
def self.word_combo(phnumber)
time_start = Time.now
final_collection = []
file_path= "/Users/kumar/Downloads/dictionary.txt"
return [] if phnumber.nil? || phnumber.length != 10 || phnumber.split('').select {|a| ([0, 1].include?(a.to_i))}.length > 0
letters = {"2" => ["a", "b", "c"], "3" => ["d", "e", "f"], "4" => ["g", "h", "i"], "5" => ["j", "k", "l"], "6" => ["m", "n", "o"], "7" => ["p", "q", "r", "s"], "8" => ["t", "u", "v"], "9" => ["w", "x", "y", "z"]}
file_words = File.read(file_path).split.map {|a| a.downcase}
keys = phnumber.chars.map {|digit| letters[digit]}
results = {}
phnumbe_length = keys.length - 1 
for i in (2..phnumbe_length)
array1 = keys[0..i]
array2 = keys[i + 1..phnumbe_length]
next if array1.length < 3 || array2.length < 3
collection1 = array1.shift.product(*array1).map(&:join)
next if collection1.nil?
collection2 = array2.shift.product(*array2).map(&:join)
next if collection2.nil?

results[i] = [(collection1 & file_words), (collection2 & file_words)]
end
results.each do |key, comb|
next if comb.values_at(0, -1).include?(nil)
comb.first.product(comb.last).each do |combo_words|
final_collection << combo_words
end
end
final_collection << (keys.shift.product(*keys).map(&:join) & file_words).join(", ")
time_end = Time.now
puts "Time #{time_end.to_f - time_start.to_f}"
final_collection
end

end

final_words = WordFinder.word_combo("6686787825")
print final_words
