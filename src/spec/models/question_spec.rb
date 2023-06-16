require_relative '../../models/init'

describe Question do
  context "validations" do

    it "is valid with valid attributes" do
      question = Question.new(number: 1, description: "This is a question", test_letter: "B")
      expect(question).to be_valid
    end

    it "is not valid without a number" do
      question = Question.new(number: nil)
      expect(question).not_to be_valid
    end

    it "is not valid without a description" do
      question = Question.new(description: nil)
      expect(question).not_to be_valid
    end

    it "is not valid without a test letter" do
      question = Question.new(test_letter: nil)
      expect(question).not_to be_valid
    end
  end

end
