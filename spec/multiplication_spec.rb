require "multiplication"

describe Multiplication do
  describe "#perform" do
    context "with a single operand" do
      it "is a noop" do
        operands = [1]

        multiplier = Multiplication.new(operands)

        expect(multiplier.perform).to eq(1)
      end
    end

    context "with multiple operands" do
      it "subctracts the last operand from the second to last" do
        operands = [2, 5]

        multiplier = Multiplication.new(operands)

        expect(multiplier.perform).to eq(10)
      end
    end
  end
end
