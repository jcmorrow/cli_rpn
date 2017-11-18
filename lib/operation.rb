class NoOperandsProvided < StandardError; end

class Operation
  def initialize(operands)
    @a = operands.shift || no_operands_provided
    @b = operands.shift || identity
  end

  def perform
    raise NotImplementedError
  end

  def no_operands_provided
    raise NoOperandsProvided
  end

  private

  attr_reader :a, :b

  def identity
    raise NotImplementedError
  end
end
