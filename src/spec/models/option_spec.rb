require_relative '../../models/init'

describe Option do
  context "validations" do

    it "is valid with valid attributes" do
      option = Option.new(number: 3, correct: true, description: "This is a option", question_number: 2, test_letter: "B")
      expect(option).to be_valid
    end

    it "is not valid without a number" do
      option = Option.new(number: nil)
      expect(option).not_to be_valid
    end

    it "is not valid without a correction value" do
      option = Option.new(correct: nil)
      expect(option).not_to be_valid
    end

    it "is not valid without a description" do
      option = Option.new(description: nil)
      expect(option).not_to be_valid
    end

    it "is not valid without a question number" do
      option = Option.new(question_number: nil)
      expect(option).not_to be_valid
    end

    it "is not valid without a test letter" do
      option = Option.new(test_letter: nil)
      expect(option).not_to be_valid
    end
  end

end