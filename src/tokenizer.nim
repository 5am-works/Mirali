import std/options
import std/strformat
import std/re

let namePattern = re"^[A-Z][A-Za-z]*$"
let integerPattern = re"^-?[1-9][0-9]*$"
let decimalPattern = re"^-?[1-9][0-9]*\.[0-9]+$"

type
   TokenType* = enum
      Integer
      Identifer
      Name
      Decimal
   Token* = tuple[literal: string, tokenType: TokenType]
   Tokenizer = object
      input: string
      position: int

proc readChar(t: var Tokenizer): char =
   if t.position >= t.input.len:
      result = '\0'
   else:
      result = t.input[t.position]
      t.position += 1

proc readToken(t: var Tokenizer): Option[Token] =
   let tokenStart = t.position
   var nextChar = t.readChar()
   var tokenEnd = tokenStart
   while nextChar != '\0' and nextChar != ' ':
      nextChar = t.readChar()
      tokenEnd += 1
   return if tokenStart == tokenEnd:
      none(Token)
   else:
      let literal = t.input[tokenStart .. tokenEnd - 1]
      let tokenType = if literal.match(namePattern):
         Name
      elif literal.match(integerPattern):
         Integer
      elif literal.match(decimalPattern):
         Decimal
      else:
         Identifer
      some((literal: literal, tokenType: tokenType))

iterator tokenize*(input: string): Token =
   var tokenizer = Tokenizer(input: input, position: 0)
   var nextToken = tokenizer.readToken()
   while nextToken.isSome:
      yield nextToken.get
      nextToken = tokenizer.readToken()