require './board'
require './player'

class Game
  def initialize
    @turns = 12
    @board = Board.new(self)
  end

  def play_game
    play_turn until @turns.zero? || code_guessed?
  end

  def play_turn; end

  def code_guessed?; end
end

game = Game.new
game.play_game
