require 'sinatra/base'
require 'bundler/setup'
require 'logger'
require 'sinatra/activerecord'
require 'sinatra/base'
require 'rack/session/cookie'
require 'asciidoctor'

require 'sinatra/reloader' if Sinatra::Base.environment == :development

require_relative 'models/account'
require_relative 'models/lesson'
require_relative 'models/test'
require_relative 'models/option'
require_relative 'models/question'
require_relative 'models/snippet'
require_relative 'models/account_lesson'
require_relative 'models/account_test'
require_relative 'models/account_option'
require_relative 'models/account_question'


class App < Sinatra::Application
  def initialize(app = nil)
    super()
  end

  use Rack::Session::Cookie,  key: 'rack.session',
                              expire_after: 60 * 60 * 24 * 7, #1 semana                            ,
                              secret: '93b88de68f9a312d4e33b6c62a58229016b001af8ce01ced7884ae26e03708cd53eaba82ecd3f1a140b21e6e573ae7391efcaa2a81190840e3fe5702daa2e66a'

  configure :production, :development do
    enable :logging
    enable :session
    logger = Logger.new(STDOUT)
    logger.level = Logger::DEBUG if development?
    set :logger, logger
  end


  configure :development do
    register Sinatra::Reloader
    after_reload do
      puts 'Reloaded...'
    end
  end

  def log (msg, thing)
    logger.info '*******************'
    logger.info "#{msg}: "
    logger.info thing
    logger.info '*******************'
  end

  set :views, File.join(File.dirname(__FILE__), 'views')
  set :public_folder, File.join(File.dirname(__FILE__), 'styles')
  lessons_folder = File.join(File.dirname(__FILE__), 'lessons')

  get '/' do
    if session[:logged_in] == true
      redirect '/home'
    else
      erb :login
    end
  end

  get '/signup' do
    erb :signup
  end

  get '/home' do
    if session[:logged_in] == true
      @tests = Test.all

      erb :home, locals: { tests: @tests }
    else
      redirect "/"
    end
  end

  get '/profile' do
    if session[:logged_in] == true

      erb :profile
    else
      redirect "/"
    end
  end

  before '/snippets' do
    redirect "/" unless session[:logged_in]
    @snippets = Snippet.where(account_id: session[:account_id])
  end

  get '/snippets' do
    if session[:logged_in] == true

      erb :snippets, locals: { snippets: @snippets }
    else
      redirect "/"
    end
  end

  get '/lesson/:test_letter/:lesson_number' do
    if session[:logged_in] == true

      test_letter = params[:test_letter]
      lesson_number = params[:lesson_number]

      @test = Test.find_by(letter: test_letter)
      @lesson = Lesson.find_by(test_letter: test_letter, number: lesson_number)

      @lesson_html_body = @lesson.content

      # Se obtiene la letra del test que se corresponde con la leccion
      related_test_letter = @lesson.test_letter

      # Se obtienen todas las preguntas y las lecciones que estan relacionadas con el test
      @questions = Question.where(test_letter: related_test_letter)
      @lessons = Lesson.where(test_letter: related_test_letter)

      # Se obtiene la ultima leccion
      last_lesson_in_group = @lessons.last.number

      # Se verifica si la leccion actual es la ultima
      @current_is_last = @lesson.number == last_lesson_in_group

      # Se obtiene la (supuesta) proxima leccion
      next_lesson = @lesson.number + 1

      # Se almacena la url a donde debera ser redirigido el usuario dependiendo de la situacion
      @next_step = @current_is_last ? "/test/#{related_test_letter}/#{@questions.minimum(:number)}" : "/lesson/#{related_test_letter}/#{next_lesson}"

      # Progreso
      account = Account.find(session[:account_id])
      lesson = Lesson.find_by(test_letter: test_letter, number: lesson_number)

      if lesson
        accounts_lesson = AccountLesson.find_by(lesson_id: lesson.id, account_id: account.id)

        if accounts_lesson
          # Actualizar el valor de lesson_completed
          accounts_lesson.update(lesson_completed: true)
        end
      end

      erb :lesson
    else
      redirect "/"
    end
  end

  get '/test/:test_letter/:question_number' do
    if session[:logged_in] == true

      test_letter = params[:test_letter]
      question_number = params[:question_number]

      # Encuentra el test y la pregunta asociados a los nombres
      @test = Test.find_by(letter: test_letter)
      @question = Question.find_by(number: question_number, test_letter: test_letter)

      questions = Question.where(test_letter: test_letter)

      lessons = Lesson.where(test_letter: test_letter)
      account = Account.find(session[:account_id])

      # Verificar si todas las lecciones relacionadas con el test están completadas
      lessons.each do |lesson|
        previous_lessons_completed = AccountLesson.exists?(lesson_id: lesson.id, account_id: account.id, lesson_completed: true)

        # Redirigir al inicio si alguna lección relacionada no está completada
        redirect '/home?error=Previous-lessons-incompleted' unless previous_lessons_completed
      end


      if questions.exists?(number: question_number)
        # Encuentra la pregunta asociada al question_number y al test
        @options = Option.where(question_number: @question.number, test_letter: @test.letter).shuffle

        erb :test, locals: { test: @test, question: @question, options: @options }
      else
        redirect "/"
      end
    else
      redirect "/"
    end
  end



  get '/answer_status/:status/:test_letter/:question_number' do
    if session[:logged_in] == true

      @status = params[:status]
      test_letter = params[:test_letter]
      question_number = params[:question_number].to_i

      # Se obtienen todas las preguntas que estan relacionadas con el test
      questions = Question.where(test_letter: test_letter)
      # Se obtiene la ultima pregunta
      last_question_in_group = questions.last.number
      # Se verifica si la pregunta actual es la ultima
      current_is_last = question_number == last_question_in_group
      # Se obtiene la (supuesta) proxima pregunta
      next_question_number = question_number + 1

      @can_continue = !current_is_last && next_question_number <= questions.maximum(:number)

      if @can_continue
        @url_redirect = "/test/#{test_letter}/#{next_question_number}"
      else

        @lessons = Lesson.where(test_letter: test_letter.next)
        next_lesson = @lessons.minimum(:number)
        @url_redirect = "/test_status/#{test_letter}"
      end

      erb :answer_status

    else
      redirect "/"
    end

  end

  get '/test_status/:test_letter' do
    if session[:logged_in] == true

      test_letter = params[:test_letter]

      @test = Test.find_by(letter: test_letter)
      @questions = Question.all
      @options = Option.all

      current_account_id = session[:account_id]
      existing_account_test = AccountTest.find_by(account_id: current_account_id, test_id: @test.id)
      if !AccountQuestion.where(account_id: current_account_id, question_id: @questions.where(test_letter: test_letter), well_answered: false).exists?
        # Todas las preguntas del test han sido respondidas correctamente

        existing_account_test.update(test_completed: true)
      else
        existing_account_test.update(test_completed: false)
      end

      # Obtengo todas las respuestas de la cuenta
      answers = AccountOption.where(account_id: current_account_id, option_id: @options.where(test_letter: test_letter))
      count_correct = 0
      answers.each do |answer|
        count_correct += 1 if answer.option.correct
      end
      # Busco el account_test relacionado a la question de la option
      related_account_test = AccountTest.find_by(account_id: current_account_id, test_id: @test.id)
      related_account_test.update_column(:correct_questions, count_correct)

      @test_completed = existing_account_test.test_completed
      @final_test = test_letter == Test.last.letter
      @lessons = Lesson.where(test_letter: test_letter)
      first_lesson_current_test = @lessons.minimum(:number)
      @lessons_next_test = Lesson.where(test_letter: test_letter.next)
      next_lesson = @lessons_next_test.minimum(:number)
      @url_retry = "/test/#{test_letter}/#{first_lesson_current_test}"
      @url_redirect = "/lesson/#{test_letter.next}/#{next_lesson}"

      erb :test_status

    else
      redirect "/"
    end

  end


  post '/signup' do
    # Retrieve the form data
    email = params[:email]
    password = params[:password]
    name = params[:name]
    nickname = params[:nickname]

    valid_email_format = /^[a-zA-Z0-9_.+-]+@(gmail|outlook|hotmail|live)\.[a-z.]+$/
    valid_password_format = /(?=(?:.*[A-Z].*)+)(?=(?:.*[a-z].*)+)(?=(?:.*\d.*)+)(?!(?:.*\s.*)+)^(?=.{8,}$).*/
    valid_name_format = /(?=(?:^\D*$)+)/
    valid_nickname_format = /(?=(?:^\S*$)+)/

    unless (email =~ valid_email_format)
      redirect '/signup?Invalid-email'
    end
    unless password =~ valid_password_format
      redirect '/signup?Invalid-password'
    end
    unless name =~ valid_name_format
      redirect '/signup?Invalid-name'
    end
    unless nickname =~ valid_nickname_format
      redirect '/signup?Invalid-nickname'
    end

    account = Account.find_by(email: email, password: password)
    account_with_nickname = Account.find_by(nickname: nickname)

    if account
      redirect '/signup?error=Account-already-exists'
    else
      if account_with_nickname
        redirect '/signup?error=Nickname-already-exists'
      end
      account = Account.new(email: email, password: password, name: name, nickname: nickname, progress: 0)

      if account.save
        session[:logged_in] = true
        session[:account_id] = account.id
        session[:account_theme] = account.theme_light

        Lesson.all.each do |lesson|
          AccountLesson.create(account_id: account.id, lesson_id: lesson.id)
        end

        Question.all.each do |question|
          AccountQuestion.create(account_id: account.id, question_id: question.id)
        end

        Test.all.each do |test|
          AccountTest.create(account_id: account.id, test_id: test.id)
        end

        redirect '/home'
      else
        erb :signup, locals: { error_message: "Error al crear cuenta" }
      end
    end
  end

  post '/' do
    nickname = params[:nickname]
    password = params[:password]

    account = Account.find_by(nickname: nickname, password: password)

    if account
      session[:logged_in] = true
      session[:account_id] = account.id
      session[:account_theme] = account.theme_light

      redirect '/home'
    else
      redirect '/?error=Invalid-nickname-or-password'
    end
  end

  post '/snippets' do
    if session[:logged_in] == true
      account = Account.find(session[:account_id])

      if params[:snippet_code]
        snippet = Snippet.create(code: params[:snippet_code], description: params[:snippet_description], account_id: session[:account_id])
      end

      erb :snippets, locals: { snippets: @snippets }
    else
      redirect "/"
    end
  end
  

  post '/home' do
    if params[:lesson_number]
      lesson_number = params[:lesson_number]
      test_letter = params[:test_letter]
      redirect "/lesson/#{test_letter}/#{lesson_number}"
    else
      test_letter = params[:test_letter]
      question_number = params[:question_number]
      redirect "/test/#{test_letter}/#{question_number}"
    end
  end

  post '/submit_answer' do
    if session[:logged_in] == true
      question_number = params[:question_number]
      test_letter = params[:test_letter]
      selected_option_number = params[:selected_option]

      @test = Test.find_by(letter: test_letter)
      @question = Question.find_by(number: question_number, test_letter: test_letter)
      @questions = Question.all
      @options = Option.all


      # Encuentra la opción seleccionada por el usuario
      selected_option = Option.find_by(number: selected_option_number, test_letter: test_letter, question_number: question_number)

      correct_option = selected_option.correct

      current_account_id = session[:account_id]


      existing_account_option = AccountOption.find_by(account_id: current_account_id, question_id: @question.id)

      # Me fijo si ya contestó esa pregunta
      if existing_account_option
        # Actualizo la tabla
        existing_account_option.update(option_id: selected_option.id)
      else
        # Creo la opción en la tabla accounts_options
        AccountOption.create(option_id: selected_option.id, account_id: current_account_id, question_id: @question.id)
      end

      # Verifica si la opción seleccionada es correcta
      if correct_option

        # Actualiza el estado de la pregunta para indicar que ha sido bien respondida
        if @question
          existing_account_question = AccountQuestion.find_by(account_id: current_account_id, question_id: @question.id)
          existing_account_question.update(well_answered: true)
        else
          # Si @question es nulo, maneja el caso de error
          redirect '/error_page'
        end
      else
        existing_account_question = AccountQuestion.find_by(account_id: current_account_id, question_id: @question.id)
        existing_account_question.update(well_answered: false)
      end

      @questions = Question.where(test_letter: test_letter)
      next_question_number = @question.number

      if next_question_number <= @questions.maximum(:number)
        redirect "/answer_status/#{correct_option ? 'correct' : 'incorrect'}/#{test_letter}/#{@question.number}"
      else
        redirect "/home"
      end

    else
      redirect "/"
    end

  end

  post '/logout' do
    session.delete(:logged_in)
    session.delete(:account_id)
    session.delete(:account_theme)
    redirect '/'
  end

  post '/profile' do
    if session[:logged_in] == true
      account = Account.find(session[:account_id])

      if params[:nicknameInput]
        account.update(nickname: params[:nicknameInput])
      end

      if params[:emailInput]
        account.update(email: params[:emailInput])
      end

      if params[:passwordInput]
        account.update(password: params[:passwordInput])
      end

      if params[:theme] == 'dark'
        account.update(theme_light: true)
        session[:account_theme] = true
      end

      if params[:theme] == 'light'
        account.update(theme_light: false)
        session[:account_theme] = false
      end

      redirect "/profile"
    else
      redirect "/"
    end
  end




end
