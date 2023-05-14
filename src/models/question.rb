class Question < ActiveRecord::Base
  validates :title_question, presence: true
  validates :description_question, presence: true
  validates :correct_option, presence: true
end
