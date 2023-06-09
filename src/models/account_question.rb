class AccountQuestion < ActiveRecord::Base
  validates :well_answered, presence: true
  
  belongs_to :account
  belongs_to :question
end