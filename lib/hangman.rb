# frozen_string_literal: true

# Hangman game
class Game
  def initialize(word)
    @word = word
    @guessed = []
    @letters_wrong = []
    @wrong_guess_count = 0
  end

  def play
    # Have player guess a word by giving a letter
    # If word.include? letter => reveal letter in word
    # and add letter to the letters_correct array
    # If not, increase wrong_guess_count
    # and add letter to the letters_wrong array
    # Unless win before wrong_guess_count reaches N (TBD)
    # Then lose
    # Else win
  end

  def guess_letter
    puts 'Guess a letter!'
    letter = gets.chomp.downcase
    return guess_letter unless letter.match?(/^[a-z]+/)

    if @guessed.include?(letter.chr)
      puts 'Already guessed that!'
      guess_letter
    else
      puts 'Only keeping first letter' if letter.length > 1
      letter.chr
    end
  end

  def sort_letter
    letter = guess_letter
    @guessed << letter
    if @word.include?(letter)
      puts "#{letter.upcase} is in #{@word}!"
      print_guess
    else
      puts "#{letter.upcase} is not in #{@word} :("
      @wrong_guess_count += 1
    end
  end

  def print_guess
    @word.split('').map { |l| @guessed.include?(l) ? l : '_' }.join(' ')
  end

  def win?
    !print_guess.include?('_')
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
