# frozen_string_literal: true

module Colorize
  def replace(value)
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
    when 'pos'
      '🔴'
    when 'col'
      '⚪️'
    else
      value
    end
  end
end
