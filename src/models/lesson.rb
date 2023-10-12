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
    lesson_file_path = File.join("/src/lessons", "L-#{test_letter}-#{number}.adoc")
    lesson_file_content = File.read lesson_file_path, mode: 'r:utf-8'

    # Se renderiza el contenido
    stylesheet_path = "/src/stylesheets/lesson.css"
    Asciidoctor.convert lesson_file_content, safe: :safe, attributes: { 'showtitle' => true,'stylesheet' => stylesheet_path }
  end
end

