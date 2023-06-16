class Account < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :nickname, presence: true
  validates :progress, presence: true
  validates :theme_light, inclusion: { in: [true, false] }

  has_many :account_lessons
  has_many :lessons, through: :account_lessons 
  has_many :account_options
  has_many :options, through: :account_options
  has_many :account_questions
  has_many :questions, through: :account_questions
  has_many :account_tests
  has_many :tests, through: :account_tests


  after_commit :actualizar_progreso


  def actualizar_progreso
    # Lógica para actualizar el progreso de la cuenta
  
    # Los capítulos valen el 100% del progreso (1 cap 100%, 2 caps 50%, etc)
    total_chapters = Test.distinct.count(:letter)
    total_progress = 100
    chapter_progress = total_chapters != 0 ? total_progress / total_chapters : 0
  
    # El test vale el 50% del progreso de un capítulo
    total_tests = Test.distinct.count(:letter)
    completed_tests = account_tests.where(test_completed: true).count
    test_progress = total_tests != 0 ? chapter_progress / 2 : 0
    completed_tests_progress = completed_tests * test_progress
  
    # Las lecciones valen el otro 50% del progreso de un capítulo
    total_lessons = Lesson.distinct.count(:test_letter)
    completed_lessons = account_lessons.where(lesson_completed: true).count
    lesson_progress = total_lessons != 0 ? chapter_progress / (2 * total_lessons) : 0
    completed_lessons_progress = completed_lessons * lesson_progress
  
    # Calcular el progreso total
    new_progress = completed_tests_progress + completed_lessons_progress
    update_column(:progress, new_progress)
  end
end