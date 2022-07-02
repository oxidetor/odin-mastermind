class Board
  attr_accessor :played_lines

  def initialize(game)
    @game = game
    @played_lines = []
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
    draw_empty_lines
    draw_current_line
    draw_played_lines
    played_lines.push [@game.guess, @pegs, 12 - @game.turns + 1]
  end

  def draw_empty_lines
    (@game.turns - 1).times do |index|
      if index == @game.turns - 2
        puts draw_holes(%w[_ _ _ _], '==>') + draw_pegs([]).join(' ')

      else
        puts draw_holes(%w[_ _ _ _], 12 - index) + draw_pegs([]).join(' ')
      end
    end
  end

  def draw_current_line
    puts draw_holes(@game.guess, 12 - @game.turns + 1) + draw_pegs(@pegs).join(' ')
  end

  def draw_played_lines
    played_lines.reverse.each do |line|
      draw_played_line(line)
    end
  end

  def draw_played_line(line)
    puts draw_holes(line[0], line[2]) + draw_pegs(line[1]).join(' ')
  end

  def draw_holes(guess, turn_number)
    " #{turn_number}\t| #{guess[0]} | #{guess[1]} | #{guess[2]} | #{guess[3]} |\t"
  end

  def draw_pegs(pegs)
    pegs
  end

  def generate_pegs(right_positions, right_colors)
    pegs = []
    right_positions.times { pegs.push('R') }
    right_colors.times { pegs.push('W') }
    pegs
  end
end
