words = File.read('wordlist.txt').lines.map(&:chomp)
puts words.first
puts words.last
