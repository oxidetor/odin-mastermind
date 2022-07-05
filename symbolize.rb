# frozen_string_literal: true

module Symbolize
  def replace_holes(value)
    case value
    when 'R'
      '🟥'
    when 'B'
      '🟦'
    when 'G'
      '🟩'
    when 'Y'
      '🟨'
    when 'O'
      '🟧'
    when 'P'
      '🟪'
    else
      value
    end
  end

  def replace_pegs(value)
    case value
    when 'pos'
      '🔴'
    when 'col'
      '⚪️'
    else
      value
    end
  end
end
