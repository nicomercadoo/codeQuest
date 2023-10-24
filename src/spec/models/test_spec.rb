# frozen_string_literal: true

require_relative '../../models/init'

describe Test do
  context 'validations' do
    it 'is valid with valid attributes' do
      test = Test.new(letter: 'A', description: 'This is a test', cant_questions: 3)
      expect(test).to be_valid
    end

    it 'is not valid without a letter' do
      test = Test.new(letter: nil)
      expect(test).not_to be_valid
    end

    it 'is not valid without a description' do
      test = Test.new(description: nil)
      expect(test).not_to be_valid
    end

    it 'is not valid without the number of questions' do
      test = Test.new(cant_questions: nil)
      expect(test).not_to be_valid
    end
  end
end
