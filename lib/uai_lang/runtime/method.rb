module UaiLang
  module Runtime
    class Method
      def initialize(params, body)
        @params = params
        @body = body
      end

      def call(receiver, arguments)
        context = Context.new(receiver)

        params.each_with_index do |param, index|
          context.locals[param] = arguments[index]
        end

        body.eval(context)
      end

      private

      attr_reader :params, :body
    end
  end
end
