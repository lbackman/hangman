# frozen_string_literal: true

# Hangman game
class Game
  def initialize(word)
    @word = word
    @guessed = []
    @letters_wrong = []
    @wrong_guess_count = 0
    @allowed_wrong_guesses = @word.length
  end

  def play
    puts @word
    until @wrong_guess_count > @word.length
      sort_letter
      if win?
        puts "Congratulations, you guessed the correct word: #{@word}!"
        return
      end
    end
    puts "You lost! The correct answer was #{@word}."
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
      letter_in_word(letter)
    else
      not_in_word(letter)
    end
  end

  def letter_in_word(letter)
    puts "#{letter.upcase} is in the word!"
    puts print_guess
    puts "Wrong guesses: ( #{print_wrongs} )."
  end

  def not_in_word(letter)
    puts "#{letter.upcase} is not in the word :("
    @letters_wrong << letter
    @wrong_guess_count += 1
    if (@allowed_wrong_guesses - @wrong_guess_count) >= 0
      puts "You now have #{@allowed_wrong_guesses - @wrong_guess_count} "\
      "wrong guesses left."
      puts print_guess
      puts "Wrong guesses: ( #{print_wrongs} )."
    end
  end

  def print_guess
    @word.split('').map { |l| @guessed.include?(l) ? l : '_' }.join(' ')
  end

  def print_wrongs
    @letters_wrong.sort.join(' ')
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
Game.new(words.sample).play
