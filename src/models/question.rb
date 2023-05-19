class Question < ActiveRecord::Base
  validates :description_question, presence: true
  validates :well_answered, presence: true
end
