class Lesson < ActiveRecord::Base
  validates :number, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :test_letter, presence: true

  has_many :accounts, through: :account_lessons
  has_many :account_lessons
  belongs_to :test, foreign_key: 'test_letter'
end

