module UaiLang
  class Interpreter
    def initialize
      @parser = Parser::Generator.new
    end

    def eval(code)
      parser.parse(code).eval(context)
    end

    private

    attr_reader :parser

    def context
      Globals['RootContext']
    end
  end
end
