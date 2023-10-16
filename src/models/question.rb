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
    question_file_path = File.join("/src/tests", "#{test_letter}/Q-#{test_letter}-#{number}/Q-#{number}.adoc")
    question_file_content = File.read question_file_path, mode: 'r:utf-8'

    # Se renderiza el contenido
    stylesheet_path = "/src/stylesheets/test.css"
    Asciidoctor.convert question_file_content, safe: :safe, attributes: { 'showtitle' => true,'stylesheet' => stylesheet_path }
  end

end
