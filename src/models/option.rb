class Option < ActiveRecord::Base
  validates :description_option, presence: true
  validates :correct_option, presence: true
end
