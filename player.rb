class Player
  def initialize; end

  def make_code
    'rbgy'
  end

  def guess_code
    'rbgy'
  end
end

class ComputerPlayer < Player
end

class HumanPlayer < Player
  def guess_code
    puts 'Enter your guess:'
    gets.upcase.chomp.split('')
  end
end
