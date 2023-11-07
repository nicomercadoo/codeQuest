class RegisterController < Sinatra::Application
  def log(msg, thing)
    logger.info '*******************'
    logger.info "#{msg}: "
    logger.info thing
    logger.info '*******************'
  end

  set :views, '/src/views'

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
    redirect '/signup?Invalid-password' unless validation[:password]
    redirect '/signup?Invalid-name'     unless validation[:name]
    redirect '/signup?Invalid-nickname' unless validation[:nickname]

    redirect '/signup?error=Account-already-exists'  if Account.find_by(email: email, password: password)
    redirect '/signup?error=Nickname-already-exists' if Account.find_by(nickname: nickname)

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
