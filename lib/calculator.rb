# frozen_string_literal: true

require "addition"
require "division"
require "multiplication"
require "no_output"
require "subtraction"

class Calculator
  NO_OUTPUT = NoOutput.new
  OPERATIONS = {
    "*" => Multiplication,
    "+" => Addition,
    "-" => Subtraction,
    "/" => Division,
  }.freeze
  OPERATORS = %w(+ - * /).freeze

  def initialize
    @operands = []
  end

  def output
    @operands.last || NO_OUTPUT
  end

  def input(input = "")
    inputs = input.to_s.strip.split(/\s/)
    inputs.each do |single_input|
      if single_input.match?(/\A$/)
        # we might want to consider adding a replay functionality where we
        # repeat the last operation with the current stack here.
        next
      elsif single_input =~ /(-?\d+)/
        @operands.push($1.to_f)
      elsif OPERATORS.include?(single_input)
        handle_operator(single_input)
      else
        raise "Unrecognized input: #{single_input.inspect}"
      end
    end
    self
  end

  private

  def handle_operator(operator)
    unless @operands.empty?
      result = OPERATIONS[operator].new(@operands.pop(2)).perform
      @operands.push(result)
      @output = result
    end
  end
end
