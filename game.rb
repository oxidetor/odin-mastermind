# frozen_string_literal: true

require './board'
require './player'

class Game
  attr_accessor :code, :guess, :solved
  attr_reader :turns, :breaker, :board

  def initialize
    @turns = 12
    @board = Board.new(self)
    @maker = ComputerPlayer.new(self)
    @breaker = HumanPlayer.new(self)
    @solved = false
  end

  def switch_roles
    @maker, @breaker = @breaker, @maker
  end

  def intro_prompt
    puts('Hello, welcome to Mastermind! What is your name?')
    @breaker.name = gets.chomp
    puts("Hi #{@breaker.name}. Would you like to (M)ake a code or (B)reak a code?")
    switch_roles if gets.upcase.chomp == 'M'
  end

  def play_game
    intro_prompt
    self.code = @maker.make_code
    until @turns.zero?
      play_turn
      next unless solved == true

      display_result(@breaker)
      return
    end
    display_result(@maker)
  end

  def display_result(winner)
    @board.draw_board
    puts "\n#{winner.name} wins in #{12 - turns} turns!\n"
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
