class Test < ActiveRecord::Base
  validates :letter, presence: true
  validates :description, presence: true
  validates :completed, presence: true
  validates :cant_questions, presence: true
  validates :acerted_answers, presence: true
  has_many :lessons
  has_many :questions
end
