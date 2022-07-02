class Board
  def initialize(game)
    @game = game
  end

  def check_guess; end

  def draw_board
    12.times do
      draw_line
    end
  end

  def draw_line
    puts draw_holes + draw_pegs
  end

  def draw_holes
    "#{@game.guess}\t| _ | _ | _ | _ |\t"
  end

  def draw_pegs
    generate_pegs
    ' p1 p2 p3 p4'
  end

  def generate_pegs; end
end
