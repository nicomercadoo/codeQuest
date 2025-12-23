# frozen_string_literal: true

class MenuController < ApplicationController
  # Apply authentication to all routes except (none here, as all require auth)
  before do
    authenticate!
  end

  get '/home' do

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

    erb :profile
  end

  post '/profile' do

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




  get '/snippets' do
    @snippets = Snippet.where(account_id: current_user.id)
    erb :snippets, locals: { snippets: @snippets }
  end

  post '/snippets' do
    if params[:snippet_code]
      Snippet.create(code: params[:snippet_code], description: params[:snippet_description],
                     account_id: current_user.id)
    end
    redirect '/snippets'
  end

  get '/resources' do

    erb :resources
  end

  post '/logout' do
    session.delete(:logged_in)
    session.delete(:account_id)
    session.delete(:account_theme)
    redirect '/'
  end


end
