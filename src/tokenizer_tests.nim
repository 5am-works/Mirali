import std/sequtils
import unittest
import tokenizer

suite "Tokenizer tests":
   test "Operator identifiers":
      let input = "+ - * /"
      let result = tokenize(input).toSeq
      check(result == @[
         (literal: "+", tokenType: Identifer),
         (literal: "-", tokenType: Identifer),
         (literal: "*", tokenType: Identifer),
         (literal: "/", tokenType: Identifer),
      ])

   test "Number literals":
      let input = "1 2 2.3"
      let result = tokenize(input).toSeq
      check(result == @[
         (literal: "1", tokenType: Integer),
         (literal: "2", tokenType: Integer),
         (literal: "2.3", tokenType: Decimal),
      ])
   
   test "Names":
      let input = "X Alice Bob"
      let result = tokenize(input).toSeq
      check(result == @[
         (literal: "X", tokenType: Name),
         (literal: "Alice", tokenType: Name),
         (literal: "Bob", tokenType: Name),
      ])
   
   test "Function names":
      let input = "print! println! define!"
      let result = tokenize(input).toSeq
      check(result == @[
         (literal: "print!", tokenType: Identifer),
         (literal: "println!", tokenType: Identifer),
         (literal: "define!", tokenType: Identifer),
      ])