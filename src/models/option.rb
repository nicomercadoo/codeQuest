class Option < ActiveRecord::Base
  validates :number, presence: true
  validates :description, presence: true
  validates :question_number, presence: true
  validates :test_letter, presence: true

  has_many :accounts, through: :accounts_options
  has_many :accounts_options
  belongs_to :question
  belongs_to :test

end
