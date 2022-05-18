# frozen_string_literal: true

# Hangman game
class Game
  def initialize(word)
    @word = word
    @letters_guessed = []
    @letters_wrong = []
    @letters_correct = []
    @wrong_guess_count = 0
  end

  def play
    # Have player guess a word by giving a letter
    # If word.inlcude? letter => reveal letter in word
    # and add letter to the letters_correct array
    # If not, increase wrong_guess_count
    # and add letter to the letters_wrong array
    # Unless win before wrong_guess_count reaches N (TBD)
    # Then lose
    # Else win
  end
end

def get_words(textfile)
  File.read(textfile).lines.map(&:chomp).select { |w| correct_length?(w) }
end

def correct_length?(word)
  word.length >= 5 && word.length <= 12
end

words = get_words('wordlist.txt')
10.times { puts words.sample }
