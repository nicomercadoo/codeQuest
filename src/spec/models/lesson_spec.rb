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

    it 'should move on to the next lesson', type: :feature do
      first_lesson = Lesson.create(number: 1, title: 'Introduction', test_letter: 'A')
      Lesson.create(number: 2, title: 'Conclusion', test_letter: 'A')
      result = first_lesson.getNextLesson
      expect(result).to eq('/lesson/A/2')
    end

    it 'should not move on to the next lesson' do
      lesson = Lesson.create(number: 1, title: 'Introduction', test_letter: 'A')
      Question.create(number: 1, description: 'Is this a question?', test_letter: 'A')
      result = lesson.getNextLesson
      expect(result).to eq('/test/A/1')
    end
  end
end
