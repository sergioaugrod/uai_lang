require 'spec_helper'

RSpec.describe UaiLang::Lexer do
  describe '#tokenize' do
    it 'returns tokens for assigns code' do
      code = ''"
      b = 5
      a = 25 + b
      "''

      result = described_class.new(code).tokenize
      tokens = [
        [:NEWLINE, "\n"],
        [:IDENTIFIER, 'b'],
        ['=', '='],
        [:NUMBER, '5'],
        [:NEWLINE, "\n"],
        [:IDENTIFIER, 'a'],
        ['=', '='],
        [:NUMBER, '25'],
        ['+', '+'],
        [:IDENTIFIER, 'b'],
        [:NEWLINE, "\n"]
      ]

      expect(result).to eq tokens
    end

    it 'returns tokens for function definition code' do
      code = ''"
      functrem soma(a, b) faiz
        a + b
      popara
      "''

      result = described_class.new(code).tokenize
      tokens = [
        [:NEWLINE, "\n"],
        [:DEF, 'functrem'],
        [:IDENTIFIER, 'soma'],
        ['(', '('],
        [:IDENTIFIER, 'a'],
        [',', ','],
        [:IDENTIFIER, 'b'],
        [')', ')'],
        [:BLOCK_INIT, 'faiz'],
        [:NEWLINE, "\n"],
        [:IDENTIFIER, 'a'],
        ['+', '+'],
        [:IDENTIFIER, 'b'],
        [:NEWLINE, "\n"],
        [:BLOCK_END, 'popara'],
        [:NEWLINE, "\n"]
      ]

      expect(result).to eq tokens
    end
  end
end
