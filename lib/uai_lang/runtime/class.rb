module UaiLang
  module Runtime
    class Class
      attr_reader :self_methods

      def initialize
        @self_methods = {}
      end

      def run_method(name)
        self_methods[name.to_sym].tap do |method|
          raise "O trem não existe só." if method.nil?
        end
      end

      def define_method(name, &block)
        self_methods[name] = block
      end

      def new(value = nil)
        value ? Object.new(self, value) : Object.new(self)
      end
    end
  end
end
