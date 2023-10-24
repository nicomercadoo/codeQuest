# frozen_string_literal: true

require_relative '../../models/init'
require_relative '../../models/account'
require_relative '../../models/lesson'
require_relative '../../models/test'
require_relative '../../models/option'
require_relative '../../models/question'
require_relative '../../models/account_lesson'
require_relative '../../models/account_test'
require_relative '../../models/account_option'
require_relative '../../models/account_question'

describe Account do
  describe 'Valid' do
    context 'valid create situations' do
      it 'should be valid' do
        # Arrange
        account = Account.new(name: 'Juan', email: 'juanito@gmail.com', password: 'Juanito32', nickname: 'juanito',
                              theme_light: 'dark')
        # Assert
        expect(account.valid? && account.correct_format_of_fields?).to be_truthy
      end
    end
    context 'not valid situations' do
      it 'should be invalid (email blame)' do
        # Arrange
        account = Account.new(name: 'Juan', email: 'juanito@yieil.com', password: 'Juanito32', nickname: 'juanito',
                              theme_light: 'dark')
        # Assert
        expect(account.valid? && account.correct_format_of_fields?).to be_falsey
      end

      it 'should be invalid (password blame)' do
        # Arrange
        account = Account.new(name: 'Juan', email: 'juanito@gmail.com', password: 'juanito3', nickname: 'juanito',
                              theme_light: 'dark')
        # Assert
        expect(account.valid? && account.correct_format_of_fields?).to be_falsey
      end

      it 'should be invalid (nickname blame)' do
        # Arrange
        account = Account.new(name: 'Juan', email: 'juanito@gmail.com', password: 'Juanito32', nickname: 'ju anito',
                              theme_light: 'dark')
        # Assert
        expect(account.valid? && account.correct_format_of_fields?).to be_falsey
      end

      it 'should be invalid (name blame)' do
        # Arrange
        account = Account.new(name: 'Juanit0', email: 'juanito@gmail.com', password: 'Juanito32', nickname: 'juanito',
                              theme_light: 'dark')
        # Assert
        expect(account.valid? && account.correct_format_of_fields?).to be_falsey
      end
    end
  end
  describe 'Create same account' do
    it 'should be invalid (email blame)' do
      # Arrange
      account1 = Account.find_or_create_by(name: 'Juan', email: 'juanito@gmail.com', password: 'Juanito32',
                                           nickname: 'juanito', theme_light: 'dark')
      # Act
      account1.save
      account2 = Account.find_or_create_by(name: account1.name, email: account1.email, password: account1.password,
                                           nickname: account1.nickname, theme_light: account1.theme_light)
      # Assert
      expect(account2.save).to be_truthy
    end
  end
end
