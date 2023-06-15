class AccountLesson < ActiveRecord::Base
  validates :lesson_completed, inclusion: { in: [true, false] }

  belongs_to :account
  belongs_to :lesson
end