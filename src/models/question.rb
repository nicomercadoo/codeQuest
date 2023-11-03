# frozen_string_literal: true

class Question < ActiveRecord::Base
  validates :number, presence: true
  validates :description, presence: true
  validates :test_letter, presence: true

  belongs_to :test, foreign_key: 'test_letter'
  has_many :options, through: :account_options
  has_many :account_options
  has_many :accounts, through: :account_questions
  has_many :account_questions

  # Retorna el contenido de una pregunta.
  def content
    # Se lee el archivo de la lección
    question_file_path = File.join('/src/tests', "#{test_letter}/Q-#{test_letter}-#{number}/Q-#{number}.adoc")
    question_file_content = File.read question_file_path, mode: 'r:utf-8'

    # Se renderiza el contenido
    stylesheet_path = '/src/stylesheets/test.css'
    Asciidoctor.convert question_file_content, safe: :safe,
                                               attributes: { 'showtitle' => true, 'stylesheet' => stylesheet_path }
  end

  def get_next_question
    # Se obtienen todas las preguntas que estan relacionadas con el test
    questions = Question.where(test_letter: test_letter)
    # Se obtiene la ultima pregunta
    last_question_in_group = questions.last.number
    # Se verifica si la pregunta actual es la ultima
    current_is_last = number == last_question_in_group
    # Se obtiene la (supuesta) proxima pregunta
    next_question_number = number + 1

    can_continue = !current_is_last && next_question_number <= questions.maximum(:number)

    if can_continue
      return "/test/#{test_letter}/#{next_question_number}"
    else
      lessons = Lesson.where(test_letter: test_letter.next)
      next_lesson = lessons.minimum(:number)
      return "/test_status/#{test_letter}"
    end
  end

  def submit_answer(answer_status)
    questions = Question.where(test_letter: test_letter)

    if number <= questions.maximum(:number)
      return "/#{answer_status ? 'correct' : 'incorrect'}/#{test_letter}/#{number}"
    else
      return '/home'
    end
  end

end
