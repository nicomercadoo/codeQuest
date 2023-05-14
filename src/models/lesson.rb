class Lesson < ActiveRecord::Base
  validates :number_lesson, presence: true
  validates :completed_lesson, presence: true
  validates :title_lesson, presence: true
  validates :description_lesson, presence: true
end

end
