class Account < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :nickname, presence: true
  validates :progress, presence: true
  validates :theme_light, presence: true

  has_many :account_lessons
  has_many :lessons, through: :account_lessons 
  has_many :account_options
  has_many :options, through: :account_options
  has_many :account_questions
  has_many :questions, through: :account_questions
  has_many :account_tests
  has_many :tests, through: :account_tests
end