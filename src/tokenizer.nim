import std/options
import std/strformat

type
   TokenType* = enum
      Integer
      Plus
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
   let nextChar = t.readChar()
   result = case nextChar:
      of '+':
         some((literal: $nextChar, tokenType: Plus))
      of '\0':
         none(Token)
      else:
         raise newException(Exception, &"Invalid character: {nextChar}")

iterator tokenize*(input: string): Token =
   var tokenizer = Tokenizer(input: input, position: 0)
   var nextToken = tokenizer.readToken()
   while nextToken.isSome:
      yield nextToken.get
      nextToken = tokenizer.readToken()