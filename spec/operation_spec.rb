require "operation"

class SimpleOperation < Operation
  def perform
    [a, b]
  end

  def identity
    :identity
  end
end

describe Operation do
  describe ".new" do
    context "when there are multiple operands" do
      it "assigns the first to a and the second to b" do
        operands = %i(a b)

        expect(SimpleOperation.new(operands).perform).to eq(%i(a b))
      end
    end

    context "when there is only one operand" do
      it "assigns the first to a and identity to b" do
        operands = %i(a)

        expect(SimpleOperation.new(operands).perform).to eq(%i(a identity))
      end
    end

    context "when there are no operands" do
      it "raises a related error" do
        expect { SimpleOperation.new([]) }.to raise_error(NoOperandsProvided)
      end
    end
  end
end
