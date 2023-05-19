class RemoveNameLessonFromLessons < ActiveRecord::Migration[7.0]
  def change
    remove_column :lessons, :name_lesson
  end
end
