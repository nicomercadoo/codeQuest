class Test < ActiveRecord::Base
  validates :letter, presence: true
  validates :completed_test, presence: true
  validates :description_test, presence: true
  validates :cant_questions, presence: true
  validates :acerted_answers, presence: true
end
