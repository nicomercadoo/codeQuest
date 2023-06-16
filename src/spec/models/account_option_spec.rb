require_relative '../../models/init'

describe AccountOption do
  context "validations" do

    it "is valid with valid attributes" do
      account_option = AccountOption.new(account_id: 5, option_id: 10, question_id: 3)
      expect(account_option).to be_valid
    end
    
  end

end