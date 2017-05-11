module UaiLang
  module Runtime
    class Eval
      def initialize(nodes, context)
        @nodes = nodes
        @context = context
      end

      def execute
        value = Globals['nil']

        nodes.each do |node|
          value = node_eval(node)
        end

        value
      end

      private

      attr_reader :nodes

      def node_eval(node)
      end
    end
  end
end
