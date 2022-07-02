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
    when 'P'
      '🔴'
    when 'W'
      '⚪️'
    else
      value
    end
  end
end
