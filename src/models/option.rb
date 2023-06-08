class Option < ActiveRecord::Base
  validates :number, presence: true
  validates :description, presence: true
  validates :question_number, presence: true
  validates :test_letter, presence: true

  belongs_to :question
  belongs_to :test
  has_and_belongs_to_many :accounts
end
