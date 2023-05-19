class Lesson < ActiveRecord::Base
  validates :name, presence: true
  validates :tittle, presence: true
  validates :completed_lesson, presence: true
  validates :description_lesson, presence: true
end

