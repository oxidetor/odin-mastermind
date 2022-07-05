# frozen_string_literal: true

module Symbolize
  def replace_holes(value)
    symbol = {
      'R' => '🟥',
      'B' => '🟦',
      'G' => '🟩',
      'Y' => '🟨',
      'O' => '🟧',
      'P' => '🟪'
    }[value]
    symbol.nil? ? value : symbol
  end

  def replace_pegs(_value)
    {
      'pos' => '🔴',
      'col' => '⚪️'
    }[value]
  end
end
