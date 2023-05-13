require 'sinatra/base'
require 'bundler/setup'
require 'logger'
require 'sinatra/activerecord'

require 'sinatra/reloader' if Sinatra::Base.environment == :development


require_relative 'models/account'

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
    erb :signin
  end

  get '/login' do
    erb :login
  end

  get '/settings' do
    erb :settings
  end

  post '/login' do
    # Retrieve the form data
    email = params[:email]
    password = params[:password]
    name = params[:name]
    nickname = params[:nickname]
  
    account = Account.find_by(email: email, password: password)
    
    if account
      logger.info "Account #{email} already exists"
      redirect '/login_error'
    else
      account = Account.new(email: email, password: password, name: name, nickname: nickname) 
      if account.save
        logger.info "Account #{email} created successfully"
        redirect '/home'
      else
        logger.info "Failed to create account for #{email}"
        erb :login, locals: { error_message: "Error al crear cuenta" }
      end
    end
  end

  post '/' do
    email = params[:email]
    password = params[:password]

    account = Account.find_by(email: email, password: password)

    if account
      logger.info "Account #{email} signed in successfully"
      redirect '/home'
    else
      logger.info "Account #{email} failed to sign in"
      redirect '/signin_error'
    end
  end

  get '/home' do
    erb :home
  end

  get '/login_error' do
    erb :login_error
  end

  get '/signin_error' do
    erb :signin_error
  end

end