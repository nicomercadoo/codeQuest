require 'sinatra/base'
require 'bundler/setup'
require 'logger'
require 'sinatra/activerecord'

require 'sinatra/reloader' if Sinatra::Base.environment == :development

require_relative 'models/account'
require_relative 'models/lesson'
require_relative 'models/test'

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
    @theme = 'dark'
    erb :login
  end

  get '/signup' do
    @theme = 'dark'
    erb :signup
  end

  get '/home' do
    @theme = 'dark'
    @tests = Test.all
    @lessons = Lesson.all
    erb :home, locals: { lessons: @lessons, tests: @tests}
  end

  get '/profile' do
    @theme = 'dark'
    erb :profile
  end

  get '/settings' do
    @theme = 'dark'
    erb :settings
  end

  get '/snippets' do
    @theme = 'dark'
    erb :snippets
  end

  get '/lesson/:lesson_id' do
    lesson_id = params[:lesson_id]
    @lesson = Lesson.find_by(id: lesson_id.to_i)
    @theme = 'light'
    erb :lesson
  end

  get '/test/:test_id' do
    test_id = params[:test_id]
    @test = Test.find_by(id: test_id)
    @theme = 'light'
    erb :test
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
    email = params[:email]
    password = params[:password]

    account = Account.find_by(email: email, password: password)

    if account
      redirect '/home'
    else
      redirect '/?error=Invalid-email-or-password'
    end
  end

  
  post '/home' do
    if params[:lesson_id]
      lesson_id = params[:lesson_id]
      redirect "/lesson/#{lesson_id}"
    else
      test_id = params[:test_id]
      redirect "/test/#{test_id}"
    end
  end
end
