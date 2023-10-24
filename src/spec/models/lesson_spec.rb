# frozen_string_literal: true

require_relative '../../models/init'

describe Lesson do
  context 'validations' do
    it 'is valid with valid attributes' do
      lesson = Lesson.new(number: 1, title: 'Introduction', test_letter: 'A')
      expect(lesson).to be_valid
    end

    it 'is not valid without a number' do
      lesson = Lesson.new(number: nil)
      expect(lesson).not_to be_valid
    end

    it 'is not valid without a title' do
      lesson = Lesson.new(title: nil)
      expect(lesson).not_to be_valid
    end

    it 'is not valid without a test letter' do
      lesson = Lesson.new(test_letter: nil)
      expect(lesson).not_to be_valid
    end
  end
end
