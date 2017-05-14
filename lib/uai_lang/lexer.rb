module UaiLang
  class Lexer
    KEYWORDS = [
      { name: :DEF, value: 'functrem' },
      { name: :CLASS, value: 'trem' },
      { name: :IF, value: 'if' },
      { name: :TRUE, value: 'true' },
      { name: :FALSE, value: 'false' },
      { name: :NIL, value: 'nil' },
      { name: :BLOCK_INIT, value: 'faiz' },
      { name: :BLOCK_END, value: 'popara' }
    ].freeze

    REGEX = {
      identifier: /\A([a-z]\w*)/,
      constant: /\A([A-Z]\w*)/,
      number: /\A([0-9]+)/,
      string: /\A"([^"]*)"/,
      operator: /\A(AND|OR|==|!=|<=|>=)/,
      line: /\A\n+/,
      whitespace: /\A /
    }.freeze

    attr_reader :code, :tokens

    def initialize(code)
      @code = code
      @tokens = []
    end

    def tokenize
      code.chomp!

      position = 0
      position = parse_tokens(position) while position < code.size

      tokens
    end

    private

    def parse_tokens(position)
      chunk = code[position..-1]

      if identifier = chunk[REGEX[:identifier], 1]
        position + token_identifier(identifier)
      elsif constant = chunk[REGEX[:constant], 1]
        position + token_constant(constant)
      elsif number = chunk[REGEX[:number], 1]
        position + token_number(number)
      elsif string = chunk[REGEX[:string], 1]
        position + token_string(string)
      elsif operator = chunk[REGEX[:operator], 1]
        position + token_operator(operator)
      elsif chunk.match(REGEX[:line])
        token_new_line
        position += 1
      elsif chunk.match(REGEX[:whitespace])
        position += 1
      else
        value = chunk[0, 1]
        tokens << [value, value]
        position + 1
      end
    end

    def token_identifier(identifier)
      keyword = KEYWORDS.find { |k| k[:value] == identifier }

      tokens << if keyword
                  [keyword[:name], identifier]
                else
                  [:IDENTIFIER, identifier]
                end
      identifier.size
    end

    def token_constant(constant)
      tokens << [:CONSTANT, constant]
      constant.size
    end

    def token_number(number)
      tokens << [:NUMBER, number]
      number.size
    end

    def token_string(string)
      tokens << [:STRING, string]
      string.size + 2
    end

    def token_operator(operator)
      tokens << [operator, operator]
      operator.size
    end

    def token_new_line
      tokens << [:NEWLINE, "\n"] unless block_init?
    end

    def block_init?
      tokens.empty? || tokens.last.first == :BLOCK_INIT
    end
  end
end
