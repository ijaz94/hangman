# Hangman Game in Ruby

## Overview
This is a simple Hangman game implemented in Ruby using object-oriented programming principles. The game allows players to guess a secret word, letter by letter, while tracking incorrect guesses. Additionally, players can save their progress and load a previously saved game.

## Features
- Randomly selects a secret word from a predefined word list.
- Allows players to guess letters until they either guess the word or exceed the maximum incorrect guesses.
- Option to save the game at any point and resume later.
- Loads a saved game when restarting, restoring the exact state of progress.
- Ensures input validation to prevent duplicate guesses or invalid entries.

## Installation
1. Ensure you have Ruby installed on your system.
2. Clone or download this repository.
3. Download the word list file `google-10000-english-no-swears.txt` and place it in the same directory.

## Usage
1. Run the game using the command:
   ruby hangman.rb
2. Choose whether to start a new game or load a saved game.
3. Enter letters to guess the secret word.
4. Type `save` anytime to save your progress and exit.

## How Saving Works
- The game state is stored in a JSON file (`hangman_save.json`).
- When a saved game is loaded, it restores:
  - The secret word.
  - Previously guessed letters.
  - Number of incorrect guesses.
- If no saved game exists, a new game starts automatically.

## File Structure
- `hangman.rb` - Main Ruby script containing the game logic.
- `hangman_save.json` - Save file storing the game state.
- `google-10000-english-no-swears.txt` - Word list file used for selecting the secret word.

## Requirements
- Ruby 2.7 or later.
- JSON library (included by default in Ruby).

## Future Enhancements
- Add difficulty levels with different word lengths.
- Implement a graphical interface using a Ruby GUI framework.
- Support for multiple save slots.

## License
This project is open-source and available under the MIT License.

