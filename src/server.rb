require 'sinatra/base'
require 'bundler/setup'
require 'logger'
require 'sinatra/activerecord'

require 'sinatra/reloader' if Sinatra::Base.environment == :development


require_relative 'models/user'

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

  get '/' do
    erb :sign_in
  end

  get '/log_in' do
    erb :log_in
  end

  get '/settings' do
    erb :settings
  end

  post '/log_in' do
    # Retrieve the form data
    email = params[:email]
    password = params[:password]
    name = params[:name]
    nickname = params[:nickname]
  
    # Store the user data in your desired way (e.g., database, file, etc.)
    # Here, we're just printing the data as an example
    puts "New User Registration:"
    puts "Email: #{email}"
    puts "Password: #{password}"
    puts "Name: #{name}"
    puts "Nickname: #{nickname}"
  
    # Redirect to a success page or perform other actions as needed
    redirect '/home'
  end

  get '/home' do
    erb :home
  end

end