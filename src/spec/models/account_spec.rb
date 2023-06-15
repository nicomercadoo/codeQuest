require_relative '../../models/init'

describe 'Account' do
  describe 'valid' do
    describe 'when there is no name' do
      it 'should be invalid' do
        account = Account.new
        expect(account.valid?).to eq(false)
      end
    end
  end
end
