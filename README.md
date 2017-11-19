# What is this?

It's a [reverse polish
notation](https://en.wikipedia.org/wiki/Reverse_Polish_notation) calculator with
a CLI interface, written in Ruby.

# Using it

### From your own code:

``` #ruby
require "calculator"

calculator = Calculator.new
calculator.input("1 2 +")
p calculator.output
# => 3.0

# You can chain input calls also
calculator.input("4").input("*")
p calculator.output
# => 12.0

# or do the whole cycle in one line
p calculator.input("4").input("*").output
# => 48.0
```

### From a command line:

``` #bash
git clone https://github.com/jcmorrow/cli_rpn'
cd cli_rpn
./bin/calculator
Commands:
  - 'pop' or 'p' to pop the top value off of the current stack
  - 'quit' or 'q' to exit
  - 'stack' or 's' to view the current stack
  - 'help' or 'h' to print these instructions
> 1 2 +
3.0
> 4
4.0
> *
12.0
> 4 *
48.0
> q
```

# Approach

This calculator is designed to take advantage of two abstractions: a stack for
storing operands and an interface for running operations on those operands. The
calculator class is designed to be relatively interface-neutral; right now there
is only a CLI, but it should be straightforward to add on a different interface
like wrapping this class in a Sinatra app to have HTTP functionality.

# Decisions

Using a stack was an obvious choice once I started looking at the examples given
in the spec. I thought about writing a wrapper around `Array` instead of just
using a blank array (which would allow me to move the logic in the `output`
method out of `Calculator`) but it didn't feel like that class would have enough
responsibility to be worth the indirection.

I *did* decide to add a class just to represent a blank output. I wanted to do
this mostly for testing reasons, I didn't think it would be appropriate for this
class to return an empty string directly, since that is very much a
representation of `nil` that just happens to be appropriate on a CLI. I could
imagine someone instantiating a new `Calculator`, submitting a blank line,
getting an empty string back and then accidentally trying to do some math with
it and not knowing where the blank line came from necessarily . This way they
can at least grep for `class NoOutput` if they're confused. Returning `nil`
itself is *almost always* a bad idea because it gives no hints as to
where in the call-stack it started.

# Operations

A key insight about the basic arithmatic operations is that they all take two
parameters, and they all have an "identity" operand (in the case of addition
and subtraction this is 0, in the case of multiplication and division it is 1).
I made a base Operation class to handle the things that all operatoins have in
common, which makes the Operations quite readable.

# Adding a New Operation

When I sat down to write this one thing I wanted to at least think about was
what directions I would *expect* this code to expand. The most obvious two ways
were: non-CLI interfaces and additional operators. It's pretty straightforward
to add a new operation, as long as it can be done with two operands. It has to:

1) Be implemented as a class inheriting from `Operation`
2) Have a symbol added in the `OPERATORS` constant in `lib/calculator.rb`
3) Have a corresponding key/value pair in the `OPERATIONS` constant in
`lib/calculator/rb`

The class has to implement `#perform` and `#identity`. Good operators to add
would be things like: `**` (exponent), perhaps `log`, or `c` (combinatorial).

I *think* you could have a pretty good pattern for operations that take
more or fewer operands by implementing something like an `.arity` method for
each operation, so that the `Calculator` class would know how many values need
to be `pop`ed to run the operation. I haven't implemented this but in theory it
seems straightforward (famous last words).

# Adding a New Interface

The calculator only has two public methods: `input` and `output`. This makes
implementing an interface to it pretty simple. You can submit input to it with
the `input` method and read the current evaluation with the `output` method. For
any kind of REPL-like interface these should be useful and straightforward. See
`bin/calculator` for an example.

# Contributing

There shouldn't be much setup to do, just clone the repo and run `bundle`. Tests
can be run with `bin/rspec`. Pull requests welcome!
