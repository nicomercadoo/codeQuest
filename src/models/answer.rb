class Answer < ActiveRecord::Base
    validates :description, presence: true
    belongs_to :account
    belongs_to :option
end
