class Question < ActiveRecord::Base
  validates :number, presence: true
  validates :description, presence: true
  validates :test_letter, presence: true

  belongs_to :test, foreign_key: 'test_letter'
  has_many :options, through: :accounts_options
  has_many :accounts_options
  has_many :accounts, through: :accounts_questions
  has_many :accounts_questions
end
