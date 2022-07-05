# frozen_string_literal: true

require_relative './symbolize'

class Board
  include Symbolize
  attr_accessor :played_lines

  def initialize(game)
    @game = game
    @played_lines = []
  end

  def check_guess
    @game.solved = true if right_positions == 4
    @pegs = generate_pegs(right_positions, right_colors)
  end

  def right_positions(guess = @game.guess)
    guess.each_with_index.count do |position, index|
      position == @game.code[index]
    end
  end

  def right_colors(guess = @game.guess)
    code = @game.code.dup
    count = 0
    guess.each do |color|
      if code.include?(color)
        code.delete_at(code.index(color))
        count += 1
      end
    end
    count - right_positions
  end

  def draw_board
    return if @game.turns == 12 # don't draw an empty board before first turn

    draw_shield
    draw_empty_lines
    return unless @game.guess

    draw_current_line
    draw_played_lines
    played_lines.push [@game.guess, @pegs, 12 - @game.turns]
  end

  def draw_shield
    puts "\n   CODE\t| 🔒 🔒 🔒 🔒 |\n\n" unless @game.solved || @game.turns.zero?
    puts "\n#{draw_turn_number('CODE')}#{draw_holes(@game.code)}\n\n" if @game.solved || @game.turns.zero?
  end

  def draw_empty_lines
    @game.turns.times do |index|
      if index == @game.turns - 1
        puts draw_turn_number('==>') + draw_holes(%w[__ __ __ __])

      else
        puts draw_turn_number(12 - index) + draw_holes(%w[__ __ __ __])
      end
    end
  end

  def draw_current_line
    puts draw_turn_number(12 - @game.turns) + draw_holes(@game.guess) + draw_pegs(@pegs).join(' ')
  end

  def draw_played_lines
    played_lines.reverse.each do |line|
      draw_played_line(line)
    end
  end

  def draw_played_line(line)
    puts draw_turn_number(line[2]) + draw_holes(line[0]) + draw_pegs(line[1]).join(' ')
  end

  def draw_holes(guess)
    holes = ''
    guess.each do |value|
      holes += "#{replace_holes(value)} "
    end
    "#{holes}|\t"
  end

  def draw_turn_number(turn_number)
    "   #{turn_number}\t| "
  end

  def draw_pegs(pegs)
    pegs.map { |peg| replace_pegs(peg) }
  end

  def generate_pegs(right_positions, right_colors)
    pegs = []
    right_positions.times { pegs.push('pos') }
    right_colors.times { pegs.push('col') }
    @game.breaker.pegs = pegs
    pegs
  end
end
