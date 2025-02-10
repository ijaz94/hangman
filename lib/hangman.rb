require 'json'

class Hangman
  WORDS_FILE = 'google-10000-english-no-swears.txt'
  SAVE_FILE = 'hangman_save.json'

  def initialize(max_guesses = 6)
    @words = File.readlines(WORDS_FILE).map(&:chomp).select { |word| word.length.between?(5, 12) } # Word list
    @secret_word = @words.sample.downcase
    @letters_guessed = []
    @incorrect_guesses = 0
    @max_guesses = max_guesses
  end

  def play
    puts "Welcome to Hangman!"
    puts "1. Start a new game"
    puts "2. Load saved game"
    print "Choose an option: "
    choice = gets.chomp
    load_game if choice == '2'

    puts "The secret word has #{@secret_word.length} letters." 

    while @incorrect_guesses < @max_guesses
      display_word
      puts "Letters guessed: #{@letters_guessed.join(", ")}" unless @letters_guessed.empty?
      puts "Incorrect guesses left: #{@max_guesses - @incorrect_guesses}"
      puts "Enter a letter to guess or type 'save' to save the game."

      print "Your choice: "
      input = gets.chomp.downcase

      if input == 'save'
        save_game
        puts "Game saved! Exiting..."
        return
      elsif input.match?(/^[a-z]$/) && !@letters_guessed.include?(input)
        handle_guess(input)
      else
        puts "Invalid input or letter already guessed. Try again."
      end
      
      
      if word_guessed?
        puts "Congratulations! You guessed the word: #{@secret_word}"
        return
      end
    end
    puts "Sorry, you ran out of guesses. The secret word was: #{@secret_word}"
  end

  private

  # Handles the player's guess
  def handle_guess(guess)
    if @secret_word.include?(guess)
      puts "Good guess!"
      @letters_guessed << guess
    else
      puts "Sorry, that letter is not in the word."
      @letters_guessed << guess
      @incorrect_guesses += 1
    end
  end

   # Displays the word with guessed letters and underscores
   def display_word
     display_word = ""
     @secret_word.each_char do |char|
       if @letters_guessed.include?(char)
         display_word << char
       else
         display_word << "_ "
       end
     end
     puts display_word
   end

   # Checks if the word has been completely guessed
   def word_guessed?
      @secret_word.chars.all? { |char| @letters_guessed.include?(char) }
   end

    # Saves the game state to a JSON file
    def save_game
      save_data = {
        secret_word: @secret_word,
        letters_guessed: @letters_guessed,
        incorrect_guesses: @incorrect_guesses,
        max_guesses: @max_guesses
      }
      File.write(SAVE_FILE, JSON.dump(save_data))
    end 

    # Loads the game state from a JSON file
    def load_game
      if File.exist?(SAVE_FILE)
        save_data = JSON.parse(File.read(SAVE_FILE), symbolize_names: true)
        @secret_word = save_data[:secret_word]
        @letters_guessed = save_data[:letters_guessed]
        @incorrect_guesses = save_data[:incorrect_guesses]
        @max_guesses = save_data[:max_guesses]
        puts "Game loaded successfully!"
      else
        puts "No saved game found. Starting a new game."
      end
    end


end


# Create an instance of the Hangman class and start the game
game = Hangman.new
game.play