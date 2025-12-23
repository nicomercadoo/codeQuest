# frozen_string_literal: true

require 'sinatra/base'
require 'bundler/setup'
require 'logger'
require 'sinatra/activerecord'
require 'rack/session/cookie'
require 'bcrypt'
require 'asciidoctor'

require 'sinatra/reloader' if Sinatra::Base.environment == :development

require_relative 'models/init'
require_relative 'controllers/init_controllers'

class App < Sinatra::Application
  def initialize(_app = nil)
    super()
  end

  use Rack::Session::Cookie,  key: 'rack.session',
                              expire_after: 60 * 60 * 24 * 7, # 1 semana                            ,
                              secret: ENV['SESSION_SECRET'] || '93b88de68f9a312d4e33b6c62a58229016b001af8ce01ced7884ae26e03708cd53eaba82ecd3f1a140b21e6e573ae7391efcaa2a81190840e3fe5702daa2e66a'

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

  use RegisterController
  use MenuController
  use GameController
end
