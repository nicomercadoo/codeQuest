class Lesson < ActiveRecord::Base
  validates :number, presence: true
  validates :title, presence: true
  validates :path, presence: true
  validates :test_letter, presence: true

  has_many :accounts, through: :accounts_lessons
  has_many :accounts_lessons
  belongs_to :test, foreign_key: 'test_letter'
end

