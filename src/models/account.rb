class Account < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :nickname, presence: true
  validates :progress, presence: true

  has_and_belongs_to_many :lessons, join_table: :accounts_lessons
  has_and_belongs_to_many :tests
  has_and_belongs_to_many :questions
end