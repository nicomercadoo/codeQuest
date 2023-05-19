class Test < ActiveRecord::Base
  validates :name, presence: true
  validates :completed, presence: true
  validates :cant_questions, presence: true
  validates :acerted_answers, presence: true
end
