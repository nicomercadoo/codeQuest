require 'sinatra/base'
require 'bundler/setup'
require 'logger'
require 'sinatra/activerecord'

require 'sinatra/reloader' if Sinatra::Base.environment == :development

require_relative 'models/account'
require_relative 'models/lesson'
require_relative 'models/test'
require_relative 'models/option'
require_relative 'models/answer'
require_relative 'models/question'

class App < Sinatra::Application
  def initialize(app = nil)
    super()
  end

  configure :production, :development do
    enable :logging

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

  set :views, File.join(File.dirname(__FILE__), 'views')
  set :public_folder, File.join(File.dirname(__FILE__), 'styles')

  get '/' do
    if request.cookies['logged_in'] == 'true'
      redirect '/home'
    else
      @theme = 'light'
      erb :login
    end
  end

  get '/signup' do
    @theme = 'light'
    erb :signup
  end

  get '/home' do
    if request.cookies['logged_in'] == 'true'
      @theme = 'dark'
      @tests = Test.all
      erb :home, locals: { tests: @tests }
    else
      redirect "/"
    end
  end

  get '/profile' do
    if request.cookies['logged_in'] == 'true'
      @theme = 'dark'
      erb :profile
    else
      redirect "/"
    end
  end

  get '/snippets' do
    if request.cookies['logged_in'] == 'true'
      @theme = 'dark'
      erb :snippets
    else
      redirect "/"
    end
  end

  get '/lesson/:lesson_number' do
    if request.cookies['logged_in'] == 'true'
      lesson_number = params[:lesson_number]
      @lesson = Lesson.find_by(number: lesson_number)
      current_user_nickname = request.cookies['logged_in_nickname']
      if @lesson
        # Marcar la lección como completada
        @lesson.update(completed: true)
        @lesson.update(account_nickname: current_user_nickname)
        @lesson.save
      end

      # Verificar si la lección anterior ha sido completada
      if @lesson.number > 1 && Lesson.where(number: 1..(@lesson.number - 1), completed: false).exists?
        redirect '/home/lecciones_incompletas' # Redirigir al inicio si la lección anterior no está completada
      end
      # Se obtiene la letra del test que se corresponde con la leccion
      related_test_letter = @lesson.test_letter
      # Se obtiene la letra del test
      related_test = Test.find_by(letter: related_test_letter).letter
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
      @next_step = @current_is_last ? "/test/#{related_test}/#{@questions.minimum(:number)}" : "/lesson/#{next_lesson}"

      @theme = 'dark'
      erb :lesson
    else
      redirect "/"
    end
  end

  get '/test/:test_letter/:question_number' do
    if request.cookies['logged_in'] == 'true'
      test_letter = params[:test_letter]
      question_number = params[:question_number]

      # Encuentra el test y la pregunta asociados a los nombres
      @test = Test.find_by(letter: test_letter)
      @question = Question.find_by(number: question_number)

      questions = Question.where(test_letter: test_letter)

      # Verificar si todas las lecciones relacionadas con el test están completadas
      if @test.lessons.exists?(completed: false)
        redirect '/home/lecciones_incompletas' # Redirigir al inicio si alguna lección relacionada no está completada
      end

      if questions.exists?(number: question_number)
        # Encuentra la pregunta asociada al question_number y al test
        @options = Option.where(question_number: @question.number)

        @theme = 'dark'
        erb :test, locals: { test: @test, question: @question, options: @options }
      else
        redirect "/"
      end
    else
      redirect "/"
    end
  end

  get '/answer_status/:status/:test_letter/:question_number' do
    if request.cookies['logged_in'] == 'true'
      @status = params[:status]
      # @dir = params[:dir]
      @test_letter = params[:test_letter]
      @question_number = params[:question_number]
      @theme = 'dark'

      question = Question.find_by(number: @question_number)
      related_test_letter = question.test_letter
      # Se obtienen todas las preguntas que estan relacionadas con el test
      questions = Question.where(test_letter: related_test_letter)
      # Se obtiene la ultima pregunta
      last_question_in_group = questions.last.number
      # Se verifica si la pregunta actual es la ultima
      current_is_last = question.number == last_question_in_group
      # Se obtiene la (supuesta) proxima pregunta
      @next_question_number = question.number + 1

      if !current_is_last && @next_question_number <= questions.maximum(:number)
        @url_redirect = "/test/#{@test_letter}/#{@next_question_number}"
      else
        @url_redirect = "/home"
      end

      erb :answer_status

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
        response.set_cookie('logged_in', value: 'true', httponly: true, expires: Time.now + 24*60*60*7)
        response.set_cookie('logged_in_nickname', value: nickname, httponly: true, expires: Time.now + 24*60*60*7)  # Establecer la cookie del nickname
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
      response.set_cookie('logged_in', value: 'true', httponly: true, expires: Time.now + 24*60*60*7)
      response.set_cookie('logged_in_nickname', value: nickname, httponly: true, expires: Time.now + 24*60*60*7)  # Establecer la cookie del nickname
      redirect '/home'
    else
      redirect '/?error=Invalid-nickname-or-password'
    end
  end


  post '/home' do
    if params[:lesson_number]
      lesson_number = params[:lesson_number]
      redirect "/lesson/#{lesson_number}"
    else
      test_letter = params[:test_letter]
      question_number = params[:question_number]
      redirect "/test/#{test_letter}/#{question_number}"
    end
  end

  post '/submit_answer' do
    if request.cookies['logged_in'] == 'true'
      question_number = params[:question_number]
      test_letter = params[:test_letter]

      @test = Test.find_by(letter: test_letter)
      @question = Question.find_by(number: question_number)

      selected_option_number = params[:selected_option]

      # Encuentra la opción seleccionada por el usuario
      selected_option = Option.find(selected_option_number)

      correct_option = selected_option.correct

      # Verifica si la opción seleccionada es correcta
      if correct_option

        current_user_nickname = request.cookies['logged_in_nickname']
        answer = Answer.new(description: selected_option.description, account_nickname: current_user_nickname)
        answer.save

        if @test
          unless Question.where(test_letter: @test.letter, number: @question.number, well_answered: true).exists?
            @test.increment!(:acerted_answers)  # Incrementar el contador acerted_answers del test en 1
          end
        end

        # Actualiza el estado de la pregunta para indicar que ha sido bien respondida
        if @question
          @question.well_answered = true
          @question.save
        else
          # Si @question es nulo, maneja el caso de error
          redirect '/error_page'
        end

        if @test && !Question.where(test_letter: @test.letter, well_answered: false).exists?
          # Todas las preguntas del test han sido respondidas correctamente
          @test.update(completed: true)
        end

      else
        # La opción seleccionada es incorrecta
        current_user_nickname = request.cookies['logged_in_nickname']
        answer = Answer.new(description: selected_option.description, account_nickname: current_user_nickname)
        answer.save
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
    response.delete_cookie('logged_in')
    redirect '/'
  end

end
