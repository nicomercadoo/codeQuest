# frozen_string_literal: true

class RegisterController < ApplicationController
  def log(msg, thing)
    logger.info '*******************'
    logger.info "#{msg}: "
    logger.info thing
    logger.info '*******************'
  end



  get '/' do
    if session[:logged_in] == true
      redirect '/home'
    else
      erb :login
    end
  end

  post '/' do
    nickname = params[:nickname]
    password = params[:password]

    account = Account.find_by(nickname: nickname)

    if account && account.authenticate(password)
      session[:logged_in] = true
      session[:account_id] = account.id
      session[:account_theme] = account.theme_light

      redirect '/home'
    else
      redirect '/?error=Invalid-nickname-or-password'
    end
  end

  get '/signup' do
    erb :signup
  end

  post '/signup' do
    email = params[:email]
    password = params[:password]
    name = params[:name]
    nickname = params[:nickname]

    validation = Account.validate_data(email, password, name, nickname)

    redirect '/signup?Invalid-email'    unless validation[:email]
    # Password format validation could be done here if needed, but has_secure_password guarantees presence/hashing.
    # If keeping strictly regex:
    # redirect '/signup?Invalid-password' unless password =~ /(?=(?:.*[A-Z].*)+)(?=(?:.*[a-z].*)+)(?=(?:.*\d.*)+)(?!(?:.*\s.*)+)^(?=.{8,}$).*/

    redirect '/signup?Invalid-name'     unless validation[:name]
    redirect '/signup?Invalid-nickname' unless validation[:nickname]

    redirect '/signup?error=Account-already-exists'  if Account.find_by(email: email)
    redirect '/signup?error=Nickname-already-exists' if Account.find_by(nickname: nickname)

    # With has_secure_password, passing password: password automatically handles hashing
    account = Account.new(email: email, password: password, name: name, nickname: nickname, progress: 0)

    if account.save
      session[:logged_in] = true
      session[:account_id] = account.id
      session[:account_theme] = account.theme_light

      account.stuff

      redirect '/home'
    else
      erb :signup, locals: { error_message: 'Error al crear cuenta' }
    end
  end
end
