class RegisterController < Sinatra::Application

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
    # Retrieve the form data
    email = params[:email]
    password = params[:password]
    name = params[:name]
    nickname = params[:nickname]

    valid_email_format = /^[a-zA-Z0-9_.+-]+@(gmail|outlook|hotmail|live)\.[a-z.]+$/
    valid_password_format = /(?=(?:.*[A-Z].*)+)(?=(?:.*[a-z].*)+)(?=(?:.*\d.*)+)(?!(?:.*\s.*)+)^(?=.{8,}$).*/
    valid_name_format = /(?=(?:^\D*$)+)/
    valid_nickname_format = /(?=(?:^\S*$)+)/

    redirect '/signup?Invalid-email' unless email =~ valid_email_format
    redirect '/signup?Invalid-password' unless password =~ valid_password_format
    redirect '/signup?Invalid-name' unless name =~ valid_name_format
    redirect '/signup?Invalid-nickname' unless nickname =~ valid_nickname_format

    account = Account.find_by(email: email, password: password)
    account_with_nickname = Account.find_by(nickname: nickname)

    if account
      redirect '/signup?error=Account-already-exists'
    else
      redirect '/signup?error=Nickname-already-exists' if account_with_nickname
      account = Account.new(email: email, password: password, name: name, nickname: nickname, progress: 0)

      if account.save
        session[:logged_in] = true
        session[:account_id] = account.id
        session[:account_theme] = account.theme_light

        Lesson.all.each do |lesson|
          AccountLesson.create(account_id: account.id, lesson_id: lesson.id)
        end

        Question.all.each do |question|
          AccountQuestion.create(account_id: account.id, question_id: question.id)
        end

        Test.all.each do |test|
          AccountTest.create(account_id: account.id, test_id: test.id)
        end

        redirect '/home'
      else
        erb :signup, locals: { error_message: 'Error al crear cuenta' }
      end
    end
  end

end