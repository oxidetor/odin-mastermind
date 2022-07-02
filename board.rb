class Board
  def initialize(game)
    @game = game
  end

  def check_guess
    right_positions = 0
    @game.guess.each_with_index.count do |position, index|
      right_positions += 1 if position == @game.code[index]
    end
    right_colors = (@game.guess & @game.code).size - right_positions
    @pegs = generate_pegs(right_positions, right_colors)
  end

  def draw_board
    12.times do
      draw_line
    end
  end

  def draw_line
    puts draw_holes + draw_pegs.to_s
  end

  def draw_holes
    "#{@game.guess}\t| _ | _ | _ | _ |\t"
  end

  def draw_pegs
    @pegs
  end

  def generate_pegs(right_positions, right_colors)
    pegs = []
    right_positions.times { pegs.push('R') }
    right_colors.times { pegs.push('W') }
    pegs
  end
end
