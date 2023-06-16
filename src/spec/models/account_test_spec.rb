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

  end

end