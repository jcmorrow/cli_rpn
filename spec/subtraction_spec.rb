require "subtraction"

describe Subtraction do
  describe "#perform" do
    context "with a single operand" do
      it "is a noop" do
        operands = [1]

        subtracter = Subtraction.new(operands)

        expect(subtracter.perform).to eq(1)
      end
    end

    context "with multiple operands" do
      it "subctracts the last operand from the second to last" do
        operands = [2, 1]

        subtracter = Subtraction.new(operands)

        expect(subtracter.perform).to eq(1)
      end
    end
  end
end
