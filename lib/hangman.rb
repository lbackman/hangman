# frozen_string_literal: true

require 'yaml'

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
    # toggle comment below line for troubleshooting
    # puts @word
    puts print_guess if @guessed[0]
    puts print_wrongs if @letters_wrong[0]
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
    puts 'Guess a letter! Or press 1 to save.'
    letter = gets.chomp.downcase
    return guess_letter unless letter.match?(/^[[a-z][1]]+/)
    if letter == '1'
      save_game
      guess_letter
    elsif @guessed.include?(letter.chr)
      puts 'Already guessed that!'
      puts print_guess
      puts print_wrongs
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
    puts "'#{letter.upcase}' is in the word!"
    puts print_guess
    puts print_wrongs if @letters_wrong[0]
  end

  def not_in_word(letter)
    puts "'#{letter.upcase}' is not in the word :("
    @letters_wrong << letter
    @wrong_guess_count += 1
    if (@allowed_wrong_guesses - @wrong_guess_count) >= 0
      puts "You now have #{@allowed_wrong_guesses - @wrong_guess_count} "\
      "wrong guesses left."
      puts print_guess
      puts print_wrongs
    end
  end

  def print_guess
    @word.split('').map { |l| @guessed.include?(l) ? l : '_' }.join(' ')
  end

  def print_wrongs
    "Wrong guesses: ( #{@letters_wrong.sort.join(' ')} )."
  end

  def win?
    !print_guess.include?('_')
  end

  def save_game
    File.open('savegame.yaml', 'w') { |file| file.write(self.to_yaml) }
    puts 'Game saved!'
  end
end

def get_words(textfile)
  File.read(textfile).lines.map(&:chomp).select { |w| correct_length?(w) }
end

def correct_length?(word)
  word.length >= 5 && word.length <= 12
end

def hangman
  words = get_words('wordlist.txt')
  puts "Press 1 to start a new game\n"\
       "Press 2 to load an existing game\n"\
       "Press any other key to quit"
  input = gets.to_i
  case input
  when 1
    Game.new(words.sample).play
    hangman
  when 2
    puts 'Loading game...'
    game_file = File.open('savegame.yaml', 'r') { |file| file.read }
    game = YAML::load(game_file)
    game.play
    hangman
  end
end

hangman
