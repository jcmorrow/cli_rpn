require "operation"

class Addition < Operation
  def perform
    a + b
  end

  private

  def identity
    0
  end
end
