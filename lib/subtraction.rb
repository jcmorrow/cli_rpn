require "operation"

class Subtraction < Operation
  def perform
    a - b
  end

  private

  def identity
    0
  end
end
