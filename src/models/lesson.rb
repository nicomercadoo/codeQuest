class Lesson < ActiveRecord::Base
  def initialize(lesson)
    @id = 
    @lesson_number = lesson
    @complete = false
  end
end
