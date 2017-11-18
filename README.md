# What is this?

It's a [reverse polish
notation](https://en.wikipedia.org/wiki/Reverse_Polish_notation) calculator with
a CLI interface, written in Ruby.

# Approach

I've recently been working on a scheme interpreter in Ruby, and I think a lot of
my original plans for this project stem from that. I'm considering actually
running a full grammar tokenizer/parser, but I'm not sure yet that that will
actually be necessary.

The game plan to start with is to model the calculator's number input with a
stack (at least to start out). When it hits an operator it'll pop some values
off of the stack, perform an arithmatic operation with them, and then put the
result back onto the stack.

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

[TODO: Fill this out once I've actually added a single UI 😂]
