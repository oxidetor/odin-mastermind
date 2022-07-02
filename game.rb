require './board'
require './player'

class Game
  attr_accessor :code, :guess
  attr_reader :turns

  def initialize
    @turns = 12
    @board = Board.new(self)
    @maker = ComputerPlayer.new
    @breaker = HumanPlayer.new
  end

  def play_game
    self.code = @maker.make_code
    play_turn until @turns.zero? || code_guessed?
  end

  def play_turn
    @board.draw_board
    self.guess = @breaker.make_guess
    @board.check_guess
    @turns -= 1
  end

  def code_guessed?
    false
  end
end

game = Game.new
game.play_game
