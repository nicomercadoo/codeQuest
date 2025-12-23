# frozen_string_literal: true

require_relative '../../models/init'

describe Snippet do
  context 'validations' do
    it 'is valid with valid attributes' do
      snippet = Snippet.new(code: 'This is a code', account_id: 1)
      expect(snippet).to be_valid
    end

    it 'is not valid without a code' do
      snippet = Snippet.new(code: nil)
      expect(snippet).not_to be_valid
    end

    it 'is not valid without a account id' do
      snippet = Snippet.new(account_id: nil)
      expect(snippet).not_to be_valid
    end
  end
end
