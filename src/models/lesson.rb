class Lesson < ActiveRecord::Base
  validates :number, presence: true
  validates :tittle, presence: true
  validates :completed, presence: true
  validates :description, presence: true
  belongs_to :account
  belongs_to :test, foreign_key: 'test_letter', primary_key: 'letter'
end

