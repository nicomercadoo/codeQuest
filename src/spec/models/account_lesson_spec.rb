# frozen_string_literal: true

require_relative '../../models/init'

describe AccountLesson do
  context 'validations' do
    it 'is valid with valid attributes' do
      account_lesson = AccountLesson.new(lesson_completed: false, account_id: 5, lesson_id: 10)
      expect(account_lesson).to be_valid
    end

    it 'is not valid without a completion value' do
      account_lesson = AccountLesson.new(lesson_completed: nil)
      expect(account_lesson).not_to be_valid
    end

    it 'increases progress correctly when lesson is completed' do
      Account.find_or_create_by(name: 'Juan', email: 'juanito@gmail.com', password: 'Juanito32',
                                nickname: 'juanito', theme_light: 'dark')

      test = Test.find_or_create_by(letter: 'A', description: 'Description', cant_questions: 5)
      test.save

      lesson = Lesson.find_or_create_by(number: 1, title: 'Title', test_letter: 'A')
      lesson.save

      account_lesson = AccountLesson.find_or_create_by(lesson_completed: false, account_id: 1, lesson_id: 1)
      account_lesson.save

      account = Account.find_by(id: 1)
      initial_progress = account.progress

      account_lesson.update(lesson_completed: true)
      account_lesson.send(:actualizar_progreso_account) # Llamar al método usando send ya que es privado
      account.reload

      expect(account.progress).to be > initial_progress
    end

    it 'marks the lesson as completed for the given account' do
      account = Account.find_or_create_by(name: 'Juan', email: 'juanito@gmail.com', password: 'Juanito32',
                                          nickname: 'juanito', theme_light: 'dark')
      lesson = Lesson.find_or_create_by(number: 1, title: 'Title', test_letter: 'A')
      lesson.save

      account_lesson = AccountLesson.find_or_create_by(lesson_completed: false, account_id: account.id,
                                                       lesson_id: lesson.id)
      account_lesson.save

      AccountLesson.complete_lesson(lesson.id, account.id)

      expect(account_lesson.reload.lesson_completed).to be true
    end

    it 'returns true when all previous lessons are completed' do
      account = Account.find_or_create_by(name: 'Juan', email: 'juanito@gmail.com', password: 'Juanito32',
                                          nickname: 'juanito', theme_light: 'dark')
      lesson1 = Lesson.find_or_create_by(number: 1, title: 'Title1', test_letter: 'A')
      lesson2 = Lesson.find_or_create_by(number: 2, title: 'Title2', test_letter: 'A')
      [lesson1, lesson2].each(&:save)

      AccountLesson.find_or_create_by(lesson_completed: true, account_id: account.id, lesson_id: lesson1.id).save
      AccountLesson.find_or_create_by(lesson_completed: true, account_id: account.id, lesson_id: lesson2.id).save

      lessons = Lesson.where(id: [lesson1.id, lesson2.id])

      expect(AccountLesson.previous_lessons_completed?(lessons, account.id)).to be true
    end

    it 'returns false when any previous lesson is not completed' do
      account = Account.find_or_create_by(name: 'Juan', email: 'juanito@gmail.com', password: 'Juanito32',
                                          nickname: 'juanito', theme_light: 'dark')
      lesson1 = Lesson.find_or_create_by(number: 1, title: 'Title1', test_letter: 'A')
      lesson2 = Lesson.find_or_create_by(number: 2, title: 'Title2', test_letter: 'A')
      [lesson1, lesson2].each(&:save)

      AccountLesson.find_or_create_by(lesson_completed: true, account_id: account.id, lesson_id: lesson1.id).save
      AccountLesson.find_or_create_by(lesson_completed: false, account_id: account.id, lesson_id: lesson2.id).save

      lessons = Lesson.where(id: [lesson1.id, lesson2.id])

      expect(AccountLesson.previous_lessons_completed?(lessons, account.id)).to be false
    end
  end
end
