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
    @working_set = COLORS.to_a.repeated_permutation(4).to_a
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

    filter_right_positions
    filter_right_colors

    puts "\nSet size: #{@working_set.size}"
    guess = @working_set.sample
    @working_set.delete(guess)
    guess
  end

  def filter_right_positions
    pos_indices = [0, 1, 2, 3]
    pos_count = @pegs.count('pos')
    pos_idx_perms = pos_indices.permutation(pos_count).to_a

    @working_set.filter! do |item|
      pos_idx_perms.any? do |indices|
        indices.all? { |index| item[index] == @previous_guess[index] }
      end
    end
  end

  def filter_right_colors
    col_count = @pegs.count('col') + @pegs.count('pos')
    col_perms = @previous_guess.permutation(col_count).to_a

    @working_set.filter! do |item|
      col_perms.any? { |perm| contains(item, perm) }
    end
  end

  def initial_guess
    @working_set.filter do |permutation|
      permutation[0] == permutation[1] &&
        permutation[2] == permutation[3] &&
        permutation[0] != permutation[3]
    end.sample
  end

  def contains(item, perm)
    item = item.tally
    perm = perm.tally
    third = item.keep_if { |k, _v| perm.key? k }
    diff = perm.map { |k, v| v - third[k] if third[k] }
    diff.all? { |value| value <= 0 unless value.nil? }
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
