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
      @theme = 'light'
      @tests = Test.all
      @lessons = Lesson.all
      erb :home, locals: { lessons: @lessons, tests: @tests }
    else
      redirect "/" 
    end
  end
  
  get '/profile' do
    if request.cookies['logged_in'] == 'true' 
      @theme = 'light'
      erb :profile
    else
      redirect "/"
    end
  end 

  get '/snippets' do
    if request.cookies['logged_in'] == 'true'
      @theme = 'light'
      erb :snippets
    else
      redirect "/"
    end
  end

  get '/lesson/:lesson_number' do
    if request.cookies['logged_in'] == 'true' 
      lesson_number = params[:lesson_number]
      @lesson = Lesson.find_by(number: lesson_number)
      @theme = 'light'
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

      # Encuentra las opciones asociadas a la pregunta
      @options = Option.where(questions_id: @question.number)

      @theme = 'light'
      erb :test, locals: { test: @test, question: @question, options: @options }
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
      account = Account.new(email: email, password: password, name: name, nickname: nickname)
      if account.save
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
      response.set_cookie('logged_in', value: 'true', expires: Time.now + 24*60*60)
      redirect '/home'
    else
      redirect '/?error=Invalid-email-or-password'
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

end
