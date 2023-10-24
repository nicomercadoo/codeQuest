# frozen_string_literal: true

class Option < ActiveRecord::Base
  validates :number, presence: true
  validates :description, presence: true
  validates :question_number, presence: true
  validates :test_letter, presence: true

  has_many :accounts, through: :account_options
  has_many :account_options
  belongs_to :question
  belongs_to :test

  # Retorna el contenido de una opcion.
  def content
    # Se lee el archivo de la lección
    option_file_path = File.join('/src/tests',
                                 "#{test_letter}/Q-#{test_letter}-#{question_number}/Q-#{question_number}-O-#{number}.adoc")
    option_file_content = File.read option_file_path, mode: 'r:utf-8'

    # Se renderiza el contenido
    stylesheet_path = '/src/stylesheets/test.css'
    Asciidoctor.convert option_file_content, safe: :safe,
                                             attributes: { 'showtitle' => true, 'stylesheet' => stylesheet_path }
  end
end
