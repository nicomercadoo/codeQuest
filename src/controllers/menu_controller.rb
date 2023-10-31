class MenuController < Sinatra::Application

  set :views, '/src/views'

  get '/home' do
    if session[:logged_in] == true
      @tests = Test.all

      erb :home, locals: { tests: @tests }
    else
      redirect '/'
    end
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
    if session[:logged_in] == true
      
      erb :profile
    else
      redirect '/'
    end
  end

  post '/profile' do
    if session[:logged_in] == true
      account = Account.find(session[:account_id])

      account.update(nickname: params[:nicknameInput]) if params[:nicknameInput]

      account.update(email: params[:emailInput]) if params[:emailInput]

      account.update(password: params[:passwordInput]) if params[:passwordInput]

      if params[:theme] == 'dark'
        account.update(theme_light: true)
        session[:account_theme] = true
      end

      if params[:theme] == 'light'
        account.update(theme_light: false)
        session[:account_theme] = false
      end

      redirect '/profile'
    else
      redirect '/'
    end
  end

  before '/snippets' do
    redirect '/' unless session[:logged_in]
    @snippets = Snippet.where(account_id: session[:account_id])
  end

  get '/snippets' do
    if session[:logged_in] == true

      erb :snippets, locals: { snippets: @snippets }
    else
      redirect '/'
    end
  end

  post '/snippets' do
    if session[:logged_in] == true
      Account.find(session[:account_id])
      
      if params[:snippet_code]
        Snippet.create(code: params[:snippet_code], description: params[:snippet_description],
        account_id: session[:account_id])
      end
      
      erb :snippets, locals: { snippets: @snippets }
    else
      redirect '/'
    end
  end
  
  get '/resources' do
    if session[:logged_in] == true

      erb :resources
    else
      redirect '/'
    end
  end

  post '/logout' do
    session.delete(:logged_in)
    session.delete(:account_id)
    session.delete(:account_theme)
    redirect '/'
  end


end
