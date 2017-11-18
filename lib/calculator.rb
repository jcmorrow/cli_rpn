# frozen_string_literal: true

require "addition"
require "division"
require "multiplication"
require "no_output"
require "subtraction"

class UnrecognizedCommand < StandardError; end

class Calculator
  NOOP = :noop
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
    @last_command = NOOP
  end

  def output
    @operands.last || NO_OUTPUT
  end

  def input(input = "")
    inputs = input.to_s.strip.split(/\s/)
    if inputs.empty? && @last_command != NOOP
      handle_operator(@last_command)
    else
      handle_inputs(inputs)
    end
    self
  end

  def handle_inputs(inputs)
    inputs.each do |single_input|
      if single_input =~ /(-?\d+)/
        @operands.push($1.to_f)
      elsif OPERATORS.include?(single_input)
        handle_operator(single_input)
      else
        raise(
          UnrecognizedCommand,
          "Unrecognized command: #{single_input.inspect}",
        )
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
    @last_command = operator
  end
end
