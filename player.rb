require 'set'

class Player
  attr_accessor :name, :pegs

  def initialize(name = 'NoName')
    @name = name
  end

  COLORS = Set['R', 'G', 'B', 'Y', 'O', 'P'].freeze

  def make_code; end

  def guess_code; end
end

class ComputerPlayer < Player
  def initialize
    super('COMPUTER')
    @previous_guess = nil
  end

  def make_code
    code = []
    4.times { code.push(COLORS.to_a.sample) }
    code
  end

  def make_guess
    guess = []
    4.times { guess.push(COLORS.to_a.sample) }
    guess = think(guess)
    sleep(2)
    @previous_guess = guess
    guess
  end

  def think(guess)
    # if pos, randomly select an element from previous guess and
    # keep it in the same position
    # if col, randomly select an element from previouis guess and
    # keep it in new guess but not necessarily in the same spot
    return guess if @pegs.nil? || @previous_guess.nil?

    indices = [0, 1, 2, 3]
    right_pos_count = @pegs.count('pos')
    right_pos_indices = indices.sample(right_pos_count)
    right_col_count = @pegs.count('col')
    non_right_pos_indices = indices - right_pos_indices
    right_col_indices = non_right_pos_indices.sample(right_col_count)
    right_pos_indices.each { |rp_index| guess[rp_index] = @previous_guess[rp_index] }
    right_col_indices.each do |rc_index|
      guess[rc_index] = @previous_guess[rc_index] unless guess.include?(@previous_guess[rc_index])
    end

    p @pegs
    p @previous_guess

    guess
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
