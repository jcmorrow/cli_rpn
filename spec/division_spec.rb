require "division"

describe Division do
  describe "#perform" do
    context "with a single operand" do
      it "is a noop" do
        operands = [1]

        divider = Division.new(operands)

        expect(divider.perform).to eq(1)
      end
    end

    context "with multiple operands" do
      it "subctracts the last operand from the second to last" do
        operands = [10, 5]

        divider = Division.new(operands)

        expect(divider.perform).to eq(2)
      end
    end
  end
end
