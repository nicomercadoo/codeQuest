class Question < ActiveRecord::Base
  validates :number, presence: true
  validates :description, presence: true
  validates :test_letter, presence: true

  belongs_to :test, foreign_key: 'test_letter'
  has_many :options, through: :account_options
  has_many :account_options
  has_many :accounts, through: :account_questions
  has_many :account_questions
end