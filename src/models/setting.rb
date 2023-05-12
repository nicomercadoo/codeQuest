class Setting < ActiveRecord::Base
  def initialize(theme, font)
    @theme = theme
    @font = font
  end
end
