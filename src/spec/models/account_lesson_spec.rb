require_relative '../../models/init'

describe AccountLesson do
  context "validations" do

    it "is valid with valid attributes" do
      account_lesson = AccountLesson.new(lesson_completed: false, account_id: 5, lesson_id: 10)
      expect(account_lesson).to be_valid
    end

    it "not valid without a completion value" do
      account_lesson = AccountLesson.new(lesson_completed: nil)
      expect(account_lesson).not_to be_valid
    end

  end

end