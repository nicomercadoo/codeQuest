class Snippet < ActiveRecord::Base
  validates :code, presence: true

  has_many :accounts, through: :account_snippets
  has_many :account_snippets

end