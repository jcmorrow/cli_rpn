require "operation"

class Multiplication < Operation
  def perform
    a * b
  end

  private

  def identity
    1
  end
end
