class Lesson < ActiveRecord::Base
  validates :number, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :test_letter, presence: true

  has_and_belongs_to_many :accounts, join_table: :accounts_lessons
  belongs_to :test, foreign_key: 'test_letter'
end

