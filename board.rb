class Board
  attr_accessor :played_lines

  def initialize(game)
    @game = game
    @played_lines = []
  end

  def check_guess
    @game.solved = true if right_positions == 4
    @pegs = generate_pegs(right_positions, right_colors)
  end

  def right_positions
    @game.guess.each_with_index.count do |position, index|
      position == @game.code[index]
    end
  end

  def right_colors
    @game.guess.sort.each_with_index.count do |position, index|
      position == @game.code.sort[index]
    end - right_positions
  end

  def draw_board
    draw_empty_lines
    return unless @game.guess

    draw_current_line
    draw_played_lines
    played_lines.push [@game.guess, @pegs, 12 - @game.turns]
  end

  def draw_empty_lines
    @game.turns.times do |index|
      if index == @game.turns - 1
        puts draw_holes(%w[_ _ _ _], '==>') + draw_pegs([]).join(' ')

      else
        puts draw_holes(%w[_ _ _ _], 12 - index) + draw_pegs([]).join(' ')
      end
    end
  end

  def draw_current_line
    puts draw_holes(@game.guess, 12 - @game.turns) + draw_pegs(@pegs).join(' ')
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

  def reveal_code
    puts "Code: | #{@game.code[0]} | #{@game.code[1]} | #{@game.code[2]} | #{@game.code[3]} |"
  end
end
