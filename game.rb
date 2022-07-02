require './board'
require './player'

class Game
  attr_accessor :code, :guess, :solved
  attr_reader :turns

  def initialize
    @turns = 12
    @board = Board.new(self)
    @maker = ComputerPlayer.new
    @breaker = HumanPlayer.new
    @solved = false
  end

  def play_game
    self.code = @maker.make_code
    until @turns.zero?
      play_turn
      next unless solved == true

      @board.draw_board
      @board.reveal_code
      puts 'YOU WIN'
      return
    end
    @board.reveal_code
  end

  def play_turn
    @board.draw_board
    self.guess = @breaker.make_guess
    @board.check_guess

    @turns -= 1
  end
end

game = Game.new
game.play_game
