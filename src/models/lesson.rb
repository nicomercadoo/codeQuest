# frozen_string_literal: true

class Lesson < ActiveRecord::Base
  validates :number, presence: true
  validates :title, presence: true
  validates :test_letter, presence: true

  has_many :accounts, through: :account_lessons
  has_many :account_lessons
  belongs_to :test, foreign_key: 'test_letter'

  # Retorna el contenido de una leccion.
  def content
    # Se lee el archivo de la lección
    lesson_file_path = File.join('/src/lessons', "L-#{test_letter}-#{number}.adoc")
    lesson_file_content = File.read lesson_file_path, mode: 'r:utf-8'

    # Se renderiza el contenido
    stylesheet_path = '/src/stylesheets/lesson.css'
    Asciidoctor.convert lesson_file_content, safe: :safe,
                                             attributes: { 'showtitle' => true, 'stylesheet' => stylesheet_path }
  end

  def self.present_lesson(session, test_letter, lesson_number)
    lesson = find_by(test_letter: test_letter, number: lesson_number)

    lesson_html_body = lesson.content

    # Progreso
    account = Account.find(session[:account_id])

    if account
      accounts_lesson = AccountLesson.find_by(lesson_id: lesson.id, account_id: account.id)
      accounts_lesson&.update(lesson_completed: true)
    end

    { lesson: lesson, lesson_content: lesson_html_body }
  end

  def getNextLesson
    # Se obtiene la letra del test que se corresponde con la leccion
    related_test_letter = test_letter

    # Se obtienen todas las preguntas y las lecciones que estan relacionadas con el test
    questions = Question.where(test_letter: related_test_letter)
    lessons = Lesson.where(test_letter: related_test_letter)

    # Se obtiene la ultima leccion
    last_lesson_in_group = lessons.last.number

    # Se verifica si la leccion actual es la ultima
    current_is_last = number == last_lesson_in_group

    # Se obtiene la (supuesta) proxima leccion
    next_lesson = number + 1

    # Se almacena la url a donde debera ser redirigido el usuario dependiendo de la situacion
    next_step = current_is_last ? "/test/#{related_test_letter}/#{questions.minimum(:number)}" : "/lesson/#{related_test_letter}/#{next_lesson}"
  end
end
