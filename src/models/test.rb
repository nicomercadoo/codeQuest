class Test < ActiveRecord::Base
  validates :letter, presence: true
  validates :description, presence: true
  validates :cant_questions, presence: true

  has_many :lessons
  has_many :questions
  has_many :options
  has_and_belongs_to_many :accounts
end
