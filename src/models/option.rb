class Option < ActiveRecord::Base
  validates :description, presence: true
  validates :correct, presence: true
end
