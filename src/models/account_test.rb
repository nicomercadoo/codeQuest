class AccountTest < ActiveRecord::Base
  validates :test_completed, inclusion: { in: [true, false] }
  validates :correct_questions, presence: true
  
  belongs_to :account
  belongs_to :test

  #after_save :actualizar_validaciones

  #private

  #def actualizar_validaciones
    # Obtengo todas las questions relacionadas al test
   # test_questions = Question.where(test_letter: test.letter)

    # Verificar si la cantidad de correct_questions es igual a la cantidad total de preguntas del test
    #if account_test.correct_questions == test_questions.count
    #  account_test.update(test_completed: true)
    #end

    # Incrementar el contador correct_questions solo si la opción elegida por la cuenta es true
    #account_option = AccountOption.find_by(account_id: account.id, option_id: selected_option.id)
    #if account_option && account_option.option.correct
    #  account_test.increment!(:correct_questions)
    #end
  #end
end