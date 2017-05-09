module UaiLang
  module Runtime
    class Object
      attr_reader :origin_class, :value

      def initialize(origin_class, value = self)
        @origin_class = origin_class
        @value = value
      end

      def call(method, arguments = [])
        @origin_class.run_method(method).call(self, arguments)
      end
    end
  end
end
