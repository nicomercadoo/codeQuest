class Account < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :nickname, presence: true
end