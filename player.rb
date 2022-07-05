# frozen_string_literal: true

require 'set'

class Player
  attr_accessor :name, :pegs

  def initialize(game, name = 'NoName')
    @game = game
    @name = name
  end

  COLORS = Set['R', 'G', 'B', 'Y', 'O', 'P'].freeze

  def make_code; end

  def guess_code; end
end

class ComputerPlayer < Player
  def initialize(game)
    super(game, 'COMPUTER')
    @possible_set = COLORS.to_a.repeated_permutation(4).to_a
  end

  def make_code
    code = []
    4.times { code.push(COLORS.to_a.sample) }
    code
  end

  def make_guess
    return initial_guess if @pegs.nil? || @game.guess.nil?

    filter_matching_positions
    filter_matching_colors
    puts "\nPossible set size: #{@possible_set.size}"
    sleep(2)
    @possible_set.delete(@possible_set.sample)
  end

  def filter_matching_positions
    @possible_set.filter! do |possible_set_item|
      matching_positions(possible_set_item) == @pegs.count('pos')
    end
  end

  def matching_positions(possible_set_item)
    count = 0
    possible_set_item.each_with_index do |color, idx|
      count += 1 if color == @game.guess[idx]
    end
    count
  end

  def filter_matching_colors
    @possible_set.filter! do |possible_set_item|
      matching_colors(possible_set_item) == @pegs.count('col') + @pegs.count('pos')
    end
  end

  def matching_colors(possible_set_item)
    guess = @game.guess.dup
    count = 0
    possible_set_item.each do |color|
      if guess.include?(color)
        guess.delete_at(guess.index(color))
        count += 1
      end
    end
    count
  end

  def initial_guess
    @possible_set.filter do |possible_set_item|
      possible_set_item[0] == possible_set_item[1] &&
        possible_set_item[2] == possible_set_item[3] &&
        possible_set_item[0] != possible_set_item[3]
    end.sample
  end
end

class HumanPlayer < Player
  def make_guess
    prompt_input('guess')
  end

  def make_code
    prompt_input('code')
  end

  def prompt_input(type)
    input = nil
    loop do
      puts "\nEnter your #{type} (Example: 'royb' or 'bprg' | Available colors: [r, o, y, b, g, p])"
      input = gets.upcase.chomp.split('')
      break if input.size == 4 && input.to_set.subset?(COLORS)
    end
    input
  end
end
