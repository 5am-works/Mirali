import std/sequtils
import unittest
import tokenizer

suite "Tokenizer tests":
   test "Single-character tokens":
      let input = "+"
      let result = tokenize(input).toSeq
      check(result == @[
         (literal: "+", tokenType: Plus),
      ])