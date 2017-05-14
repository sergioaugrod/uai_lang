require 'spec_helper'

RSpec.describe UaiLang::Lexer do
  describe '#tokenize' do
    it 'returns tokens for assigns code' do
      code = <<-CODE
      b = "5"
      a = 25 + b
      CODE

      result = described_class.new(code).tokenize
      tokens = [
        [:IDENTIFIER, 'b'],
        ['=', '='],
        [:STRING, '5'],
        [:NEWLINE, "\n"],
        [:IDENTIFIER, 'a'],
        ['=', '='],
        [:NUMBER, 25],
        ['+', '+'],
        [:IDENTIFIER, 'b']
      ]

      expect(result).to eq tokens
    end

    it 'returns tokens for function definition code' do
      code = <<-CODE
      functrem soma(a, b) faiz
        a + b
      popara
      CODE

      result = described_class.new(code).tokenize
      tokens = [
        [:DEF, 'functrem'],
        [:IDENTIFIER, 'soma'],
        ['(', '('],
        [:IDENTIFIER, 'a'],
        [',', ','],
        [:IDENTIFIER, 'b'],
        [')', ')'],
        [:BLOCK_INIT, 'faiz'],
        [:IDENTIFIER, 'a'],
        ['+', '+'],
        [:IDENTIFIER, 'b'],
        [:NEWLINE, "\n"],
        [:BLOCK_END, 'popara']
      ]

      expect(result).to eq tokens
    end
  end
end
