require "calculator"

describe "Calculator" do
  describe ".input" do
    it "can handle a blank input string" do
      expect(run_input("")).to be_a(NoOutput)
      expect(run_input("\n")).to be_a(NoOutput)
      expect(run_input(" ")).to be_a(NoOutput)
    end

    it "can handle an integer as input" do
      (0..9).each do |int|
        expect(run_input(int)).to eq(int.to_f)
      end
    end

    it "correctly calls the operation for only the last two inputs" do
      calculator = Calculator.new

      expect(calculator.input("5 1 3 +").output).to eq(4)
      expect(calculator.input("+").output).to eq(9)
    end

    it "has no output when there is only an operator" do
      expect(run_input("+")).to be_a(NoOutput)
    end
  end
end

def run_input(equation)
  Calculator.new.input(equation).output
end
