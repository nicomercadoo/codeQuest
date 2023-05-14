class Answer < ActiveRecord::Base
  validates :description_answer, presence: true
end
