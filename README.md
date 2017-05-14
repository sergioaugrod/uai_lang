# UaiLang

[![Build Status](https://travis-ci.org/sergioaugrod/uai_lang.svg?branch=master)](https://travis-ci.org/sergioaugrod/uai_lang)

UaiLang is an initial structure of a language created with Ruby for study purposes. Structure based on the examples of the great book "How to Create Your Own Programming Language".
Lexer was created using regex and used [racc](https://github.com/tenderlove/racc) as parser generator.

## Installation

Install deps:

´´´console
$ bundle install
´´´

For changes in grammar.y it is necessary to have the racc installed:

´´´console
$ gem install racc
´´´

## Running Code

Running codes in REPL:

´´´console
bin/repl
´´´

Executing file code:

´´´console
bin/repl code.uai
´´´

## Usage

Example of function creation:

´´´ruby
functrem printa faiz
  print(10)
  print(2)
popara

printa()
´´´

Example of if:

´´´ruby
if true faiz
  print("true")
  print(1)
popara
´´´
