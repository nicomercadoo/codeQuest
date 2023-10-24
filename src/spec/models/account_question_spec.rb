# frozen_string_literal: true

require_relative '../../models/init'

describe AccountQuestion do
  context 'validations' do
    it 'is valid with valid attributes' do
      account_question = AccountQuestion.new(well_answered: false, account_id: 5, question_id: 3)
      # TODO: Un test que verifique que un test solo sea true si correct_questions = test.cant_questions
      expect(account_question).to be_valid
    end

    it 'is not valid without a value of well answered' do
      account_question = AccountQuestion.new(well_answered: nil)
      expect(account_question).not_to be_valid
    end
  end
end
