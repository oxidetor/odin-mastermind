require 'set'

class Player
  COLORS = Set['R', 'G', 'B', 'Y'].freeze

  def make_code
    'rbgy'
  end

  def guess_code
    'rbgy'
  end
end

class ComputerPlayer < Player
  def make_code
    %w[R G B Y]
  end
end

class HumanPlayer < Player
  def guess_code
    loop do
      puts 'Enter your guess:'
      guess = gets.upcase.chomp.split('')
      break if guess.size == 4 && guess.to_set.subset?(COLORS)
    end
  end
end
