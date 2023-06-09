class AccountLesson < ActiveRecord::Base
  validates :lesson_completed, presence: true
  
  belongs_to :account
  belongs_to :lesson
end