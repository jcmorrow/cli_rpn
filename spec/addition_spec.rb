require "addition"

describe Addition do
  describe "#perform" do
    context "with a single operand" do
      it "is a noop" do
        operands = [1]

        adder = Addition.new(operands)

        expect(adder.perform).to eq(1)
      end
    end

    context "with multiple operands" do
      it "adds them" do
        operands = [2, 3]

        adder = Addition.new(operands)

        expect(adder.perform).to eq(5)
      end
    end
  end
end
