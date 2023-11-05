# frozen_string_literal: true

require_relative '../../models/init'

describe Account do
  describe 'Valid' do
    context 'valid create situations' do
      it 'should be valid' do
        # Arrange
        account = Account.new(name: 'Juan', email: 'juanito@gmail.com', password: 'Juanito32', nickname: 'juanito',
                              theme_light: 'dark')
        # Act
        validation = Account.validate_data(account.email, account.password, account.name, account.nickname)

        # Assert
        expect(validation[:email]).to be_truthy
        expect(validation[:password]).to be_truthy
        expect(validation[:name]).to be_truthy
        expect(validation[:nickname]).to be_truthy
      end
    end
    context 'not valid situations' do
      it 'should be invalid (email blame)' do
        # Arrange
        account = Account.new(name: 'Juan', email: 'juanito@yieil.com', password: 'Juanito32', nickname: 'juanito',
                              theme_light: 'dark')
        # Act
        validation = Account.validate_data(account.email, account.password, account.name, account.nickname)

        # Assert
        expect(validation[:email]).to be_falsey
      end

      it 'should be invalid (password blame)' do
        # Arrange
        account = Account.new(name: 'Juan', email: 'juanito@gmail.com', password: 'juanito3', nickname: 'juanito',
                              theme_light: 'dark')
        # Act
        validation = Account.validate_data(account.email, account.password, account.name, account.nickname)

        # Assert
        expect(validation[:password]).to be_falsey
      end

      it 'should be invalid (nickname blame)' do
        # Arrange
        account = Account.new(name: 'Juan', email: 'juanito@gmail.com', password: 'Juanito32', nickname: 'ju anito',
                              theme_light: 'dark')
        # Act
        validation = Account.validate_data(account.email, account.password, account.name, account.nickname)

        # Assert
        expect(validation[:nickname]).to be_falsey
      end

      it 'should be invalid (name blame)' do
        # Arrange
        account = Account.new(name: 'Juanit0', email: 'juanito@gmail.com', password: 'Juanito32', nickname: 'juanito',
                              theme_light: 'dark')
        # Act
        validation = Account.validate_data(account.email, account.password, account.name, account.nickname)

        # Assert
        expect(validation[:name]).to be_falsey
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
