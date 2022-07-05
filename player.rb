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
    @previous_guess = nil
    @possible_set = COLORS.to_a.repeated_permutation(4).to_a
  end

  def make_code
    code = []
    4.times { code.push(COLORS.to_a.sample) }
    code
  end

  def make_guess
    guess = think
    sleep(2)
    @previous_guess = guess
    guess
  end

  def think
    return initial_guess if @pegs.nil? || @previous_guess.nil?

    filter_matching_positions
    filter_matching_colors

    puts "\nPossible set size: #{@possible_set.size}"
    guess = @possible_set.sample
    @possible_set.delete(guess)
    guess
  end

  def filter_matching_positions
    @possible_set.filter! do |possible_set_item|
      matching_positions(possible_set_item) == @pegs.count('pos')
    end
  end

  def matching_positions(possible_set_item)
    count = 0
    possible_set_item.each_with_index do |color, idx|
      count += 1 if color == @previous_guess[idx]
    end
    count
  end

  def filter_matching_colors
    @possible_set.filter! do |possible_set_item|
      matching_colors(possible_set_item) == @pegs.count('col') + @pegs.count('pos')
    end
  end

  def matching_colors(possible_set_item)
    previous_guess = @previous_guess.dup
    count = 0
    possible_set_item.each do |color|
      if previous_guess.include?(color)
        previous_guess.delete_at(previous_guess.index(color))
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
    guess = nil
    loop do
      puts "\nEnter your guess:"
      guess = gets.upcase.chomp.split('')
      break if guess.size == 4 && guess.to_set.subset?(COLORS)
    end
    guess
  end

  def make_code
    code = nil
    loop do
      puts "\nEnter your secret code:"
      code = gets.upcase.chomp.split('')
      break if code.size == 4 && code.to_set.subset?(COLORS)
    end
    code
  end
end
