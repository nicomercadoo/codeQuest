# frozen_string_literal: true

require_relative '../../models/init'

describe Question do
  context 'validations' do
    it 'is valid with valid attributes' do
      question = Question.new(number: 1, description: 'This is a question', test_letter: 'B')
      expect(question).to be_valid
    end

    it 'is not valid without a number' do
      question = Question.new(number: nil)
      expect(question).not_to be_valid
    end

    it 'is not valid without a description' do
      question = Question.new(description: nil)
      expect(question).not_to be_valid
    end

    it 'is not valid without a test letter' do
      question = Question.new(test_letter: nil)
      expect(question).not_to be_valid
    end

    it 'should move on to the next question' do
      question1 = Question.create(number: 1, description: 'Is this a question?', test_letter: 'A')
      question2 = Question.create(number: 2, description: 'Is this a question?', test_letter: 'A')
      result = question1.get_next_question
      expect(result).to eq('/test/A/2')
    end

    it 'should not move on to the next question' do
      question = Question.create(number: 1, description: 'Is this a question?', test_letter: 'A')
      result = question.get_next_question
      expect(result).to eq('/test_status/A')
    end

    it 'answer status should be incorrect' do
      question = Question.create(number: 1, description: 'Is this a question?', test_letter: 'A')
      result = question.submit_answer(false)
      expect(result).to eq('/incorrect/A/1')
    end

    it 'answer status should be correct' do
      question = Question.create(number: 1, description: 'Is this a question?', test_letter: 'A')
      result = question.submit_answer(true)
      expect(result).to eq('/correct/A/1')
    end
  end
end
