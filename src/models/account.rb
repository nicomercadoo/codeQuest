class Account < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :nickname, presence: true
  validates :progress, presence: true
  validates :theme, presence: true
  has_many :answers
  has_many :lessons
end