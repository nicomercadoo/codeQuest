# frozen_string_literal: true
require 'bcrypt'

class Account < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true
  has_secure_password
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
  has_many :account_snippets
  has_many :snippets

  after_commit :actualizar_progreso

  # Valida si los datos que se pretenden guardar en una cuenta son válidos
  def self.validate_data(email, password, name, nickname)
    valid_email_format = /^[a-zA-Z0-9_.+-]+@(gmail|outlook|hotmail|live)\.[a-z.]+$/
    valid_password_format = /(?=(?:.*[A-Z].*)+)(?=(?:.*[a-z].*)+)(?=(?:.*\d.*)+)(?!(?:.*\s.*)+)^(?=.{8,}$).*/
    valid_name_format = /(?=(?:^\D*$)+)/
    valid_nickname_format = /(?=(?:^\S*$)+)/

    { email: valid_email_format.match(email),
      name: valid_name_format.match(name), nickname: valid_nickname_format.match(nickname) }
  end

  # Crea los registros de las lecciones, preguntas y tests para la cuenta
  def stuff
    Lesson.all.each do |lesson|
      AccountLesson.create(account_id: id, lesson_id: lesson.id)
    end

    Question.all.each do |question|
      AccountQuestion.create(account_id: id, question_id: question.id)
    end

    Test.all.each do |test|
      AccountTest.create(account_id: id, test_id: test.id)
    end
  end

  # Actualiza el progreso de la cuenta
  def actualizar_progreso
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
