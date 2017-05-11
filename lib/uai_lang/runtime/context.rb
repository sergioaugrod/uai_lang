module UaiLang
  module Runtime
    class Context
      attr_reader :locals, :current_self, :current_class

      def initialize(current_self, current_class = current_self.origin_class)
        @locals = {}
        @current_self = current_self
        @current_class = current_class
      end
    end
  end
end
