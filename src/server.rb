# frozen_string_literal: true

require 'sinatra/base'
require 'bundler/setup'
require 'logger'
require 'sinatra/activerecord'
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
require_relative 'controllers/register_controller'
require_relative 'controllers/menu_controller'
require_relative 'controllers/game_controller'

class App < Sinatra::Application
  def initialize(_app = nil)
    super()
  end

  use Rack::Session::Cookie,  key: 'rack.session',
                              expire_after: 60 * 60 * 24 * 7, # 1 semana                            ,
                              secret: '93b88de68f9a312d4e33b6c62a58229016b001af8ce01ced7884ae26e03708cd53eaba82ecd3f1a140b21e6e573ae7391efcaa2a81190840e3fe5702daa2e66a'

  configure :production, :development do
    enable :logging
    enable :session
    logger = Logger.new($stdout)
    logger.level = Logger::DEBUG if development?
    set :logger, logger
  end

  configure :development do
    register Sinatra::Reloader
    after_reload do
      puts 'Reloaded...'
    end
  end

  def log(msg, thing)
    logger.info '*******************'
    logger.info "#{msg}: "
    logger.info thing
    logger.info '*******************'
  end

  set :views, File.join(File.dirname(__FILE__), 'views')
  set :public_folder, File.join(File.dirname(__FILE__), 'styles')

  use RegisterController
  use MenuController
  use GameController

  get '/' do
    if session[:logged_in] == true
      redirect '/home'
    else
      erb :login
    end
  end
end
