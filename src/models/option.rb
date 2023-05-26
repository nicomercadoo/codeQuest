class Option < ActiveRecord::Base
  validates :description, presence: true
  validates :correct, presence: true
  belongs_to :question
  belongs_to :answer
end
