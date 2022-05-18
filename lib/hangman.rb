# frozen_string_literal: true

def get_words(textfile)
  File.read(textfile).lines.map(&:chomp).select { |w| correct_length?(w) }
end

def correct_length?(word)
  word.length >= 5 && word.length <= 12
end

words = get_words('wordlist.txt')
10.times { puts words.sample }
