# What is this?

It's a (reverse polish
notation)[https://en.wikipedia.org/wiki/Reverse_Polish_notation] calculator with
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
