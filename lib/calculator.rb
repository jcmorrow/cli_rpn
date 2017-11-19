# frozen_string_literal: true

require "addition"
require "division"
require "multiplication"
require "no_output"
require "subtraction"

class UnrecognizedCommand < StandardError; end

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
    handle_inputs(inputs)
    self
  end

  def stack
    @operands
  end

  def pop!
    @operands.pop
  end

  private

  def handle_inputs(inputs)
    inputs.each do |single_input|
      handle_input(single_input)
    end
    self
  end

  def handle_input(input)
    if input =~ /(-?\d+)/
      @operands.push($1.to_f)
    elsif OPERATORS.include?(input)
      handle_operator(input)
    else
      raise(UnrecognizedCommand, "Unrecognized command: #{input.inspect}")
    end
  end

  def handle_operator(operator)
    unless @operands.empty?
      result = OPERATIONS[operator].new(@operands.pop(2)).perform
      @operands.push(result)
    end
  end
end
