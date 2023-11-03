class GameController < Sinatra::Application

  set :views, '/src/views'
  File.join(File.dirname(__FILE__), 'lessons')

  get '/lesson/:test_letter/:lesson_number' do
    if session[:logged_in] == true

      test_letter = params[:test_letter]
      lesson_number = params[:lesson_number]

      lesson = Lesson.find_by(test_letter: test_letter, number: lesson_number)

      lesson_html_body = lesson.content

      # Progreso
      account = Account.find(session[:account_id])

      if lesson
        accounts_lesson = AccountLesson.find_by(lesson_id: lesson.id, account_id: account.id)

        # Actualizar el valor de lesson_completed
        accounts_lesson&.update(lesson_completed: true)
      end

      erb :lesson, locals: { lesson: lesson, lesson_content: lesson_html_body }
    else
      redirect '/'
    end
  end

  get '/test/:test_letter/:question_number' do
    if session[:logged_in] == true

      test_letter = params[:test_letter]
      question_number = params[:question_number]

      # Encuentra el test y la pregunta asociados a los nombres
      @test = Test.find_by(letter: test_letter)
      @question = Question.find_by(number: question_number, test_letter: test_letter)

      questions = Question.where(test_letter: test_letter)

      lessons = Lesson.where(test_letter: test_letter)
      account = Account.find(session[:account_id])

      # Verificar si todas las lecciones relacionadas con el test están completadas
      lessons.each do |lesson|
        previous_lessons_completed = AccountLesson.exists?(lesson_id: lesson.id, account_id: account.id,
                                                           lesson_completed: true)

        # Redirigir al inicio si alguna lección relacionada no está completada
        redirect '/home?error=Previous-lessons-incompleted' unless previous_lessons_completed
      end

      if questions.exists?(number: question_number)
        # Encuentra la pregunta asociada al question_number y al test
        @options = Option.where(question_number: @question.number, test_letter: @test.letter).shuffle

        erb :test, locals: { test: @test, question: @question, options: @options }
      else
        redirect '/'
      end
    else
      redirect '/'
    end
  end

  get '/:status/:test_letter/:question_number' do
    if session[:logged_in] == true

      status = params[:status]
      test_letter = params[:test_letter]
      question_number = params[:question_number].to_i

      question = Question.find_by(test_letter: test_letter, number: question_number)

      erb :answer_status, locals: { status: status, question: question }

    else
      redirect "/"
    end

  end

  get '/test_status/:test_letter' do
    if session[:logged_in] == true

      test_letter = params[:test_letter]

      @test = Test.find_by(letter: test_letter)
      @questions = Question.all
      @options = Option.all

      current_account_id = session[:account_id]
      existing_account_test = AccountTest.find_by(account_id: current_account_id, test_id: @test.id)
      if !AccountQuestion.where(account_id: current_account_id,
                                question_id: @questions.where(test_letter: test_letter), well_answered: false).exists?
        # Todas las preguntas del test han sido respondidas correctamente

        existing_account_test.update(test_completed: true)
      else
        existing_account_test.update(test_completed: false)
      end

      # Obtengo todas las respuestas de la cuenta
      answers = AccountOption.where(account_id: current_account_id, option_id: @options.where(test_letter: test_letter))
      count_correct = 0
      answers.each do |answer|
        count_correct += 1 if answer.option.correct
      end
      # Busco el account_test relacionado a la question de la option
      related_account_test = AccountTest.find_by(account_id: current_account_id, test_id: @test.id)
      related_account_test.update_column(:correct_questions, count_correct)

      @test_completed = existing_account_test.test_completed
      @final_test = test_letter == Test.last.letter
      @lessons = Lesson.where(test_letter: test_letter)
      first_lesson_current_test = @lessons.minimum(:number)
      @lessons_next_test = Lesson.where(test_letter: test_letter.next)
      next_lesson = @lessons_next_test.minimum(:number)
      @url_retry = "/test/#{test_letter}/#{first_lesson_current_test}"
      @url_redirect = "/lesson/#{test_letter.next}/#{next_lesson}"

      erb :test_status

    else
      redirect '/'
    end
  end

  post '/submit_answer' do
    if session[:logged_in] == true
      question_number = params[:question_number]
      test_letter = params[:test_letter]
      selected_option_number = params[:selected_option]

      question = Question.find_by(number: question_number, test_letter: test_letter)
      selected_option = Option.find_by(number: selected_option_number, test_letter: test_letter,
                                          question_number: question_number)
      session = request.env['rack.session']

      # Metodo para verificar si la opcion elegida es correcta
      answer_status = selected_option.choose_option(question, session)
      # Redirige segun corresponda 
      redirect question.submit_answer(answer_status)
    else
      redirect '/'
    end
  end

end