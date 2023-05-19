class Lesson < ActiveRecord::Base
  validates :completed_lesson, presence: true
  validates :description_lesson, presence: true
end

