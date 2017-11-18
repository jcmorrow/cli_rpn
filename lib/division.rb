require "operation"

class Division < Operation
  def perform
    a / b
  end

  def identity
    1
  end
end
