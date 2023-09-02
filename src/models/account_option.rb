class AccountOption < ActiveRecord::Base
  belongs_to :account
  belongs_to :option
  belongs_to :question

end