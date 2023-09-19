class AccountSnippet < ActiveRecord::Base

  belongs_to :account
  belongs_to :snippet

end