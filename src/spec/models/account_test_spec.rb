require_relative '../../models/init'

describe AccountTest do
  context "validations" do

    it "is valid with valid attributes" do
      account_test = AccountTest.new(test_completed: true, correct_questions: 5, account_id: 5, test_id: 3)
      #TODO: Un test que verifique que un test solo sea true si correct_questions = test.cant_questions
      expect(account_test).to be_valid
    end

    it "not valid without a completion value" do
      account_test = AccountTest.new(test_completed: nil)
      expect(account_test).not_to be_valid
    end

    it "not valid without a number of correct answers" do
      account_test = AccountTest.new(correct_questions: nil)
      expect(account_test).not_to be_valid
    end

    it "increases progress correctly when test is completed" do
      account = Account.find_or_create_by(name: 'Juan', email: 'juanito@gmail.com', password: 'Juanito32', nickname: 'juanito', theme_light: 'dark')

      test = Test.find_or_create_by(letter: 'A', description: "Description", cant_questions: 5)
      test.save

      account_test = AccountTest.find_or_create_by(test_completed: false, correct_questions: 0, account_id: 1, test_id: 1)
      account_test.save
    
      account = Account.find_by(id: 1)
      initial_progress = account.progress
    
      account_test.update(test_completed: true)
      account_test.send(:actualizar_progreso_account) # Llamar al método usando send ya que es privado
      account.reload
    
      expect(account.progress).to be > initial_progress
    end

  end

end