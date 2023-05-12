class Option < ActiveRecord::Base
  def initialize(option, is_correct)
    @option = option
    @is_correct = is_correct
  end
end
