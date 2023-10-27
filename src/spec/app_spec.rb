# frozen_string_literal: true

require 'rack/test'
require_relative '../server'

RSpec.describe 'Sinatra App' do
  include Rack::Test::Methods

  def app
    App
  end

  it 'probando ruta /signup del server' do
    get '/signup' # Accede a la ruta '/signup'

    expect(last_response.status).to eq(200) # Verifica el código de respuesta HTTP
  end

  it 'probando ruta / del server' do
    get '/' # Accede a la ruta '/'

    expect(last_response.status).to eq(200) # Verifica el código de respuesta HTTP
  end
  
  it 'probando ruta / del server cuando el usuario está autenticado' do
    Account.create(name: 'Juan', email: 'juanito@gmail.com', password: 'Juanito32', nickname: 'juanito', 
                  theme_light: true)

    # Configura una sesión simulada con el usuario autenticado
    session = { logged_in: true, account_theme: true, account_id: 1 }

    get '/', {}, 'rack.session' => session

    expect(last_response.status).to eq(302) # Verifica el código de respuesta HTTP
    follow_redirect!

    # Verifica que la respuesta final sea 200 (OK)
    expect(last_response.status).to eq(200)
  end

  it 'probando ruta /home del server cuando el usuario está autenticado' do
    Account.create(name: 'Juan', email: 'juanito@gmail.com', password: 'Juanito32', nickname: 'juanito', 
                  theme_light: true)

    # Configura una sesión simulada con el usuario autenticado
    session = { logged_in: true, account_theme: true, account_id: 1 }

    get '/home', {}, 'rack.session' => session

    expect(last_response.status).to eq(200)
  end

  it 'probando ruta /home del server cuando el usuario no está autenticado' do
    # Configura una sesión simulada con el usuario no autenticado
    session = { logged_in: false }

    get '/home', {}, 'rack.session' => session

    expect(last_response.status).to eq(302) # Debería redirigir
    follow_redirect!

    # Verifica que la respuesta final sea 200 (OK)
    expect(last_response.status).to eq(200)
  end

  it 'probando ruta /profile del server cuando el usuario está autenticado' do
    Account.create(name: 'Juan', email: 'juanito@gmail.com', password: 'Juanito32', nickname: 'juanito', 
                  theme_light: true)
                  
    # Configura una sesión simulada con el usuario autenticado
    session = { logged_in: true, account_theme: true, account_id: 1 }

    get '/profile', {}, 'rack.session' => session

    expect(last_response.status).to eq(200)
  end

  it 'probando ruta /profile del server cuando el usuario no está autenticado' do
    # Configura una sesión simulada con el usuario no autenticado
    session = { logged_in: false }

    get '/profile', {}, 'rack.session' => session

    expect(last_response.status).to eq(302) # Debería redirigir
    follow_redirect!

    # Verifica que la respuesta final sea 200 (OK)
    expect(last_response.status).to eq(200)
  end

  it 'probando ruta /lesson/:test_letter/:lesson_number del server cuando el usuario está autenticado' do
    Account.create(name: 'Juan', email: 'juanito@gmail.com', password: 'Juanito32', nickname: 'juanito', 
                  theme_light: true)

    Test.create(letter: 'A', description: 'Description', cant_questions: 5)

    Lesson.create(number: 1, title: 'Title', test_letter: 'A')

    # Configura una sesión simulada con el usuario autenticado
    session = { logged_in: true, account_theme: true, account_id: 1 }

    get '/lesson/A/1', {}, 'rack.session' => session

    expect(last_response.status).to eq(200)
  end

  it 'probando ruta /lesson/:test_letter/:lesson_number del server cuando el usuario no está autenticado' do
    # Configura una sesión simulada con el usuario no autenticado
    session = { logged_in: false }

    get '/lesson/A/1', {}, 'rack.session' => session

    expect(last_response.status).to eq(302) # Debería redirigir
    follow_redirect!

    # Verifica que la respuesta final sea 200 (OK)
    expect(last_response.status).to eq(200)
  end

  it 'probando ruta /test/:test_letter/:question_number del server cuando el usuario está autenticado y la pregunta existe', type: :feature do
    Account.create(name: 'Juan', email: 'juanito@gmail.com', password: 'Juanito32', nickname: 'juanito', 
                  theme_light: true)

    Test.create(letter: 'A', description: 'Description', cant_questions: 5)

    Question.create(number: 1, description: 'Is this a description?', test_letter: 'A')
    # Configura una sesión simulada con el usuario autenticado
    session = { logged_in: true, account_theme: true, account_id: 1 }

    get '/test/A/1', {}, 'rack.session' => session

    expect(last_response.status).to eq(200)
  end

  it 'probando ruta /test/:test_letter/:question_number del server cuando el usuario está autenticado pero la pregunta no existe' do
    Account.create(name: 'Juan', email: 'juanito@gmail.com', password: 'Juanito32', nickname: 'juanito', 
                  theme_light: true)
    question = Question.find_by(number: 1, description: 'Is this a description?', test_letter: 'A')

    # Si la pregunta existe, la eliminamos
    question&.destroy

    # Configura una sesión simulada con el usuario autenticado
    session = { logged_in: true, account_theme: true, account_id: 1 }

    get '/test/A/1', {}, 'rack.session' => session

    expect(last_response.status).to eq(302) # Debería redirigir
  end

  it 'probando ruta /test/:test_letter/:question_number del server cuando el usuario no está autenticado' do
    # Configura una sesión simulada con el usuario no autenticado
    session = { logged_in: false }

    get '/test/A/1', {}, 'rack.session' => session

    expect(last_response.status).to eq(302) # Debería redirigir
    follow_redirect!

    # Verifica que la respuesta final sea 200 (OK)
    expect(last_response.status).to eq(200)
  end

  it 'probando ruta /:status/:test_letter/:question_number del server cuando el usuario está autenticado' do
    Question.create(number: 1, description: 'Is this a description?', test_letter: 'A')
    # Configura una sesión simulada con el usuario autenticado
    session = { logged_in: true, account_theme: true, account_id: 1 }

    get '/correct/A/1', {}, 'rack.session' => session

    expect(last_response.status).to eq(200)
  end

  it 'probando ruta /:status/:test_letter/:question_number del server cuando el usuario no está autenticado' do
    Question.create(number: 1, description: 'Is this a description?', test_letter: 'A')
    # Configura una sesión simulada con el usuario autenticado
    session = { logged_in: false }

    get '/correct/A/1', {}, 'rack.session' => session

    expect(last_response.status).to eq(302) # Debería redirigir
    follow_redirect!

    # Verifica que la respuesta final sea 200 (OK)
    expect(last_response.status).to eq(200)
  end

  it 'probando ruta /test_status/:test_letter del server cuando el usuario está autenticado' do
    Account.create(name: 'Juan', email: 'juanito@gmail.com', password: 'Juanito32', nickname: 'juanito', 
                  theme_light: true)

    Test.create(letter: 'A', description: 'Description', cant_questions: 5)
    # Configura una sesión simulada con el usuario autenticado
    session = { logged_in: true, account_theme: true, account_id: 1 }

    get '/test_status/A', {}, 'rack.session' => session

    expect(last_response.status).to eq(200)
  end

  it 'probando ruta /test_status/:test_letter del server cuando el usuario no está autenticado' do

    Test.create(letter: 'A', description: 'Description', cant_questions: 5)
    # Configura una sesión simulada con el usuario autenticado
    session = { logged_in: false }

    get '/test_status/A', {}, 'rack.session' => session

    expect(last_response.status).to eq(302)
  end

  it 'probando post /signup del server con datos válidos de una cuenta existente' do
    # Proporciona datos válidos para la prueba
    email = 'juanito@gmail.com'
    password = 'Juanito32' # Cumple con las condiciones de contraseña
    name = 'Juan'
    nickname = 'juanito' # Cumple con las condiciones de apodo

    # Realiza la solicitud al servidor
    post '/signup', { email: email, password: password, name: name, nickname: nickname }

    # Verifica que la respuesta sea una redirección a '/home' (éxito)
    expect(last_response.status).to eq(302)
    follow_redirect!

    # Verifica que la respuesta final sea 200 (OK)
    expect(last_response.status).to eq(200)
  end
end
