require 'sinatra/base'
require 'sinatra/activerecord'
require 'sinatra/reloader'
require 'logger'

# Load Models
Dir[File.join(__dir__, '../models/*.rb')].each { |file| require file }

class ApplicationController < Sinatra::Base
  # Configuración compartida
  configure do
    set :views, File.expand_path('../views', __dir__)
    set :public_folder, File.expand_path('../styles', __dir__)
    enable :logging
  end

  # Logging config for development
  configure :development do
    register Sinatra::Reloader
  end
  
  # Helpers compartidos
  helpers do
    def log(msg, thing)
      logger.info '*******************'
      logger.info "#{msg}: "
      logger.info thing
      logger.info '*******************'
    end

    def current_user
      @current_user ||= Account.find(session[:account_id]) if session[:account_id]
    end

    def logged_in?
      !!session[:logged_in]
    end

    def authenticate!
      redirect '/' unless logged_in?
    end
  end

  # Manejo de 404 (opcional)
  not_found do
    "Página no encontrada"
  end
end
