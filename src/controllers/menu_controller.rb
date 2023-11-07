class MenuController < Sinatra::Application

  set :views, '/src/views'
  set :public_folder, '/src/styles'
  

  get '/home' do
    logged_in?
    @tests = Test.all
    erb :home, locals: { tests: @tests }
  end
  
  post '/home' do
    if params[:lesson_number]
      lesson_number = params[:lesson_number]
      test_letter = params[:test_letter]
      redirect "/lesson/#{test_letter}/#{lesson_number}"
    else
      test_letter = params[:test_letter]
      question_number = params[:question_number]
      redirect "/test/#{test_letter}/#{question_number}"
    end
  end

  get '/profile' do
    logged_in?
    erb :profile
  end

  post '/profile' do
    logged_in?
    account = Account.find(session[:account_id])
    account.update(nickname: params[:nicknameInput]) if params[:nicknameInput]
    account.update(email: params[:emailInput]) if params[:emailInput]
    account.update(password: params[:passwordInput]) if params[:passwordInput]

    if params[:theme] == 'dark'
      account.update(theme_light: true)
    else
      account.update(theme_light: false)
    end
    redirect '/profile'
  end

  before '/snippets' do
    logged_in?
    @snippets = Snippet.where(account_id: session[:account_id])
  end

  get '/snippets' do
    erb :snippets, locals: { snippets: @snippets }
  end

  post '/snippets' do
    logged_in?
    Account.find(session[:account_id])

    if params[:snippet_code]
      Snippet.create(code: params[:snippet_code], description: params[:snippet_description],
      account_id: session[:account_id])
    end
    
    erb :snippets, locals: { snippets: @snippets }
  end
  
  get '/resources' do
    logged_in?
    erb :resources
  end

  post '/logout' do
    session.delete(:logged_in)
    session.delete(:account_id)
    session.delete(:account_theme)
    redirect '/'
  end

  def logged_in?
    redirect '/' unless session[:logged_in]
  end

end
