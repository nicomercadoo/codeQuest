class AccountQuestion < ActiveRecord::Base
  validates :well_answered, inclusion: { in: [true, false] }
  
  belongs_to :account
  belongs_to :question
end