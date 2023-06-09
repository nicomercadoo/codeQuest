class Account < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :nickname, presence: true
  validates :progress, presence: true
  validates :theme_light, presence: true

  has_many :account_lessons
  has_many :lessons, through: :account_lessons 
  has_many :account_options
  has_many :options, through: :account_options
  has_many :accounts_questions
  has_many :questions, through: :accounts_questions
  has_many :account_tests
  has_many :tests, through: :account_tests

#  after_save :actualizar_progreso

#  private

#  def actualizar_progreso
    # Lógica para actualizar el progreso de la cuenta
    
    # Los capítulos valen el 100% del progreso (1 cap 100%, 2 caps 50%, etc)
#    total_chapters = Test.distinct.count(:letter)
#    total_progress = 100
    # Progreso total por capítulo
#    if total_chapters != nil && total_chapters > 0
#      chapter_progress = (total_progress / total_chapters)
#    else
      # Manejar error
#    end

    # El test vale el 50% del progreso de un capítulo
#    total_tests = Test.distinct.count(:letter)
#    completed_tests = account_tests.where(test_completed: true).count
#    if chapter_progress != nil 
#      test_progress = (chapter_progress / 2)
#    else
      # Manejar error
#    end
    # Total por los tests completados
#    if completed_tests != nil
#      completed_tests_progress = (completed_tests * test_progress)
#    else
      # Manejar error
#    end
    # Las preguntas valen el 100% de un test
#    total_questions = test.cant_questions
#    completed_questions_tests = accounts_questions.where(well_answered: true, question: test_questions).count
#    if total_questions != nil && total_questions > 0
#      question_progress = (test_progress / total_questions)
#    else
      # Manejar error
#    end
    # Total por las preguntas completadas
#    completed_questions_progress = (completed_questions_tests * question_progress)

    # Las lecciones valen el otro 50% del progreso de un capítulo
#    total_lessons = Lesson.count
#    completed_lessons = account_lessons.where(lesson_completed: true).count
#    if total_lessons != nil && total_lessons > 0
#      lesson_progress = ((chapter_progress / total_lessons) / 2)
#    else
      # Manejar error
#    end
    # Total por las lecciones completadas
#    if completed_lessons != nil
#      completed_lessons_progress = (completed_lessons * lesson_progress)
#    else
          # Manejar error
#    end



    # Calcular el progreso total
#    self.progress = (completed_tests_progress + completed_questions_progress + completed_lessons_progress)
#    save
#  end
    

    
end